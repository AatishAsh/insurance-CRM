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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _purposeController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _docsController = TextEditingController();

  String _selectedCategory = 'Work';
  bool _isAdding = false;

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _purposeController.dispose();
    _timeController.dispose();
    _docsController.dispose();
    super.dispose();
  }

  Future<void> _pickTime(BuildContext context, TextEditingController controller) async {
    final now = TimeOfDay.now();
    final picked = await showTimePicker(
      context: context,
      initialTime: now,
    );
    if (picked != null) {
      if (!mounted) return;
      controller.text = picked.format(context);
    }
  }

  void _appendDoc(String doc) {
    final current = _docsController.text.trim();
    if (current.isEmpty) {
      _docsController.text = doc;
    } else if (!current.toLowerCase().contains(doc.toLowerCase())) {
      _docsController.text = '$current, $doc';
    }
  }

  void _addTask() async {
    final name = _nameController.text.trim();
    final location = _locationController.text.trim();
    final purpose = _purposeController.text.trim();
    final time = _timeController.text.trim();
    final docs = _docsController.text.trim();

    if (name.isEmpty && purpose.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter at least Name or Purpose for the daily task.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() => _isAdding = true);
    try {
      final db = ref.read(databaseServiceProvider);
      await db.saveDailyTask(
        date: widget.targetDate,
        name: name,
        location: location,
        purpose: purpose,
        time: time,
        documentsRequired: docs,
        category: _selectedCategory,
      );

      _nameController.clear();
      _locationController.clear();
      _purposeController.clear();
      _timeController.clear();
      _docsController.clear();

      setState(() {
        _isAdding = false;
        _selectedCategory = 'Work';
      });

      ref.invalidate(tomorrowNotesProvider);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Daily task saved for tomorrow!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isAdding = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save task: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showEditDialog(DailyNote note) {
    final editName = TextEditingController(text: note.taskName);
    final editLocation = TextEditingController(text: note.taskLocation);
    final editPurpose = TextEditingController(text: note.taskPurpose);
    final editTime = TextEditingController(text: note.taskTime);
    final editDocs = TextEditingController(text: note.documentsRequired);
    String editCategory = note.category ?? 'Work';

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Row(
            children: [
              Icon(Icons.edit_note_rounded, color: AppColors.skyBlue),
              SizedBox(width: 8),
              Text('Edit Daily Task', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
            ],
          ),
          content: SizedBox(
            width: 500,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: TextField(
                          controller: editName,
                          decoration: const InputDecoration(
                            labelText: '1. Name',
                            hintText: 'Client / Person name',
                            isDense: true,
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person_outline_rounded, size: 18),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 2,
                        child: TextField(
                          controller: editTime,
                          decoration: InputDecoration(
                            labelText: '4. Time',
                            hintText: 'e.g. 10:30 AM',
                            isDense: true,
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.access_time_rounded, size: 18),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.schedule, size: 18),
                              onPressed: () => _pickTime(ctx, editTime),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: editLocation,
                    decoration: const InputDecoration(
                      labelText: '2. Location',
                      hintText: 'Office / Branch / Place',
                      isDense: true,
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.location_on_outlined, size: 18),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: editPurpose,
                    decoration: const InputDecoration(
                      labelText: '3. Purpose',
                      hintText: 'Purpose of visit / Task to do',
                      isDense: true,
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.assignment_outlined, size: 18),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: editDocs,
                    decoration: const InputDecoration(
                      labelText: '5. Documents REQUIRED',
                      hintText: 'e.g. PAN, Aadhaar, Cheque, Photo',
                      isDense: true,
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.folder_shared_outlined, size: 18),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    children: ['PAN Card', 'Aadhaar Card', 'Cheque', 'Photos', 'Policy Copy'].map((chip) {
                      return ActionChip(
                        label: Text('+ $chip', style: const TextStyle(fontSize: 11)),
                        padding: EdgeInsets.zero,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onPressed: () {
                          final cur = editDocs.text.trim();
                          setDialogState(() {
                            if (cur.isEmpty) {
                              editDocs.text = chip;
                            } else if (!cur.toLowerCase().contains(chip.toLowerCase())) {
                              editDocs.text = '$cur, $chip';
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Text('Category:', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                      const SizedBox(width: 8),
                      DropdownButton<String>(
                        value: editCategory,
                        items: const ['Work', 'General', 'Personal', 'Urgent', 'Follow-up', 'Reminder']
                            .map((c) => DropdownMenuItem(value: c, child: Text(c, style: const TextStyle(fontSize: 13))))
                            .toList(),
                        onChanged: (val) {
                          if (val != null) setDialogState(() => editCategory = val);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.skyBlue,
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                final n = editName.text.trim();
                final p = editPurpose.text.trim();
                if (n.isEmpty && p.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Name or Purpose is required.')),
                  );
                  return;
                }
                final db = ref.read(databaseServiceProvider);
                await db.saveDailyTask(
                  date: widget.targetDate,
                  name: n,
                  location: editLocation.text.trim(),
                  purpose: p,
                  time: editTime.text.trim(),
                  documentsRequired: editDocs.text.trim(),
                  category: editCategory,
                  existingId: note.id,
                );
                ref.invalidate(tomorrowNotesProvider);
                if (mounted) {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Daily task updated!'), backgroundColor: Colors.green),
                  );
                }
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(DailyNote note) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Daily Task?'),
        content: Text('Are you sure you want to delete "${note.displayTitle}"?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final db = ref.read(databaseServiceProvider);
      await db.deleteDailyNote(note.id);
      ref.invalidate(tomorrowNotesProvider);
    }
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

  InputDecoration _buildInputDecoration(String label, String hint, IconData icon, {Widget? suffix}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      hintStyle: TextStyle(fontSize: 12, color: Colors.grey[400]),
      labelStyle: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600),
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      prefixIcon: Icon(icon, size: 18, color: AppColors.skyBlue),
      suffixIcon: suffix,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.skyBlue, width: 1.5),
      ),
      filled: true,
      fillColor: Colors.white,
    );
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
                child: const Icon(Icons.assignment_turned_in_rounded, color: AppColors.badgeAmberText, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tomorrow\'s Work & Daily Tasks',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.headingText,
                      ),
                    ),
                    Text(
                      'Tasks & work checklist scheduled for $formattedDate',
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
          const SizedBox(height: 14),

          // Add Daily Task Form Container
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth > 720;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isWide) ...[
                      // Wide Mode: Row 1
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextField(
                              controller: _nameController,
                              decoration: _buildInputDecoration(
                                '1. Name',
                                'Client / Contact name',
                                Icons.person_outline_rounded,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 2,
                            child: TextField(
                              controller: _timeController,
                              decoration: _buildInputDecoration(
                                '4. Time',
                                'e.g. 10:30 AM',
                                Icons.access_time_rounded,
                                suffix: IconButton(
                                  icon: const Icon(Icons.schedule, size: 18, color: AppColors.skyBlue),
                                  onPressed: () => _pickTime(context, _timeController),
                                  tooltip: 'Pick Time',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 3,
                            child: TextField(
                              controller: _locationController,
                              decoration: _buildInputDecoration(
                                '2. Location',
                                'Office / Branch / Address',
                                Icons.location_on_outlined,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Wide Mode: Row 2
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 4,
                            child: TextField(
                              controller: _purposeController,
                              decoration: _buildInputDecoration(
                                '3. Purpose',
                                'Purpose of visit / Task description',
                                Icons.assignment_outlined,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 4,
                            child: TextField(
                              controller: _docsController,
                              decoration: _buildInputDecoration(
                                '5. Documents REQUIRED',
                                'e.g. PAN, Aadhaar, Cheque, Photos',
                                Icons.folder_shared_outlined,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryBlue,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            onPressed: _isAdding ? null : _addTask,
                            icon: _isAdding
                                ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                                : const Icon(Icons.add_task_rounded, size: 18),
                            label: const Text('Add Task', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          ),
                        ],
                      ),
                    ] else ...[
                      // Compact Mode
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextField(
                              controller: _nameController,
                              decoration: _buildInputDecoration(
                                '1. Name',
                                'Client / Contact',
                                Icons.person_outline_rounded,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 2,
                            child: TextField(
                              controller: _timeController,
                              decoration: _buildInputDecoration(
                                '4. Time',
                                '10:30 AM',
                                Icons.access_time_rounded,
                                suffix: IconButton(
                                  icon: const Icon(Icons.schedule, size: 18, color: AppColors.skyBlue),
                                  onPressed: () => _pickTime(context, _timeController),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _locationController,
                        decoration: _buildInputDecoration(
                          '2. Location',
                          'Office / Branch / Address',
                          Icons.location_on_outlined,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _purposeController,
                        decoration: _buildInputDecoration(
                          '3. Purpose',
                          'Purpose / Task description',
                          Icons.assignment_outlined,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _docsController,
                        decoration: _buildInputDecoration(
                          '5. Documents REQUIRED',
                          'e.g. PAN, Aadhaar, Cheque',
                          Icons.folder_shared_outlined,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryBlue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: _isAdding ? null : _addTask,
                          icon: _isAdding
                              ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                              : const Icon(Icons.add_task_rounded, size: 18),
                          label: const Text('Add Task', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                        ),
                      ),
                    ],
                    const SizedBox(height: 6),
                    // Document Quick Select Chips
                    Row(
                      children: [
                        const Text(
                          'Quick Docs:',
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: ['PAN Card', 'Aadhaar Card', 'Cheque', 'Photos', 'Policy Copy'].map((chip) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 4.0),
                                  child: ActionChip(
                                    label: Text('+ $chip', style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w500)),
                                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    visualDensity: VisualDensity.compact,
                                    backgroundColor: Colors.white,
                                    side: BorderSide(color: Colors.grey.shade300, width: 0.8),
                                    onPressed: () => _appendDoc(chip),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),

          const SizedBox(height: 14),

          // Daily Tasks List
          notesAsync.when(
            data: (notes) {
              if (notes.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'No daily tasks added for $formattedDate yet. Add tasks above with Name, Location, Purpose, Time, and Docs Required.',
                    style: TextStyle(fontSize: 12.5, fontStyle: FontStyle.italic, color: Colors.grey[500]),
                  ),
                );
              }

              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: notes.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final note = notes[index];
                  final isStructured = note.isStructuredTask;
                  final hasCat = note.category != null && note.category!.trim().isNotEmpty;

                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: note.isCompleted ? const Color(0xFFF8FAFC) : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: note.isCompleted ? const Color(0xFFE2E8F0) : const Color(0xFFBFDBFE),
                        width: note.isCompleted ? 1 : 1.2,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: Checkbox(
                            value: note.isCompleted,
                            activeColor: AppColors.skyBlue,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                            onChanged: (_) async {
                              final db = ref.read(databaseServiceProvider);
                              await db.toggleDailyNoteCompleted(note.id);
                              ref.invalidate(tomorrowNotesProvider);
                            },
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (isStructured) ...[
                                // Header: Name + Time + Location
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  spacing: 8,
                                  runSpacing: 4,
                                  children: [
                                    if (note.taskName.isNotEmpty)
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.person_rounded, size: 15, color: AppColors.skyBlue),
                                          const SizedBox(width: 4),
                                          Text(
                                            note.taskName,
                                            style: TextStyle(
                                              fontSize: 13.5,
                                              fontWeight: FontWeight.bold,
                                              color: note.isCompleted ? AppColors.mutedText : AppColors.headingText,
                                              decoration: note.isCompleted ? TextDecoration.lineThrough : null,
                                            ),
                                          ),
                                        ],
                                      ),
                                    if (note.taskTime.isNotEmpty)
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFEFF6FF),
                                          borderRadius: BorderRadius.circular(6),
                                          border: Border.all(color: const Color(0xFFDBEAFE)),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(Icons.access_time_rounded, size: 12, color: Color(0xFF2563EB)),
                                            const SizedBox(width: 3),
                                            Text(
                                              note.taskTime,
                                              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF1D4ED8)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    if (note.taskLocation.isNotEmpty)
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF1F5F9),
                                          borderRadius: BorderRadius.circular(6),
                                          border: Border.all(color: const Color(0xFFE2E8F0)),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(Icons.location_on_outlined, size: 12, color: Colors.blueGrey),
                                            const SizedBox(width: 3),
                                            Text(
                                              note.taskLocation,
                                              style: const TextStyle(fontSize: 11, color: AppColors.bodyText),
                                            ),
                                          ],
                                        ),
                                      ),
                                    if (hasCat)
                                      ColorBadge(
                                        text: note.category!.toUpperCase(),
                                        style: _getCategoryBadgeStyle(note.category!),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                // Purpose
                                if (note.taskPurpose.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2.0),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(top: 2.0),
                                          child: Icon(Icons.assignment_outlined, size: 13, color: Colors.grey),
                                        ),
                                        const SizedBox(width: 5),
                                        Expanded(
                                          child: Text(
                                            note.taskPurpose,
                                            style: TextStyle(
                                              fontSize: 12.5,
                                              color: note.isCompleted ? AppColors.mutedText : AppColors.bodyText,
                                              decoration: note.isCompleted ? TextDecoration.lineThrough : null,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                // Documents Required
                                if (note.documentsRequired.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFFFBEB),
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(color: const Color(0xFFFDE68A)),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.folder_shared_outlined, size: 13, color: Color(0xFFB45309)),
                                          const SizedBox(width: 5),
                                          Flexible(
                                            child: Text(
                                              'Docs Required: ${note.documentsRequired}',
                                              style: const TextStyle(
                                                fontSize: 11.5,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF92400E),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                              ] else ...[
                                // Unstructured / Legacy Note
                                if (hasCat)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 4.0),
                                    child: ColorBadge(
                                      text: note.category!.toUpperCase(),
                                      style: _getCategoryBadgeStyle(note.category!),
                                    ),
                                  ),
                                Text(
                                  note.content,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: note.isCompleted ? AppColors.mutedText : AppColors.headingText,
                                    decoration: note.isCompleted ? TextDecoration.lineThrough : null,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        // Actions
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit_outlined, size: 18, color: Colors.blueAccent),
                              tooltip: 'Edit task',
                              onPressed: () => _showEditDialog(note),
                              constraints: const BoxConstraints(),
                              padding: const EdgeInsets.all(6),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline_rounded, size: 18, color: Colors.redAccent),
                              tooltip: 'Delete task',
                              onPressed: () => _confirmDelete(note),
                              constraints: const BoxConstraints(),
                              padding: const EdgeInsets.all(6),
                            ),
                          ],
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
