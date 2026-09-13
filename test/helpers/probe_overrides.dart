// -----------------------------------------------------------------------------
// --[probe]--  PROBE CODE (TEMPORARY DISCOVERY TOOLING)
//              Canned Riverpod overrides that bypass live Isar stream
//              subscriptions. Live watchLazy() listeners prevent Isar.close()
//              from completing in widget-test teardown, so widget probes must
//              render screens with canned data. Real DB verification belongs in
//              plain test() files (see probe_data_test.dart).
//              Remove these files before production release.
// -----------------------------------------------------------------------------
import 'package:customer_detail_management/models/company.dart';
import 'package:customer_detail_management/models/customer.dart';
import 'package:customer_detail_management/models/daily_note.dart';
import 'package:customer_detail_management/models/marketing_lead.dart';
import 'package:customer_detail_management/models/performance_record.dart';
import 'package:customer_detail_management/models/work_task.dart';
import 'package:customer_detail_management/providers/customer_provider.dart';
import 'package:customer_detail_management/providers/daily_notes_provider.dart';
import 'package:customer_detail_management/providers/events_provider.dart';
import 'package:customer_detail_management/providers/marketing_provider.dart';
import 'package:customer_detail_management/providers/performance_provider.dart';
import 'package:customer_detail_management/providers/work_provider.dart';
import 'package:customer_detail_management/services/database_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final DateTime _now = DateTime.now();

List<Customer> _cannedCustomers() => [
      Customer()
        ..uuid = 'custa-1'
        ..customerId = 'CUST-001'
        ..name = 'Amit Sharma'
        ..mobileNumber1 = '9876543210'
        ..dateOfBirth = DateTime(1990, 5, 15)
        ..updatedAt = _now,
      Customer()
        ..uuid = 'custa-2'
        ..customerId = 'CUST-002'
        ..name = 'Priya Patel'
        ..mobileNumber1 = '8765432109'
        ..dateOfBirth = DateTime(1987, 9, 2)
        ..updatedAt = _now,
    ];

List<WorkTask> _cannedTasks() => [
      WorkTask()
        ..uuid = 'task-1'
        ..description = 'Follow-up call with Amit'
        ..workDate = _now
        ..priority = 'High'
        ..status = 'Pending'
        ..updatedAt = _now,
      WorkTask()
        ..uuid = 'task-2'
        ..description = 'Send proposal to Priya'
        ..workDate = _now
        ..priority = 'Medium'
        ..status = 'In Progress'
        ..updatedAt = _now,
    ];

List<MarketingLead> _cannedLeads() => [
      MarketingLead()
        ..uuid = 'lead-1'
        ..name = 'Rohan Desai'
        ..mobile = '7654321098'
        ..status = 'New'
        ..updatedAt = _now,
    ];

List<Company> _cannedCompanies() => [
      Company()
        ..uuid = 'comp-1'
        ..name = 'Acme Life Insurance'
        ..updatedAt = _now,
      Company()
        ..uuid = 'comp-2'
        ..name = 'SecureLife Pvt Ltd'
        ..updatedAt = _now,
    ];

List<DailyNote> _cannedNotes() => [
      DailyNote()
        ..noteId = 'note-1'
        ..dateKey = '2030-06-10'
        ..content = 'Review savings plans'
        ..createdAt = _now,
    ];

List<UpcomingEvent> _cannedUpcomingEvents() => [
      UpcomingEvent(
        title: "Amit Sharma's Birthday",
        dateText: 'In 12 days',
        type: 'birthday',
        details: 'Turning 36 years old',
        customer: _cannedCustomers()[0],
        date: _now.add(const Duration(days: 12)),
      ),
      UpcomingEvent(
        title: 'Marketing Visit: Rohan Desai',
        dateText: 'Tomorrow',
        type: 'marketing',
        details: 'Status: New',
        marketingLead: _cannedLeads()[0],
        date: _now.add(const Duration(days: 1)),
      ),
    ];

