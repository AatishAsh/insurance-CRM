import 'package:flutter/material.dart';

class WorkManagementScreen extends StatefulWidget {
  const WorkManagementScreen({super.key});

  @override
  State<WorkManagementScreen> createState() => _WorkManagementScreenState();
}

class _WorkManagementScreenState extends State<WorkManagementScreen> {
  // Mock data for companies
  final List<String> companies = List.generate(15, (index) => 'Company ${index + 1}');
  int? selectedCompanyIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar for Company Selection (1-15)
          Container(
            width: 180,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border(right: BorderSide(color: Colors.grey[300]!)),
            ),
            child: ListView.builder(
              itemCount: companies.length,
              itemBuilder: (context, index) {
                final isSelected = selectedCompanyIndex == index;
                return ListTile(
                  title: Text(
                    companies[index],
                    style: TextStyle(
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? Colors.blue : Colors.black87,
                    ),
                  ),
                  selected: isSelected,
                  onTap: () {
                    setState(() => selectedCompanyIndex = index);
                  },
                );
              },
            ),
          ),
          // Main Work Tracking Area
          Expanded(
            child: selectedCompanyIndex == null
                ? const Center(child: Text('Select a company to manage daily work'))
                : _buildWorkTracker(companies[selectedCompanyIndex!]),
          ),
        ],
      ),
      floatingActionButton: selectedCompanyIndex != null
          ? FloatingActionButton.extended(
              onPressed: () => _showAddTaskDialog(),
              label: const Text('Add Task'),
              icon: const Icon(Icons.add),
            )
          : null,
    );
  }

  Widget _buildWorkTracker(String companyName) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$companyName Work History',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Chip(label: Text('Today: April 25, 2024')),
            ],
          ),
        ),
        const Divider(),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildTaskItem(
                'Policy renewal follow-up',
                'Pending',
                'Urgent',
                'WhatsApp',
              ),
              _buildTaskItem(
                'Aadhaar document collection',
                'Under Process',
                'Normal',
                'In Person',
              ),
              _buildTaskItem(
                'Medical report review',
                'Completed',
                'Important',
                'Email',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTaskItem(String desc, String status, String priority, String method) {
    Color statusColor = Colors.grey;
    if (status == 'Completed') statusColor = Colors.green;
    if (status == 'Pending') statusColor = Colors.orange;
    if (status == 'Under Process') statusColor = Colors.blue;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(desc),
        subtitle: Text('Method: $method | Priority: $priority'),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: statusColor),
          ),
          child: Text(
            status,
            style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
      ),
    );
  }

  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Work Entry'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const TextField(decoration: InputDecoration(labelText: 'Work Description')),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Status'),
                items: ['Pending', 'Completed', 'Under Process', 'No Response']
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (_) {},
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Priority'),
                items: ['Normal', 'Important', 'Urgent']
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (_) {},
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Method'),
                items: ['In Person', 'WhatsApp', 'Email', 'Call']
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (_) {},
              ),
              CheckboxListTile(
                title: const Text('Carry Forward to next day?'),
                value: false,
                onChanged: (_) {},
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Save')),
        ],
      ),
    );
  }
}
