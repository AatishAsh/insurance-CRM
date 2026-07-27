import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import '../models/customer.dart';
import '../services/database_service.dart';
import '../providers/auth_provider.dart';
import '../widgets/rename_file_dialog.dart';

class CustomerFormScreen extends ConsumerStatefulWidget {
  final Customer? customer;

  const CustomerFormScreen({super.key, this.customer});

  @override
  ConsumerState<CustomerFormScreen> createState() => _CustomerFormScreenState();
}

class _CustomerFormScreenState extends ConsumerState<CustomerFormScreen> {
  final _formKey = GlobalKey<FormState>();

  // Text Controllers
  final Map<String, TextEditingController> _controllers = {};

  // Dates
  final Map<String, DateTime?> _dates = {};

  // Dropdowns
  final Map<String, String> _dropdowns = {};

  // Documents
  List<CustomerDocument> _documents = [];

  // Configured Insurance/Finance Companies (loaded from DB)
  List<String> _companies = [];

  @override
  void initState() {
    super.initState();
    _loadCompanies();
    _initFields();
  }

  void _loadCompanies() async {
    final db = ref.read(databaseServiceProvider);
    final companyList = await db.getCompanies();
    setState(() {
      _companies = companyList.map((c) => c.name).toList();
    });
  }

  void _initFields() {
    final c = widget.customer;

    // Fields list to initialize
    final textFields = [
      'name', 'customerId', 'fatherName', 'spouseName', 'nationality', 'aadhaarNumber',
      'qualification', 'height', 'weight', 'numberOfChildren', 'fatherAge', 'motherAge',
      'spouseAge', 'brotherAge', 'sisterAge', 'employerBusinessName', 'designation',
      'natureOfBusiness', 'annualIncome', 'officeContactNumber', 'mobileNumber1',
      'mobileNumber2', 'mobileNumber3', 'mobileNumber4', 'emailId', 'panNumber',
      'nomineeName', 'nomineeRelationship', 'nomineeFatherName', 'nomineePan',
      'nomineeMobile1', 'nomineeMobile2', 'nomineeEmail', 'selfPolicyNumber',
      'selfSumAssured1', 'selfSumAssured2', 'selfYearOfIssue', 'fatherPolicyNumber',
      'fatherCompany', 'motherPolicyNumber', 'motherCompany', 'spousePolicyNumber',
      'spouseCompany', 'childrenPolicyNumber', 'childrenCompany', 'healthProblems',
      'pregnancyDetails', 'healthRemarks', 'communicationAddress', 'permanentAddress',
      'productName', 'planSumAssured', 'rider', 'riskCover', 'pensionPlan',
      'investmentPlan', 'mutualFunds', 'mediClaim', 'moneyBackPolicy',
      'childrenEducationPlan', 'referenceFriendName', 'referenceMobile',
      'referenceAge', 'reminderNote1', 'reminderNote2', 'notes'
    ];

    for (final field in textFields) {
      _controllers[field] = TextEditingController();
    }

    if (c != null) {
      _controllers['name']!.text = c.name;
      _controllers['customerId']!.text = c.customerId ?? '';
      _controllers['fatherName']!.text = c.fatherName ?? '';
      _controllers['spouseName']!.text = c.spouseName ?? '';
      _controllers['nationality']!.text = c.nationality ?? '';
      _controllers['aadhaarNumber']!.text = c.aadhaarNumber ?? '';
      _controllers['qualification']!.text = c.qualification ?? '';
      _controllers['height']!.text = c.height ?? '';
      _controllers['weight']!.text = c.weight ?? '';
      _controllers['numberOfChildren']!.text = c.numberOfChildren?.toString() ?? '';
      _controllers['fatherAge']!.text = c.fatherAge ?? '';
      _controllers['motherAge']!.text = c.motherAge ?? '';
      _controllers['spouseAge']!.text = c.spouseAge ?? '';
      _controllers['brotherAge']!.text = c.brotherAge ?? '';
      _controllers['sisterAge']!.text = c.sisterAge ?? '';
      _controllers['employerBusinessName']!.text = c.employerBusinessName ?? '';
      _controllers['designation']!.text = c.designation ?? '';
      _controllers['natureOfBusiness']!.text = c.natureOfBusiness ?? '';
      _controllers['annualIncome']!.text = c.annualIncome ?? '';
      _controllers['officeContactNumber']!.text = c.officeContactNumber ?? '';
      _controllers['mobileNumber1']!.text = c.mobileNumber1 ?? '';
      _controllers['mobileNumber2']!.text = c.mobileNumber2 ?? '';
      _controllers['mobileNumber3']!.text = c.mobileNumber3 ?? '';
      _controllers['mobileNumber4']!.text = c.mobileNumber4 ?? '';
      _controllers['emailId']!.text = c.emailId ?? '';
      _controllers['panNumber']!.text = c.panNumber ?? '';
      _controllers['nomineeName']!.text = c.nomineeName ?? '';
      _controllers['nomineeRelationship']!.text = c.nomineeRelationship ?? '';
      _controllers['nomineeFatherName']!.text = c.nomineeFatherName ?? '';
      _controllers['nomineePan']!.text = c.nomineePan ?? '';
      _controllers['nomineeMobile1']!.text = c.nomineeMobile1 ?? '';
      _controllers['nomineeMobile2']!.text = c.nomineeMobile2 ?? '';
      _controllers['nomineeEmail']!.text = c.nomineeEmail ?? '';
      _controllers['selfPolicyNumber']!.text = c.selfPolicyNumber ?? '';
      _controllers['selfSumAssured1']!.text = c.selfSumAssured1 ?? '';
      _controllers['selfSumAssured2']!.text = c.selfSumAssured2 ?? '';
      _controllers['selfYearOfIssue']!.text = c.selfYearOfIssue ?? '';
      _controllers['fatherPolicyNumber']!.text = c.fatherPolicyNumber ?? '';
      _controllers['fatherCompany']!.text = c.fatherCompany ?? '';
      _controllers['motherPolicyNumber']!.text = c.motherPolicyNumber ?? '';
      _controllers['motherCompany']!.text = c.motherCompany ?? '';
      _controllers['spousePolicyNumber']!.text = c.spousePolicyNumber ?? '';
      _controllers['spouseCompany']!.text = c.spouseCompany ?? '';
      _controllers['childrenPolicyNumber']!.text = c.childrenPolicyNumber ?? '';
      _controllers['childrenCompany']!.text = c.childrenCompany ?? '';
      _controllers['healthProblems']!.text = c.healthProblems ?? '';
      _controllers['pregnancyDetails']!.text = c.pregnancyDetails ?? '';
      _controllers['healthRemarks']!.text = c.healthRemarks ?? '';
      _controllers['communicationAddress']!.text = c.communicationAddress ?? '';
      _controllers['permanentAddress']!.text = c.permanentAddress ?? '';
      _controllers['productName']!.text = c.productName ?? '';
      _controllers['planSumAssured']!.text = c.planSumAssured ?? '';
      _controllers['rider']!.text = c.rider ?? '';
      _controllers['riskCover']!.text = c.riskCover ?? '';
      _controllers['pensionPlan']!.text = c.pensionPlan ?? '';
      _controllers['investmentPlan']!.text = c.investmentPlan ?? '';
      _controllers['mutualFunds']!.text = c.mutualFunds ?? '';
      _controllers['mediClaim']!.text = c.mediClaim ?? '';
      _controllers['moneyBackPolicy']!.text = c.moneyBackPolicy ?? '';
      _controllers['childrenEducationPlan']!.text = c.childrenEducationPlan ?? '';
      _controllers['referenceFriendName']!.text = c.referenceFriendName ?? '';
      _controllers['referenceMobile']!.text = c.referenceMobile ?? '';
      _controllers['referenceAge']!.text = c.referenceAge ?? '';
      _controllers['reminderNote1']!.text = c.reminderNote1 ?? '';
      _controllers['reminderNote2']!.text = c.reminderNote2 ?? '';
      _controllers['notes']!.text = c.notes ?? '';

      // Date fields
      _dates['dateOfBirth'] = c.dateOfBirth;
      _dates['familyDOB'] = c.familyDOB;
      _dates['weddingAnniversary'] = c.weddingAnniversary;
      _dates['nomineeDOB'] = c.nomineeDOB;
      _dates['reminderDate1'] = c.reminderDate1;
      _dates['reminderDate2'] = c.reminderDate2;

      // Dropdown fields
      _dropdowns['maritalStatus'] = c.maritalStatus ?? '';
      _dropdowns['selfCompany'] = c.selfCompany ?? '';
      _dropdowns['premiumMode'] = c.premiumMode ?? '';
      _dropdowns['lifestyleHabits'] = c.lifestyleHabits ?? '';

      // Documents
      _documents = List.from(c.documents);
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _pickDocument() async {
    String? selectedLabel;
    final labels = [
      'Age Proof', 'ID Proof', 'Address Proof', 'Photo', 'School ID',
      'Form 16', 'Bank Statement', 'Bank Cheque 1', 'Bank Cheque 2',
      'Proposal Form 1', 'Proposal Form 2', 'Visiting Card', 'PAN Card Copy',
      'Other'
    ];

    // First prompt for a label
    final labelSelected = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Document Attachment'),
          content: StatefulBuilder(
            builder: (context, setDialogState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Select document label:'),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    items: labels.map((l) => DropdownMenuItem(value: l, child: Text(l))).toList(),
                    onChanged: (val) {
                      selectedLabel = val;
                    },
                    decoration: const InputDecoration(border: OutlineInputBorder(), isDense: true),
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (selectedLabel != null) {
                  Navigator.pop(context, true);
                }
              },
              child: const Text('Choose File'),
            ),
          ],
        );
      },
    );

    if (labelSelected == true && selectedLabel != null) {
      // Pick File
      ref.read(isPickingFileProvider.notifier).state = true;
      try {
        final result = await FilePicker.platform.pickFiles(type: FileType.any);
        if (result != null && result.files.single.path != null) {
          final File srcFile = File(result.files.single.path!);
          
          // Ask user to rename attachment
          final customFileName = await showRenameFileDialog(context, srcFile.path);
          if (customFileName == null) {
            return; // User canceled upload
          }

          // Save locally using relative path
          final appDir = await getApplicationDocumentsDirectory();
          final docsDir = Directory('${appDir.path}/customer_documents');
          if (!await docsDir.exists()) {
            await docsDir.create(recursive: true);
          }

          final localFileName = '${DateTime.now().millisecondsSinceEpoch}_$customFileName';
          await srcFile.copy('${docsDir.path}/$localFileName');

          setState(() {
            _documents.add(CustomerDocument()
              ..documentName = selectedLabel
              ..fileName = localFileName);
          });
        }
      } finally {
        ref.read(isPickingFileProvider.notifier).state = false;
      }
    }
  }

  void _deleteCustomer() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Profile'),
        content: const Text('Are you sure you want to permanently delete this customer profile?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm == true && widget.customer != null) {
      final db = ref.read(databaseServiceProvider);
      await db.deleteCustomer(widget.customer!.id);
      if (mounted) {
        Navigator.pop(context); // Close the form screen
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Customer profile deleted'), backgroundColor: Colors.redAccent),
        );
      }
    }
  }

  void _saveForm() async {
    if (!_formKey.currentState!.validate()) return;

    final db = ref.read(databaseServiceProvider);
    final customer = widget.customer ?? Customer()..uuid = '';

    customer.name = _controllers['name']!.text;
    customer.customerId = _controllers['customerId']!.text.isEmpty ? null : _controllers['customerId']!.text;
    customer.fatherName = _controllers['fatherName']!.text;
    customer.spouseName = _controllers['spouseName']!.text;
    customer.nationality = _controllers['nationality']!.text;
    customer.aadhaarNumber = _controllers['aadhaarNumber']!.text;
    customer.qualification = _controllers['qualification']!.text;
    customer.height = _controllers['height']!.text;
    customer.weight = _controllers['weight']!.text;
    customer.numberOfChildren = int.tryParse(_controllers['numberOfChildren']!.text);
    customer.fatherAge = _controllers['fatherAge']!.text;
    customer.motherAge = _controllers['motherAge']!.text;
    customer.spouseAge = _controllers['spouseAge']!.text;
    customer.brotherAge = _controllers['brotherAge']!.text;
    customer.sisterAge = _controllers['sisterAge']!.text;
    customer.employerBusinessName = _controllers['employerBusinessName']!.text;
    customer.designation = _controllers['designation']!.text;
    customer.natureOfBusiness = _controllers['natureOfBusiness']!.text;
    customer.annualIncome = _controllers['annualIncome']!.text;
    customer.officeContactNumber = _controllers['officeContactNumber']!.text;
    customer.mobileNumber1 = _controllers['mobileNumber1']!.text;
    customer.mobileNumber2 = _controllers['mobileNumber2']!.text;
    customer.mobileNumber3 = _controllers['mobileNumber3']!.text;
    customer.mobileNumber4 = _controllers['mobileNumber4']!.text;
    customer.emailId = _controllers['emailId']!.text;
    customer.panNumber = _controllers['panNumber']!.text;
    customer.nomineeName = _controllers['nomineeName']!.text;
    customer.nomineeRelationship = _controllers['nomineeRelationship']!.text;
    customer.nomineeFatherName = _controllers['nomineeFatherName']!.text;
    customer.nomineePan = _controllers['nomineePan']!.text;
    customer.nomineeMobile1 = _controllers['nomineeMobile1']!.text;
    customer.nomineeMobile2 = _controllers['nomineeMobile2']!.text;
    customer.nomineeEmail = _controllers['nomineeEmail']!.text;
    customer.selfPolicyNumber = _controllers['selfPolicyNumber']!.text;
    customer.selfSumAssured1 = _controllers['selfSumAssured1']!.text;
    customer.selfSumAssured2 = _controllers['selfSumAssured2']!.text;
    customer.selfYearOfIssue = _controllers['selfYearOfIssue']!.text;
    customer.fatherPolicyNumber = _controllers['fatherPolicyNumber']!.text;
    customer.fatherCompany = _controllers['fatherCompany']!.text;
    customer.motherPolicyNumber = _controllers['motherPolicyNumber']!.text;
    customer.motherCompany = _controllers['motherCompany']!.text;
    customer.spousePolicyNumber = _controllers['spousePolicyNumber']!.text;
    customer.spouseCompany = _controllers['spouseCompany']!.text;
    customer.childrenPolicyNumber = _controllers['childrenPolicyNumber']!.text;
    customer.childrenCompany = _controllers['childrenCompany']!.text;
    customer.healthProblems = _controllers['healthProblems']!.text;
    customer.pregnancyDetails = _controllers['pregnancyDetails']!.text;
    customer.healthRemarks = _controllers['healthRemarks']!.text;
    customer.communicationAddress = _controllers['communicationAddress']!.text;
    customer.permanentAddress = _controllers['permanentAddress']!.text;
    customer.productName = _controllers['productName']!.text;
    customer.planSumAssured = _controllers['planSumAssured']!.text;
    customer.rider = _controllers['rider']!.text;
    customer.riskCover = _controllers['riskCover']!.text;
    customer.pensionPlan = _controllers['pensionPlan']!.text;
    customer.investmentPlan = _controllers['investmentPlan']!.text;
    customer.mutualFunds = _controllers['mutualFunds']!.text;
    customer.mediClaim = _controllers['mediClaim']!.text;
    customer.moneyBackPolicy = _controllers['moneyBackPolicy']!.text;
    customer.childrenEducationPlan = _controllers['childrenEducationPlan']!.text;
    customer.referenceFriendName = _controllers['referenceFriendName']!.text;
    customer.referenceMobile = _controllers['referenceMobile']!.text;
    customer.referenceAge = _controllers['referenceAge']!.text;
    customer.reminderNote1 = _controllers['reminderNote1']!.text;
    customer.reminderNote2 = _controllers['reminderNote2']!.text;
    customer.notes = _controllers['notes']!.text;

    // Date assignments
    customer.dateOfBirth = _dates['dateOfBirth'];
    customer.familyDOB = _dates['familyDOB'];
    customer.weddingAnniversary = _dates['weddingAnniversary'];
    customer.nomineeDOB = _dates['nomineeDOB'];
    customer.reminderDate1 = _dates['reminderDate1'];
    customer.reminderDate2 = _dates['reminderDate2'];

    // Dropdown assignments
    customer.maritalStatus = _dropdowns['maritalStatus']?.isEmpty ?? true ? null : _dropdowns['maritalStatus'];
    customer.selfCompany = _dropdowns['selfCompany']?.isEmpty ?? true ? null : _dropdowns['selfCompany'];
    customer.premiumMode = _dropdowns['premiumMode']?.isEmpty ?? true ? null : _dropdowns['premiumMode'];
    customer.lifestyleHabits = _dropdowns['lifestyleHabits']?.isEmpty ?? true ? null : _dropdowns['lifestyleHabits'];

    // Documents
    customer.documents = _documents;

    await db.saveCustomer(customer);
    if (mounted) {
      Navigator.pop(context);
    }
  }

  // Helper for text fields
  Widget _buildField(String key, String label, {TextInputType keyboardType = TextInputType.text, int maxLines = 1, bool required = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
      child: TextFormField(
        controller: _controllers[key],
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          isDense: true,
          errorStyle: const TextStyle(height: 0.8),
        ),
        validator: (value) {
          if (required && (value == null || value.trim().isEmpty)) {
            return '$label is required';
          }
          return null;
        },
      ),
    );
  }

  // Helper for Date pickers
  Widget _buildDateField(String key, String label) {
    final value = _dates[key];
    final text = value == null ? '' : DateFormat('dd MMM yyyy').format(value);
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
      child: InkWell(
        onTap: () async {
          final picked = await showDatePicker(
            context: context,
            initialDate: value ?? DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2100),
          );
          if (picked != null) {
            setState(() {
              _dates[key] = picked;
            });
          }
        },
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
            isDense: true,
            suffixIcon: const Icon(Icons.calendar_today, size: 20),
          ),
          child: Text(
            text.isEmpty ? 'Select Date' : text,
            style: TextStyle(color: text.isEmpty ? Colors.grey[600] : Colors.black87),
          ),
        ),
      ),
    );
  }

  // Helper for Dropdowns
  Widget _buildDropdownField(String key, String label, List<String> options) {
    final value = _dropdowns[key] ?? '';
    final items = options.map((o) => DropdownMenuItem(value: o, child: Text(o))).toList();
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
      child: DropdownButtonFormField<String>(
        value: value.isEmpty ? null : value,
        items: items,
        onChanged: (val) {
          setState(() {
            _dropdowns[key] = val ?? '';
          });
        },
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          isDense: true,
        ),
      ),
    );
  }

  // Helper for Expansion Accordion Card
  Widget _buildAccordionSection(String title, IconData icon, List<Widget> children) {
    return Card(
      elevation: 0.5,
      margin: const EdgeInsets.only(bottom: 8.0),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        initiallyExpanded: false, // ALL COLLAPSED AS REQUESTED
        childrenPadding: const EdgeInsets.all(12.0),
        expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.customer != null;
    final double width = MediaQuery.of(context).size.width;
    final isDesktop = width > 800;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Customer Profile' : 'Add New Customer'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            tooltip: 'Save',
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Core Required Details (always visible at top)
              Card(
                elevation: 0,
                color: Colors.blue.withOpacity(0.05),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.blue.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Expanded(child: _buildField('name', 'Full Name *', required: true)),
                      Expanded(child: _buildField('customerId', 'Customer ID (e.g. CUST-001)')),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Accordion 1: Personal Details
              _buildAccordionSection('Personal Details', Icons.person_outline, [
                if (isDesktop)
                  Row(
                    children: [
                      Expanded(child: _buildField('fatherName', "Father's Name")),
                      Expanded(child: _buildDateField('dateOfBirth', 'Date of Birth')),
                    ],
                  )
                else ...[
                  _buildField('fatherName', "Father's Name"),
                  _buildDateField('dateOfBirth', 'Date of Birth'),
                ],
                if (isDesktop)
                  Row(
                    children: [
                      Expanded(child: _buildDropdownField('maritalStatus', 'Marital Status', ['Single', 'Married', 'Divorced', 'Widowed'])),
                      Expanded(child: _buildField('spouseName', 'Spouse Name')),
                    ],
                  )
                else ...[
                  _buildDropdownField('maritalStatus', 'Marital Status', ['Single', 'Married', 'Divorced', 'Widowed']),
                  _buildField('spouseName', 'Spouse Name'),
                ],
                if (isDesktop)
                  Row(
                    children: [
                      Expanded(child: _buildField('nationality', 'Nationality')),
                      Expanded(child: _buildField('aadhaarNumber', 'Aadhaar Number', keyboardType: TextInputType.number)),
                    ],
                  )
                else ...[
                  _buildField('nationality', 'Nationality'),
                  _buildField('aadhaarNumber', 'Aadhaar Number', keyboardType: TextInputType.number),
                ],
                Row(
                  children: [
                    Expanded(child: _buildField('qualification', 'Qualification')),
                    Expanded(child: _buildField('height', 'Height')),
                    Expanded(child: _buildField('weight', 'Weight')),
                  ],
                ),
              ]),

              // Accordion 2: Family Details
              _buildAccordionSection('Family Details', Icons.family_restroom_outlined, [
                Row(
                  children: [
                    Expanded(child: _buildField('numberOfChildren', 'Number of Children', keyboardType: TextInputType.number)),
                    Expanded(child: _buildDateField('familyDOB', 'Family DOB')),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: _buildField('fatherAge', "Father's Age")),
                    Expanded(child: _buildField('motherAge', "Mother's Age")),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: _buildField('spouseAge', "Spouse's Age")),
                    Expanded(child: _buildField('brotherAge', "Brother's Age")),
                    Expanded(child: _buildField('sisterAge', "Sister's Age")),
                  ],
                ),
              ]),

              // Accordion 3: Professional Details
              _buildAccordionSection('Professional Information', Icons.business_center_outlined, [
                _buildField('employerBusinessName', 'Employer / Business Name'),
                Row(
                  children: [
                    Expanded(child: _buildField('designation', 'Designation')),
                    Expanded(child: _buildField('natureOfBusiness', 'Nature of Business / Occupation')),
                  ],
                ),
                _buildField('annualIncome', 'Annual Income', keyboardType: TextInputType.number),
              ]),

              // Accordion 4: Contact Information
              _buildAccordionSection('Contact Details', Icons.call_outlined, [
                if (isDesktop)
                  Row(
                    children: [
                      Expanded(child: _buildField('mobileNumber1', 'Mobile Number 1', keyboardType: TextInputType.phone)),
                      Expanded(child: _buildField('mobileNumber2', 'Mobile Number 2', keyboardType: TextInputType.phone)),
                    ],
                  )
                else ...[
                  _buildField('mobileNumber1', 'Mobile Number 1', keyboardType: TextInputType.phone),
                  _buildField('mobileNumber2', 'Mobile Number 2', keyboardType: TextInputType.phone),
                ],
                if (isDesktop)
                  Row(
                    children: [
                      Expanded(child: _buildField('mobileNumber3', 'Mobile Number 3', keyboardType: TextInputType.phone)),
                      Expanded(child: _buildField('mobileNumber4', 'Mobile Number 4', keyboardType: TextInputType.phone)),
                    ],
                  )
                else ...[
                  _buildField('mobileNumber3', 'Mobile Number 3', keyboardType: TextInputType.phone),
                  _buildField('mobileNumber4', 'Mobile Number 4', keyboardType: TextInputType.phone),
                ],
                Row(
                  children: [
                    Expanded(child: _buildField('officeContactNumber', 'Office Contact', keyboardType: TextInputType.phone)),
                    Expanded(child: _buildField('emailId', 'Email ID', keyboardType: TextInputType.emailAddress)),
                  ],
                ),
              ]),

              // Accordion 5: Address Information
              _buildAccordionSection('Address Details', Icons.home_outlined, [
                _buildField('communicationAddress', 'Communication Address', maxLines: 3),
                const SizedBox(height: 8),
                _buildField('permanentAddress', 'Permanent Address', maxLines: 3),
              ]),

              // Accordion 6: Nominee Information
              _buildAccordionSection('Nominee Details', Icons.badge_outlined, [
                Row(
                  children: [
                    Expanded(child: _buildField('nomineeName', 'Nominee Name')),
                    Expanded(child: _buildField('nomineeRelationship', 'Relationship')),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: _buildDateField('nomineeDOB', 'Nominee DOB')),
                    Expanded(child: _buildField('nomineeFatherName', "Nominee's Father's Name")),
                  ],
                ),
                _buildField('nomineePan', 'Nominee PAN'),
                Row(
                  children: [
                    Expanded(child: _buildField('nomineeMobile1', 'Nominee Mobile 1', keyboardType: TextInputType.phone)),
                    Expanded(child: _buildField('nomineeMobile2', 'Nominee Mobile 2', keyboardType: TextInputType.phone)),
                  ],
                ),
                _buildField('nomineeEmail', 'Nominee Email', keyboardType: TextInputType.emailAddress),
              ]),

              // Accordion 7: Insurance Policy Details
              _buildAccordionSection('Insurance Details', Icons.security_outlined, [
                _buildDropdownField('selfCompany', 'Self Assigned Company', _companies),
                Row(
                  children: [
                    Expanded(child: _buildField('selfPolicyNumber', 'Self Policy Number')),
                    Expanded(child: _buildField('selfYearOfIssue', 'Year of Issue')),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: _buildField('selfSumAssured1', 'Sum Assured 1')),
                    Expanded(child: _buildField('selfSumAssured2', 'Sum Assured 2')),
                  ],
                ),
                const Divider(height: 24),
                Row(
                  children: [
                    Expanded(child: _buildField('fatherPolicyNumber', 'Father Policy Number')),
                    Expanded(child: _buildField('fatherCompany', 'Father Company')),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: _buildField('motherPolicyNumber', 'Mother Policy Number')),
                    Expanded(child: _buildField('motherCompany', 'Mother Company')),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: _buildField('spousePolicyNumber', 'Spouse Policy Number')),
                    Expanded(child: _buildField('spouseCompany', 'Spouse Company')),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: _buildField('childrenPolicyNumber', 'Children Policy Number')),
                    Expanded(child: _buildField('childrenCompany', 'Children Company')),
                  ],
                ),
              ]),

              // Accordion 8: Health Details
              _buildAccordionSection('Health Details', Icons.health_and_safety_outlined, [
                _buildField('healthProblems', 'Health Problems', maxLines: 3),
                _buildDropdownField('lifestyleHabits', 'Lifestyle Habits', ['None', 'Smoking', 'Drinking', 'Both']),
                _buildField('pregnancyDetails', 'Pregnancy Details (If applicable)'),
                _buildField('healthRemarks', 'Other Remarks', maxLines: 2),
              ]),

              // Accordion 9: Plan Information
              _buildAccordionSection('Plan Details', Icons.article_outlined, [
                _buildField('productName', 'Product Name'),
                _buildDropdownField('premiumMode', 'Premium Mode', ['Yearly', 'Half-Yearly', 'Quarterly', 'Monthly']),
                _buildField('planSumAssured', 'Plan Sum Assured'),
                _buildField('rider', 'Riders Configured'),
              ]),

              // Accordion 10: Mutual Finance Specifics
              _buildAccordionSection('PAN & Mutual Finance Details', Icons.account_balance_outlined, [
                _buildField('panNumber', 'PAN Number'),
                Row(
                  children: [
                    Expanded(child: _buildField('riskCover', 'Risk Cover')),
                    Expanded(child: _buildField('pensionPlan', 'Pension Plan')),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: _buildField('investmentPlan', 'Investment Plan')),
                    Expanded(child: _buildField('mutualFunds', 'Mutual Funds')),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: _buildField('mediClaim', 'Medi Claim')),
                    Expanded(child: _buildField('moneyBackPolicy', 'Money Back Policy')),
                  ],
                ),
                _buildField('childrenEducationPlan', "Children's Education Plan"),
              ]),

              // Accordion 11: Reminders
              _buildAccordionSection('Reminders', Icons.alarm_outlined, [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          _buildDateField('reminderDate1', 'Reminder Date 1'),
                          _buildField('reminderNote1', 'Reminder 1 Note', maxLines: 2),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          _buildDateField('reminderDate2', 'Reminder Date 2'),
                          _buildField('reminderNote2', 'Reminder 2 Note', maxLines: 2),
                        ],
                      ),
                    ),
                  ],
                ),
              ]),

              // Accordion 12: Reference Details
              _buildAccordionSection('References', Icons.people_outline, [
                _buildField('referenceFriendName', "Friend's Name"),
                Row(
                  children: [
                    Expanded(child: _buildField('referenceMobile', 'Reference Mobile', keyboardType: TextInputType.phone)),
                    Expanded(child: _buildField('referenceAge', 'Reference Age')),
                  ],
                ),
              ]),

              // Accordion 13: Document Attachments
              _buildAccordionSection('Document Attachments', Icons.attach_file_outlined, [
                if (_documents.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text('No documents attached yet.', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _documents.length,
                    itemBuilder: (context, index) {
                      final doc = _documents[index];
                      return ListTile(
                        leading: const Icon(Icons.description, color: Colors.blue),
                        title: Text(doc.documentName ?? 'Unnamed Document'),
                        subtitle: Text(doc.fileName ?? '', overflow: TextOverflow.ellipsis),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              _documents.removeAt(index);
                            });
                          },
                        ),
                      );
                    },
                  ),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: _pickDocument,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Document File'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ]),

              // Accordion 14: Additional Notes
              _buildAccordionSection('Remarks / Notes', Icons.notes_outlined, [
                _buildField('notes', 'Additional Notes', maxLines: 5),
              ]),

              const SizedBox(height: 32),

              if (widget.customer != null) ...[
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _deleteCustomer,
                        icon: const Icon(Icons.delete_outline),
                        label: const Text('DELETE PROFILE', style: TextStyle(fontWeight: FontWeight.bold)),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Colors.redAccent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: _saveForm,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('SAVE PROFILE', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                    ),
                  ],
                ),
              ] else ...[
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _saveForm,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('SAVE PROFILE', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ),
              ],
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
