import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bonsoir/bonsoir.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart' as shelf_router;
import 'package:http/http.dart' as http;
import 'package:isar/isar.dart';
import 'database_service.dart';
import 'app_storage_service.dart';
import '../models/customer.dart';
import '../models/company.dart';
import '../models/work_task.dart';
import '../models/marketing_lead.dart';
import '../models/daily_note.dart';
import '../providers/customer_provider.dart';
import '../providers/events_provider.dart';
import '../providers/work_provider.dart';
import '../providers/marketing_provider.dart';
import '../providers/daily_notes_provider.dart';

final syncServiceProvider = ChangeNotifierProvider<SyncService>((ref) {
  final db = ref.watch(databaseServiceProvider);
  return SyncService(db, ref);
});

class DiscoveredDevice {
  final String id;
  final String name;
  final String host;
  final int port;

  DiscoveredDevice({required this.id, required this.name, required this.host, required this.port});
}

class SyncService extends ChangeNotifier {
  final DatabaseService _db;
  final Ref _ref;
  
  HttpServer? _server;
  int _serverPort = 8080;
  bool _isServerRunning = false;

  BonsoirBroadcast? _broadcast;
  BonsoirDiscovery? _discovery;
  
  RawDatagramSocket? _udpSocket;
  Timer? _udpBeaconTimer;
  static const int _udpPort = 8888;

  final List<DiscoveredDevice> _discoveredDevices = [];
  bool _isDiscovering = false;
  bool _isSyncing = false;
  String _syncStatusText = 'Idle';

  SyncService(this._db, this._ref);

  void _invalidateProviders() {
    _ref.invalidate(customerListProvider);
    _ref.invalidate(taskListProvider);
    _ref.invalidate(todayTasksProvider);
    _ref.invalidate(companiesForSelectedTabProvider);
    _ref.invalidate(todaySummaryEventsProvider);
    _ref.invalidate(upcomingEventsProvider);
    _ref.invalidate(marketingListProvider);
    _ref.invalidate(tomorrowNotesProvider);
  }

  List<DiscoveredDevice> get discoveredDevices => _discoveredDevices;
  bool get isServerRunning => _isServerRunning;
  bool get isDiscovering => _isDiscovering;
  bool get isSyncing => _isSyncing;
  String get syncStatusText => _syncStatusText;
  int get serverPort => _serverPort;

  // --- SERVER METHODS ---

  Future<void> startServer() async {
    if (_isServerRunning) return;

    final router = shelf_router.Router();

    // 1. Get database metadata (UUIDs and updatedAt times)
    router.get('/sync/meta', (Request request) async {
      try {
        final customers = await _db.isar.customers.where().findAll();
        final companies = await _db.isar.companys.where().findAll();
        final tasks = await _db.isar.workTasks.where().findAll();
        final leads = await _db.isar.marketingLeads.where().findAll();
        final notes = await _db.isar.dailyNotes.where().findAll();

        final meta = {
          'customers': customers.map((c) => {'uuid': c.uuid, 'updatedAt': c.updatedAt.toIso8601String()}).toList(),
          'companies': companies.map((c) => {'uuid': c.uuid, 'updatedAt': c.updatedAt.toIso8601String()}).toList(),
          'tasks': tasks.map((t) => {'uuid': t.uuid, 'updatedAt': t.updatedAt.toIso8601String()}).toList(),
          'leads': leads.map((l) => {'uuid': l.uuid, 'updatedAt': l.updatedAt.toIso8601String()}).toList(),
          'notes': notes.map((n) => {'uuid': n.noteId, 'updatedAt': (n.updatedAt ?? n.createdAt).toIso8601String()}).toList(),
        };

        return Response.ok(jsonEncode(meta), headers: {'Content-Type': 'application/json'});
      } catch (e) {
        return Response.internalServerError(body: 'Error: $e');
      }
    });

    // 2. Data exchange endpoint
    router.post('/sync/exchange', (Request request) async {
      try {
        final body = await request.readAsString();
        final payload = jsonDecode(body) as Map<String, dynamic>;

        // Acknowledge remote data & merge it
        await _mergePayload(payload);
        _invalidateProviders();

        // Prepare and return local newer data
        final responsePayload = await _buildExchangePayload(payload['meta'] ?? {});

        return Response.ok(jsonEncode(responsePayload), headers: {'Content-Type': 'application/json'});
      } catch (e) {
        return Response.internalServerError(body: 'Error: $e');
      }
    });

    // 3. File serving endpoint
    router.get('/sync/file/<filename>', (Request request, String filename) async {
      try {
        final docsDir = await AppStorageService.getCustomerDocumentsDirectory();
        final safeName = filename.replaceAll('\\', '/').split('/').last;
        final file = File('${docsDir.path}/$safeName');
        if (await file.exists()) {
          return Response.ok(file.openRead(), headers: {
            'Content-Type': 'application/octet-stream',
            'Content-Disposition': 'attachment; filename="$safeName"',
          });
        } else {
          return Response.notFound('File $safeName not found');
        }
      } catch (e) {
        return Response.internalServerError(body: 'Error: $e');
      }
    });

    // 4. File upload endpoint
    router.post('/sync/file/<filename>', (Request request, String filename) async {
      try {
        final docsDir = await AppStorageService.getCustomerDocumentsDirectory();
        final safeName = filename.replaceAll('\\', '/').split('/').last;
        final file = File('${docsDir.path}/$safeName');
        final bytes = await request.read().expand((bit) => bit).toList();
        await file.writeAsBytes(bytes, flush: true);
        return Response.ok('File $safeName uploaded successfully');
      } catch (e) {
        return Response.internalServerError(body: 'Upload Error: $e');
      }
    });

    // 5. File check endpoint
    router.get('/sync/has_file/<filename>', (Request request, String filename) async {
      try {
        final docsDir = await AppStorageService.getCustomerDocumentsDirectory();
        final safeName = filename.replaceAll('\\', '/').split('/').last;
        final file = File('${docsDir.path}/$safeName');
        return Response.ok(jsonEncode({'exists': await file.exists()}), headers: {'Content-Type': 'application/json'});
      } catch (e) {
        return Response.internalServerError(body: 'Error: $e');
      }
    });

    // Start Shelf Server on an available port
    int port = 8080;
    while (port < 8090) {
      try {
        _server = await shelf_io.serve(router, InternetAddress.anyIPv4, port, shared: true);
        _serverPort = port;
        _isServerRunning = true;
        break;
      } catch (e) {
        port++;
      }
    }

    if (_isServerRunning) {
      notifyListeners();
      await _startBroadcasting();
      await _startUdpBeacon();
    }
  }