List<TodayEventSummaryItem> _cannedTodaySummary() => [
      TodayEventSummaryItem(
        id: 'task_1',
        title: 'Follow-up call with Amit',
        subtitle: 'Priority: High  •  Status: Pending',
        categoryLabel: 'Work Task',
        type: TodayEventType.workTask,
        workTask: _cannedTasks()[0],
      ),
      TodayEventSummaryItem(
        id: 'marketing_1',
        title: 'Marketing Visit: Rohan Desai',
        subtitle: 'Status: New',
        categoryLabel: 'Marketing',
        type: TodayEventType.marketing,
        marketingLead: _cannedLeads()[0],
      ),
    ];

PerformanceRecord _record({required bool seeded}) => PerformanceRecord()
  ..year = _now.year
  ..month = _now.month
  ..earned = seeded ? '45000' : ''
  ..newBusiness = seeded ? '12000' : ''
  ..urgent = seeded ? '5000' : ''
  ..updatedAt = _now;

class _CannedPerformanceNotifier extends PerformanceNotifier {
  _CannedPerformanceNotifier(
    super.db,
    super.year,
    super.month, {
    required bool seeded,
  }) {
    state = _record(seeded: seeded);
  }
}

/// Overrides shared by multiple screens (live stream providers only).
List<Override> cannedStreamProvidersOverrides({required bool seeded}) {
  return [
    customerListProvider.overrideWith(
      (ref) => Stream.value(seeded ? _cannedCustomers() : const <Customer>[]),
    ),
    marketingListProvider.overrideWith(
      (ref) => Stream.value(seeded ? _cannedLeads() : const <MarketingLead>[]),
    ),
    todayTasksProvider.overrideWith(
      (ref) => Stream.value(seeded ? _cannedTasks() : const <WorkTask>[]),
    ),
  ];
}

/// Overrides for the Dashboard screen (includes its future providers).
List<Override> dashboardOverrides({required bool seeded}) => [
      ...cannedStreamProvidersOverrides(seeded: seeded),
      tomorrowNotesProvider.overrideWith(
        (ref) => Future.value(seeded ? _cannedNotes() : const <DailyNote>[]),
      ),
      todaySummaryEventsProvider.overrideWith(
        (ref) => Future.value(seeded ? _cannedTodaySummary() : const <TodayEventSummaryItem>[]),
      ),
    ];

/// Overrides for the Customer List screen.
List<Override> customerListOverrides({required bool seeded}) => [
      customerListProvider.overrideWith(
        (ref) => Stream.value(seeded ? _cannedCustomers() : const <Customer>[]),
      ),
    ];

/// Overrides for the Upcoming Events screen.
List<Override> upcomingEventsOverrides({required bool seeded}) => [
      ...cannedStreamProvidersOverrides(seeded: seeded),
      upcomingEventsProvider.overrideWith(
        (ref) => Future.value(seeded ? _cannedUpcomingEvents() : const <UpcomingEvent>[]),
      ),
    ];

/// Overrides for the Work Management screen.
List<Override> workManagementOverrides({required bool seeded}) => [
      taskListProvider.overrideWith(
        (ref) => Stream.value(seeded ? _cannedTasks() : const <WorkTask>[]),
      ),
      companiesForSelectedTabProvider.overrideWith(
        (ref) => Future.value(seeded ? _cannedCompanies() : const <Company>[]),
      ),
    ];

/// Overrides for the Marketing screen.
List<Override> marketingOverrides({required bool seeded}) => [
      marketingListProvider.overrideWith(
        (ref) => Stream.value(seeded ? _cannedLeads() : const <MarketingLead>[]),
      ),
    ];

/// Overrides for the Performance screen.
List<Override> performanceOverrides({required bool seeded}) => [
      performanceRecordProvider.overrideWith(
        (ref, key) => _CannedPerformanceNotifier(
          ref.watch(databaseServiceProvider),
          _now.year,
          _now.month,
          seeded: seeded,
        ),
      ),
    ];