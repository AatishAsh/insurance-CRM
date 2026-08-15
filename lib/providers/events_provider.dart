import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../models/customer.dart';
import '../models/marketing_lead.dart';
import '../models/work_task.dart';
import 'customer_provider.dart';
import 'marketing_provider.dart';
import 'work_provider.dart';

class UpcomingEvent {
  final String title;
  final String dateText;
  final String type; // 'birthday', 'anniversary', 'reminder', 'marketing'
  final String details;
  final Customer? customer;
  final MarketingLead? marketingLead;
  final DateTime date;

  UpcomingEvent({
    required this.title,
    required this.dateText,
    required this.type,
    required this.details,
    this.customer,
    this.marketingLead,
    required this.date,
  });
}

final upcomingEventsProvider = FutureProvider<List<UpcomingEvent>>((ref) async {
  final customers = await ref.watch(customerListProvider.future);
  final marketingLeads = await ref.watch(marketingListProvider.future);
  
  final List<UpcomingEvent> events = [];
  final today = DateTime.now();
  final todayNormalized = DateTime(today.year, today.month, today.day);

  int getDifferenceInDays(DateTime date) {
    final localDate = date.toLocal();
    final thisYearEvent = DateTime(today.year, localDate.month, localDate.day);
    var diff = thisYearEvent.difference(todayNormalized).inDays;
    if (diff < 0) {
      final nextYearEvent = DateTime(today.year + 1, localDate.month, localDate.day);
      diff = nextYearEvent.difference(todayNormalized).inDays;
    }
    return diff;
  }

  String getDaysText(int diff) {
    if (diff == 0) return 'Today';
    if (diff == 1) return 'Tomorrow';
    return 'In $diff days';
  }

  // 1. Customer Events
  for (final customer in customers) {
    // Birthday
    if (customer.dateOfBirth != null) {
      final diff = getDifferenceInDays(customer.dateOfBirth!);
      if (diff <= 30) {
        final age = today.year - customer.dateOfBirth!.toLocal().year;
        events.add(UpcomingEvent(
          title: "${customer.name}'s Birthday",
          dateText: getDaysText(diff),
          type: 'birthday',
          details: 'Turning $age years old (${DateFormat('dd MMM').format(customer.dateOfBirth!.toLocal())})',
          customer: customer,
          date: todayNormalized.add(Duration(days: diff)),
        ));
      }
    }

    // Children DOBs
    if (customer.childrenDOBs != null) {
      for (int i = 0; i < customer.childrenDOBs!.length; i++) {
        final childDob = customer.childrenDOBs![i];
        final diff = getDifferenceInDays(childDob);
        if (diff <= 30) {
          final age = today.year - childDob.toLocal().year;
          events.add(UpcomingEvent(
            title: "${customer.name}'s Child Birthday",
            dateText: getDaysText(diff),
            type: 'birthday',
            details: 'Child #${i + 1} turning $age years old (${DateFormat('dd MMM').format(childDob.toLocal())})',
            customer: customer,
            date: todayNormalized.add(Duration(days: diff)),
          ));
        }
      }
    }

    // Wedding Anniversary
    if (customer.weddingAnniversary != null) {
      final diff = getDifferenceInDays(customer.weddingAnniversary!);
      if (diff <= 30) {
        final years = today.year - customer.weddingAnniversary!.toLocal().year;
        events.add(UpcomingEvent(
          title: "${customer.name}'s Anniversary",
          dateText: getDaysText(diff),
          type: 'anniversary',
          details: '$years Wedding Anniversary (${DateFormat('dd MMM').format(customer.weddingAnniversary!.toLocal())})',
          customer: customer,
          date: todayNormalized.add(Duration(days: diff)),
        ));
      }
    }

    // Personal Accident Incident
    final hasPA = (customer.hasPersonalAccident ?? '').trim().toLowerCase() == 'yes';
    if (customer.personalAccidentDate != null || hasPA) {
      if (customer.personalAccidentDate != null) {
        final diff = getDifferenceInDays(customer.personalAccidentDate!);
        if (diff <= 30) {
          final years = today.year - customer.personalAccidentDate!.toLocal().year;
          final yearsText = years > 0 ? ' ($years Yr Anniversary)' : '';
          events.add(UpcomingEvent(
            title: "Personal Accident Incident: ${customer.name}",
            dateText: getDaysText(diff),
            type: 'reminder',
            details: 'Incident Date: ${DateFormat('dd MMM yyyy').format(customer.personalAccidentDate!.toLocal())}$yearsText',
            customer: customer,
            date: todayNormalized.add(Duration(days: diff)),
          ));
        }
      }
    }

    // Reminders (Date 1 and Date 2)
    void addReminder(DateTime? remDate, String? note, String num) {
      if (remDate == null) return;
      final diff = remDate.toLocal().difference(todayNormalized).inDays;
      if (diff >= 0 && diff <= 30) {
        final noteText = note != null && note.trim().isNotEmpty ? ' - $note' : '';
        events.add(UpcomingEvent(
          title: "Follow-up reminder: ${customer.name}",
          dateText: getDaysText(diff),
          type: 'reminder',
          details: 'Reminder $num Scheduled$noteText',
          customer: customer,
          date: remDate.toLocal(),
        ));
      }
    }

    addReminder(customer.reminderDate1, customer.reminderNote1, '1');
    addReminder(customer.reminderDate2, customer.reminderNote2, '2');
  }

  // 2. Marketing Visits
  for (final lead in marketingLeads) {
    for (final visit in lead.visits) {
      if (visit.visitDate == null) continue;
      
      final localVisitDate = visit.visitDate!.toLocal();
      final visitDateNormalized = DateTime(localVisitDate.year, localVisitDate.month, localVisitDate.day);
      final diff = visitDateNormalized.difference(todayNormalized).inDays;
      if (diff >= 0 && diff <= 30) {
        final timeStr = visit.visitTime != null && visit.visitTime!.isNotEmpty ? ' at ${visit.visitTime}' : '';
        final noteStr = visit.visitNote != null && visit.visitNote!.isNotEmpty ? ' - ${visit.visitNote}' : '';
        events.add(UpcomingEvent(
          title: "Marketing Visit: ${lead.name}",
          dateText: getDaysText(diff),
          type: 'marketing',
          details: 'Status: ${lead.status}$timeStr$noteStr',
          marketingLead: lead,
          date: visitDateNormalized,
        ));
      }
    }
  }

  // Sort events by date ascending
  events.sort((a, b) => a.date.compareTo(b.date));
  return events;
});