  Future<void> stopServer() async {
    await _stopBroadcasting();
    if (!_isDiscovering) {
      _stopUdpBeacon();
    }
    await _server?.close(force: true);
    _server = null;
    _isServerRunning = false;
    notifyListeners();
  }

  // --- MDNS & UDP BROADCASTING & DISCOVERY ---

  Future<void> _startBroadcasting() async {
    try {
      final String serviceName = 'ShineCRM_${Platform.localHostname.replaceAll(' ', '_')}_$_serverPort';
      
      final service = BonsoirService(
        name: serviceName,
        type: '_shinecrm._tcp',
        port: _serverPort,
      );

      _broadcast = BonsoirBroadcast(service: service);
      await _broadcast!.ready;
      await _broadcast!.start();
    } catch (e) {
      debugPrint('mDNS Bonsoir Broadcast notice (falling back to UDP beacon): $e');
    }
  }

  Future<void> _stopBroadcasting() async {
    try {
      await _broadcast?.stop();
    } catch (_) {}
    _broadcast = null;
  }

  Future<void> startDiscovery() async {
    if (_isDiscovering) return;
    _discoveredDevices.clear();
    _isDiscovering = true;
    notifyListeners();

    // 1. Start pure Dart UDP Socket beacon (works natively on Windows, Linux, macOS, Android, iOS without plugin channels)
    await _startUdpBeacon();

    // 2. Try Bonsoir mDNS discovery if supported
    try {
      _discovery = BonsoirDiscovery(type: '_shinecrm._tcp');
      await _discovery!.ready;
      
      _discovery!.eventStream!.listen((event) {
        if (event.service == null) return;
        final service = event.service!;

        if (event.type == BonsoirDiscoveryEventType.discoveryServiceResolved) {
          final service = event.service;
          if (service is ResolvedBonsoirService) {
            // Verify it isn't ourselves
            final isOurselves = service.name.contains(Platform.localHostname.replaceAll(' ', '_')) && service.port == _serverPort;
            if (!isOurselves) {
              String hostIp = service.host ?? 'localhost';
              final deviceId = service.name;
              if (!_discoveredDevices.any((d) => d.id == deviceId || (d.host == hostIp && d.port == service.port))) {
                _discoveredDevices.add(DiscoveredDevice(
                  id: deviceId,
                  name: service.name.split('_').first,
                  host: hostIp,
                  port: service.port,
                ));
                notifyListeners();
              }
            }
          }
        } else if (event.type == BonsoirDiscoveryEventType.discoveryServiceLost) {
          _discoveredDevices.removeWhere((d) => d.id == service.name);
          notifyListeners();
        }
      });

      await _discovery!.start();
    } catch (e) {
      debugPrint('mDNS Bonsoir Discovery non-critical notice (UDP Beacon active): $e');
    }
  }

  Future<void> stopDiscovery() async {
    try {
      await _discovery?.stop();
    } catch (_) {}
    _discovery = null;
    _isDiscovering = false;
    if (!_isServerRunning) {
      _stopUdpBeacon();
    }
    notifyListeners();
  }

  // Pure Dart UDP Broadcast Implementation
  Future<void> _startUdpBeacon() async {
    try {
      _udpSocket ??= await RawDatagramSocket.bind(
        InternetAddress.anyIPv4,
        _udpPort,
        reuseAddress: true,
        reusePort: !Platform.isWindows,
      );
      _udpSocket?.broadcastEnabled = true;

      _udpSocket?.listen((RawSocketEvent event) {
        if (event == RawSocketEvent.read) {
          final datagram = _udpSocket?.receive();
          if (datagram != null) {
            _handleUdpDatagram(datagram);
          }
        }
      });

      _udpBeaconTimer?.cancel();
      _udpBeaconTimer = Timer.periodic(const Duration(seconds: 3), (_) => _sendUdpPing());
      _sendUdpPing();
    } catch (e) {
      debugPrint('UDP Beacon initialization notice: $e');
    }
  }

  void _sendUdpPing() async {
    if (!_isServerRunning && !_isDiscovering) return;
    try {
      final localIps = await getLocalIpAddresses();
      final primaryIp = localIps.isNotEmpty ? localIps.first : '';
      final payload = jsonEncode({
        'app': 'ShineCRM',
        'name': Platform.localHostname,
        'ip': primaryIp,
        'port': _serverPort,
        'isServer': _isServerRunning,
      });
      final bytes = utf8.encode(payload);

      // 1. General broadcast (255.255.255.255)
      try {
        _udpSocket?.send(bytes, InternetAddress('255.255.255.255'), _udpPort);
      } catch (_) {}

      // 2. Targeted subnet broadcast for Windows/Linux multi-interface networks
      for (final ip in localIps) {
        final parts = ip.split('.');
        if (parts.length == 4) {
          final subnetBroadcast = '${parts[0]}.${parts[1]}.${parts[2]}.255';
          try {
            _udpSocket?.send(bytes, InternetAddress(subnetBroadcast), _udpPort);
          } catch (_) {}
        }
      }
    } catch (e) {
      debugPrint('UDP send ping notice: $e');
    }
  }

