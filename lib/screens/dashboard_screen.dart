import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../providers/customer_provider.dart';
import '../providers/events_provider.dart';
import '../providers/marketing_provider.dart';
import '../providers/work_provider.dart';
import '../services/dashboard_export_service.dart';
import '../theme/app_colors.dart';
import '../widgets/brand_card.dart';
import '../widgets/color_badge.dart';
import 'customer_detail_screen.dart';
import 'customer_form_screen.dart';

final dashboardFilterCategoryProvider = StateProvider<String>((ref) => 'All');

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todaySummaryAsync = ref.watch(todaySummaryEventsProvider);
    final selectedFilter = ref.watch(dashboardFilterCategoryProvider);
    final now = DateTime.now();
    final formattedTodayDate = DateFormat('EEEE, dd MMMM yyyy').format(now);
    final allItems = todaySummaryAsync.value ?? [];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Welcome Header & Today Banner
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
                      Icons.today_rounded,
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
                          "Today's Event Summary",
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
                              formattedTodayDate,
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
                    tooltip: 'Share PDF Report',
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.badgeGreenBg,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.picture_as_pdf_rounded, color: AppColors.limeGreen, size: 20),
                    ),
                    onPressed: () => DashboardExportService.shareDashboardPdf(allItems),
                  ),
                    const SizedBox(width: 6),
                    IconButton(
                      tooltip: 'Refresh Today Data',
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
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

            // Summary Metrics Grid
            todaySummaryAsync.when(
              data: (allItems) {
                final birthdayCount = allItems.where((i) => i.type == TodayEventType.birthday).length;
                final anniversaryCount = allItems.where((i) => i.type == TodayEventType.anniversary).length;
                final paCount = allItems.where((i) => i.type == TodayEventType.personalAccident).length;
                final reminderCount = allItems.where((i) => i.type == TodayEventType.reminder).length;
                final taskCount = allItems.where((i) => i.type == TodayEventType.workTask).length;
                final marketingCount = allItems.where((i) => i.type == TodayEventType.marketing).length;

                // Filtered List
                List<TodayEventSummaryItem> filteredItems = allItems;
                if (selectedFilter == 'Birthdays') {
                  filteredItems = allItems.where((i) => i.type == TodayEventType.birthday).toList();
                } else if (selectedFilter == 'Anniversaries') {
                  filteredItems = allItems.where((i) => i.type == TodayEventType.anniversary).toList();
                } else if (selectedFilter == 'Accidents') {
                  filteredItems = allItems.where((i) => i.type == TodayEventType.personalAccident).toList();
                } else if (selectedFilter == 'Reminders') {
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
                          crossAxisCount: isWide ? 6 : 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: isWide ? 1.4 : 1.7,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            _buildStatTile(
                              title: 'Total Today',
                              count: allItems.length,
                              icon: Icons.dashboard_customize_rounded,
                              bg: AppColors.badgeBlueBg,
                              fg: AppColors.skyBlue,
                              isSelected: selectedFilter == 'All',
                              onTap: () => ref.read(dashboardFilterCategoryProvider.notifier).state = 'All',
                            ),
                            _buildStatTile(
                              title: 'Birthdays',
                              count: birthdayCount,
                              icon: Icons.cake_rounded,
                              bg: AppColors.badgeRoseBg,
                              fg: AppColors.badgeRoseText,
                              isSelected: selectedFilter == 'Birthdays',
                              onTap: () => ref.read(dashboardFilterCategoryProvider.notifier).state = 'Birthdays',
                            ),
                            _buildStatTile(
                              title: 'Anniversaries',
                              count: anniversaryCount,
                              icon: Icons.favorite_rounded,
                              bg: AppColors.badgeAmberBg,
                              fg: AppColors.badgeAmberText,
                              isSelected: selectedFilter == 'Anniversaries',
                              onTap: () => ref.read(dashboardFilterCategoryProvider.notifier).state = 'Anniversaries',
                            ),
                            _buildStatTile(
                              title: 'Personal Accident',
                              count: paCount,
                              icon: Icons.healing_rounded,
                              bg: AppColors.badgeAmberBg,
                              fg: AppColors.badgeAmberText,
                              isSelected: selectedFilter == 'Accidents',
                              onTap: () => ref.read(dashboardFilterCategoryProvider.notifier).state = 'Accidents',
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
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: 20),

                    // Filter Chips Bar
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildFilterChip(ref, 'All', 'All (${allItems.length})', selectedFilter),
                          const SizedBox(width: 8),
                          _buildFilterChip(ref, 'Birthdays', 'Birthdays ($birthdayCount)', selectedFilter),
                          const SizedBox(width: 8),
                          _buildFilterChip(ref, 'Anniversaries', 'Anniversaries ($anniversaryCount)', selectedFilter),
                          const SizedBox(width: 8),
                          _buildFilterChip(ref, 'Accidents', 'Accidents ($paCount)', selectedFilter),
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
                                  ? 'No events or follow-ups scheduled for today!'
                                  : 'No $selectedFilter found for today.',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.headingText,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Enjoy your productive day or add new tasks and customer reminders.',
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
                          return _buildEventItemCard(context, item);
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
                child: Text('Error loading today summary: $err', style: const TextStyle(color: AppColors.roseAccent)),
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

  Widget _buildEventItemCard(BuildContext context, TodayEventSummaryItem item) {
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

          if (item.customer != null) ...[
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
}
