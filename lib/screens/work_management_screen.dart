import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../models/work_task.dart';
import '../models/company.dart';
import '../providers/work_provider.dart';
import '../services/database_service.dart';
import '../theme/app_colors.dart';

class WorkManagementScreen extends ConsumerStatefulWidget {
  const WorkManagementScreen({super.key});

  @override
  ConsumerState<WorkManagementScreen> createState() => _WorkManagementScreenState();
}

class _WorkManagementScreenState extends ConsumerState<WorkManagementScreen> {
  @override
  Widget build(BuildContext context) {
    final companiesAsync = ref.watch(companiesProvider);
    final selectedCompanyId = ref.watch(selectedCompanyIdProvider);

    final List<Color> avatarColors = [
      AppColors.skyBlue,
      AppColors.limeGreen,
      AppColors.violetAccent,
      AppColors.cyanAccent,
      AppColors.amberAccent,
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Row(
        children: [
          // Sidebar for Company Selection
          Container(
            width: 220,
            decoration: const BoxDecoration(
              color: AppColors.cardSurface,
              border: Border(right: BorderSide(color: AppColors.cardBorder, width: 1)),
              boxShadow: [AppColors.softShadow],
            ),
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.badgeCyanBg,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.business_rounded, color: AppColors.cyanAccent, size: 18),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'COMPANIES',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: AppColors.headingText,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                Expanded(
                  child: companiesAsync.when(
                    data: (companies) {
                      if (companies.isEmpty) {
                        return const Center(
                          child: Text('No companies', style: TextStyle(color: AppColors.mutedText, fontSize: 12)),
                        );
                      }
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                        itemCount: companies.length,
                        itemBuilder: (context, index) {
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
            child: selectedCompanyId == null
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
                : _buildWorkTracker(selectedCompanyId),
          ),
        ],
      ),
      floatingActionButton: selectedCompanyId != null
          ? FloatingActionButton.extended(
              onPressed: () => _showAddTaskDialog(selectedCompanyId),
              label: const Text('Add Task', style: TextStyle(fontWeight: FontWeight.bold)),
              icon: const Icon(Icons.add),
              backgroundColor: AppColors.skyBlue,
              foregroundColor: Colors.white,
            )
          : null,
    );
  }

  Widget _buildWorkTracker(int companyId) {
    final tasksAsync = ref.watch(taskListProvider);
    final selectedDate = ref.watch(selectedDateProvider);

    return Column(
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Work History & Log',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              // Date Navigation
              Row(
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
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.assignment_turned_in_outlined, size: 48, color: Colors.grey[400]),
                      const SizedBox(height: 12),
                      const Text('No tasks registered for this company on this day.'),
                    ],
                  ),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return _buildTaskCard(task);
                },
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

    return Card(
      elevation: 0.5,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Icon(statusIcon, color: statusColor, size: 28),
        title: Text(
          task.description,
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
                  _buildBadge('Priority: ${task.priority}', priorityColor),
                  _buildBadge('Method: ${task.communicationMethod ?? "N/A"}', Colors.blueGrey),
                  if (task.assignedTo != null && task.assignedTo!.isNotEmpty)
                    _buildBadge('To: ${task.assignedTo}', Colors.indigo),
                  if (task.carryForwardRequired)
                    _buildBadge('Carry Forward', Colors.purple),
                ],
              ),
              if (task.remarks != null && task.remarks!.isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(
                  'Remarks: ${task.remarks}',
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
            DropdownButton<String>(
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.3), width: 0.5),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold),
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

  void _showAddTaskDialog(int companyId) {
    final descController = TextEditingController();
    final toController = TextEditingController();
    final remarkController = TextEditingController();
    final reasonController = TextEditingController();
    
    String status = 'Pending';
    String priority = 'Normal';
    String method = 'WhatsApp';
    bool carryForward = true;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Work Task Entry'),
        content: StatefulBuilder(
          builder: (context, setDialogState) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: descController,
                    decoration: const InputDecoration(labelText: 'Task Description *', border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: status,
                    decoration: const InputDecoration(labelText: 'Initial Status', border: OutlineInputBorder()),
                    items: ['Pending', 'Completed', 'Under Process', 'No Response']
                        .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) setDialogState(() => status = val);
                    },
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: priority,
                    decoration: const InputDecoration(labelText: 'Priority Level', border: OutlineInputBorder()),
                    items: ['Normal', 'Important', 'Urgent']
                        .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) setDialogState(() => priority = val);
                    },
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: method,
                    decoration: const InputDecoration(labelText: 'Communication Channel', border: OutlineInputBorder()),
                    items: ['In Person', 'WhatsApp', 'Email', 'Call']
                        .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) setDialogState(() => method = val);
                    },
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: toController,
                    decoration: const InputDecoration(labelText: 'Assign To / Contact Person', border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: remarkController,
                    decoration: const InputDecoration(labelText: 'Additional Remarks', border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 8),
                  CheckboxListTile(
                    title: const Text('Carry Forward if incomplete?', style: TextStyle(fontSize: 14)),
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
                      decoration: const InputDecoration(
                        labelText: 'Reason for Carry Forward',
                        border: OutlineInputBorder(),
                        hintText: 'e.g. Awaiting client documents',
                      ),
                    ),
                  ]
                ],
              ),
            );
          },
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              if (descController.text.trim().isNotEmpty) {
                final db = ref.read(databaseServiceProvider);
                final task = WorkTask()
                  ..uuid = ''
                  ..companyId = companyId
                  ..description = descController.text.trim()
                  ..workDate = ref.read(selectedDateProvider)
                  ..assignedDate = DateTime.now()
                  ..priority = priority
                  ..assignedTo = toController.text.trim().isEmpty ? null : toController.text.trim()
                  ..communicationMethod = method
                  ..status = status
                  ..carryForwardRequired = carryForward
                  ..carryForwardReason = carryForward && reasonController.text.trim().isNotEmpty
                      ? reasonController.text.trim()
                      : null
                  ..remarks = remarkController.text.trim().isEmpty ? null : remarkController.text.trim()
                  ..isDeleted = false;

                await db.saveTask(task);
                ref.invalidate(taskListProvider);
                if (context.mounted) Navigator.pop(context);
              }
            },
            child: const Text('Save Task'),
          ),
        ],
      ),
    );
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
      ref.invalidate(taskListProvider);
    }
  }
}