  void _handleUdpDatagram(Datagram datagram) {
    try {
      final message = utf8.decode(datagram.data);
      final data = jsonDecode(message) as Map<String, dynamic>;
      if (data['app'] == 'ShineCRM') {
        final String remoteName = data['name'] ?? 'Unknown Node';
        final String remoteIp = (data['ip'] != null && (data['ip'] as String).isNotEmpty)
            ? data['ip'] as String
            : datagram.address.address;
        final int remotePort = data['port'] as int? ?? 8080;
        final bool remoteIsServer = data['isServer'] as bool? ?? true;

        if (!remoteIsServer) return;

        // Check if it's ourselves
        final isOurselves = datagram.address.address == '127.0.0.1' ||
            (remoteName == Platform.localHostname && remotePort == _serverPort);
        if (!isOurselves) {
          final deviceId = 'udp_${remoteIp}_$remotePort';
          final existingIndex = _discoveredDevices.indexWhere((d) => d.host == remoteIp && d.port == remotePort);
          if (existingIndex == -1) {
            _discoveredDevices.add(DiscoveredDevice(
              id: deviceId,
              name: remoteName,
              host: remoteIp,
              port: remotePort,
            ));
            notifyListeners();
          }
        }
      }
    } catch (_) {}
  }

  void _stopUdpBeacon() {
    _udpBeaconTimer?.cancel();
    _udpBeaconTimer = null;
    _udpSocket?.close();
    _udpSocket = null;
  }

  Future<List<String>> getLocalIpAddresses() async {
    final List<String> ips = [];
    try {
      final interfaces = await NetworkInterface.list(
        type: InternetAddressType.IPv4,
        includeLinkLocal: false,
      );
      for (final interface in interfaces) {
        for (final addr in interface.addresses) {
          if (!addr.isLoopback && !addr.isLinkLocal) {
            ips.add(addr.address);
          }
        }
      }
    } catch (_) {}

    // Sort to prioritize standard Wi-Fi LAN subnets (192.168.x.x, 10.x.x.x, 172.16-31.x.x)
    ips.sort((a, b) {
      final aIsLan = a.startsWith('192.168.') || a.startsWith('10.') || (a.startsWith('172.') && !a.startsWith('172.17.'));
      final bIsLan = b.startsWith('192.168.') || b.startsWith('10.') || (b.startsWith('172.') && !b.startsWith('172.17.'));
      if (aIsLan && !bIsLan) return -1;
      if (!aIsLan && bIsLan) return 1;
      return a.compareTo(b);
    });

    return ips;
  }

  Future<void> triggerSyncWithIp(String rawHost, int port) async {
    String cleanHost = rawHost.trim();
    int cleanPort = port;

    // Handle user entering http:// or https://
    if (cleanHost.startsWith('http://')) {
      cleanHost = cleanHost.substring(7);
    } else if (cleanHost.startsWith('https://')) {
      cleanHost = cleanHost.substring(8);
    }

    // Handle user pasting IP:Port e.g. "192.168.1.15:8081"
    if (cleanHost.contains(':')) {
      final parts = cleanHost.split(':');
      cleanHost = parts[0].trim();
      final parsedPort = int.tryParse(parts[1].trim());
      if (parsedPort != null) {
        cleanPort = parsedPort;
      }
    }

    if (cleanHost.contains('/')) {
      cleanHost = cleanHost.split('/').first.trim();
    }

    final device = DiscoveredDevice(
      id: 'manual_$cleanHost:$cleanPort',
      name: 'Manual ($cleanHost)',
      host: cleanHost,
      port: cleanPort,
    );
    await triggerSyncWith(device);
  }

