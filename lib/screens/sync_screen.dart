import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import '../services/sync_service.dart';
import '../providers/auth_provider.dart';
import '../services/database_service.dart';
import '../providers/customer_provider.dart';
import '../providers/events_provider.dart';
import '../providers/work_provider.dart';
import '../services/backup_service.dart';
import '../services/security_service.dart';

class SyncScreen extends ConsumerStatefulWidget {
  const SyncScreen({super.key});

  @override
  ConsumerState<SyncScreen> createState() => _SyncScreenState();
}

class _SyncScreenState extends ConsumerState<SyncScreen> {
  final _pinController = TextEditingController();
  final _newPinController = TextEditingController();
  final _confirmPinController = TextEditingController();
  final _pinFormKey = GlobalKey<FormState>();

  bool _isChangingPin = false;

  @override
  void dispose() {
    _pinController.dispose();
    _newPinController.dispose();
    _confirmPinController.dispose();
    super.dispose();
  }

  void _changePin() async {
    if (!_pinFormKey.currentState!.validate()) return;

    final authNotifier = ref.read(authStateProvider.notifier);
    final success = await authNotifier.unlock(_pinController.text);
    if (!success) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Current PIN is incorrect'), backgroundColor: Colors.redAccent),
        );
      }
      return;
    }

    // Set new pin
    await authNotifier.setPin(_newPinController.text);
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('PIN updated successfully'), backgroundColor: Colors.green),
      );
      setState(() {
        _isChangingPin = false;
        _pinController.clear();
        _newPinController.clear();
        _confirmPinController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final syncService = ref.watch(syncServiceProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings & Synchronization'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Wi-Fi Sync Server Configuration Card
            Card(
              elevation: 0.5,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey[200]!),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.wifi_tethering, color: Colors.blueAccent),
                            SizedBox(width: 12),
                            Text('Local Server Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          ],
                        ),
                        Switch(
                          value: syncService.isServerRunning,
                          activeColor: Colors.blueAccent,
                          onChanged: (val) {
                            if (val) {
                              syncService.startServer();
                            } else {
                              syncService.stopServer();
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      syncService.isServerRunning
                          ? 'Server is running on port ${syncService.serverPort} and advertising on local Wi-Fi.'
                          : 'Server is stopped. Enable to allow other devices to sync data with this machine.',
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                    if (syncService.isServerRunning) ...[
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.info_outline, size: 16, color: Colors.blueAccent),
                            const SizedBox(width: 8),
                            Text(
                              'Service Name: ShineCRM_${syncService.serverPort}',
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.blueAccent),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Discovery & Sync Card
            Card(
              elevation: 0.5,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey[200]!),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.travel_explore, color: Colors.blueAccent),
                            SizedBox(width: 12),
                            Text('Discover Nearby Devices', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          ],
                        ),
                        IconButton(
                          icon: Icon(
                            syncService.isDiscovering ? Icons.stop_circle_outlined : Icons.play_arrow_outlined,
                            color: syncService.isDiscovering ? Colors.redAccent : Colors.green,
                          ),
                          onPressed: () {
                            if (syncService.isDiscovering) {
                              syncService.stopDiscovery();
                            } else {
                              syncService.startDiscovery();
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Search for other ShineCraft CRM nodes on the same local Wi-Fi router network.',
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                    const SizedBox(height: 16),
                    // Sync Status
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          if (syncService.isSyncing)
                            const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.blueAccent),
                            )
                          else
                            const Icon(Icons.sync, size: 16, color: Colors.grey),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Sync State: ${syncService.syncStatusText}',
                              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text('Discovered Hosts:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    const SizedBox(height: 8),
                    if (syncService.discoveredDevices.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Center(
                          child: Text(
                            syncService.isDiscovering
                                ? 'Scanning Wi-Fi broadcast channels...'
                                : 'Discovery inactive. Press Play above to scan.',
                            style: const TextStyle(color: Colors.grey, fontSize: 13, fontStyle: FontStyle.italic),
                          ),
                        ),
                      )
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: syncService.discoveredDevices.length,
                        itemBuilder: (context, index) {
                          final device = syncService.discoveredDevices[index];
                          return Card(
                            elevation: 0,
                            color: Colors.grey[50],
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.grey[200]!),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ListTile(
                              dense: true,
                              leading: const Icon(Icons.computer, color: Colors.blueAccent),
                              title: Text(device.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Text('${device.host}:${device.port}'),
                              trailing: ElevatedButton.icon(
                                onPressed: syncService.isSyncing
                                    ? null
                                    : () => syncService.triggerSyncWith(device),
                                icon: const Icon(Icons.sync_alt, size: 14),
                                label: const Text('Sync Now', style: TextStyle(fontSize: 11)),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Password Manager Card
            Card(
              elevation: 0.5,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey[200]!),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.password_outlined, color: Colors.blueAccent),
                        SizedBox(width: 12),
                        Text('Vault Passcode Configuration', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Modify the numeric 4-digit security PIN used to authenticate database decryption on app startup.',
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                    const SizedBox(height: 12),
                    if (!_isChangingPin)
                      ElevatedButton(
                        onPressed: () => setState(() => _isChangingPin = true),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[200],
                          foregroundColor: Colors.black87,
                          elevation: 0,
                        ),
                        child: const Text('Change Security PIN'),
                      )
                    else
                      Form(
                        key: _pinFormKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _pinController,
                              obscureText: true,
                              keyboardType: TextInputType.number,
                              maxLength: 4,
                              decoration: const InputDecoration(labelText: 'Current 4-digit PIN', border: OutlineInputBorder()),
                              validator: (val) => val == null || val.length != 4 ? 'Must be 4 digits' : null,
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              controller: _newPinController,
                              obscureText: true,
                              keyboardType: TextInputType.number,
                              maxLength: 4,
                              decoration: const InputDecoration(labelText: 'New 4-digit PIN', border: OutlineInputBorder()),
                              validator: (val) => val == null || val.length != 4 ? 'Must be 4 digits' : null,
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              controller: _confirmPinController,
                              obscureText: true,
                              keyboardType: TextInputType.number,
                              maxLength: 4,
                              decoration: const InputDecoration(labelText: 'Confirm New PIN', border: OutlineInputBorder()),
                              validator: (val) {
                                if (val == null || val.length != 4) return 'Must be 4 digits';
                                if (val != _newPinController.text) return 'PINs do not match';
                                return null;
                              },
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () => setState(() => _isChangingPin = false),
                                  child: const Text('Cancel'),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  onPressed: _changePin,
                                  child: const Text('Update PIN'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Backup & Restore Card
            Card(
              elevation: 0.5,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey[200]!),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.backup_outlined, color: Colors.blueAccent),
                        SizedBox(width: 12),
                        Text('Backup & Restore Utility', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Export database records and documents to a single file, or import from an existing backup.',
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        ElevatedButton.icon(
                          icon: const Icon(Icons.download),
                          label: const Text('Export Data'),
                          onPressed: () => _handleExport(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            foregroundColor: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 12),
                        OutlinedButton.icon(
                          icon: const Icon(Icons.upload),
                          label: const Text('Import Data'),
                          onPressed: () => _handleImport(context),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.blueAccent,
                            side: const BorderSide(color: Colors.blueAccent),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Testing & Sandbox Card
            Card(
              elevation: 0.5,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey[200]!),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.terminal_outlined, color: Colors.blueAccent),
                        SizedBox(width: 12),
                        Text('Developer Sandbox Tools', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Load mock customer directories, configured companies, and carrying daily work logs for offline sandbox testing.',
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.playlist_add),
                      label: const Text('Seed Dummy Data'),
                      onPressed: () async {
                        final db = ref.read(databaseServiceProvider);
                        await db.seedDummyData();
                        
                        // Force all lists to reload immediately
                        ref.invalidate(customerListProvider);
                        ref.invalidate(upcomingEventsProvider);
                        ref.invalidate(companiesProvider);
                        ref.invalidate(taskListProvider);
                        ref.invalidate(todayTasksProvider);
                        
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('5 customers and 3 work tasks seeded successfully!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleExport(BuildContext context) {
    final pinController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    String? errorMessage;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Enter PIN to Export'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Please verify your 4-digit security PIN before exporting sensitive client directories.',
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: pinController,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  decoration: InputDecoration(
                    labelText: '4-digit PIN',
                    border: const OutlineInputBorder(),
                    isDense: true,
                    errorText: errorMessage,
                  ),
                  validator: (val) => val == null || val.length != 4 ? 'PIN must be 4 digits' : null,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (!formKey.currentState!.validate()) return;
                final pin = pinController.text;
                final verified = await ref.read(securityServiceProvider).verifyPin(pin);
                if (verified) {
                  if (context.mounted) Navigator.pop(context);
                  _runExportProcess();
                } else {
                  setDialogState(() {
                    errorMessage = 'Incorrect PIN';
                  });
                }
              },
              child: const Text('Verify & Export'),
            ),
          ],
        ),
      ),
    );
  }

  void _runExportProcess() async {
    // Show loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Compiling database and base64 document payloads...'),
              ],
            ),
          ),
        ),
      ),
    );

    try {
      final backupData = await ref.read(backupServiceProvider).exportBackup();
      final jsonStr = jsonEncode(backupData);
      
      if (mounted) Navigator.pop(context); // Close loading dialog

      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final fileName = 'shinecraft_backup_$timestamp.json';

      ref.read(isPickingFileProvider.notifier).state = true;
      String? outputPath;
      try {
        outputPath = await FilePicker.platform.saveFile(
          dialogTitle: 'Save Database Backup',
          fileName: fileName,
          type: FileType.custom,
          allowedExtensions: ['json'],
        );
      } finally {
        ref.read(isPickingFileProvider.notifier).state = false;
      }

      if (outputPath != null) {
        final file = File(outputPath);
        await file.writeAsString(jsonStr);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Database and attachments exported successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) Navigator.pop(context); // Close loading dialog if error occurs
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Export failed: $e'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  void _handleImport(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: const [
            Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 28),
            SizedBox(width: 8),
            Text('Overwrite Warning'),
          ],
        ),
        content: const Text(
          'Importing a backup file will permanently replace all current database records (customers, tasks, companies) and local document files.\n\nThis action cannot be undone. Are you sure you want to proceed?',
          style: TextStyle(fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _runImportProcess();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
            ),
            child: const Text('Replace All Data'),
          ),
        ],
      ),
    );
  }

  void _runImportProcess() async {
    try {
      ref.read(isPickingFileProvider.notifier).state = true;
      FilePickerResult? result;
      try {
        result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['json'],
        );
      } finally {
        ref.read(isPickingFileProvider.notifier).state = false;
      }

      if (result == null || result.files.single.path == null) {
        return;
      }

      // Show loading
      if (!mounted) return;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Restoring database records and writing files...'),
                ],
              ),
            ),
          ),
        ),
      );

      final file = File(result.files.single.path!);
      final content = await file.readAsString();
      final backup = jsonDecode(content) as Map<String, dynamic>;

      if (!backup.containsKey('customers') || !backup.containsKey('documentFiles')) {
        throw 'Selected file is not a valid ShineCraft backup.';
      }

      await ref.read(backupServiceProvider).importBackup(backup);

      // Reload providers
      ref.invalidate(customerListProvider);
      ref.invalidate(upcomingEventsProvider);
      ref.invalidate(companiesProvider);
      ref.invalidate(taskListProvider);
      ref.invalidate(todayTasksProvider);

      if (mounted) Navigator.pop(context); // Close loading dialog

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Database and attachments restored successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) Navigator.pop(context); // Close loading dialog if error occurs
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Import failed: $e'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }
}
