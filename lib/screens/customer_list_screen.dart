import 'package:flutter/material.dart';
import 'customer_form_screen.dart';

class CustomerListScreen extends StatelessWidget {
  const CustomerListScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12.0),
        children: [
          _buildCustomerTile(context, 'CUST-001', 'Amit Sharma', '9876543210', 'Active Policies: 2', Colors.blue),
          _buildCustomerTile(context, 'CUST-002', 'Priya Patel', '8765432109', 'Active Policies: 1', Colors.purple),
          _buildCustomerTile(context, 'CUST-003', 'Rohan Desai', '7654321098', 'Active Policies: 3', Colors.teal),
          _buildCustomerTile(context, 'CUST-004', 'Sneha Reddy', '6543210987', 'Active Policies: 0', Colors.orange),
          _buildCustomerTile(context, 'CUST-005', 'Vikram Singh', '5432109876', 'Active Policies: 1', Colors.indigo),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const CustomerFormScreen()));
        },
        icon: const Icon(Icons.person_add),
        label: const Text('Add Customer'),
      ),
    );
  }

  Widget _buildCustomerTile(BuildContext context, String id, String name, String phone, String subtitle, Color color) {
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
          child: Text(name[0], style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 20)),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text('$id  •  $phone\n$subtitle', style: TextStyle(color: Colors.grey[700], height: 1.4)),
        ),
        isThreeLine: true,
        trailing: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.edit, size: 20, color: Colors.blue),
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const CustomerFormScreen()));
        },
      ),
    );
  }
}