  Future<void> triggerSyncWith(DiscoveredDevice device) async {
    if (_isSyncing) return;
    _isSyncing = true;
    _syncStatusText = 'Connecting to ${device.host}:${device.port}...';
    notifyListeners();

    final client = http.Client();
    final baseUrl = 'http://${device.host}:${device.port}';

    try {
      // 1. Fetch remote metadata
      _syncStatusText = 'Fetching metadata...';
      notifyListeners();

      final metaRes = await client.get(Uri.parse('$baseUrl/sync/meta')).timeout(const Duration(seconds: 8));
      if (metaRes.statusCode != 200) throw Exception('Server responded with status ${metaRes.statusCode}');
      
      final remoteMeta = jsonDecode(metaRes.body) as Map<String, dynamic>;

      // 2. Determine what local records need to be sent
      _syncStatusText = 'Preparing data payload...';
      notifyListeners();
      final localPayload = await _buildExchangePayload(remoteMeta);

      // 3. Exchange data
      _syncStatusText = 'Exchanging databases...';
      notifyListeners();
      final exchangeRes = await client.post(
        Uri.parse('$baseUrl/sync/exchange'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(localPayload),
      ).timeout(const Duration(seconds: 30));

      if (exchangeRes.statusCode != 200) throw Exception('Exchange failed: ${exchangeRes.body}');
      final responsePayload = jsonDecode(exchangeRes.body) as Map<String, dynamic>;

      // 4. Merge received data
      _syncStatusText = 'Merging updates...';
      notifyListeners();
      await _mergePayload(responsePayload);
      _invalidateProviders();

      // 5. Download missing document files
      _syncStatusText = 'Checking missing files...';
      notifyListeners();
      await _syncMissingFiles(client, baseUrl);

      _syncStatusText = 'Sync complete!';
    } catch (e) {
      if (e is SocketException) {
        _syncStatusText = 'Connection failed: Cannot reach ${device.host}:${device.port}. Ensure server switch is ON on remote device & both are on same Wi-Fi.';
      } else if (e is TimeoutException) {
        _syncStatusText = 'Connection timed out to ${device.host}:${device.port}. Check firewall or network connection.';
      } else {
        _syncStatusText = 'Sync failed: $e';
      }
    } finally {
      client.close();
      _isSyncing = false;
      notifyListeners();
    }
  }

  // --- INTERNAL HELPER PROCEDURES ---

  /// Helper to collect records that are newer than remote counterparts
  Future<Map<String, dynamic>> _buildExchangePayload(Map<String, dynamic> remoteMeta) async {
    final remoteCustomers = {for (var item in remoteMeta['customers'] ?? []) item['uuid'] as String: DateTime.parse(item['updatedAt'] as String)};
    final remoteCompanies = {for (var item in remoteMeta['companies'] ?? []) item['uuid'] as String: DateTime.parse(item['updatedAt'] as String)};
    final remoteTasks = {for (var item in remoteMeta['tasks'] ?? []) item['uuid'] as String: DateTime.parse(item['updatedAt'] as String)};
    final remoteLeads = {for (var item in remoteMeta['leads'] ?? []) item['uuid'] as String: DateTime.parse(item['updatedAt'] as String)};

    final localCustomers = await _db.isar.customers.where().findAll();
    final localCompanies = await _db.isar.companys.where().findAll();
    final localTasks = await _db.isar.workTasks.where().findAll();
    final localLeads = await _db.isar.marketingLeads.where().findAll();

    final List<Map<String, dynamic>> sendCustomers = [];
    for (final c in localCustomers) {
      final remTime = remoteCustomers[c.uuid];
      if (remTime == null || c.updatedAt.isAfter(remTime)) {
        sendCustomers.add({
          'uuid': c.uuid,
          'customerId': c.customerId,
          'familyId': c.familyId,
          'name': c.name,
          'fatherName': c.fatherName,
          'dateOfBirth': c.dateOfBirth?.toIso8601String(),
          'age': c.age,
          'maritalStatus': c.maritalStatus,
          'spouseName': c.spouseName,
          'nationality': c.nationality,
          'aadhaarNumber': c.aadhaarNumber,
          'qualification': c.qualification,
          'height': c.height,
          'weight': c.weight,
          'numberOfChildren': c.numberOfChildren,
          'childrenDOBs': c.childrenDOBs?.map((d) => d.toIso8601String()).toList(),
          'fatherDOB': c.fatherDOB?.toIso8601String(),
          'motherDOB': c.motherDOB?.toIso8601String(),
          'spouseDOB': c.spouseDOB?.toIso8601String(),
          'fatherAge': c.fatherAge,
          'motherAge': c.motherAge,
          'spouseAge': c.spouseAge,
          'brotherAge': c.brotherAge,
          'sisterAge': c.sisterAge,
          'familyDOB': c.familyDOB?.toIso8601String(),
          'employerBusinessName': c.employerBusinessName,
          'designation': c.designation,
          'natureOfBusiness': c.natureOfBusiness,
          'annualIncome': c.annualIncome,
          'officeContactNumber': c.officeContactNumber,
          'mobileNumber1': c.mobileNumber1,
          'mobileNumber2': c.mobileNumber2,
          'mobileNumber3': c.mobileNumber3,
          'mobileNumber4': c.mobileNumber4,
          'emailId': c.emailId,
          'panNumber': c.panNumber,
          'weddingAnniversary': c.weddingAnniversary?.toIso8601String(),
          'nomineeName': c.nomineeName,
          'nomineeRelationship': c.nomineeRelationship,
          'nomineeDOB': c.nomineeDOB?.toIso8601String(),
          'nomineeAge': c.nomineeAge,
          'nomineeFatherName': c.nomineeFatherName,
          'nomineePan': c.nomineePan,
          'nomineeMobile1': c.nomineeMobile1,
          'nomineeMobile2': c.nomineeMobile2,
          'nomineeEmail': c.nomineeEmail,
          'appointeeName': c.appointeeName,
          'appointeeDOB': c.appointeeDOB?.toIso8601String(),
          'appointeeAge': c.appointeeAge,
          'appointeeRelationship': c.appointeeRelationship,
          'appointeeOtherRelationship': c.appointeeOtherRelationship,
          'selfPolicyNumber': c.selfPolicyNumber,
          'selfAadhaarNumber': c.selfAadhaarNumber,
          'selfSumAssured1': c.selfSumAssured1,
          'selfSumAssured2': c.selfSumAssured2,
          'selfYearOfIssue': c.selfYearOfIssue,
          'selfCompany': c.selfCompany,
          'fatherPolicyNumber': c.fatherPolicyNumber,
          'fatherCompany': c.fatherCompany,
          'motherPolicyNumber': c.motherPolicyNumber,
          'motherCompany': c.motherCompany,
          'spousePolicyNumber': c.spousePolicyNumber,
          'spouseCompany': c.spouseCompany,
          'childrenPolicyNumber': c.childrenPolicyNumber,
          'childrenCompany': c.childrenCompany,
          'childrenPolicyNumbers': c.childrenPolicyNumbers,
          'childrenCompanies': c.childrenCompanies,
          'hasExistingPolicy': c.hasExistingPolicy,
          'existingSelfCompany': c.existingSelfCompany,
          'existingPolicyNumber': c.existingPolicyNumber,
          'existingDocDate': c.existingDocDate?.toIso8601String(),
          'healthProblems': c.healthProblems,
          'lifestyleHabits': c.lifestyleHabits,
          'pregnancyDetails': c.pregnancyDetails,
          'healthRemarks': c.healthRemarks,
          'hasPersonalAccident': c.hasPersonalAccident,
          'personalAccidentDate': c.personalAccidentDate?.toIso8601String(),
          'communicationAddress': c.communicationAddress,
          'permanentAddress': c.permanentAddress,
          'productName': c.productName,
          'premiumMode': c.premiumMode,
          'planSumAssured': c.planSumAssured,
          'rider': c.rider,
          'riskCover': c.riskCover,
          'pensionPlan': c.pensionPlan,
          'investmentPlan': c.investmentPlan,
          'mutualFunds': c.mutualFunds,
          'mediClaim': c.mediClaim,
          'moneyBackPolicy': c.moneyBackPolicy,
          'childrenEducationPlan': c.childrenEducationPlan,
          'reminderDate1': c.reminderDate1?.toIso8601String(),
          'reminderNote1': c.reminderNote1,
          'reminderDate2': c.reminderDate2?.toIso8601String(),
          'reminderNote2': c.reminderNote2,
          'reminderDate3': c.reminderDate3?.toIso8601String(),
          'reminderNote3': c.reminderNote3,
          'reminderDate4': c.reminderDate4?.toIso8601String(),
          'reminderNote4': c.reminderNote4,
          'reminderDate5': c.reminderDate5?.toIso8601String(),
          'reminderNote5': c.reminderNote5,
          'referenceFriendName': c.referenceFriendName,
          'referenceMobile': c.referenceMobile,
          'referenceAge': c.referenceAge,
          'notes': c.notes,
          'updatedAt': c.updatedAt.toIso8601String(),
          'isDeleted': c.isDeleted,
          'assignedCompanyId': c.assignedCompanyId,
          'plans': c.plans.map((p) => {
            'planTitle': p.planTitle,
            'productName': p.productName,
            'premium': p.premium,
            'mode': p.mode,
            'planSumAssured': p.planSumAssured,
            'rider': p.rider,
            'planDate': p.planDate?.toIso8601String(),
          }).toList(),
          'references': c.references.map((r) => {
            'name': r.name,
            'mobile': r.mobile,
            'age': r.age,
          }).toList(),
          'reminders': c.reminders.map((rem) => {
            'reminderTitle': rem.reminderTitle,
            'reminderDate': rem.reminderDate?.toIso8601String(),
            'note': rem.note,
          }).toList(),
          'documents': c.documents.map((d) => {'documentName': d.documentName, 'fileName': d.fileName}).toList(),
        });
      }
    }

    final List<Map<String, dynamic>> sendCompanies = [];
    for (final c in localCompanies) {
      final remTime = remoteCompanies[c.uuid];
      if (remTime == null || c.updatedAt.isAfter(remTime)) {
        sendCompanies.add({
          'uuid': c.uuid,
          'name': c.name,
          'referenceNumber': c.referenceNumber,
          'tabIndex': c.tabIndex,
          'updatedAt': c.updatedAt.toIso8601String(),
          'isDeleted': c.isDeleted,
        });
      }
    }

    final List<Map<String, dynamic>> sendTasks = [];
    for (final t in localTasks) {
      final remTime = remoteTasks[t.uuid];
      if (remTime == null || t.updatedAt.isAfter(remTime)) {
        sendTasks.add({
          'uuid': t.uuid,
          'companyId': t.companyId,
          'description': t.description,
          'workDate': t.workDate.toIso8601String(),
          'assignedDate': t.assignedDate?.toIso8601String(),
          'createdAt': t.createdAt?.toIso8601String(),
          'priority': t.priority,
          'assignedTo': t.assignedTo,
          'communicationMethod': t.communicationMethod,
          'status': t.status,
          'carryForwardRequired': t.carryForwardRequired,
          'carryForwardDate': t.carryForwardDate?.toIso8601String(),
          'carryForwardReason': t.carryForwardReason,
          'remarks': t.remarks,
          'updatedAt': t.updatedAt.toIso8601String(),
          'isDeleted': t.isDeleted,
        });
      }
    }

    final List<Map<String, dynamic>> sendLeads = [];
    for (final l in localLeads) {
      final remTime = remoteLeads[l.uuid];
      if (remTime == null || l.updatedAt.isAfter(remTime)) {
        sendLeads.add({
          'uuid': l.uuid,
          'name': l.name,
          'mobile': l.mobile,
          'status': l.status,
          'visits': l.visits.map((v) => {
            'visitDate': v.visitDate?.toIso8601String(),
            'visitTime': v.visitTime,
            'visitNote': v.visitNote,
            'attachedPhoto': v.attachedPhoto,
            'attachedPhotos': v.attachedPhotos,
          }).toList(),
          'updatedAt': l.updatedAt.toIso8601String(),
          'isDeleted': l.isDeleted,
        });
      }
    }

    final remoteNotes = {for (var item in remoteMeta['notes'] ?? []) item['uuid'] as String: DateTime.parse(item['updatedAt'] as String)};
    final localNotes = await _db.isar.dailyNotes.where().findAll();
    final List<Map<String, dynamic>> sendNotes = [];
    for (final n in localNotes) {
      final lastTime = n.updatedAt ?? n.createdAt;
      final remTime = remoteNotes[n.noteId];
      if (remTime == null || lastTime.isAfter(remTime)) {
        sendNotes.add({
          'noteId': n.noteId,
          'dateKey': n.dateKey,
          'content': n.content,
          'category': n.category,
          'isCompleted': n.isCompleted,
          'createdAt': n.createdAt.toIso8601String(),
          'updatedAt': lastTime.toIso8601String(),
        });
      }
    }

    // Build overall metadata
    final localMeta = {
      'customers': localCustomers.map((c) => {'uuid': c.uuid, 'updatedAt': c.updatedAt.toIso8601String()}).toList(),
      'companies': localCompanies.map((c) => {'uuid': c.uuid, 'updatedAt': c.updatedAt.toIso8601String()}).toList(),
      'tasks': localTasks.map((t) => {'uuid': t.uuid, 'updatedAt': t.updatedAt.toIso8601String()}).toList(),
      'leads': localLeads.map((l) => {'uuid': l.uuid, 'updatedAt': l.updatedAt.toIso8601String()}).toList(),
      'notes': localNotes.map((n) => {'uuid': n.noteId, 'updatedAt': (n.updatedAt ?? n.createdAt).toIso8601String()}).toList(),
    };

    return {
      'customers': sendCustomers,
      'companies': sendCompanies,
      'tasks': sendTasks,
      'leads': sendLeads,
      'notes': sendNotes,
      'meta': localMeta
    };
  }

  /// Merges remote exchanges using LWW conflict resolution
  Future<void> _mergePayload(Map<String, dynamic> payload) async {
    await _db.isar.writeTxn(() async {
      // 1. Merge Companies
      final List<dynamic> remCompanies = payload['companies'] ?? [];
      for (final json in remCompanies) {
        final uuid = json['uuid'] as String;
        final updatedAt = DateTime.parse(json['updatedAt'] as String);
        
        final existing = await _db.isar.companys.filter().uuidEqualTo(uuid).findFirst();
        if (existing == null || updatedAt.isAfter(existing.updatedAt)) {
          final comp = existing ?? Company();
          comp.uuid = uuid;
          comp.name = json['name'] as String;
          comp.referenceNumber = json['referenceNumber'] as String?;
          comp.tabIndex = json['tabIndex'] as int? ?? 0;
          comp.updatedAt = updatedAt;
          comp.isDeleted = json['isDeleted'] as bool? ?? false;
          await _db.isar.companys.put(comp);
        }
      }

      // 2. Merge Customers
      final List<dynamic> remCustomers = payload['customers'] ?? [];
      for (final json in remCustomers) {
        final uuid = json['uuid'] as String;
        final updatedAt = DateTime.parse(json['updatedAt'] as String);

        // 1. Primary lookup by UUID
        Customer? existing = await _db.isar.customers.filter().uuidEqualTo(uuid).findFirst();

        // 2. Fallback lookup by customerId (e.g. CUST-001)
        final customerIdVal = json['customerId'] as String?;
        if (existing == null && customerIdVal != null && customerIdVal.trim().isNotEmpty) {
          existing = await _db.isar.customers.filter().customerIdEqualTo(customerIdVal.trim()).findFirst();
        }

        // 3. Fallback lookup by Name + Mobile 1
        final nameVal = json['name'] as String?;
        final mobileVal = json['mobileNumber1'] as String?;
        if (existing == null && nameVal != null && nameVal.trim().isNotEmpty && mobileVal != null && mobileVal.trim().isNotEmpty) {
          existing = await _db.isar.customers
              .filter()
              .nameEqualTo(nameVal.trim(), caseSensitive: false)
              .and()
              .mobileNumber1EqualTo(mobileVal.trim())
              .findFirst();
        }

        if (existing == null || updatedAt.isAfter(existing.updatedAt)) {
          final cust = existing ?? Customer();
          cust.uuid = uuid; // Unify system UUID across sync nodes
          cust.customerId = customerIdVal;
          cust.familyId = json['familyId'] as String?;
          cust.name = json['name'] as String;
          cust.fatherName = json['fatherName'] as String?;
          cust.dateOfBirth = json['dateOfBirth'] != null ? DateTime.parse(json['dateOfBirth'] as String) : null;
          cust.age = json['age'] as String?;
          cust.maritalStatus = json['maritalStatus'] as String?;
          cust.spouseName = json['spouseName'] as String?;
          cust.nationality = json['nationality'] as String?;
          cust.aadhaarNumber = json['aadhaarNumber'] as String?;
          cust.qualification = json['qualification'] as String?;
          cust.height = json['height'] as String?;
          cust.weight = json['weight'] as String?;
          cust.numberOfChildren = json['numberOfChildren'] as int?;
          cust.childrenDOBs = (json['childrenDOBs'] as List?)?.map((d) => DateTime.parse(d as String)).toList();
          cust.fatherDOB = json['fatherDOB'] != null ? DateTime.parse(json['fatherDOB'] as String) : null;
          cust.motherDOB = json['motherDOB'] != null ? DateTime.parse(json['motherDOB'] as String) : null;
          cust.spouseDOB = json['spouseDOB'] != null ? DateTime.parse(json['spouseDOB'] as String) : null;
          cust.fatherAge = json['fatherAge'] as String?;
          cust.motherAge = json['motherAge'] as String?;
          cust.spouseAge = json['spouseAge'] as String?;
          cust.brotherAge = json['brotherAge'] as String?;
          cust.sisterAge = json['sisterAge'] as String?;
          cust.familyDOB = json['familyDOB'] != null ? DateTime.parse(json['familyDOB'] as String) : null;
          cust.employerBusinessName = json['employerBusinessName'] as String?;
          cust.designation = json['designation'] as String?;
          cust.natureOfBusiness = json['natureOfBusiness'] as String?;
          cust.annualIncome = json['annualIncome'] as String?;
          cust.officeContactNumber = json['officeContactNumber'] as String?;
          cust.mobileNumber1 = json['mobileNumber1'] as String?;
          cust.mobileNumber2 = json['mobileNumber2'] as String?;
          cust.mobileNumber3 = json['mobileNumber3'] as String?;
          cust.mobileNumber4 = json['mobileNumber4'] as String?;
          cust.emailId = json['emailId'] as String?;
          cust.panNumber = json['panNumber'] as String?;
          cust.weddingAnniversary = json['weddingAnniversary'] != null ? DateTime.parse(json['weddingAnniversary'] as String) : null;
          cust.nomineeName = json['nomineeName'] as String?;
          cust.nomineeRelationship = json['nomineeRelationship'] as String?;
          cust.nomineeDOB = json['nomineeDOB'] != null ? DateTime.parse(json['nomineeDOB'] as String) : null;
          cust.nomineeAge = json['nomineeAge'] as String?;
          cust.nomineeFatherName = json['nomineeFatherName'] as String?;
          cust.nomineePan = json['nomineePan'] as String?;
          cust.nomineeMobile1 = json['nomineeMobile1'] as String?;
          cust.nomineeMobile2 = json['nomineeMobile2'] as String?;
          cust.nomineeEmail = json['nomineeEmail'] as String?;
          cust.appointeeName = json['appointeeName'] as String?;
          cust.appointeeDOB = json['appointeeDOB'] != null ? DateTime.parse(json['appointeeDOB'] as String) : null;
          cust.appointeeAge = json['appointeeAge'] as String?;
          cust.appointeeRelationship = json['appointeeRelationship'] as String?;
          cust.appointeeOtherRelationship = json['appointeeOtherRelationship'] as String?;
          cust.selfPolicyNumber = json['selfPolicyNumber'] as String?;
          cust.selfAadhaarNumber = json['selfAadhaarNumber'] as String?;
          cust.selfSumAssured1 = json['selfSumAssured1'] as String?;
          cust.selfSumAssured2 = json['selfSumAssured2'] as String?;
          cust.selfYearOfIssue = json['selfYearOfIssue'] as String?;
          cust.selfCompany = json['selfCompany'] as String?;
          cust.fatherPolicyNumber = json['fatherPolicyNumber'] as String?;
          cust.fatherCompany = json['fatherCompany'] as String?;
          cust.motherPolicyNumber = json['motherPolicyNumber'] as String?;
          cust.motherCompany = json['motherCompany'] as String?;
          cust.spousePolicyNumber = json['spousePolicyNumber'] as String?;
          cust.spouseCompany = json['spouseCompany'] as String?;
          cust.childrenPolicyNumber = json['childrenPolicyNumber'] as String?;
          cust.childrenCompany = json['childrenCompany'] as String?;
          cust.childrenPolicyNumbers = (json['childrenPolicyNumbers'] as List?)?.map((e) => e as String).toList();
          cust.childrenCompanies = (json['childrenCompanies'] as List?)?.map((e) => e as String).toList();
          cust.hasExistingPolicy = json['hasExistingPolicy'] as String?;
          cust.existingSelfCompany = json['existingSelfCompany'] as String?;
          cust.existingPolicyNumber = json['existingPolicyNumber'] as String?;
          cust.existingDocDate = json['existingDocDate'] != null ? DateTime.parse(json['existingDocDate'] as String) : null;
          cust.healthProblems = json['healthProblems'] as String?;
          cust.lifestyleHabits = json['lifestyleHabits'] as String?;
          cust.pregnancyDetails = json['pregnancyDetails'] as String?;
          cust.healthRemarks = json['healthRemarks'] as String?;
          cust.hasPersonalAccident = json['hasPersonalAccident'] as String?;
          cust.personalAccidentDate = json['personalAccidentDate'] != null ? DateTime.parse(json['personalAccidentDate'] as String) : null;
          cust.communicationAddress = json['communicationAddress'] as String?;
          cust.permanentAddress = json['permanentAddress'] as String?;
          cust.productName = json['productName'] as String?;
          cust.premiumMode = json['premiumMode'] as String?;
          cust.planSumAssured = json['planSumAssured'] as String?;
          cust.rider = json['rider'] as String?;
          cust.riskCover = json['riskCover'] as String?;
          cust.pensionPlan = json['pensionPlan'] as String?;
          cust.investmentPlan = json['investmentPlan'] as String?;
          cust.mutualFunds = json['mutualFunds'] as String?;
          cust.mediClaim = json['mediClaim'] as String?;
          cust.moneyBackPolicy = json['moneyBackPolicy'] as String?;
          cust.childrenEducationPlan = json['childrenEducationPlan'] as String?;
          cust.reminderDate1 = json['reminderDate1'] != null ? DateTime.parse(json['reminderDate1'] as String) : null;
          cust.reminderNote1 = json['reminderNote1'] as String?;
          cust.reminderDate2 = json['reminderDate2'] != null ? DateTime.parse(json['reminderDate2'] as String) : null;
          cust.reminderNote2 = json['reminderNote2'] as String?;
          cust.reminderDate3 = json['reminderDate3'] != null ? DateTime.parse(json['reminderDate3'] as String) : null;
          cust.reminderNote3 = json['reminderNote3'] as String?;
          cust.reminderDate4 = json['reminderDate4'] != null ? DateTime.parse(json['reminderDate4'] as String) : null;
          cust.reminderNote4 = json['reminderNote4'] as String?;
          cust.reminderDate5 = json['reminderDate5'] != null ? DateTime.parse(json['reminderDate5'] as String) : null;
          cust.reminderNote5 = json['reminderNote5'] as String?;
          cust.referenceFriendName = json['referenceFriendName'] as String?;
          cust.referenceMobile = json['referenceMobile'] as String?;
          cust.referenceAge = json['referenceAge'] as String?;
          cust.notes = json['notes'] as String?;
          cust.updatedAt = updatedAt;
          cust.isDeleted = json['isDeleted'] as bool? ?? false;
          cust.assignedCompanyId = json['assignedCompanyId'] as int?;

          // Map plans
          final List<dynamic> plansJson = json['plans'] ?? [];
          cust.plans = plansJson.map((p) => CustomerPlanItem()
            ..planTitle = p['planTitle'] as String?
            ..productName = p['productName'] as String?
            ..premium = p['premium'] as String?
            ..mode = p['mode'] as String?
            ..planSumAssured = p['planSumAssured'] as String?
            ..rider = p['rider'] as String?
            ..planDate = p['planDate'] != null ? DateTime.parse(p['planDate'] as String) : null).toList();

          // Map references
          final List<dynamic> refsJson = json['references'] ?? [];
          cust.references = refsJson.map((r) => CustomerReferenceItem()
            ..name = r['name'] as String?
            ..mobile = r['mobile'] as String?
            ..age = r['age'] as String?).toList();

          // Map reminders
          final List<dynamic> remsJson = json['reminders'] ?? [];
          cust.reminders = remsJson.map((rem) => CustomerReminderItem()
            ..reminderTitle = rem['reminderTitle'] as String?
            ..reminderDate = rem['reminderDate'] != null ? DateTime.parse(rem['reminderDate'] as String) : null
            ..note = rem['note'] as String?).toList();

          // Map documents
          final List<dynamic> docsJson = json['documents'] ?? [];
          cust.documents = docsJson.map((d) => CustomerDocument()
            ..documentName = d['documentName'] as String?
            ..fileName = d['fileName'] as String?).toList();

          await _db.isar.customers.put(cust);
        }
      }

      // 3. Merge Tasks
      final List<dynamic> remTasks = payload['tasks'] ?? [];
      for (final json in remTasks) {
        final uuid = json['uuid'] as String;
        final updatedAt = DateTime.parse(json['updatedAt'] as String);

        final existing = await _db.isar.workTasks.filter().uuidEqualTo(uuid).findFirst();
        if (existing == null || updatedAt.isAfter(existing.updatedAt)) {
          final task = existing ?? WorkTask();
          task.uuid = uuid;
          task.companyId = json['companyId'] as int?;
          task.description = json['description'] as String;
          task.workDate = DateTime.parse(json['workDate'] as String);
          task.assignedDate = json['assignedDate'] != null ? DateTime.parse(json['assignedDate'] as String) : null;
          task.createdAt = json['createdAt'] != null ? DateTime.parse(json['createdAt'] as String) : null;
          task.priority = json['priority'] as String;
          task.assignedTo = json['assignedTo'] as String?;
          task.communicationMethod = json['communicationMethod'] as String?;
          task.status = json['status'] as String;
          task.carryForwardRequired = json['carryForwardRequired'] as bool? ?? false;
          task.carryForwardDate = json['carryForwardDate'] != null ? DateTime.parse(json['carryForwardDate'] as String) : null;
          task.carryForwardReason = json['carryForwardReason'] as String?;
          task.remarks = json['remarks'] as String?;
          task.updatedAt = updatedAt;
          task.isDeleted = json['isDeleted'] as bool? ?? false;
          await _db.isar.workTasks.put(task);
        }
      }

      // 4. Merge Marketing Leads
      final List<dynamic> remLeads = payload['leads'] ?? [];
      for (final json in remLeads) {
        final uuid = json['uuid'] as String;
        final updatedAt = DateTime.parse(json['updatedAt'] as String);

        final existing = await _db.isar.marketingLeads.filter().uuidEqualTo(uuid).findFirst();
        if (existing == null || updatedAt.isAfter(existing.updatedAt)) {
          final lead = existing ?? MarketingLead();
          lead.uuid = uuid;
          lead.name = json['name'] as String;
          lead.mobile = json['mobile'] as String;
          lead.status = json['status'] as String;
          lead.updatedAt = updatedAt;
          lead.isDeleted = json['isDeleted'] as bool? ?? false;

          final List<dynamic> visitsJson = json['visits'] ?? [];
          lead.visits = visitsJson.map((v) => MarketingVisit()
            ..visitDate = v['visitDate'] != null ? DateTime.parse(v['visitDate'] as String) : null
            ..visitTime = v['visitTime'] as String?
            ..visitNote = v['visitNote'] as String?
            ..attachedPhoto = v['attachedPhoto'] as String?
            ..attachedPhotos = (v['attachedPhotos'] as List?)?.map((e) => e as String).toList() ?? []).toList();

          await _db.isar.marketingLeads.put(lead);
        }
      }

      // 5. Merge Daily Notes & Tasks
      final List<dynamic> remNotes = payload['notes'] ?? [];
      for (final json in remNotes) {
        final noteId = json['noteId'] as String;
        final updatedAt = DateTime.parse(json['updatedAt'] as String);

        final existing = await _db.isar.dailyNotes.filter().noteIdEqualTo(noteId).findFirst();
        final localTime = existing != null ? (existing.updatedAt ?? existing.createdAt) : null;
        if (existing == null || updatedAt.isAfter(localTime!)) {
          final note = existing ?? DailyNote();
          note.noteId = noteId;
          note.dateKey = json['dateKey'] as String;
          note.content = json['content'] as String;
          note.category = json['category'] as String?;
          note.isCompleted = json['isCompleted'] as bool? ?? false;
          note.createdAt = json['createdAt'] != null ? DateTime.parse(json['createdAt'] as String) : DateTime.now();
          note.updatedAt = updatedAt;
          await _db.isar.dailyNotes.put(note);
        }
      }

      // 6. Automatic Deduplication Sweep: purge any duplicate customer clones
      final allCusts = await _db.isar.customers.where().findAll();
      final Map<String, List<Customer>> custIdMap = {};
      for (final c in allCusts) {
        final key = (c.customerId != null && c.customerId!.trim().isNotEmpty)
            ? 'id_${c.customerId!.trim()}'
            : 'uuid_${c.uuid}';
        custIdMap.putIfAbsent(key, () => []).add(c);
      }

      for (final list in custIdMap.values) {
        if (list.length > 1) {
          // Sort by updatedAt descending (newest update first)
          list.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
          // Keep newest (list[0]), delete older duplicates
          for (int i = 1; i < list.length; i++) {
            await _db.isar.customers.delete(list[i].id);
          }
        }
      }
    });
  }

  /// Downloads missing attachment files (customer documents & marketing photos) from the server
  Future<void> _syncMissingFiles(http.Client client, String baseUrl) async {
    final docsDir = await AppStorageService.getCustomerDocumentsDirectory();
    final Set<String> requiredFileNames = {};

    // 1. Collect Customer documents
    final customers = await _db.isar.customers.where().findAll();
    for (final cust in customers) {
      for (final doc in cust.documents) {
        if (doc.fileName != null && doc.fileName!.trim().isNotEmpty) {
          requiredFileNames.add(doc.fileName!.trim());
        }
      }
    }

    // 2. Collect Marketing Lead photos and documents
    final leads = await _db.isar.marketingLeads.where().findAll();
    for (final lead in leads) {
      for (final visit in lead.visits) {
        if (visit.attachedPhoto != null && visit.attachedPhoto!.trim().isNotEmpty) {
          requiredFileNames.add(visit.attachedPhoto!.trim());
        }
        for (final photo in visit.attachedPhotos) {
          if (photo.trim().isNotEmpty) {
            requiredFileNames.add(photo.trim());
          }
        }
      }
    }

    // 3. Two-way attachment file sync: download missing local files & upload missing remote files
    for (final fileName in requiredFileNames) {
      final localFile = File('${docsDir.path}/$fileName');
      if (!localFile.existsSync()) {
        try {
          final fileUrl = '$baseUrl/sync/file/$fileName';
          final response = await client.get(Uri.parse(fileUrl));
          if (response.statusCode == 200) {
            await localFile.writeAsBytes(response.bodyBytes, flush: true);
          }
        } catch (e) {
          debugPrint('Failed to download missing file $fileName: $e');
        }
      } else {
        try {
          final checkUrl = '$baseUrl/sync/has_file/$fileName';
          final checkRes = await client.get(Uri.parse(checkUrl)).timeout(const Duration(seconds: 3));
          if (checkRes.statusCode == 200) {
            final checkData = jsonDecode(checkRes.body) as Map<String, dynamic>;
            final bool remoteHasFile = checkData['exists'] as bool? ?? false;
            if (!remoteHasFile) {
              final uploadUrl = '$baseUrl/sync/file/$fileName';
              final fileBytes = await localFile.readAsBytes();
              await client.post(
                Uri.parse(uploadUrl),
                headers: {'Content-Type': 'application/octet-stream'},
                body: fileBytes,
              );
            }
          }
        } catch (e) {
          debugPrint('Failed to check or upload file $fileName: $e');
        }
      }
    }
  }
}
