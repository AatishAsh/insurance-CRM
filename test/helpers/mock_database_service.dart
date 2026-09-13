// -----------------------------------------------------------------------------
// --[probe]--  PROBE CODE (TEMPORARY DISCOVERY TOOLING)
//              Deterministic mock of DatabaseService for widget probes so that
//              screens never issue real Isar queries from a widget-test
//              fake-async zone (which deadlocks Isar.close() in teardown).
//              Remove these files before production release.
// -----------------------------------------------------------------------------
import 'package:customer_detail_management/models/company.dart';
import 'package:customer_detail_management/models/customer.dart';
import 'package:customer_detail_management/models/insurance_company.dart';
import 'package:customer_detail_management/models/performance_record.dart';
import 'package:customer_detail_management/models/work_task.dart';
import 'package:customer_detail_management/services/database_service.dart';
import 'package:mocktail/mocktail.dart';

class MockDatabaseService extends Mock implements DatabaseService {}

/// Stubs every DatabaseService method invoked from widget-test fake-async zones.
void registerMockDatabaseServiceStubs(MockDatabaseService db) {
  when(() => db.getInsuranceCompanies())
      .thenAnswer((_) async => const <InsuranceCompany>[]);
  when(() => db.getCompanies())
      .thenAnswer((_) async => const <Company>[]);
  when(() => db.getCompaniesForTab(any()))
      .thenAnswer((_) async => const <Company>[]);
  when(() => db.getCustomers(searchQuery: any(named: 'searchQuery')))
      .thenAnswer((_) async => const <Customer>[]);
  when(() => db.getTasksForCompany(any(), any()))
      .thenAnswer((_) async => const <WorkTask>[]);
  when(() => db.getTasksForDate(any()))
      .thenAnswer((_) async => const <WorkTask>[]);
  when(() => db.carryForwardIncompleteTasks(any())).thenAnswer((_) async => 0);
  when(() => db.seedDummyData()).thenAnswer((_) async {});
  when(() => db.getPerformanceRecord(any(), any())).thenAnswer((_) async => null);
  when(() => db.getLatestPerformanceHeaders()).thenAnswer((_) async => null);
}