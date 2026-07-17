import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../providers/customer_provider.dart';
import '../providers/events_provider.dart';
import '../models/customer.dart';
import 'customer_detail_screen.dart';
import '../models/work_task.dart';
import '../providers/work_provider.dart';
import '../models/marketing_lead.dart';
import '../providers/marketing_provider.dart';

class CalendarEvent {
  final String title;
  final String type; // 'birthday', 'anniversary', 'reminder', 'marketing'
  final String details;
  final Customer? customer;
  final MarketingLead? marketingLead;

  CalendarEvent({
    required this.title,
    required this.type,
    required this.details,
    this.customer,
    this.marketingLead,
  });
}

class UpcomingEventsScreen extends ConsumerStatefulWidget {
  const UpcomingEventsScreen({super.key});

  @override
  ConsumerState<UpcomingEventsScreen> createState() => _UpcomingEventsScreenState();
}

class _UpcomingEventsScreenState extends ConsumerState<UpcomingEventsScreen> {
  late DateTime _selectedDay;
  late DateTime _focusedMonth;

  @override
  void initState() {
    super.initState();
    final today = DateTime.now();
    _selectedDay = DateTime(today.year, today.month, today.day);
    _focusedMonth = DateTime(today.year, today.month, 1);
  }

  // Calculate days in the current month view
  List<DateTime?> _getCalendarDays(DateTime month) {
    final List<DateTime?> days = [];
    final firstDay = DateTime(month.year, month.month, 1);
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;

    // Leading empty slots (Monday start)
    final offset = firstDay.weekday - 1;
    for (int i = 0; i < offset; i++) {
      days.add(null);
    }

    // Actual month days
    for (int i = 1; i <= daysInMonth; i++) {
      days.add(DateTime(month.year, month.month, i));
    }

    return days;
  }

  // Get events on a specific day
  List<CalendarEvent> _getEventsForDay(DateTime day, List<Customer> customers, List<MarketingLead> marketingLeads) {
    final List<CalendarEvent> dayEvents = [];

    for (final c in customers) {
      // 1. Birthday
      if (c.dateOfBirth != null &&
          c.dateOfBirth!.month == day.month &&
          c.dateOfBirth!.day == day.day) {
        final age = day.year - c.dateOfBirth!.year;
        dayEvents.add(CalendarEvent(
          title: "${c.name}'s Birthday",
          type: 'birthday',
          details: 'Turning $age years old (${DateFormat('dd MMM').format(c.dateOfBirth!)})',
          customer: c,
        ));
      }

      // Children Birthdays
      if (c.childrenDOBs != null) {
        for (int i = 0; i < c.childrenDOBs!.length; i++) {
          final dob = c.childrenDOBs![i];
          if (dob.month == day.month && dob.day == day.day) {
            final age = day.year - dob.year;
            dayEvents.add(CalendarEvent(
              title: "${c.name}'s Child Birthday",
              type: 'birthday',
              details: 'Child #${i + 1} turning $age (${DateFormat('dd MMM').format(dob)})',
              customer: c,
            ));
          }
        }
      }

      // 2. Wedding Anniversary
      if (c.weddingAnniversary != null &&
          c.weddingAnniversary!.month == day.month &&
          c.weddingAnniversary!.day == day.day) {
        final years = day.year - c.weddingAnniversary!.year;
        dayEvents.add(CalendarEvent(
          title: "${c.name}'s Anniversary",
          type: 'anniversary',
          details: '$years Wedding Anniversary (${DateFormat('dd MMM').format(c.weddingAnniversary!)})',
          customer: c,
        ));
      }

      // 3. Reminders
      if (c.reminderDate1 != null &&
          c.reminderDate1!.year == day.year &&
          c.reminderDate1!.month == day.month &&
          c.reminderDate1!.day == day.day) {
        final noteText = c.reminderNote1 != null && c.reminderNote1!.trim().isNotEmpty
            ? ' - ${c.reminderNote1}'
            : '';
        dayEvents.add(CalendarEvent(
          title: "Follow-up reminder: ${c.name}",
          type: 'reminder',
          details: 'Reminder 1 Scheduled$noteText',
          customer: c,
        ));
      }

      if (c.reminderDate2 != null &&
          c.reminderDate2!.year == day.year &&
          c.reminderDate2!.month == day.month &&
          c.reminderDate2!.day == day.day) {
        final noteText = c.reminderNote2 != null && c.reminderNote2!.trim().isNotEmpty
            ? ' - ${c.reminderNote2}'
            : '';
        dayEvents.add(CalendarEvent(
          title: "Follow-up reminder: ${c.name}",
          type: 'reminder',
          details: 'Reminder 2 Scheduled$noteText',
          customer: c,
        ));
      }
    }

    // 4. Marketing Visits
    for (final lead in marketingLeads) {
      for (final visit in lead.visits) {
        if (visit.visitDate != null &&
            visit.visitDate!.year == day.year &&
            visit.visitDate!.month == day.month &&
            visit.visitDate!.day == day.day) {
          final timeStr = visit.visitTime != null && visit.visitTime!.isNotEmpty ? ' at ${visit.visitTime}' : '';
          final noteStr = visit.visitNote != null && visit.visitNote!.isNotEmpty ? ' - ${visit.visitNote}' : '';
          dayEvents.add(CalendarEvent(
            title: "Marketing Visit: ${lead.name}",
            type: 'marketing',
            details: 'Status: ${lead.status}$timeStr$noteStr',
            marketingLead: lead,
          ));
        }
      }
    }

    return dayEvents;
  }

