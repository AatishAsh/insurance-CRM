import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../models/work_task.dart';
import '../models/company.dart';
import '../providers/work_provider.dart';
import '../providers/events_provider.dart';
import '../services/database_service.dart';
import '../theme/app_colors.dart';
import '../widgets/key_cycle_dropdown.dart';

class WorkManagementScreen extends ConsumerStatefulWidget {
  const WorkManagementScreen({super.key});

  @override
  ConsumerState<WorkManagementScreen> createState() => _WorkManagementScreenState();
}

class _WorkManagementScreenState extends ConsumerState<WorkManagementScreen> {
  final Set<int> _selectedTaskIds = {};

  @override
  Widget build(BuildContext context) {
    final selectedTabIndex = ref.watch(selectedWorkTabIndexProvider);
    final tabNames = ref.watch(workTabNamesProvider);
    final companiesAsync = ref.watch(companiesForSelectedTabProvider);
    final selectedCompanyId = ref.watch(selectedCompanyIdProvider);

    final List<Color> tabHeaderColors = [
      const Color(0xFF1E88E5), // Header 1: Vivid Ocean Blue
      const Color(0xFF059669), // Header 2: Emerald Green
      const Color(0xFF7C3AED), // Header 3: Royal Violet
    ];
    final List<Color> tabHeaderBgColors = [
      const Color(0xFFE3F2FD), // Header 1 Light Background
      const Color(0xFFECFDF5), // Header 2 Light Background
      const Color(0xFFF5F3FF), // Header 3 Light Background
    ];
    final activeTabColor = tabHeaderColors[selectedTabIndex.clamp(0, tabHeaderColors.length - 1)];
    final activeTabBgColor = tabHeaderBgColors[selectedTabIndex.clamp(0, tabHeaderBgColors.length - 1)];

    final List<Color> avatarColors = [
      AppColors.skyBlue,
      AppColors.limeGreen,
      AppColors.violetAccent,
      AppColors.cyanAccent,
      AppColors.amberAccent,
    ];

    // Compute effective company ID synchronously
    final activeCompanies = companiesAsync.value ?? [];
    int? effectiveCompanyId = selectedCompanyId;
    if (activeCompanies.isNotEmpty) {
      if (effectiveCompanyId == null || !activeCompanies.any((c) => c.id == effectiveCompanyId)) {
        effectiveCompanyId = activeCompanies.first.id;
      }
    } else {
      effectiveCompanyId = null;
    }

    final currentTabTitle = tabNames.length > selectedTabIndex ? tabNames[selectedTabIndex] : 'Tab ${selectedTabIndex + 1}';
    final bool isWide = MediaQuery.of(context).size.width >= 700;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: isWide
          ? Row(
              children: [
                // Sidebar for Company Selection & Tabs (Wide / Tablet mode)
                Container(
                  width: 250,
                  decoration: const BoxDecoration(
                    color: AppColors.cardSurface,
                    border: Border(right: BorderSide(color: AppColors.cardBorder, width: 1)),
                    boxShadow: [AppColors.softShadow],
                  ),
                  child: Column(
                    children: [
                      // Header with current tab name and rename option
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14, 14, 14, 8),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: activeTabBgColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(Icons.business_rounded, color: activeTabColor, size: 18),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                currentTabTitle.toUpperCase(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: activeTabColor,
                                  letterSpacing: 0.8,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.edit_outlined, size: 16, color: activeTabColor),
                              tooltip: 'Rename Tab',
                              onPressed: () => _showRenameTabDialog(selectedTabIndex, currentTabTitle),
                              constraints: const BoxConstraints(),
                              padding: EdgeInsets.zero,
                            ),
                          ],
                        ),
                      ),
                      // 3 Company Tabs Selector
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: List.generate(3, (index) {
                            final isTabSelected = selectedTabIndex == index;
                            final tabTitle = tabNames.length > index ? tabNames[index] : 'Tab ${index + 1}';
                            final thisTabColor = tabHeaderColors[index.clamp(0, tabHeaderColors.length - 1)];

                            return Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  ref.read(selectedWorkTabIndexProvider.notifier).state = index;
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 150),
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  decoration: BoxDecoration(
                                    color: isTabSelected ? thisTabColor : Colors.transparent,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: isTabSelected
                                        ? [BoxShadow(color: thisTabColor.withOpacity(0.35), blurRadius: 4, offset: const Offset(0, 2))]
                                        : [],
                                  ),
                                  child: Center(
                                    child: Text(
                                      tabTitle,
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: isTabSelected ? FontWeight.bold : FontWeight.w600,
                                        color: isTabSelected ? Colors.white : AppColors.mutedText,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      const Divider(height: 1),
                      // Scrollable Companies List + Add Company button at the end
                      Expanded(
                        child: companiesAsync.when(
                          data: (companies) {
                            return ListView.builder(
                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                              itemCount: companies.length + 1,
                              itemBuilder: (context, index) {
                                // Render "+ Add Company" option at the end of the list
                                if (index == companies.length) {
                                  final count = companies.length;
                                  final isMaxReached = count >= 15;

                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
                                    child: InkWell(
                                      onTap: () {
                                        if (isMaxReached) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text('Maximum limit of 15 companies reached for this tab.'),
                                              backgroundColor: AppColors.roseAccent,
                                              duration: Duration(seconds: 2),
                                            ),
                                          );
                                        } else {
                                          _showAddCompanyDialog(selectedTabIndex);
                                        }
                                      },
                                      borderRadius: BorderRadius.circular(12),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                                        decoration: BoxDecoration(
                                          color: isMaxReached ? Colors.grey.withOpacity(0.05) : AppColors.skyBlue.withOpacity(0.08),
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(
                                            color: isMaxReached ? Colors.grey.withOpacity(0.3) : AppColors.skyBlue.withOpacity(0.4),
                                            width: 1,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              isMaxReached ? Icons.block_rounded : Icons.add_circle_outline,
                                              size: 16,
                                              color: isMaxReached ? Colors.grey : AppColors.skyBlue,
                                            ),
                                            const SizedBox(width: 6),
                                            Flexible(
                                              child: Text(
                                                isMaxReached ? 'Max Limit (15/15)' : 'Add Company ($count/15)',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: isMaxReached ? Colors.grey : AppColors.skyBlue,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }

                                // Render Company Item
                                final company = companies[index];
                                final isSelected = selectedCompanyId == company.id;
                                final avatarColor = avatarColors[company.name.hashCode.abs() % avatarColors.length];

                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 3.0),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 150),
                                    decoration: BoxDecoration(
                                      color: isSelected ? AppColors.badgeBlueBg : Colors.transparent,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: isSelected ? AppColors.skyBlue.withOpacity(0.3) : Colors.transparent,
                                      ),
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: ListTile(
                                        dense: true,
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                        leading: CircleAvatar(
                                          radius: 16,
                                          backgroundColor: isSelected ? avatarColor : avatarColor.withOpacity(0.15),
                                          child: Text(
                                            company.name.isNotEmpty ? company.name[0].toUpperCase() : 'C',
                                            style: TextStyle(
                                              color: isSelected ? Colors.white : avatarColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                          company.name,
                                          style: TextStyle(
                                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                                            fontSize: 13,
                                            color: isSelected ? AppColors.badgeBlueText : AppColors.headingText,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        subtitle: company.referenceNumber != null && company.referenceNumber!.isNotEmpty
                                            ? Text(
                                                company.referenceNumber!,
                                                style: const TextStyle(fontSize: 10, color: AppColors.mutedText),
                                                overflow: TextOverflow.ellipsis,
                                              )
                                            : null,
                                        trailing: IconButton(
                                          icon: const Icon(Icons.edit_outlined, size: 14, color: AppColors.mutedText),
                                          onPressed: () => _showEditCompanyDialog(company),
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                        ),
                                        onTap: () {
                                          ref.read(selectedCompanyIdProvider.notifier).state = company.id;
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          loading: () => const Center(child: CircularProgressIndicator(color: AppColors.skyBlue)),
                          error: (err, stack) => Center(child: Text('Error: $err', style: const TextStyle(color: AppColors.roseAccent))),
                        ),
                      ),
                    ],
                  ),
                ),
                // Main Work Tracking Area
                Expanded(
                  child: effectiveCompanyId == null
                      ? const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.business_outlined, size: 64, color: AppColors.mutedText),
                              SizedBox(height: 16),
                              Text('Select a company from the left panel to manage daily tasks', style: TextStyle(color: AppColors.bodyText, fontWeight: FontWeight.w500)),
                            ],
                          ),
                        )
                      : _buildWorkTracker(effectiveCompanyId),
                ),
              ],
            )
          : Column(
              children: [
                // Top Compact Header & Company Selector for Mobile
                Container(
                  margin: const EdgeInsets.all(12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.cardSurface,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [AppColors.softShadow],
                    border: Border.all(color: AppColors.cardBorder),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 3 Work Tabs Bar on Mobile
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: List.generate(3, (index) {
                                  final isTabSelected = selectedTabIndex == index;
                                  final tabTitle = tabNames.length > index ? tabNames[index] : 'Tab ${index + 1}';
                                  final thisTabColor = tabHeaderColors[index.clamp(0, tabHeaderColors.length - 1)];

                                  return Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        ref.read(selectedWorkTabIndexProvider.notifier).state = index;
                                      },
                                      child: AnimatedContainer(
                                        duration: const Duration(milliseconds: 150),
                                        padding: const EdgeInsets.symmetric(vertical: 8),
                                        decoration: BoxDecoration(
                                          color: isTabSelected ? thisTabColor : Colors.transparent,
                                          borderRadius: BorderRadius.circular(8),
                                          boxShadow: isTabSelected
                                              ? [BoxShadow(color: thisTabColor.withOpacity(0.35), blurRadius: 4, offset: const Offset(0, 2))]
                                              : [],
                                        ),
                                        child: Center(
                                          child: Text(
                                            tabTitle,
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: isTabSelected ? FontWeight.bold : FontWeight.w600,
                                              color: isTabSelected ? Colors.white : AppColors.mutedText,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          IconButton(
                            icon: const Icon(Icons.edit_outlined, size: 18, color: AppColors.skyBlue),
                            tooltip: 'Rename Tab',
                            onPressed: () => _showRenameTabDialog(selectedTabIndex, currentTabTitle),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // Dropdown Company Selector for Mobile
                      Row(
                        children: [
                          const Icon(Icons.business_rounded, color: AppColors.cyanAccent, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.badgeBlueBg,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: AppColors.skyBlue.withOpacity(0.3)),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: KeyCycleDropdownButton<int>(
                                  value: effectiveCompanyId,
                                  hint: const Text('Select Company', style: TextStyle(fontSize: 13, color: AppColors.mutedText)),
                                  isExpanded: true,
                                  icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.skyBlue),
                                  items: activeCompanies.map((c) {
                                    return DropdownMenuItem<int>(
                                      value: c.id,
                                      child: Text(
                                        c.name,
                                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.headingText),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (newId) {
                                    if (newId != null) {
                                      ref.read(selectedCompanyIdProvider.notifier).state = newId;
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                          if (effectiveCompanyId != null) ...[
                            const SizedBox(width: 4),
                            IconButton(
                              icon: const Icon(Icons.edit_outlined, size: 18, color: AppColors.mutedText),
                              tooltip: 'Edit Company',
                              onPressed: () {
                                final company = activeCompanies.where((c) => c.id == effectiveCompanyId).firstOrNull;
                                if (company != null) _showEditCompanyDialog(company);
                              },
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ],
                          const SizedBox(width: 4),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline, size: 22, color: AppColors.skyBlue),
                            tooltip: 'Add Company',
                            onPressed: () {
                              if (activeCompanies.length >= 15) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Maximum limit of 15 companies reached for this tab.'),
                                    backgroundColor: AppColors.roseAccent,
                                  ),
                                );
                              } else {
                                _showAddCompanyDialog(selectedTabIndex);
                              }
                            },
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Main Work Area on Mobile
                Expanded(
                  child: effectiveCompanyId == null
                      ? const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.business_outlined, size: 64, color: AppColors.mutedText),
                              SizedBox(height: 16),
                              Text('Select a company from the top selector to manage daily tasks', style: TextStyle(color: AppColors.bodyText, fontWeight: FontWeight.w500)),
                            ],
                          ),
                        )
                      : _buildWorkTracker(effectiveCompanyId),
                ),
              ],
            ),
      floatingActionButton: effectiveCompanyId != null
          ? FloatingActionButton.extended(
              onPressed: () => _showAddTaskDialog(effectiveCompanyId!),
              label: const Text('Add Task', style: TextStyle(fontWeight: FontWeight.bold)),
              icon: const Icon(Icons.add),
              backgroundColor: AppColors.skyBlue,
              foregroundColor: Colors.white,
            )
          : null,
    );
  }

  void _showRenameTabDialog(int tabIndex, String currentName) {
    final controller = TextEditingController(text: currentName);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Rename Tab ${tabIndex + 1}'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(
            labelText: 'Tab Name',
            hintText: 'e.g. Life Insurance',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (controller.text.trim().isNotEmpty) {
                await ref.read(workTabNamesProvider.notifier).renameTab(tabIndex, controller.text.trim());
                if (context.mounted) Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showAddCompanyDialog(int tabIndex) {
    final nameController = TextEditingController();
    final refController = TextEditingController();
    final tabNames = ref.read(workTabNamesProvider);
    final tabName = tabNames.length > tabIndex ? tabNames[tabIndex] : 'Tab ${tabIndex + 1}';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Company to $tabName'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'Company Name *',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: refController,
              decoration: const InputDecoration(
                labelText: 'Reference Number (Optional)',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final name = nameController.text.trim();
              if (name.isNotEmpty) {
                try {
                  final db = ref.read(databaseServiceProvider);
                  await db.addCompanyToTab(name, tabIndex, referenceNumber: refController.text.trim());
                  ref.invalidate(companiesForSelectedTabProvider);
                  ref.invalidate(companiesProvider);
                  if (context.mounted) Navigator.pop(context);
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.toString().replaceAll('Exception: ', '')), backgroundColor: Colors.red),
                    );
                  }
                }
              }
            },
            child: const Text('Add Company'),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkTracker(int companyId) {
    final tasksAsync = ref.watch(taskListProvider);
    final selectedDate = ref.watch(selectedDateProvider);
    final showAllHistory = ref.watch(showAllWorkHistoryProvider);

    return Column(
      children: [
        // Header & Filter Control Bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            runSpacing: 10,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Work History & Log',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 12),
                  // Filter Mode Selector (All History vs Single Date)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(3),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () => ref.read(showAllWorkHistoryProvider.notifier).state = true,
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: showAllHistory ? AppColors.primaryBlue : Colors.transparent,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              'All History',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: showAllHistory ? Colors.white : Colors.black87,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => ref.read(showAllWorkHistoryProvider.notifier).state = false,
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: !showAllHistory ? AppColors.primaryBlue : Colors.transparent,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              'Filter Date',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: !showAllHistory ? Colors.white : Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Date Navigation (Active when Filter Date is selected)
              if (!showAllHistory)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left),
                      onPressed: () {
                        ref.read(selectedDateProvider.notifier).state =
                            selectedDate.subtract(const Duration(days: 1));
                      },
                    ),
                    TextButton.icon(
                      onPressed: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null) {
                          ref.read(selectedDateProvider.notifier).state = picked;
                        }
                      },
                      icon: const Icon(Icons.calendar_today, size: 16),
                      label: Text(
                        DateFormat('dd MMM yyyy').format(selectedDate),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right),
                      onPressed: () {
                        ref.read(selectedDateProvider.notifier).state =
                            selectedDate.add(const Duration(days: 1));
                      },
                    ),
                  ],
                ),
            ],
          ),
        ),
        const Divider(height: 1),
        // Tasks list
        Expanded(
          child: tasksAsync.when(
            data: (tasks) {
              if (tasks.isEmpty) {
                if (_selectedTaskIds.isNotEmpty) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted) setState(() => _selectedTaskIds.clear());
                  });
                }
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.assignment_turned_in_outlined, size: 48, color: Colors.grey[400]),
                      const SizedBox(height: 12),
                      Text(
                        showAllHistory
                            ? 'No work tasks registered for this company.'
                            : 'No tasks registered for this company on ${DateFormat('dd MMM yyyy').format(selectedDate)}.',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () => _showAddTaskDialog(companyId),
                        icon: const Icon(Icons.add, size: 18),
                        label: const Text('Add Work Task Entry'),
                      ),
                    ],
                  ),
                );
              }

              final bool allSelected = tasks.isNotEmpty && tasks.every((t) => _selectedTaskIds.contains(t.id));
              final bool noneSelected = _selectedTaskIds.isEmpty;
              final bool? tristateVal = allSelected ? true : (noneSelected ? false : null);

              return Column(
                children: [
                  // Gmail-style Bulk Action / Selection Toolbar
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: _selectedTaskIds.isNotEmpty ? Colors.blue.withOpacity(0.08) : Colors.grey.withOpacity(0.04),
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1),
                      ),
                    ),
                    child: Row(
                      children: [
                        Checkbox(
                          tristate: true,
                          value: tristateVal,
                          activeColor: AppColors.primaryBlue,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                          onChanged: (bool? val) {
                            setState(() {
                              if (val == true) {
                                _selectedTaskIds.clear();
                                _selectedTaskIds.addAll(tasks.map((t) => t.id));
                              } else {
                                _selectedTaskIds.clear();
                              }
                            });
                          },
                        ),
                        PopupMenuButton<String>(
                          tooltip: 'Select tasks by status',
                          icon: const Icon(Icons.arrow_drop_down, size: 22, color: Colors.black87),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onSelected: (String choice) {
                            setState(() {
                              _selectedTaskIds.clear();
                              switch (choice) {
                                case 'All':
                                  _selectedTaskIds.addAll(tasks.map((t) => t.id));
                                  break;
                                case 'None':
                                  _selectedTaskIds.clear();
                                  break;
                                case 'Pending':
                                  _selectedTaskIds.addAll(tasks.where((t) => t.status == 'Pending').map((t) => t.id));
                                  break;
                                case 'Completed':
                                  _selectedTaskIds.addAll(tasks.where((t) => t.status == 'Completed').map((t) => t.id));
                                  break;
                                case 'Under Process':
                                  _selectedTaskIds.addAll(tasks.where((t) => t.status == 'Under Process').map((t) => t.id));
                                  break;
                                case 'No Response':
                                  _selectedTaskIds.addAll(tasks.where((t) => t.status == 'No Response').map((t) => t.id));
                                  break;
                              }
                            });
                          },
                          itemBuilder: (context) => [
                            const PopupMenuItem(value: 'All', child: Text('All')),
                            const PopupMenuItem(value: 'None', child: Text('None')),
                            const PopupMenuDivider(),
                            const PopupMenuItem(value: 'Pending', child: Text('Pending (Orange)')),
                            const PopupMenuItem(value: 'Completed', child: Text('Completed (Green)')),
                            const PopupMenuItem(value: 'Under Process', child: Text('Under Process (Blue)')),
                            const PopupMenuItem(value: 'No Response', child: Text('No Response (Red)')),
                          ],
                        ),
                        const SizedBox(width: 8),
                        if (_selectedTaskIds.isNotEmpty) ...[
                          Text(
                            '${_selectedTaskIds.length} of ${tasks.length} selected',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.primaryBlue),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _selectedTaskIds.clear();
                              });
                            },
                            child: const Text('Clear', style: TextStyle(fontSize: 12)),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton.icon(
                            onPressed: () => _deleteSelectedTasks(tasks),
                            icon: const Icon(Icons.delete, size: 16, color: Colors.white),
                            label: Text('Delete (${_selectedTaskIds.length})'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              visualDensity: VisualDensity.compact,
                            ),
                          ),
                        ] else ...[
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  const Text('Select: ', style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w600)),
                                  _buildQuickSelectChip('All', () {
                                    setState(() {
                                      _selectedTaskIds.clear();
                                      _selectedTaskIds.addAll(tasks.map((t) => t.id));
                                    });
                                  }),
                                  _buildQuickSelectChip('Pending', () {
                                    setState(() {
                                      _selectedTaskIds.clear();
                                      _selectedTaskIds.addAll(tasks.where((t) => t.status == 'Pending').map((t) => t.id));
                                    });
                                  }, color: Colors.orange),
                                  _buildQuickSelectChip('Completed', () {
                                    setState(() {
                                      _selectedTaskIds.clear();
                                      _selectedTaskIds.addAll(tasks.where((t) => t.status == 'Completed').map((t) => t.id));
                                    });
                                  }, color: Colors.green),
                                  _buildQuickSelectChip('Under Process', () {
                                    setState(() {
                                      _selectedTaskIds.clear();
                                      _selectedTaskIds.addAll(tasks.where((t) => t.status == 'Under Process').map((t) => t.id));
                                    });
                                  }, color: Colors.blue),
                                  _buildQuickSelectChip('No Response', () {
                                    setState(() {
                                      _selectedTaskIds.clear();
                                      _selectedTaskIds.addAll(tasks.where((t) => t.status == 'No Response').map((t) => t.id));
                                    });
                                  }, color: Colors.red),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];
                        return _buildTaskCard(task);
                      },
                    ),
                  ),
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Error loading tasks: $err')),
          ),
        ),
      ],
    );
  }

  Widget _buildTaskCard(WorkTask task) {
    Color statusColor = Colors.grey;
    IconData statusIcon = Icons.help_outline;

    switch (task.status) {
      case 'Completed':
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        break;
      case 'Pending':
        statusColor = Colors.orange;
        statusIcon = Icons.hourglass_empty;
        break;
      case 'Under Process':
        statusColor = Colors.blue;
        statusIcon = Icons.pending;
        break;
      case 'No Response':
        statusColor = Colors.red;
        statusIcon = Icons.block;
        break;
    }

    Color priorityColor = Colors.grey;
    if (task.priority == 'Urgent') priorityColor = Colors.red;
    if (task.priority == 'Important') priorityColor = Colors.orange;

    final createdDate = task.createdAt ?? task.assignedDate ?? task.workDate;
    final createdStr = DateFormat('dd MMM yyyy').format(createdDate);

    final isSelected = _selectedTaskIds.contains(task.id);

    final client = task.clientName;
    final loc = task.taskLocation;
    final timeStr = task.taskTime;
    final docs = task.documentsRequired;
    final extraRemarks = task.extraRemarks;

    return Card(
      elevation: isSelected ? 2 : 0.5,
      color: isSelected ? Colors.blue.withOpacity(0.04) : Colors.white,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: isSelected ? AppColors.primaryBlue : Colors.grey[200]!,
          width: isSelected ? 1.5 : 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: ListTile(
          onTap: () => _showAddTaskDialog(task.companyId ?? ref.read(selectedCompanyIdProvider) ?? 0, task),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Checkbox(
                value: isSelected,
                activeColor: AppColors.primaryBlue,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
                onChanged: (bool? checked) {
                  setState(() {
                    if (checked == true) {
                      _selectedTaskIds.add(task.id);
                    } else {
                      _selectedTaskIds.remove(task.id);
                    }
                  });
                },
              ),
              const SizedBox(width: 4),
              Icon(statusIcon, color: statusColor, size: 26),
            ],
          ),
          title: Text(
            (client.isNotEmpty && !task.description.toLowerCase().contains(client.toLowerCase()))
                ? '$client — ${task.description}'
                : task.description,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              decoration: task.status == 'Completed' ? TextDecoration.lineThrough : null,
              color: task.status == 'Completed' ? Colors.grey : Colors.black87,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: [
                    _buildBadge('Created: $createdStr', Colors.teal),
                    if (timeStr != null && timeStr.isNotEmpty)
                      _buildBadge('Time: $timeStr', Colors.blue, icon: Icons.access_time_rounded),
                    if (client.isNotEmpty)
                      _buildBadge('Client: $client', Colors.indigo, icon: Icons.person_outline),
                    if (loc != null && loc.isNotEmpty)
                      _buildBadge('Location: $loc', Colors.teal, icon: Icons.location_on_outlined),
                    if (docs != null && docs.isNotEmpty)
                      _buildBadge('Docs: $docs', Colors.deepOrange, icon: Icons.folder_special_outlined),
                    _buildBadge('Priority: ${task.priority}', priorityColor),
                    _buildBadge('Method: ${task.communicationMethod ?? "N/A"}', Colors.blueGrey),
                    if (task.carryForwardRequired)
                      _buildBadge('Carry Forward', Colors.purple),
                  ],
                ),
                if (extraRemarks != null && extraRemarks.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(
                    'Remarks: $extraRemarks',
                    style: const TextStyle(fontSize: 12, color: Colors.grey, fontStyle: FontStyle.italic),
                  ),
                ],
              ],
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Quick Status Toggle Dropdown
              KeyCycleDropdownButton<String>(
                value: task.status,
                underline: const SizedBox(),
                icon: const Icon(Icons.arrow_drop_down, color: Colors.blueAccent),
                items: ['Pending', 'Completed', 'Under Process', 'No Response'].map((String s) {
                  return DropdownMenuItem<String>(
                    value: s,
                    child: Text(s, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                  );
                }).toList(),
                onChanged: (newStatus) async {
                  if (newStatus != null) {
                    final db = ref.read(databaseServiceProvider);
                    task.status = newStatus;
                    await db.saveTask(task);
                    ref.invalidate(taskListProvider);
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
                onPressed: () => _deleteTask(task),
                tooltip: 'Delete Log',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBadge(String label, Color color, {IconData? icon}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.3), width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 11, color: color),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  void _showEditCompanyDialog(Company company) {
    final oldName = company.name;
    final controller = TextEditingController(text: company.name);
    final refController = TextEditingController(text: company.referenceNumber);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Company Configuration'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: controller, decoration: const InputDecoration(labelText: 'Company Name')),
            TextField(controller: refController, decoration: const InputDecoration(labelText: 'Reference Number')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              if (controller.text.trim().isNotEmpty) {
                final db = ref.read(databaseServiceProvider);
                final newName = controller.text.trim();
                company.referenceNumber = refController.text.trim();
                await db.renameCompany(company, oldName, newName);
                ref.invalidate(companiesForSelectedTabProvider);
                ref.invalidate(companiesProvider);
                if (context.mounted) Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showAddTaskDialog(int companyId, [WorkTask? existingTask]) {
    final nameController = TextEditingController(text: existingTask?.assignedTo ?? '');
    final locationController = TextEditingController(text: existingTask?.taskLocation ?? '');
    final purposeController = TextEditingController(text: existingTask?.purpose ?? existingTask?.description ?? '');
    final timeController = TextEditingController(text: existingTask?.taskTime ?? '');
    final docsController = TextEditingController(text: existingTask?.documentsRequired ?? '');
    final remarkController = TextEditingController(text: existingTask?.extraRemarks ?? '');
    final reasonController = TextEditingController(text: existingTask?.carryForwardReason ?? '');
    
    DateTime createdDate = existingTask?.createdAt ?? existingTask?.assignedDate ?? existingTask?.workDate ?? ref.read(selectedDateProvider);
    String status = existingTask?.status ?? 'Pending';
    String priority = existingTask?.priority ?? 'Normal';
    String method = existingTask?.communicationMethod ?? 'In Person';
    bool carryForward = existingTask?.carryForwardRequired ?? true;
    String? validationError;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.badgeBlueBg,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.assignment_turned_in_rounded, color: AppColors.skyBlue, size: 20),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                existingTask == null ? 'New Work Task Entry' : 'Edit Work Task Entry',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
        content: SizedBox(
          width: 550,
          child: StatefulBuilder(
            builder: (context, setDialogState) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (validationError != null) ...[
                      Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.red.shade200),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.error_outline, size: 16, color: Colors.red),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                validationError!,
                                style: const TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    // Work Date / Scheduled Date Picker
                    InkWell(
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: createdDate,
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null) {
                          setDialogState(() => createdDate = picked);
                        }
                      },
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Work Date / Scheduled Date',
                          border: OutlineInputBorder(),
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                          suffixIcon: Icon(Icons.calendar_today, size: 18, color: Colors.blueAccent),
                        ),
                        child: Text(
                          DateFormat('EEEE, dd MMM yyyy').format(createdDate),
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.primaryBlue),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // 1. Name
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: '1. Client / Contact Name *',
                        hintText: 'e.g. Rajesh Sharma / ABC Corp',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person_outline, size: 20),
                        isDense: true,
                      ),
                    ),
                    const SizedBox(height: 14),

                    // 2. Location
                    TextField(
                      controller: locationController,
                      decoration: const InputDecoration(
                        labelText: '2. Meeting / Work Location',
                        hintText: 'e.g. Connaught Place, Branch Office, Client Home',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.location_on_outlined, size: 20),
                        isDense: true,
                      ),
                    ),
                    const SizedBox(height: 14),

                    // 3. Purpose
                    TextField(
                      controller: purposeController,
                      minLines: 2,
                      maxLines: 4,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                        labelText: '3. Purpose of Work / Task *',
                        hintText: 'e.g. Policy renewal discussion, KYC collection, proposal submission',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.assignment_outlined, size: 20),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // 4. Time
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: timeController,
                            decoration: const InputDecoration(
                              labelText: '4. Scheduled Time',
                              hintText: 'e.g. 10:30 AM / 02:00 PM',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.access_time_rounded, size: 20),
                              isDense: true,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        OutlinedButton.icon(
                          onPressed: () async {
                            final picked = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (picked != null) {
                              setDialogState(() {
                                timeController.text = picked.format(context);
                              });
                            }
                          },
                          icon: const Icon(Icons.schedule, size: 18),
                          label: const Text('Pick Time'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // 5. Documents REQUIRED
                    TextField(
                      controller: docsController,
                      minLines: 2,
                      maxLines: 4,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                        labelText: '5. Documents REQUIRED',
                        hintText: 'e.g. Aadhaar Card, PAN, 2 Photos, Cancelled Cheque, Renewal Notice',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.folder_special_outlined, size: 20),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Status Dropdown
                    KeyCycleDropdownFormField<String>(
                      value: status,
                      decoration: const InputDecoration(labelText: 'Status', border: OutlineInputBorder(), isDense: true),
                      items: ['Pending', 'Completed', 'Under Process', 'No Response']
                          .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                          .toList(),
                      onChanged: (val) {
                        if (val != null) setDialogState(() => status = val);
                      },
                    ),
                    const SizedBox(height: 14),

                    // Priority Dropdown
                    KeyCycleDropdownFormField<String>(
                      value: priority,
                      decoration: const InputDecoration(labelText: 'Priority Level', border: OutlineInputBorder(), isDense: true),
                      items: ['Normal', 'Important', 'Urgent']
                          .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                          .toList(),
                      onChanged: (val) {
                        if (val != null) setDialogState(() => priority = val);
                      },
                    ),
                    const SizedBox(height: 14),

                    // Communication Channel
                    KeyCycleDropdownFormField<String>(
                      value: method,
                      decoration: const InputDecoration(labelText: 'Communication Channel', border: OutlineInputBorder(), isDense: true),
                      items: ['In Person', 'WhatsApp', 'Email', 'Call']
                          .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                          .toList(),
                      onChanged: (val) {
                        if (val != null) setDialogState(() => method = val);
                      },
                    ),
                    const SizedBox(height: 14),

                    // Additional Remarks
                    TextField(
                      controller: remarkController,
                      minLines: 1,
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                        labelText: 'Additional Remarks (Optional)',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.notes_outlined, size: 20),
                        isDense: true,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Carry forward
                    CheckboxListTile(
                      title: const Text('Carry Forward if incomplete?', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                      subtitle: const Text('Clones task to next day if not completed', style: TextStyle(fontSize: 11)),
                      value: carryForward,
                      onChanged: (val) {
                        if (val != null) setDialogState(() => carryForward = val);
                      },
                      contentPadding: EdgeInsets.zero,
                    ),
                    if (carryForward) ...[
                      const SizedBox(height: 8),
                      TextField(
                        controller: reasonController,
                        minLines: 1,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: 'Reason for Carry Forward',
                          border: OutlineInputBorder(),
                          hintText: 'e.g. Awaiting client documents',
                          isDense: true,
                        ),
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton.icon(
            onPressed: () async {
              final clientName = nameController.text.trim();
              final purpose = purposeController.text.trim();

              if (purpose.isEmpty && clientName.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please enter Purpose of Work or Client Name.'),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }

              final location = locationController.text.trim();
              final timeStr = timeController.text.trim();
              final docs = docsController.text.trim();
              final extraNotes = remarkController.text.trim();

              final combinedRemarks = formatWorkRemarks(
                time: timeStr,
                location: location,
                documentsRequired: docs,
                generalRemarks: extraNotes,
              );

              final db = ref.read(databaseServiceProvider);
              final task = existingTask ?? WorkTask();
              task
                ..uuid = (existingTask != null && existingTask.uuid.isNotEmpty) ? existingTask.uuid : ''
                ..companyId = companyId
                ..description = purpose.isNotEmpty ? purpose : 'Work with $clientName'
                ..assignedTo = clientName.isNotEmpty ? clientName : null
                ..workDate = createdDate
                ..createdAt = createdDate
                ..assignedDate = createdDate
                ..priority = priority
                ..communicationMethod = method
                ..status = status
                ..carryForwardRequired = carryForward
                ..carryForwardReason = carryForward && reasonController.text.trim().isNotEmpty
                    ? reasonController.text.trim()
                    : null
                ..remarks = combinedRemarks.isNotEmpty ? combinedRemarks : null
                ..isDeleted = false
                ..updatedAt = DateTime.now();

              try {
                await db.saveTask(task);
                ref.invalidate(taskListProvider);
                ref.invalidate(todayTasksProvider);
                ref.invalidate(todaySummaryEventsProvider);
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Work Task saved successfully!'),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to save task: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
            icon: const Icon(Icons.check, size: 18),
            label: const Text('Save Task'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickSelectChip(String label, VoidCallback onTap, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.only(right: 6.0),
      child: ActionChip(
        label: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: color ?? Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
        backgroundColor: (color ?? Colors.grey).withOpacity(0.1),
        side: BorderSide(color: (color ?? Colors.grey).withOpacity(0.3), width: 0.8),
        onPressed: onTap,
      ),
    );
  }

  void _deleteSelectedTasks(List<WorkTask> allTasks) async {
    if (_selectedTaskIds.isEmpty) return;
    final count = _selectedTaskIds.length;
    final check = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete $count Selected Task${count > 1 ? "s" : ""}?'),
        content: Text(
          'Are you sure you want to permanently delete $count selected work task log${count > 1 ? "s" : ""}? Any carry-forward copies will also be removed.',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete All Selected', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );

    if (check == true) {
      final db = ref.read(databaseServiceProvider);
      await db.deleteMultipleTasks(_selectedTaskIds.toList());
      setState(() {
        _selectedTaskIds.clear();
      });
      ref.invalidate(taskListProvider);
      ref.invalidate(todayTasksProvider);
      ref.invalidate(todaySummaryEventsProvider);
    }
  }

  void _deleteTask(WorkTask task) async {
    final check = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Task?'),
        content: const Text('Are you sure you want to delete this daily work task log?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (check == true) {
      final db = ref.read(databaseServiceProvider);
      await db.deleteTask(task.id);
      setState(() {
        _selectedTaskIds.remove(task.id);
      });
      ref.invalidate(taskListProvider);
      ref.invalidate(todayTasksProvider);
      ref.invalidate(todaySummaryEventsProvider);
    }
  }
}
