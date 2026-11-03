import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../models/daily_note.dart';
import '../models/work_task.dart';
import '../providers/customer_provider.dart';
import '../providers/daily_notes_provider.dart';
import '../providers/events_provider.dart';
import '../providers/marketing_provider.dart';
import '../providers/work_provider.dart';
import '../services/app_storage_service.dart';
import '../services/dashboard_export_service.dart';
import '../services/database_service.dart';
import '../theme/app_colors.dart';
import '../widgets/brand_card.dart';
import '../widgets/color_badge.dart';
import '../widgets/key_cycle_dropdown.dart';
import 'customer_detail_screen.dart';
import 'customer_form_screen.dart';
import 'marketing_screen.dart';

final dashboardFilterCategoryProvider = StateProvider<String>((ref) => 'All');

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todaySummaryAsync = ref.watch(todaySummaryEventsProvider);
    final selectedFilter = ref.watch(dashboardFilterCategoryProvider);
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    final formattedTomorrowDate = DateFormat('EEEE, dd MMMM yyyy').format(tomorrow);
    final allItems = todaySummaryAsync.value ?? [];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Welcome Header & Tomorrow Banner
            BrandCard(
              showTopGradient: true,
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [AppColors.buttonShadow],
                    ),
                    child: const Icon(
                      Icons.event_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Tomorrow's Work & Event Summary",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.headingText,
                            letterSpacing: -0.3,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.calendar_month_rounded, size: 14, color: AppColors.skyBlue),
                            const SizedBox(width: 6),
                            Text(
                              formattedTomorrowDate,
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.bodyText,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    tooltip: 'Download PDF Report',
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.badgeGreenBg,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.picture_as_pdf_rounded, color: AppColors.limeGreen, size: 20),
                    ),
                    onPressed: () => DashboardExportService.shareDashboardPdf(
                      allItems,
                      dailyNotes: ref.read(tomorrowNotesProvider).value ?? [],
                      context: context,
                    ),
                  ),
                  const SizedBox(width: 6),
                  IconButton(
                    tooltip: 'Refresh Tomorrow Data',
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.badgeBlueBg,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.refresh_rounded, color: AppColors.skyBlue, size: 20),
                    ),
                    onPressed: () {
                      ref.invalidate(customerListProvider);
                      ref.invalidate(marketingListProvider);
                      ref.invalidate(todayTasksProvider);
                      ref.invalidate(todaySummaryEventsProvider);
                      ref.invalidate(tomorrowNotesProvider);
                    },
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.violetAccent,
                      foregroundColor: Colors.white,
                      elevation: 1,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    ),
                    onPressed: () => _openNewMarketingLeadDialog(context, ref),
                    icon: const Icon(Icons.campaign_rounded, size: 18),
                    label: const Text('New Lead', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  ),
                ],
              ),
            ),

              const SizedBox(height: 16),

            // Summary Metrics Grid
            todaySummaryAsync.when(
              data: (allItems) {
                final reminderCount = allItems.where((i) => i.type == TodayEventType.reminder).length;
                final taskCount = allItems.where((i) => i.type == TodayEventType.workTask).length;
                final marketingCount = allItems.where((i) => i.type == TodayEventType.marketing).length;

                // Filtered List
                List<TodayEventSummaryItem> filteredItems = allItems;
                if (selectedFilter == 'Reminders') {
                  filteredItems = allItems.where((i) => i.type == TodayEventType.reminder).toList();
                } else if (selectedFilter == 'Tasks') {
                  filteredItems = allItems.where((i) => i.type == TodayEventType.workTask).toList();
                } else if (selectedFilter == 'Marketing') {
                  filteredItems = allItems.where((i) => i.type == TodayEventType.marketing).toList();
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Stat Cards Grid
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final bool isWide = constraints.maxWidth > 700;
                        return GridView.count(
                          crossAxisCount: isWide ? 4 : 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: isWide ? 1.5 : 1.7,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            _buildStatTile(
                              title: 'Total Summary',
                              count: allItems.length,
                              icon: Icons.dashboard_customize_rounded,
                              bg: AppColors.badgeBlueBg,
                              fg: AppColors.skyBlue,
                              isSelected: selectedFilter == 'All',
                              onTap: () => ref.read(dashboardFilterCategoryProvider.notifier).state = 'All',
                            ),
                            _buildStatTile(
                              title: 'Reminders',
                              count: reminderCount,
                              icon: Icons.alarm_rounded,
                              bg: AppColors.badgeGreenBg,
                              fg: AppColors.badgeGreenText,
                              isSelected: selectedFilter == 'Reminders',
                              onTap: () => ref.read(dashboardFilterCategoryProvider.notifier).state = 'Reminders',
                            ),
                            _buildStatTile(
                              title: 'Work Tasks',
                              count: taskCount,
                              icon: Icons.task_alt_rounded,
                              bg: AppColors.badgeCyanBg,
                              fg: AppColors.badgeCyanText,
                              isSelected: selectedFilter == 'Tasks',
                              onTap: () => ref.read(dashboardFilterCategoryProvider.notifier).state = 'Tasks',
                            ),
                            _buildStatTile(
                              title: 'Marketing Leads',
                              count: marketingCount,
                              icon: Icons.campaign_rounded,
                              bg: AppColors.badgeRoseBg,
                              fg: AppColors.badgeRoseText,
                              isSelected: selectedFilter == 'Marketing',
                              onTap: () => ref.read(dashboardFilterCategoryProvider.notifier).state = 'Marketing',
                            ),
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: 16),

                    // Day Task Notes Section
                    DayTaskNotesCard(targetDate: tomorrow),

                    const SizedBox(height: 16),

                    // Filter Chips Bar
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildFilterChip(ref, 'All', 'All (${allItems.length})', selectedFilter),
                          const SizedBox(width: 8),
                          _buildFilterChip(ref, 'Reminders', 'Reminders ($reminderCount)', selectedFilter),
                          const SizedBox(width: 8),
                          _buildFilterChip(ref, 'Tasks', 'Tasks ($taskCount)', selectedFilter),
                          const SizedBox(width: 8),
                          _buildFilterChip(ref, 'Marketing', 'Marketing ($marketingCount)', selectedFilter),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Event Summary List Section
                    if (filteredItems.isEmpty)
                      BrandCard(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: const BoxDecoration(
                                color: AppColors.badgeBlueBg,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check_circle_outline_rounded,
                                size: 48,
                                color: AppColors.skyBlue,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              selectedFilter == 'All'
                                  ? 'No events or follow-ups scheduled for tomorrow!'
                                  : 'No $selectedFilter found for tomorrow.',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.headingText,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Enjoy your productive day or add new tasks and customer reminders for tomorrow.',
                              style: TextStyle(fontSize: 13, color: AppColors.mutedText),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              alignment: WrapAlignment.center,
                              children: [
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.violetAccent,
                                    foregroundColor: Colors.white,
                                  ),
                                  onPressed: () => _openNewMarketingLeadDialog(context, ref),
                                  icon: const Icon(Icons.campaign_rounded, size: 16),
                                  label: const Text('New Marketing Lead'),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) => const CustomerFormScreen()),
                                    );
                                  },
                                  icon: const Icon(Icons.person_add, size: 16),
                                  label: const Text('Add Customer'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredItems.length,
                        itemBuilder: (context, index) {
                          final item = filteredItems[index];
                          return _buildEventItemCard(context, ref, item);
                        },
                      ),
                  ],
                );
              },
              loading: () => const Padding(
                padding: EdgeInsets.all(32.0),
                child: Center(child: CircularProgressIndicator(color: AppColors.skyBlue)),
              ),
              error: (err, stack) => BrandCard(
                padding: const EdgeInsets.all(16),
                child: Text('Error loading tomorrow summary: $err', style: const TextStyle(color: AppColors.roseAccent)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(WidgetRef ref, String key, String label, String selectedKey) {
    final isSelected = selectedKey == key;
    return FilterChip(
      selected: isSelected,
      label: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : AppColors.bodyText,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
          fontSize: 12,
        ),
      ),
      selectedColor: AppColors.skyBlue,
      backgroundColor: AppColors.cardSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: isSelected ? AppColors.skyBlue : AppColors.cardBorder),
      ),
      onSelected: (_) {
        ref.read(dashboardFilterCategoryProvider.notifier).state = key;
      },
    );
  }

  Widget _buildStatTile({
    required String title,
    required int count,
    required IconData icon,
    required Color bg,
    required Color fg,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isSelected ? bg : AppColors.cardSurface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? fg : AppColors.cardBorder,
              width: isSelected ? 2 : 1,
            ),
            boxShadow: [
              isSelected
                  ? BoxShadow(color: fg.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 4))
                  : AppColors.softShadow,
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: bg,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(icon, color: fg, size: 18),
                  ),
                  Text(
                    '$count',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: fg,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? fg : AppColors.headingText,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getWorkTaskStatusColor(String status) {
    switch (status.trim().toLowerCase()) {
      case 'completed':
        return Colors.green;
      case 'under process':
        return Colors.orange;
      case 'pending':
        return Colors.blue;
      case 'no response':
        return Colors.red;
      default:
        return Colors.blueGrey;
    }
  }

  Color _getMarketingStatusColor(String status) {
    switch (status.trim().toLowerCase()) {
      case 'confirmed':
        return Colors.green;
      case 'dropped':
        return Colors.red;
      case 'postponed':
        return Colors.orange;
      case 'hold':
        return Colors.indigo;
      case 'documents pending':
        return Colors.purple;
      default:
        return Colors.blueGrey;
    }
  }

  String _getNormalizedStatus(String rawStatus) {
    final lower = rawStatus.trim().toLowerCase();
    if (lower == 'confirmed') return 'Confirmed';
    if (lower == 'dropped') return 'Dropped';
    if (lower == 'postponed') return 'Postponed';
    if (lower == 'hold') return 'Hold';
    if (lower == 'documents pending' || lower == 'documentspending') return 'Documents Pending';
    if (lower == 'follow-up' || lower == 'followup') return 'Follow-up';
    if (rawStatus.isEmpty) return 'Confirmed';
    return rawStatus;
  }

  Widget _buildEventItemCard(BuildContext context, WidgetRef ref, TodayEventSummaryItem item) {
    IconData icon;
    BadgeStyle badgeStyle;
    Color iconColor;

    switch (item.type) {
      case TodayEventType.birthday:
        icon = Icons.cake_rounded;
        badgeStyle = BadgeStyle.rose;
        iconColor = AppColors.roseAccent;
        break;
      case TodayEventType.anniversary:
        icon = Icons.favorite_rounded;
        badgeStyle = BadgeStyle.amber;
        iconColor = AppColors.amberAccent;
        break;
      case TodayEventType.reminder:
        icon = Icons.alarm_rounded;
        badgeStyle = BadgeStyle.green;
        iconColor = AppColors.limeGreen;
        break;
      case TodayEventType.workTask:
        icon = Icons.task_alt_rounded;
        badgeStyle = BadgeStyle.cyan;
        iconColor = AppColors.cyanAccent;
        break;
      case TodayEventType.marketing:
        icon = Icons.campaign_rounded;
        badgeStyle = BadgeStyle.violet;
        iconColor = AppColors.violetAccent;
        break;
      case TodayEventType.personalAccident:
        icon = Icons.healing_rounded;
        badgeStyle = BadgeStyle.amber;
        iconColor = AppColors.amberAccent;
        break;
    }

    return BrandCard(
      margin: const EdgeInsets.only(bottom: 10),
      onTap: item.customer != null
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CustomerDetailScreen(customerId: item.customer!.id),
                ),
              );
            }
          : (item.type == TodayEventType.workTask && item.workTask != null)
              ? () {
                  if (item.workTask!.companyId != null) {
                    ref.read(selectedCompanyIdProvider.notifier).state = item.workTask!.companyId;
                  }
                  ref.read(navigationTabIndexProvider.notifier).state = 4;
                }
              : (item.type == TodayEventType.marketing && item.marketingLead != null)
                  ? () {
                      ref.read(navigationTabIndexProvider.notifier).state = 5;
                    }
                  : null,
      child: Row(
        children: [
          // Event Type Icon Box
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 14),

          // Main Title & Subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.title,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.headingText,
                          decoration: item.isCompleted ? TextDecoration.lineThrough : null,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 6),
                    ColorBadge(
                      text: item.categoryLabel.toUpperCase(),
                      style: badgeStyle,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  item.subtitle,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: AppColors.bodyText,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (item.time != null) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.access_time_rounded, size: 12, color: AppColors.mutedText),
                      const SizedBox(width: 4),
                      Text(
                        item.time!,
                        style: const TextStyle(fontSize: 11, color: AppColors.mutedText, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),

          // Status Change Control for Work Tasks
          if (item.type == TodayEventType.workTask && item.workTask != null) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: _getWorkTaskStatusColor(item.workTask!.status).withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _getWorkTaskStatusColor(item.workTask!.status).withOpacity(0.3)),
              ),
              child: KeyCycleDropdownButton<String>(
                value: item.workTask!.status,
                underline: const SizedBox(),
                items: const ['Pending', 'Completed', 'Under Process', 'No Response'].map((String s) {
                  return DropdownMenuItem<String>(
                    value: s,
                    child: Text(
                      s,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: _getWorkTaskStatusColor(s),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (newStatus) async {
                  if (newStatus != null) {
                    final db = ref.read(databaseServiceProvider);
                    final task = item.workTask!;
                    task.status = newStatus;
                    await db.saveTask(task);
                    ref.invalidate(todaySummaryEventsProvider);
                    ref.invalidate(todayTasksProvider);
                    ref.invalidate(taskListProvider);
                  }
                },
              ),
            ),
            const SizedBox(width: 4),
            IconButton(
              icon: const Icon(Icons.delete_outline_rounded, size: 20, color: Colors.redAccent),
              tooltip: 'Delete Task',
              onPressed: () => _confirmDeleteWorkTask(context, ref, item.workTask!),
            ),
          ] else if (item.type == TodayEventType.marketing && item.marketingLead != null) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: _getMarketingStatusColor(item.marketingLead!.status).withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _getMarketingStatusColor(item.marketingLead!.status).withOpacity(0.3)),
              ),
              child: KeyCycleDropdownButton<String>(
                value: _getNormalizedStatus(item.marketingLead!.status),
                underline: const SizedBox(),
                items: const [
                  'Confirmed',
                  'Dropped',
                  'Postponed',
                  'Hold',
                  'Documents Pending',
                  'Follow-up',
                ].map((String s) {
                  return DropdownMenuItem<String>(
                    value: s,
                    child: Text(
                      s,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: _getMarketingStatusColor(s),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (newStatus) async {
                  if (newStatus != null) {
                    final db = ref.read(databaseServiceProvider);
                    final lead = item.marketingLead!;
                    lead.status = newStatus;
                    lead.updatedAt = DateTime.now();
                    await db.saveMarketingLead(lead);
                    ref.invalidate(todaySummaryEventsProvider);
                    ref.invalidate(marketingListProvider);
                  }
                },
              ),
            ),
          ] else if (item.customer != null) ...[
            const SizedBox(width: 8),
            IconButton(
              tooltip: 'View Customer Profile',
              icon: const Icon(Icons.chevron_right_rounded, color: AppColors.skyBlue),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CustomerDetailScreen(customerId: item.customer!.id),
                  ),
                );
              },
            ),
          ],
        ],
      ),
    );
  }

  void _confirmDeleteWorkTask(BuildContext context, WidgetRef ref, WorkTask task) async {
    final check = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.redAccent),
            SizedBox(width: 8),
            Text('Delete Task?'),
          ],
        ),
        content: Text('Are you sure you want to delete "${task.description}"?'),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (check == true) {
      final db = ref.read(databaseServiceProvider);
      await db.deleteTask(task.id);
      ref.invalidate(todaySummaryEventsProvider);
      ref.invalidate(todayTasksProvider);
      ref.invalidate(taskListProvider);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Task deleted successfully')),
        );
      }
    }
  }

  void _openNewMarketingLeadDialog(BuildContext context, WidgetRef ref) async {
    final docsDir = await AppStorageService.getCustomerDocumentsDirectory();
    if (!context.mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return AddEditMarketingLeadDialog(
          localDocsDirPath: docsDir.path,
          onSave: () {
            ref.invalidate(marketingListProvider);
            ref.invalidate(todaySummaryEventsProvider);
          },
        );
      },
    );
  }
}

