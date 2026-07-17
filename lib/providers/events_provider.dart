import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../models/customer.dart';
import '../models/marketing_lead.dart';
import 'customer_provider.dart';
import 'marketing_provider.dart';

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
    final thisYearEvent = DateTime(today.year, date.month, date.day);
    var diff = thisYearEvent.difference(todayNormalized).inDays;
    if (diff < 0) {
      final nextYearEvent = DateTime(today.year + 1, date.month, date.day);
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
        final age = today.year - customer.dateOfBirth!.year;
        events.add(UpcomingEvent(
          title: "${customer.name}'s Birthday",
          dateText: getDaysText(diff),
          type: 'birthday',
          details: 'Turning $age years old (${DateFormat('dd MMM').format(customer.dateOfBirth!)})',
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
          final age = today.year - childDob.year;
          events.add(UpcomingEvent(
            title: "${customer.name}'s Child Birthday",
            dateText: getDaysText(diff),
            type: 'birthday',
            details: 'Child #${i + 1} turning $age years old (${DateFormat('dd MMM').format(childDob)})',
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
        final years = today.year - customer.weddingAnniversary!.year;
        events.add(UpcomingEvent(
          title: "${customer.name}'s Anniversary",
          dateText: getDaysText(diff),
          type: 'anniversary',
          details: '$years Wedding Anniversary (${DateFormat('dd MMM').format(customer.weddingAnniversary!)})',
          customer: customer,
          date: todayNormalized.add(Duration(days: diff)),
        ));
      }
    }

    // Reminders (Date 1 and Date 2)
    void addReminder(DateTime? remDate, String? note, String num) {
      if (remDate == null) return;
      final diff = remDate.difference(todayNormalized).inDays;
      if (diff >= 0 && diff <= 30) {
        final noteText = note != null && note.trim().isNotEmpty ? ' - $note' : '';
        events.add(UpcomingEvent(
          title: "Follow-up reminder: ${customer.name}",
          dateText: getDaysText(diff),
          type: 'reminder',
          details: 'Reminder $num Scheduled$noteText',
          customer: customer,
          date: remDate,
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
      
      final visitDateNormalized = DateTime(visit.visitDate!.year, visit.visitDate!.month, visit.visitDate!.day);
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
