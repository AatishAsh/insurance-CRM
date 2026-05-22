import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomerFormScreen extends StatefulWidget {
  const CustomerFormScreen({super.key});

  @override
  State<CustomerFormScreen> createState() => _CustomerFormScreenState();
}

class _CustomerFormScreenState extends State<CustomerFormScreen> {
  final _formKey = GlobalKey<FormState>();

  // Helper to build section headers
  Widget _buildSectionHeader(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
        ],
      ),
    );
  }

  // Helper for text fields
  Widget _buildTextField(String label, {TextInputType keyboardType = TextInputType.text, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          isDense: true,
        ),
        keyboardType: keyboardType,
        maxLines: maxLines,
      ),
    );
  }

  // Helper for Date fields
  Widget _buildDateField(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: TextFormField(
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          isDense: true,
          suffixIcon: const Icon(Icons.calendar_today),
        ),
        onTap: () {
          showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2100),
          );
        },
      ),
    );
  }

  // Helper for Dropdowns/Radios
  Widget _buildDropdownField(String label, List<String> options) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          isDense: true,
        ),
        items: options.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (_) {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Customer'),
        actions: [
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Save logic
                Navigator.pop(context);
              }
            },
            child: const Text('SAVE', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader('Personal Information', Icons.person),
              _buildTextField('Full Name'),
              _buildTextField('Father\'s Name'),
              _buildDateField('Date of Birth'),
              _buildDropdownField('Marital Status', ['Single', 'Married', 'Divorced', 'Widowed']),
              _buildTextField('Spouse Name'),
              _buildTextField('Nationality'),
              _buildTextField('Aadhaar Number', keyboardType: TextInputType.number),
              _buildTextField('Qualification'),
              Row(
                children: [
                  Expanded(child: _buildTextField('Height')),
                  Expanded(child: _buildTextField('Weight')),
                ],
              ),

              _buildSectionHeader('Family Details', Icons.family_restroom),
              _buildTextField('Number of Children', keyboardType: TextInputType.number),
              _buildTextField('Father\'s Age'),
              _buildTextField('Mother\'s Age'),
              _buildTextField('Brother\'s Age'),
              _buildTextField('Sister\'s Age'),

              _buildSectionHeader('Professional Information', Icons.work),
              _buildTextField('Employer / Business Name'),
              _buildTextField('Designation'),
              _buildTextField('Nature of Business'),
              _buildTextField('Annual Income', keyboardType: TextInputType.number),

              _buildSectionHeader('Contact Information', Icons.contact_phone),
              _buildTextField('Mobile Number 1', keyboardType: TextInputType.phone),
              _buildTextField('Mobile Number 2', keyboardType: TextInputType.phone),
              _buildTextField('Email ID', keyboardType: TextInputType.emailAddress),
              _buildTextField('Communication Address', maxLines: 2),

              _buildSectionHeader('Insurance Policy Details', Icons.security),
              _buildTextField('Self Policy Number'),
              _buildTextField('Self Sum Assured'),
              _buildDropdownField('Self Company', ['Company A', 'Company B', 'Company C']),
              _buildTextField('Father Policy Number'),
              _buildTextField('Mother Policy Number'),

              _buildSectionHeader('Documents / Attachments', Icons.attach_file),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('Upload scanned copies or take photos:', style: TextStyle(color: Colors.grey)),
              ),
              Wrap(
                spacing: 8,
                children: [
                  'Age Proof', 'ID Proof', 'Address Proof', 'Photo', 'PAN Card Copy'
                ].map((doc) => Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: ActionChip(
                    label: Text(doc),
                    onPressed: () {
                      // Trigger File/Image Picker
                    },
                    avatar: const Icon(Icons.add_a_photo, size: 16),
                  ),
                )).toList(),
              ),

              _buildSectionHeader('Additional Notes', Icons.notes),
              _buildTextField('Notes', maxLines: 4),

              const SizedBox(height: 100), // Padding for bottom nav
            ],
          ),
        ),
      ),
    );
  }
}
