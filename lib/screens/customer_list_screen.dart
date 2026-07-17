import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/customer_provider.dart';
import '../models/customer.dart';
import 'customer_form_screen.dart';
import 'customer_detail_screen.dart';

class CustomerListScreen extends ConsumerWidget {
  const CustomerListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customersAsync = ref.watch(customerListProvider);
    final searchQuery = ref.watch(searchQueryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Directory'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 12.0),
            child: SearchBar(
              hintText: 'Search by Name, ID, or Document (e.g. Aadhaar)',
              leading: const Icon(Icons.search),
              elevation: WidgetStateProperty.all(1),
              padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 16.0)),
              onChanged: (value) {
                ref.read(searchQueryProvider.notifier).state = value;
                ref.read(customerPageProvider.notifier).state = 0; // Reset page to 0 on search
              },
            ),
          ),
        ),
      ),
      body: customersAsync.when(
        data: (customers) {
          if (customers.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.people_outline, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    searchQuery.isEmpty ? 'No customers found. Add your first customer!' : 'No results matching "$searchQuery"',
                    style: TextStyle(color: Colors.grey[600], fontSize: 16),
                  ),
                ],
              ),
            );
          }

          final page = ref.watch(customerPageProvider);
          const int pageSize = 20;
          final totalPages = (customers.length / pageSize).ceil();
          final start = page * pageSize;
          final end = (start + pageSize) < customers.length ? (start + pageSize) : customers.length;
          
          final paginatedCustomers = customers.sublist(start, end);

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(12.0),
                  itemCount: paginatedCustomers.length,
                  itemBuilder: (context, index) {
                    final customer = paginatedCustomers[index];
                    return _buildCustomerTile(context, ref, customer);
                  },
                ),
              ),
              if (customers.length > pageSize) ...[
                const Divider(height: 1),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        onPressed: page > 0
                            ? () => ref.read(customerPageProvider.notifier).state = page - 1
                            : null,
                        icon: const Icon(Icons.arrow_back),
                        label: const Text('Previous'),
                      ),
                      Text(
                        'Page ${page + 1} of $totalPages',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      ElevatedButton.icon(
                        onPressed: page + 1 < totalPages
                            ? () => ref.read(customerPageProvider.notifier).state = page + 1
                            : null,
                        icon: const Icon(Icons.arrow_forward),
                        label: const Text('Next'),
                        iconAlignment: IconAlignment.end,
                      ),
                    ],
                  ),
                ),
              ],
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error loading customers: $err')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CustomerFormScreen()),
          );
          // Refresh list and reset page to 0 on adding new customer
          ref.read(customerPageProvider.notifier).state = 0;
          ref.invalidate(customerListProvider);
        },
        icon: const Icon(Icons.person_add),
        label: const Text('Add Customer'),
      ),
    );
  }

  Widget _buildCustomerTile(BuildContext context, WidgetRef ref, Customer customer) {
    // Generate a unique avatar color based on the hash of the customer's name
    final int hash = customer.name.hashCode;
    final List<Color> colors = [Colors.blue, Colors.purple, Colors.teal, Colors.orange, Colors.indigo, Colors.pink, Colors.red, Colors.green];
    final color = colors[hash.abs() % colors.length];

    final String policyInfo = customer.selfPolicyNumber != null && customer.selfPolicyNumber!.isNotEmpty
        ? 'Policy: ${customer.selfPolicyNumber}'
        : 'No Active Policy';

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8.0),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: color.withOpacity(0.15),
          child: Text(
            customer.name.isNotEmpty ? customer.name[0].toUpperCase() : '?',
            style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        title: Text(customer.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            '${customer.customerId ?? 'No ID'}  •  ${customer.mobileNumber1 ?? 'No Phone'}\n$policyInfo',
            style: TextStyle(color: Colors.grey[700], height: 1.4),
          ),
        ),
        isThreeLine: true,
        trailing: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.edit, size: 20, color: Colors.blue),
          ),
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CustomerFormScreen(customer: customer),
              ),
            );
            ref.invalidate(customerListProvider);
          },
        ),
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CustomerDetailScreen(customerId: customer.id),
            ),
          );
          ref.invalidate(customerListProvider);
        },
      ),
    );
  }
}