class DayTaskNotesCard extends ConsumerStatefulWidget {
  final DateTime targetDate;
  const DayTaskNotesCard({super.key, required this.targetDate});

  @override
  ConsumerState<DayTaskNotesCard> createState() => _DayTaskNotesCardState();
}

class _DayTaskNotesCardState extends ConsumerState<DayTaskNotesCard> {
  final TextEditingController _noteController = TextEditingController();
  String _selectedCategory = 'General';
  bool _isAdding = false;

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _addNote() async {
    final text = _noteController.text.trim();
    if (text.isEmpty) return;

    setState(() => _isAdding = true);
    final db = ref.read(databaseServiceProvider);
    await db.saveDailyNote(
      text,
      widget.targetDate,
      category: _selectedCategory == 'General' ? null : _selectedCategory,
    );
    _noteController.clear();
    setState(() {
      _isAdding = false;
      _selectedCategory = 'General';
    });

    ref.invalidate(tomorrowNotesProvider);
  }

  BadgeStyle _getCategoryBadgeStyle(String cat) {
    switch (cat.toLowerCase()) {
      case 'work':
        return BadgeStyle.cyan;
      case 'personal':
        return BadgeStyle.violet;
      case 'urgent':
        return BadgeStyle.rose;
      case 'follow-up':
        return BadgeStyle.amber;
      case 'reminder':
        return BadgeStyle.green;
      default:
        return BadgeStyle.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    final notesAsync = ref.watch(tomorrowNotesProvider);
    final formattedDate = DateFormat('EEEE, dd MMM').format(widget.targetDate);

    return BrandCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.badgeAmberBg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.sticky_note_2_rounded, color: AppColors.badgeAmberText, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Day Task Notes',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.headingText,
                      ),
                    ),
                    Text(
                      'Notes & quick task checklist for $formattedDate',
                      style: const TextStyle(fontSize: 11.5, color: AppColors.mutedText),
                    ),
                  ],
                ),
              ),
              notesAsync.when(
                data: (notes) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.badgeAmberBg,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${notes.where((n) => n.isCompleted).length}/${notes.length} Done',
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.badgeAmberText),
                  ),
                ),
                loading: () => const SizedBox(),
                error: (_, __) => const SizedBox(),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Add Note Bar with Optional Dropdown & Multiline Input
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Category:',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.bodyText),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: KeyCycleDropdownButton<String>(
                      value: _selectedCategory,
                      underline: const SizedBox(),
                      items: const ['General', 'Work', 'Personal', 'Urgent', 'Follow-up', 'Reminder'].map((cat) {
                        return DropdownMenuItem<String>(
                          value: cat,
                          child: Text(
                            cat,
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setState(() {
                            _selectedCategory = val;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _noteController,
                      minLines: 2,
                      maxLines: 5,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: 'Add a note or quick task (press Enter for next line)...',
                        hintStyle: TextStyle(fontSize: 13, color: Colors.grey[400]),
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey[200]!),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey[200]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.skyBlue),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.skyBlue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    ),
                    onPressed: _isAdding ? null : _addNote,
                    icon: const Icon(Icons.add_rounded, size: 18),
                    label: const Text('Add Note', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Notes List
          notesAsync.when(
            data: (notes) {
              if (notes.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'No day task notes added for $formattedDate yet.',
                    style: TextStyle(fontSize: 12.5, fontStyle: FontStyle.italic, color: Colors.grey[500]),
                  ),
                );
              }

              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: notes.length,
                separatorBuilder: (_, __) => const Divider(height: 1, indent: 32),
                itemBuilder: (context, index) {
                  final note = notes[index];
                  final hasCat = note.category != null && note.category!.trim().isNotEmpty;

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: note.isCompleted,
                          activeColor: AppColors.skyBlue,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          onChanged: (_) async {
                            final db = ref.read(databaseServiceProvider);
                            await db.toggleDailyNoteCompleted(note.id);
                            ref.invalidate(tomorrowNotesProvider);
                          },
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (hasCat) ...[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 4.0, top: 4.0),
                                  child: ColorBadge(
                                    text: note.category!.toUpperCase(),
                                    style: _getCategoryBadgeStyle(note.category!),
                                  ),
                                ),
                              ],
                              Text(
                                note.content,
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: note.isCompleted ? AppColors.mutedText : AppColors.headingText,
                                  decoration: note.isCompleted ? TextDecoration.lineThrough : null,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline_rounded, size: 18, color: Colors.grey),
                          tooltip: 'Delete note',
                          onPressed: () async {
                            final db = ref.read(databaseServiceProvider);
                            await db.deleteDailyNote(note.id);
                            ref.invalidate(tomorrowNotesProvider);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            loading: () => const Center(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
            error: (err, _) => Text('Error loading notes: $err', style: const TextStyle(color: Colors.red, fontSize: 12)),
          ),
        ],
      ),
    );
  }
}