enum TodayEventType {
  birthday,
  anniversary,
  reminder,
  workTask,
  marketing,
  personalAccident,
}

class TodayEventSummaryItem {
  final String id;
  final String title;
  final String subtitle;
  final String categoryLabel;
  final TodayEventType type;
  final String? time;
  final Customer? customer;
  final WorkTask? workTask;
  final MarketingLead? marketingLead;
  final bool isCompleted;

  TodayEventSummaryItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.categoryLabel,
    required this.type,
    this.time,
    this.customer,
    this.workTask,
    this.marketingLead,
    this.isCompleted = false,
  });
}

final todaySummaryEventsProvider = FutureProvider<List<TodayEventSummaryItem>>((ref) async {
  final customers = await ref.watch(customerListProvider.future);
  final marketingLeads = await ref.watch(marketingListProvider.future);
  final todayTasksAsync = ref.watch(todayTasksProvider);
  final tasks = todayTasksAsync.value ?? [];

  final List<TodayEventSummaryItem> items = [];
  final today = DateTime.now();

  bool isSameDayAndMonth(DateTime d) {
    final ld = d.toLocal();
    return ld.month == today.month && ld.day == today.day;
  }

  bool isSameDate(DateTime d) {
    final ld = d.toLocal();
    return ld.year == today.year && ld.month == today.month && ld.day == today.day;
  }

  // 1. Customer Birthdays & Anniversaries & Reminders
  for (final customer in customers) {
    // DOB
    if (customer.dateOfBirth != null && isSameDayAndMonth(customer.dateOfBirth!)) {
      final age = today.year - customer.dateOfBirth!.toLocal().year;
      items.add(TodayEventSummaryItem(
        id: 'dob_${customer.id}',
        title: "${customer.name}'s Birthday",
        subtitle: 'Turning $age years old today! ID: ${customer.customerId ?? 'N/A'}',
        categoryLabel: 'Birthday',
        type: TodayEventType.birthday,
        customer: customer,
      ));
    }

    // Children DOBs
    if (customer.childrenDOBs != null) {
      for (int i = 0; i < customer.childrenDOBs!.length; i++) {
        final childDob = customer.childrenDOBs![i];
        if (isSameDayAndMonth(childDob)) {
          final age = today.year - childDob.toLocal().year;
          items.add(TodayEventSummaryItem(
            id: 'child_dob_${customer.id}_$i',
            title: "${customer.name}'s Child Birthday",
            subtitle: 'Child #${i + 1} turning $age years old today',
            categoryLabel: 'Birthday',
            type: TodayEventType.birthday,
            customer: customer,
          ));
        }
      }
    }

    // Wedding Anniversary
    if (customer.weddingAnniversary != null && isSameDayAndMonth(customer.weddingAnniversary!)) {
      final years = today.year - customer.weddingAnniversary!.toLocal().year;
      items.add(TodayEventSummaryItem(
        id: 'anniversary_${customer.id}',
        title: "${customer.name}'s Wedding Anniversary",
        subtitle: 'Celebrating $years years of marriage today',
        categoryLabel: 'Anniversary',
        type: TodayEventType.anniversary,
        customer: customer,
      ));
    }

    // Personal Accident Incident & Policy Cover
    final isPASelected = (customer.hasPersonalAccident ?? '').trim().toLowerCase() == 'yes';
    final paDate = customer.personalAccidentDate;

    if (paDate != null && (isSameDayAndMonth(paDate) || isSameDate(paDate))) {
      final localPaDate = paDate.toLocal();
      final years = today.year - localPaDate.year;
      final yearsText = years > 0 ? ' ($years Yr Anniversary)' : '';
      items.add(TodayEventSummaryItem(
        id: 'pa_${customer.id}',
        title: "Personal Accident Incident: ${customer.name}",
        subtitle: 'Incident Date: ${DateFormat('dd MMM yyyy').format(localPaDate)}$yearsText',
        categoryLabel: 'Personal Accident',
        type: TodayEventType.personalAccident,
        customer: customer,
      ));
    } else if (isPASelected && paDate != null) {
      final localPaDate = paDate.toLocal();
      final years = today.year - localPaDate.year;
      final yearsText = years > 0 ? ' ($years Yr Anniversary)' : '';
      items.add(TodayEventSummaryItem(
        id: 'pa_${customer.id}',
        title: "Personal Accident Cover: ${customer.name}",
        subtitle: 'Incident/Policy Date: ${DateFormat('dd MMM yyyy').format(localPaDate)}$yearsText',
        categoryLabel: 'Personal Accident',
        type: TodayEventType.personalAccident,
        customer: customer,
      ));
    } else if (isPASelected && paDate == null) {
      items.add(TodayEventSummaryItem(
        id: 'pa_${customer.id}',
        title: "Personal Accident Cover: ${customer.name}",
        subtitle: 'Active Personal Accident Cover Registered (Customer ID: ${customer.customerId ?? 'N/A'})',
        categoryLabel: 'Personal Accident',
        type: TodayEventType.personalAccident,
        customer: customer,
      ));
    }

    // Reminder 1 & 2
    if (customer.reminderDate1 != null && isSameDate(customer.reminderDate1!)) {
      final note = customer.reminderNote1 != null && customer.reminderNote1!.isNotEmpty
          ? 'Note: ${customer.reminderNote1}'
          : 'Scheduled follow-up reminder 1';
      items.add(TodayEventSummaryItem(
        id: 'rem1_${customer.id}',
        title: "Follow-up: ${customer.name}",
        subtitle: note,
        categoryLabel: 'Reminder',
        type: TodayEventType.reminder,
        customer: customer,
      ));
    }

    if (customer.reminderDate2 != null && isSameDate(customer.reminderDate2!)) {
      final note = customer.reminderNote2 != null && customer.reminderNote2!.isNotEmpty
          ? 'Note: ${customer.reminderNote2}'
          : 'Scheduled follow-up reminder 2';
      items.add(TodayEventSummaryItem(
        id: 'rem2_${customer.id}',
        title: "Follow-up: ${customer.name}",
        subtitle: note,
        categoryLabel: 'Reminder',
        type: TodayEventType.reminder,
        customer: customer,
      ));
    }
  }

  // 2. Work Tasks Due Today
  for (final task in tasks) {
    final taskDate = task.workDate;
    if (isSameDate(taskDate)) {
      items.add(TodayEventSummaryItem(
        id: 'task_${task.id}',
        title: task.description,
        subtitle: 'Priority: ${task.priority}  •  Status: ${task.status}',
        categoryLabel: 'Work Task',
        type: TodayEventType.workTask,
        workTask: task,
        isCompleted: task.status == 'Completed',
      ));
    }
  }

  // 3. Marketing Visits Scheduled Today
  for (final lead in marketingLeads) {
    for (final visit in lead.visits) {
      if (visit.visitDate != null && isSameDate(visit.visitDate!)) {
        final timeStr = visit.visitTime != null && visit.visitTime!.isNotEmpty ? visit.visitTime : 'All Day';
        final noteStr = visit.visitNote != null && visit.visitNote!.isNotEmpty ? ' - ${visit.visitNote}' : '';
        items.add(TodayEventSummaryItem(
          id: 'marketing_${lead.id}_${visit.visitDate.toString()}',
          title: "Marketing Visit: ${lead.name}",
          subtitle: 'Status: ${lead.status}$noteStr',
          categoryLabel: 'Marketing',
          type: TodayEventType.marketing,
          time: timeStr,
          marketingLead: lead,
        ));
      }
    }
  }

  return items;
});
