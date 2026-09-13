@Tags(['probe'])
// -----------------------------------------------------------------------------
// --[probe]--  PROBE CODE (TEMPORARY DISCOVERY TOOLING)
//              Used to inspect UI layout and rendered data only.
//              Remove these files before production release.
// -----------------------------------------------------------------------------
import 'dart:ffi' show Abi;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:customer_detail_management/services/database_service.dart';
import 'package:customer_detail_management/services/sync_service.dart';
import 'package:customer_detail_management/services/security_service.dart';
import 'package:customer_detail_management/screens/sync_screen.dart';
import '../helpers/test_harness.dart';
import 'probe_dumper.dart';

/// Probe-only SyncService that never touches the network or timers, so the
/// widget layer can be dumped without binding sockets or leaking timers.
class StubSyncService extends SyncService {
  StubSyncService(super.db);

  @override
  Future<void> startServer() async {}

  @override
  Future<void> stopServer() async {}

  @override
  Future<void> startDiscovery() async {}

  @override
  Future<void> stopDiscovery() async {}

  @override
  Future<void> triggerSyncWith(DiscoveredDevice device) async {}

  @override
  Future<void> triggerSyncWithIp(String rawHost, int port) async {}
}

void main() {
  late DatabaseContext dbContext;
  late StubSyncService syncService;

  setUpAll(() async {
    await initIsarCoreForTest();
    installFakeSecureStorage();
  });

  setUp(() async {
    dbContext = await openTestDatabase();
    syncService = StubSyncService(dbContext.service);
  });

  tearDown(() async {
    await dbContext.close();
  });

  testWidgets('Probe SyncScreen Developer Tools unlocked state', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1200, 2000));
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseServiceProvider.overrideWithValue(dbContext.service),
          securityServiceProvider.overrideWithValue(SecurityService(const FlutterSecureStorage())),
          syncServiceProvider.overrideWith((ref) => syncService),
        ],
        child: const MaterialApp(
          home: SyncScreen(),
        ),
      ),
    );
    // Let the post-frame startServer callback and any providers settle without
    // an infinite pumpAndSettle.
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pump(const Duration(milliseconds: 100));

    // Tap footer 5 times to unlock Developer Sandbox Tools
    final versionFinder = find.text('JJ CRM - Offline Customer Detail Management System v2.0.1');
    expect(versionFinder, findsOneWidget);
    await tester.ensureVisible(versionFinder);

    for (int i = 0; i < 5; i++) {
      await tester.tap(versionFinder);
      await tester.pump(const Duration(milliseconds: 100));
    }

    // Let the unlock SnackBar timer expire so no timer is pending at teardown.
    await tester.pump(const Duration(seconds: 4));

    final texts = ProbeDumper.collectRenderedTexts(tester);
    ProbeDumper.writeProbeReport(
      'states__sync_developer_tools_unlocked',
      textReport: texts.join('\n'),
      structuredData: {
        'state': 'developer_tools_unlocked',
        'hasSeedButton': texts.contains('Seed Dummy Data'),
        'hasClearButton': texts.contains('Clear All Data'),
        'texts': texts,
      },
    );
  });
}