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
import 'package:customer_detail_management/screens/security_lock_screen.dart';
import 'package:customer_detail_management/screens/dashboard_screen.dart';
import 'package:customer_detail_management/screens/customer_list_screen.dart';
import 'package:customer_detail_management/screens/customer_form_screen.dart';
import 'package:customer_detail_management/screens/upcoming_events_screen.dart';
import 'package:customer_detail_management/screens/work_management_screen.dart';
import 'package:customer_detail_management/screens/marketing_screen.dart';
import 'package:customer_detail_management/screens/performance_screen.dart';
import 'package:customer_detail_management/screens/sync_screen.dart';
import '../helpers/test_harness.dart';
import '../helpers/probe_overrides.dart';
import '../helpers/mock_database_service.dart';
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
}

void main() {
  late DatabaseContext dbContext;
  late StubSyncService syncService;
  final List<String> generatedReports = [];

  setUpAll(() async {
    await initIsarCoreForTest();
    installFakeSecureStorage();
    await installPathProviderMock();
  });

  setUp(() async {
    dbContext = await openTestDatabase();
    syncService = StubSyncService(dbContext.service);
  });

  tearDown(() async {
    await dbContext.close();
  });

  tearDownAll(() {
    ProbeDumper.updateSummaryIndex(generatedReports);
  });

  /// Pumps real-async work (Isar streams, Riverpod emissions) then a frame,
  /// without an unbounded [pumpAndSettle] which can hang on stream providers.
  Future<void> pumpAsync(WidgetTester tester) async {
    await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 300)));
    await tester.pump(const Duration(milliseconds: 100));
  }

  /// Disposes the widget tree, then drains real-async work so Isar-backed
  /// stream subscriptions (Riverpod cancel) finish before fake-async teardown.
  Future<void> disposeTree(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 200)));
  }

  /// Dumps a screen's rendered texts (+ optional extras) to a probe report.
  void writeTextReport(
    String reportName, {
    required WidgetTester tester,
    Map<String, dynamic>? structuredData,
    String? header,
  }) {
    final texts = ProbeDumper.collectRenderedTexts(tester);
    ProbeDumper.writeProbeReport(
      reportName,
      textReport: header == null ? texts.join('\n') : '$header\n${texts.join('\n')}',
      structuredData: structuredData ?? {'texts': texts},
    );
    generatedReports.add(reportName);
  }

  Widget buildScreenHarness(
    Widget child, {
    Size size = const Size(1200, 800),
    List<Override> extraOverrides = const [],
    bool useMockDatabase = false,
  }) {
    final MockDatabaseService? mockDb = useMockDatabase ? MockDatabaseService() : null;
    if (mockDb != null) registerMockDatabaseServiceStubs(mockDb);
    return ProviderScope(
      overrides: [
        databaseServiceProvider.overrideWithValue(mockDb ?? dbContext.service),
        securityServiceProvider.overrideWithValue(SecurityService(const FlutterSecureStorage())),
        syncServiceProvider.overrideWith((ref) => syncService),
        ...extraOverrides,
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MediaQuery(
          data: MediaQueryData(size: size),
          child: SizedBox(
            width: size.width,
            height: size.height,
            child: Scaffold(body: child),
          ),
        ),
      ),
    );
  }

  group('Probe Screens Discovery', () {
    testWidgets('Probe SecurityLockScreen', (tester) async {
      await tester.binding.setSurfaceSize(const Size(1200, 800));
      await tester.pumpWidget(buildScreenHarness(const SecurityLockScreen()));
      await pumpAsync(tester);

      writeTextReport(
        'security_lock_screen__default',
        tester: tester,
        structuredData: {
          'screen': 'SecurityLockScreen',
          'tree': ProbeDumper.dumpWidgetTree(tester),
        },
        header: '=== SCREEN PROBE: SecurityLockScreen ===',
      );
      await disposeTree(tester);
    });

    testWidgets('Probe DashboardScreen (Empty State vs Seeded State)', (tester) async {
      await tester.binding.setSurfaceSize(const Size(1200, 800));

      await tester.pumpWidget(
        buildScreenHarness(const DashboardScreen(), extraOverrides: dashboardOverrides(seeded: false)),
      );
      await pumpAsync(tester);

      final emptyReport = 'dashboard_screen__empty_state';
      writeTextReport(
        emptyReport,
        tester: tester,
        structuredData: {
          'screen': 'DashboardScreen',
          'state': 'empty',
          'chips': ProbeDumper.inspectChipsAndSegments(tester),
        },
        header: '=== SCREEN PROBE: DashboardScreen (Empty State) ===',
      );

      await tester.pumpWidget(
        buildScreenHarness(const DashboardScreen(), extraOverrides: dashboardOverrides(seeded: true)),
      );
      await pumpAsync(tester);

      final seededReport = 'dashboard_screen__seeded_state';
      writeTextReport(
        seededReport,
        tester: tester,
        structuredData: {
          'screen': 'DashboardScreen',
          'state': 'seeded',
          'tables': ProbeDumper.inspectDataTables(tester),
        },
        header: '=== SCREEN PROBE: DashboardScreen (Seeded State) ===',
      );
      await disposeTree(tester);
    });

    testWidgets('Probe CustomerListScreen (Empty vs Seeded)', (tester) async {
      await tester.binding.setSurfaceSize(const Size(1200, 800));
      await tester.pumpWidget(
        buildScreenHarness(const CustomerListScreen(), extraOverrides: customerListOverrides(seeded: false)),
      );
      await pumpAsync(tester);

      writeTextReport(
        'customer_list_screen__empty_state',
        tester: tester,
        structuredData: {'screen': 'CustomerListScreen', 'state': 'empty'},
      );

      await tester.pumpWidget(
        buildScreenHarness(const CustomerListScreen(), extraOverrides: customerListOverrides(seeded: true)),
      );
      await pumpAsync(tester);

      writeTextReport(
        'customer_list_screen__seeded_state',
        tester: tester,
        structuredData: {'screen': 'CustomerListScreen', 'state': 'seeded'},
      );
      await disposeTree(tester);
    });

    testWidgets('Probe CustomerFormScreen (New Customer)', (tester) async {
      await tester.binding.setSurfaceSize(const Size(1200, 800));
      await tester.pumpWidget(buildScreenHarness(const CustomerFormScreen(), useMockDatabase: true));
      await pumpAsync(tester);

      writeTextReport(
        'customer_form_screen__new',
        tester: tester,
        structuredData: {
          'screen': 'CustomerFormScreen',
          'fields': ProbeDumper.inspectFormFields(tester),
        },
        header: '=== CustomerFormScreen ===',
      );
      await disposeTree(tester);
    });

    testWidgets('Probe UpcomingEventsScreen (Seeded State)', (tester) async {
      await tester.binding.setSurfaceSize(const Size(1200, 800));
      await tester.pumpWidget(
        buildScreenHarness(const UpcomingEventsScreen(), extraOverrides: upcomingEventsOverrides(seeded: true)),
      );
      await pumpAsync(tester);

      writeTextReport(
        'upcoming_events_screen__seeded_state',
        tester: tester,
        structuredData: {'screen': 'UpcomingEventsScreen', 'state': 'seeded'},
      );
      await disposeTree(tester);
    });

    testWidgets('Probe WorkManagementScreen (Seeded State)', (tester) async {
      await tester.binding.setSurfaceSize(const Size(1200, 800));
      await tester.pumpWidget(
        buildScreenHarness(const WorkManagementScreen(), extraOverrides: workManagementOverrides(seeded: true)),
      );
      await pumpAsync(tester);

      writeTextReport(
        'work_management_screen__seeded_state',
        tester: tester,
        structuredData: {'screen': 'WorkManagementScreen', 'state': 'seeded'},
      );
      await disposeTree(tester);
    });

    testWidgets('Probe MarketingScreen (Seeded State)', (tester) async {
      await tester.binding.setSurfaceSize(const Size(1200, 800));
      await tester.pumpWidget(
        buildScreenHarness(const MarketingScreen(), extraOverrides: marketingOverrides(seeded: true)),
      );
      await pumpAsync(tester);

      writeTextReport(
        'marketing_screen__seeded_state',
        tester: tester,
        structuredData: {'screen': 'MarketingScreen', 'state': 'seeded'},
      );
      await disposeTree(tester);
    });

    testWidgets('Probe PerformanceScreen (Seeded State)', (tester) async {
      await tester.binding.setSurfaceSize(const Size(1200, 800));
      await tester.pumpWidget(
        buildScreenHarness(const PerformanceScreen(), extraOverrides: performanceOverrides(seeded: true)),
      );
      await pumpAsync(tester);

      writeTextReport(
        'performance_screen__seeded_state',
        tester: tester,
        structuredData: {'screen': 'PerformanceScreen', 'state': 'seeded'},
      );
      await disposeTree(tester);
    });

    testWidgets('Probe SyncScreen (Default State)', (tester) async {
      await tester.binding.setSurfaceSize(const Size(1200, 800));
      await tester.pumpWidget(buildScreenHarness(const SyncScreen()));
      await pumpAsync(tester);

      writeTextReport(
        'sync_screen__default_state',
        tester: tester,
        structuredData: {'screen': 'SyncScreen', 'state': 'default'},
      );
      await disposeTree(tester);
    });
  });
}