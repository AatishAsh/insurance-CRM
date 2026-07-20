import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bonsoir/bonsoir.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart' as shelf_router;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:isar/isar.dart';
import 'database_service.dart';
import '../models/customer.dart';
import '../models/company.dart';
import '../models/work_task.dart';

final syncServiceProvider = ChangeNotifierProvider<SyncService>((ref) {
  final db = ref.watch(databaseServiceProvider);
  return SyncService(db);
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
  
  HttpServer? _server;
  int _serverPort = 8080;
  bool _isServerRunning = false;

  BonsoirBroadcast? _broadcast;
  BonsoirDiscovery? _discovery;
  final List<DiscoveredDevice> _discoveredDevices = [];
  bool _isDiscovering = false;
  bool _isSyncing = false;
  String _syncStatusText = 'Idle';

  SyncService(this._db);

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

        final meta = {
          'customers': customers.map((c) => {'uuid': c.uuid, 'updatedAt': c.updatedAt.toIso8601String()}).toList(),
          'companies': companies.map((c) => {'uuid': c.uuid, 'updatedAt': c.updatedAt.toIso8601String()}).toList(),
          'tasks': tasks.map((t) => {'uuid': t.uuid, 'updatedAt': t.updatedAt.toIso8601String()}).toList(),
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
        final appDir = await getApplicationDocumentsDirectory();
        final file = File('${appDir.path}/customer_documents/$filename');
        if (await file.exists()) {
          return Response.ok(file.openRead(), headers: {
            'Content-Type': 'application/octet-stream',
            'Content-Disposition': 'attachment; filename="$filename"',
          });
        } else {
          return Response.notFound('File $filename not found');
        }
      } catch (e) {
        return Response.internalServerError(body: 'Error: $e');
      }
    });

    // Start Shelf Server on an available port
    int port = 8080;
    while (port < 8090) {
      try {
        _server = await shelf_io.serve(router, InternetAddress.anyIPv4, port);
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
    }
  }

  Future<void> stopServer() async {
    await _stopBroadcasting();
    await _server?.close(force: true);
    _server = null;
    _isServerRunning = false;
    notifyListeners();
  }

  // --- MDNS BROADCASTING & DISCOVERY ---

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
      debugPrint('mDNS Broadcast error: $e');
    }
  }

  Future<void> _stopBroadcasting() async {
    await _broadcast?.stop();
    _broadcast = null;
  }

  Future<void> startDiscovery() async {
    if (_isDiscovering) return;
    _discoveredDevices.clear();
    _isDiscovering = true;
    notifyListeners();

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
              // Find resolved IP address
              String hostIp = service.ip ?? 'localhost';
              
              // Add device if not already present
              final deviceId = service.name;
              if (!_discoveredDevices.any((d) => d.id == deviceId)) {
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
      _isDiscovering = false;
      notifyListeners();
      debugPrint('mDNS Discovery error: $e');
    }
  }

  Future<void> stopDiscovery() async {
    await _discovery?.stop();
    _discovery = null;
    _isDiscovering = false;
    notifyListeners();
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
          if (!addr.isLoopback) {
            ips.add(addr.address);
          }
        }
      }
    } catch (_) {}
    return ips;
  }

  Future<void> triggerSyncWithIp(String host, int port) async {
    final device = DiscoveredDevice(
      id: 'manual_$host:$port',
      name: 'Manual ($host)',
      host: host.trim(),
      port: port,
    );
    await triggerSyncWith(device);
  }

  Future<void> triggerSyncWith(DiscoveredDevice device) async {
    if (_isSyncing) return;
    _isSyncing = true;
    _syncStatusText = 'Connecting to ${device.name}...';
    notifyListeners();

    final client = http.Client();
    final baseUrl = 'http://${device.host}:${device.port}';

    try {
      // 1. Fetch remote metadata
      _syncStatusText = 'Fetching metadata...';
      notifyListeners();

      final metaRes = await client.get(Uri.parse('$baseUrl/sync/meta')).timeout(const Duration(seconds: 5));
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
      ).timeout(const Duration(seconds: 15));

      if (exchangeRes.statusCode != 200) throw Exception('Exchange failed: ${exchangeRes.body}');
      final responsePayload = jsonDecode(exchangeRes.body) as Map<String, dynamic>;

      // 4. Merge received data
      _syncStatusText = 'Merging updates...';
      notifyListeners();
      await _mergePayload(responsePayload);

      // 5. Download missing document files
      _syncStatusText = 'Checking missing files...';
      notifyListeners();
      await _syncMissingFiles(client, baseUrl);

      _syncStatusText = 'Sync complete!';
    } catch (e) {
      _syncStatusText = 'Sync failed: $e';
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

    final localCustomers = await _db.isar.customers.where().findAll();
    final localCompanies = await _db.isar.companys.where().findAll();
    final localTasks = await _db.isar.workTasks.where().findAll();

    final List<Map<String, dynamic>> sendCustomers = [];
    for (final c in localCustomers) {
      final remTime = remoteCustomers[c.uuid];
      if (remTime == null || c.updatedAt.isAfter(remTime)) {
        sendCustomers.add({
          'uuid': c.uuid,
          'customerId': c.customerId,
          'name': c.name,
          'fatherName': c.fatherName,
          'dateOfBirth': c.dateOfBirth?.toIso8601String(),
          'maritalStatus': c.maritalStatus,
          'spouseName': c.spouseName,
          'nationality': c.nationality,
          'aadhaarNumber': c.aadhaarNumber,
          'qualification': c.qualification,
          'height': c.height,
          'weight': c.weight,
          'numberOfChildren': c.numberOfChildren,
          'childrenDOBs': c.childrenDOBs?.map((d) => d.toIso8601String()).toList(),
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
          'nomineeFatherName': c.nomineeFatherName,
          'nomineePan': c.nomineePan,
          'nomineeMobile1': c.nomineeMobile1,
          'nomineeMobile2': c.nomineeMobile2,
          'nomineeEmail': c.nomineeEmail,
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
          'healthProblems': c.healthProblems,
          'lifestyleHabits': c.lifestyleHabits,
          'pregnancyDetails': c.pregnancyDetails,
          'healthRemarks': c.healthRemarks,
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
          'referenceFriendName': c.referenceFriendName,
          'referenceMobile': c.referenceMobile,
          'referenceAge': c.referenceAge,
          'notes': c.notes,
          'updatedAt': c.updatedAt.toIso8601String(),
          'isDeleted': c.isDeleted,
          'assignedCompanyId': c.assignedCompanyId,
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

    // Build overall metadata of A
    final localMeta = {
      'customers': localCustomers.map((c) => {'uuid': c.uuid, 'updatedAt': c.updatedAt.toIso8601String()}).toList(),
      'companies': localCompanies.map((c) => {'uuid': c.uuid, 'updatedAt': c.updatedAt.toIso8601String()}).toList(),
      'tasks': localTasks.map((t) => {'uuid': t.uuid, 'updatedAt': t.updatedAt.toIso8601String()}).toList(),
    };

    return {
      'customers': sendCustomers,
      'companies': sendCompanies,
      'tasks': sendTasks,
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

        final existing = await _db.isar.customers.filter().uuidEqualTo(uuid).findFirst();
        if (existing == null || updatedAt.isAfter(existing.updatedAt)) {
          final cust = existing ?? Customer();
          cust.uuid = uuid;
          cust.customerId = json['customerId'] as String?;
          cust.name = json['name'] as String;
          cust.fatherName = json['fatherName'] as String?;
          cust.dateOfBirth = json['dateOfBirth'] != null ? DateTime.parse(json['dateOfBirth'] as String) : null;
          cust.maritalStatus = json['maritalStatus'] as String?;
          cust.spouseName = json['spouseName'] as String?;
          cust.nationality = json['nationality'] as String?;
          cust.aadhaarNumber = json['aadhaarNumber'] as String?;
          cust.qualification = json['qualification'] as String?;
          cust.height = json['height'] as String?;
          cust.weight = json['weight'] as String?;
          cust.numberOfChildren = json['numberOfChildren'] as int?;
          cust.childrenDOBs = (json['childrenDOBs'] as List?)?.map((d) => DateTime.parse(d as String)).toList();
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
          cust.nomineeFatherName = json['nomineeFatherName'] as String?;
          cust.nomineePan = json['nomineePan'] as String?;
          cust.nomineeMobile1 = json['nomineeMobile1'] as String?;
          cust.nomineeMobile2 = json['nomineeMobile2'] as String?;
          cust.nomineeEmail = json['nomineeEmail'] as String?;
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
          cust.healthProblems = json['healthProblems'] as String?;
          cust.lifestyleHabits = json['lifestyleHabits'] as String?;
          cust.pregnancyDetails = json['pregnancyDetails'] as String?;
          cust.healthRemarks = json['healthRemarks'] as String?;
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
          cust.referenceFriendName = json['referenceFriendName'] as String?;
          cust.referenceMobile = json['referenceMobile'] as String?;
          cust.referenceAge = json['referenceAge'] as String?;
          cust.notes = json['notes'] as String?;
          cust.updatedAt = updatedAt;
          cust.isDeleted = json['isDeleted'] as bool? ?? false;
          cust.assignedCompanyId = json['assignedCompanyId'] as int?;

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
    });
  }

  /// Downloads missing attachment files from the server
  Future<void> _syncMissingFiles(http.Client client, String baseUrl) async {
    final appDir = await getApplicationDocumentsDirectory();
    final docsDir = Directory('${appDir.path}/customer_documents');
    if (!await docsDir.exists()) {
      await docsDir.create(recursive: true);
    }

    final customers = await _db.isar.customers.where().findAll();
    for (final cust in customers) {
      for (final doc in cust.documents) {
        if (doc.fileName == null || doc.fileName!.isEmpty) continue;
        final localFile = File('${docsDir.path}/${doc.fileName}');
        
        // If file doesn't exist locally, fetch it from remote server
        if (!localFile.existsSync()) {
          try {
            final fileUrl = '$baseUrl/sync/file/${doc.fileName}';
            final response = await client.get(Uri.parse(fileUrl));
            if (response.statusCode == 200) {
              await localFile.writeAsBytes(response.bodyBytes);
            }
          } catch (e) {
            debugPrint('Failed to download missing file ${doc.fileName}: $e');
          }
        }
      }
    }
  }
}