  @override
  Widget build(BuildContext context) {
    final customersAsync = ref.watch(customerListProvider);
    final upcomingEventsAsync = ref.watch(upcomingEventsProvider);
    final todayTasksAsync = ref.watch(todayTasksProvider);
    final marketingLeadsAsync = ref.watch(marketingListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Upcoming Events Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.invalidate(customerListProvider);
              ref.invalidate(upcomingEventsProvider);
              ref.invalidate(todayTasksProvider);
              ref.invalidate(marketingListProvider);
            },
          )
        ],
      ),
      body: customersAsync.when(
        data: (customers) {
          return marketingLeadsAsync.when(
            data: (marketingLeads) {
              final calendarDays = _getCalendarDays(_focusedMonth);
              final selectedEvents = _getEventsForDay(_selectedDay, customers, marketingLeads);

              return LayoutBuilder(
                builder: (context, constraints) {
                  final isDesktop = constraints.maxWidth > 800;
                  final calendarWidget = _buildCalendarCard(calendarDays, customers, marketingLeads);
                  final eventsWidget = _buildEventsPanel(context, selectedEvents, upcomingEventsAsync, todayTasksAsync);

                  if (isDesktop) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(16.0),
                            child: calendarWidget,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(left: BorderSide(color: Colors.grey[200]!)),
                            ),
                            child: SingleChildScrollView(
                              child: eventsWidget,
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return ListView(
                      padding: const EdgeInsets.all(16.0),
                      children: [
                        calendarWidget,
                        const SizedBox(height: 16),
                        eventsWidget,
                      ],
                    );
                  }
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Error loading marketing: $err')),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error loading events: $err')),
      ),
    );
  }

  Widget _buildCalendarCard(List<DateTime?> calendarDays, List<Customer> customers, List<MarketingLead> marketingLeads) {
    final monthFormat = DateFormat('MMMM yyyy');
    final weekdayHeaders = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

    return Card(
      elevation: 0.5,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Calendar Header: Month/Year navigation
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () {
                    setState(() {
                      _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month - 1, 1);
                    });
                  },
                ),
                Text(
                  monthFormat.format(_focusedMonth),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: () {
                    setState(() {
                      _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month + 1, 1);
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Days of the week headers
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: weekdayHeaders.map((day) {
                return Expanded(
                  child: Center(
                    child: Text(
                      day,
                      style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                  ),
                );
              }).toList(),
            ),
            const Divider(height: 16),
            // Grid of days
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: calendarDays.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                final day = calendarDays[index];
                if (day == null) {
                  return const SizedBox.shrink();
                }

                final isSelected = day.year == _selectedDay.year &&
                    day.month == _selectedDay.month &&
                    day.day == _selectedDay.day;

                final today = DateTime.now();
                final isToday = day.year == today.year &&
                    day.month == today.month &&
                    day.day == today.day;

                final dayEvents = _getEventsForDay(day, customers, marketingLeads);

                return _buildCalendarDayTile(day, isSelected, isToday, dayEvents);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarDayTile(
    DateTime day,
    bool isSelected,
    bool isToday,
    List<CalendarEvent> events,
  ) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedDay = day;
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.blueAccent
              : (isToday ? Colors.blue.withOpacity(0.08) : Colors.transparent),
          borderRadius: BorderRadius.circular(12),
          border: isToday && !isSelected
              ? Border.all(color: Colors.blueAccent, width: 1.5)
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${day.day}',
              style: TextStyle(
                fontWeight: isToday || isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected
                    ? Colors.white
                    : (isToday ? Colors.blueAccent : Colors.black87),
                fontSize: 15,
              ),
            ),
            if (events.isNotEmpty) ...[
              const SizedBox(height: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: events.take(3).map((e) {
                  Color dotColor = Colors.blue;
                  if (e.type == 'birthday') dotColor = Colors.pink;
                  if (e.type == 'anniversary') dotColor = Colors.red;
                  if (e.type == 'marketing') dotColor = Colors.purple;
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 1),
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.white : dotColor,
                      shape: BoxShape.circle,
                    ),
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildEventsPanel(
    BuildContext context,
    List<CalendarEvent> selectedEvents,
    AsyncValue<List<UpcomingEvent>> upcomingEventsAsync,
    AsyncValue<List<WorkTask>> todayTasksAsync,
  ) {
    final selectedDateStr = DateFormat('dd MMMM yyyy').format(_selectedDay);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Section Title
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Events on $selectedDateStr',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blueAccent),
                  ),
                ),
                if (selectedEvents.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${selectedEvents.length} Event${selectedEvents.length > 1 ? 's' : ''}',
                      style: const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold, fontSize: 11),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Selected Day Events List
          if (selectedEvents.isEmpty)
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey[200]!),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
                child: Column(
                  children: [
                    Icon(Icons.calendar_today_outlined, size: 36, color: Colors.grey[400]),
                    const SizedBox(height: 8),
                    const Text(
                      'No events scheduled for this day',
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ],
                ),
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: selectedEvents.length,
              itemBuilder: (context, index) {
                final e = selectedEvents[index];
                Color color = Colors.blue;
                IconData icon = Icons.handshake;
                if (e.type == 'birthday') {
                  color = Colors.pink;
                  icon = Icons.cake;
                } else if (e.type == 'anniversary') {
                  color = Colors.red;
                  icon = Icons.favorite;
                } else if (e.type == 'marketing') {
                  color = Colors.purple;
                  icon = Icons.campaign;
                }
                return _buildEventCard(context, e.title, e.details, color, icon, e.customer, e.marketingLead);
              },
            ),
          
          const Divider(height: 32),

          // Section Title: Today's Work Tasks
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Text(
              "Today's Work Tasks",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.blueAccent),
            ),
          ),
          const SizedBox(height: 8),

          todayTasksAsync.when(
            data: (tasks) {
              if (tasks.isEmpty) {
                return Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey[200]!),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                    child: Row(
                      children: [
                        Icon(Icons.check_circle_outline, color: Colors.green, size: 20),
                        SizedBox(width: 8),
                        Text(
                          'All tasks completed or none scheduled today!',
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final t = tasks[index];
                  Color priorityColor = Colors.grey;
                  if (t.priority == 'Urgent') priorityColor = Colors.redAccent;
                  if (t.priority == 'Important') priorityColor = Colors.orangeAccent;
                  
                  Color statusColor = Colors.grey;
                  if (t.status == 'Completed') statusColor = Colors.green;
                  if (t.status == 'Under Process') statusColor = Colors.blue;

                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Colors.grey[200]!),
                    ),
                    child: InkWell(
                      onTap: () {
                        // Pre-select the company in the Work tab
                        if (t.companyId != null) {
                          ref.read(selectedCompanyIdProvider.notifier).state = t.companyId;
                        }
                        // Switch to the Work tab (Index 3)
                        ref.read(navigationTabIndexProvider.notifier).state = 3;
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: priorityColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                t.priority.toUpperCase(),
                                style: TextStyle(color: priorityColor, fontWeight: FontWeight.bold, fontSize: 10),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    t.description,
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                  ),
                                  if (t.remarks != null && t.remarks!.isNotEmpty) ...[
                                    const SizedBox(height: 2),
                                    Text(
                                      t.remarks!,
                                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: statusColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                t.status,
                                style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 11),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Text('Error loading today\'s tasks: $err'),
          ),

          const Divider(height: 32),
          
          // Section Title: Other Upcoming Events (Next 30 Days)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Text(
              'Upcoming Events (Next 30 Days)',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87),
            ),
          ),
          const SizedBox(height: 8),
          
          // List of overall upcoming events
          upcomingEventsAsync.when(
            data: (events) {
              if (events.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('No upcoming events found.', style: TextStyle(color: Colors.grey, fontSize: 13)),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final e = events[index];
                  Color color = Colors.blue;
                  IconData icon = Icons.handshake;
                  if (e.type == 'birthday') {
                    color = Colors.pink;
                    icon = Icons.cake;
                  } else if (e.type == 'anniversary') {
                    color = Colors.red;
                    icon = Icons.favorite;
                  } else if (e.type == 'marketing') {
                    color = Colors.purple;
                    icon = Icons.campaign;
                  }
                  return _buildEventCard(context, e.title, '${e.details} (${e.dateText})', color, icon, e.customer, e.marketingLead);
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Text('Error loading upcoming events: $err'),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(
    BuildContext context,
    String title,
    String details,
    Color color,
    IconData icon,
    Customer? customer,
    MarketingLead? marketingLead,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[200]!),
      ),
      child: InkWell(
        onTap: () {
          if (marketingLead != null) {
            ref.read(navigationTabIndexProvider.notifier).state = 4;
          } else if (customer != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CustomerDetailScreen(customerId: customer.id),
              ),
            );
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      details,
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                    if (customer != null && customer.notes != null && customer.notes!.trim().isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        'Notes: ${customer.notes}',
                        style: TextStyle(color: Colors.grey[500], fontSize: 11, fontStyle: FontStyle.italic),
                      ),
                    ],
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.grey[400], size: 18),
            ],
          ),
        ),
      ),
    );
  }
}
