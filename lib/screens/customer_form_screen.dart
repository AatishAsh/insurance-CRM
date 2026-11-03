import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import '../models/customer.dart';
import '../models/insurance_company.dart';
import '../services/database_service.dart';
import '../providers/auth_provider.dart';
import '../widgets/rename_file_dialog.dart';
import '../services/app_storage_service.dart';
import '../theme/app_colors.dart';
import '../widgets/brand_background.dart';
import '../providers/settings_provider.dart';
import '../widgets/date_input_formatter.dart';
import '../widgets/segmented_date_input_field.dart';
import '../widgets/aadhaar_number_formatter.dart';
import '../widgets/key_cycle_dropdown.dart';

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
  final Map<String, TextEditingController> _dateControllers = {};

  // Dates
  final Map<String, DateTime?> _dates = {};

  // Dropdowns
  final Map<String, String> _dropdowns = {};

  // Documents
  List<CustomerDocument> _documents = [];

  // Configured Insurance Companies (loaded from DB, up to 15 max)
  List<String> _insuranceCompanies = [];

  // Children DOBs & Policy lists
  List<DateTime?> _childrenDOBs = [];
  List<String> _childrenPolicyNumbers = [];
  List<String> _childrenCompanies = [];

  // Multiple Plans list
  List<CustomerPlanItem> _plans = [];

  // Multiple References list
  List<CustomerReferenceItem> _references = [];

  // Dynamic Reminders list
  List<CustomerReminderItem> _reminders = [];

  String _calculateAgeString(DateTime? dob) {
    if (dob == null) return '';
    final now = DateTime.now();
    int age = now.year - dob.year;
    if (now.month < dob.month || (now.month == dob.month && now.day < dob.day)) {
      age--;
    }
    return age < 0 ? '0' : age.toString();
  }

  @override
  void initState() {
    super.initState();
    _loadCompanies();
    _initFields();
  }

  void _loadCompanies() async {
    final db = ref.read(databaseServiceProvider);
    final insuranceList = await db.getInsuranceCompanies();
    setState(() {
      _insuranceCompanies = insuranceList.map((c) => c.name).toList();
    });
  }

  void _showAddInsuranceCompanyDialog() async {
    final db = ref.read(databaseServiceProvider);
    if (_insuranceCompanies.length >= 15) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.orange),
              SizedBox(width: 8),
              Text('Limit Reached'),
            ],
          ),
          content: const Text('Maximum limit of 15 insurance companies reached.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    final controller = TextEditingController();
    final formKey = GlobalKey<FormState>();

    final newName = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Insurance Company'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add a reusable insurance company name (Max 15 total).',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: controller,
                decoration: const InputDecoration(
                  labelText: 'Company Name *',
                  hintText: 'e.g. LIC, HDFC Life, Star Health',
                  border: OutlineInputBorder(),
                ),
                autofocus: true,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) return 'Company name is required';
                  if (_insuranceCompanies.any((existing) => existing.toLowerCase() == val.trim().toLowerCase())) {
                    return 'Company already exists';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Navigator.pop(context, controller.text.trim());
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );

    if (newName != null && newName.isNotEmpty) {
      try {
        await db.saveInsuranceCompany(newName);
        _loadCompanies();
        setState(() {
          _dropdowns['selfCompany'] = newName;
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Insurance company "$newName" added!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error adding company: $e'),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      }
    }
  }

  void _showManageInsuranceCompaniesDialog() async {
    final db = ref.read(databaseServiceProvider);

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return FutureBuilder<List<InsuranceCompany>>(
            future: db.getInsuranceCompanies(),
            builder: (context, snapshot) {
              final companies = snapshot.data ?? [];
              return AlertDialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.business, color: Colors.blueAccent),
                        SizedBox(width: 8),
                        Text('Manage Companies'),
                      ],
                    ),
                    Text(
                      '${companies.length}/15',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey[600]),
                    ),
                  ],
                ),
                content: SizedBox(
                  width: 400,
                  child: companies.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'No insurance companies added yet. Click "+ Add" to create your first company.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          itemCount: companies.length,
                          separatorBuilder: (_, __) => const Divider(height: 1),
                          itemBuilder: (context, index) {
                            final comp = companies[index];
                            return ListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                              title: Text(
                                comp.name,
                                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit_outlined, color: Colors.blue, size: 20),
                                    tooltip: 'Edit / Rename',
                                    onPressed: () async {
                                      final editController = TextEditingController(text: comp.name);
                                      final formKey = GlobalKey<FormState>();
                                      final oldName = comp.name;

                                      final renamed = await showDialog<String>(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text('Edit Insurance Company'),
                                          content: Form(
                                            key: formKey,
                                            child: TextFormField(
                                              controller: editController,
                                              decoration: const InputDecoration(
                                                labelText: 'Company Name *',
                                                border: OutlineInputBorder(),
                                              ),
                                              autofocus: true,
                                              validator: (val) {
                                                if (val == null || val.trim().isEmpty) return 'Name is required';
                                                return null;
                                              },
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(context),
                                              child: const Text('Cancel'),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                if (formKey.currentState!.validate()) {
                                                  Navigator.pop(context, editController.text.trim());
                                                }
                                              },
                                              child: const Text('Save'),
                                            ),
                                          ],
                                        ),
                                      );

                                      if (renamed != null && renamed.isNotEmpty && renamed != oldName) {
                                        try {
                                          await db.renameInsuranceCompany(comp, oldName, renamed);
                                          _loadCompanies();
                                          if (_dropdowns['selfCompany'] == oldName) {
                                            _dropdowns['selfCompany'] = renamed;
                                          }
                                          if (_dropdowns['fatherCompany'] == oldName) {
                                            _dropdowns['fatherCompany'] = renamed;
                                          }
                                          if (_dropdowns['motherCompany'] == oldName) {
                                            _dropdowns['motherCompany'] = renamed;
                                          }
                                          if (_dropdowns['spouseCompany'] == oldName) {
                                            _dropdowns['spouseCompany'] = renamed;
                                          }
                                          if (_dropdowns['childrenCompany'] == oldName) {
                                            _dropdowns['childrenCompany'] = renamed;
                                          }
                                          setDialogState(() {});
                                        } catch (e) {
                                          if (mounted) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text('Error: $e'), backgroundColor: Colors.redAccent),
                                            );
                                          }
                                        }
                                      }
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
                                    tooltip: 'Delete Company',
                                    onPressed: () async {
                                      final confirm = await showDialog<bool>(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text('Delete Insurance Company'),
                                          content: Text('Are you sure you want to delete "${comp.name}"?'),
                                          actions: [
                                            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                                            ElevatedButton(
                                              onPressed: () => Navigator.pop(context, true),
                                              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                                              child: const Text('Delete'),
                                            ),
                                          ],
                                        ),
                                      );

                                      if (confirm == true) {
                                        await db.deleteInsuranceCompany(comp.id);
                                        _loadCompanies();
                                        if (_dropdowns['selfCompany'] == comp.name) {
                                          _dropdowns['selfCompany'] = '';
                                        }
                                        setDialogState(() {});
                                      }
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Close'),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  void _initFields() {
    final c = widget.customer;

    // Fields list to initialize
    final textFields = [
      'name', 'customerId', 'familyId', 'fatherName', 'spouseName', 'nationality', 'aadhaarNumber',
      'qualification', 'height', 'weight', 'numberOfChildren', 'age', 'fatherAge', 'motherAge',
      'spouseAge', 'brotherAge', 'sisterAge', 'employerBusinessName', 'designation',
      'natureOfBusiness', 'annualIncome', 'officeContactNumber', 'mobileNumber1',
      'mobileNumber2', 'mobileNumber3', 'mobileNumber4', 'emailId', 'panNumber',
      'nomineeName', 'nomineeAge', 'nomineeFatherName', 'nomineePan',
      'nomineeMobile1', 'nomineeMobile2', 'nomineeEmail', 'appointeeName', 'appointeeAge', 'appointeeOtherRelationship', 'selfPolicyNumber',
      'selfSumAssured1', 'selfSumAssured2', 'selfYearOfIssue', 'fatherPolicyNumber',
      'fatherCompany', 'motherPolicyNumber', 'motherCompany', 'spousePolicyNumber',
      'spouseCompany', 'childrenPolicyNumber', 'childrenCompany', 'existingPolicyNumber', 'healthProblems',
      'pregnancyDetails', 'healthRemarks', 'communicationAddress', 'permanentAddress',
      'productName', 'planSumAssured', 'rider', 'riskCover', 'pensionPlan',
      'investmentPlan', 'mutualFunds', 'mediClaim', 'moneyBackPolicy',
      'childrenEducationPlan', 'referenceFriendName', 'referenceMobile',
      'referenceAge', 'reminderNote1', 'reminderNote2', 'reminderNote3',
      'reminderNote4', 'reminderNote5', 'notes'
    ];

    for (final field in textFields) {
      _controllers[field] = TextEditingController();
    }

    if (c != null) {
      _controllers['name']!.text = c.name;
      _controllers['customerId']!.text = c.customerId ?? '';
      _controllers['familyId']!.text = c.familyId ?? '';
      _controllers['fatherName']!.text = c.fatherName ?? '';
      _controllers['spouseName']!.text = c.spouseName ?? '';
      _controllers['nationality']!.text = c.nationality ?? '';
      _controllers['aadhaarNumber']!.text = c.aadhaarNumber ?? '';
      _controllers['qualification']!.text = c.qualification ?? '';
      _controllers['height']!.text = c.height ?? '';
      _controllers['weight']!.text = c.weight ?? '';
      _controllers['numberOfChildren']!.text = c.numberOfChildren?.toString() ?? '';
      _controllers['age']!.text = (c.age != null && c.age!.isNotEmpty) ? c.age! : _calculateAgeString(c.dateOfBirth);
      _controllers['fatherAge']!.text = (c.fatherAge != null && c.fatherAge!.isNotEmpty) ? c.fatherAge! : _calculateAgeString(c.fatherDOB);
      _controllers['motherAge']!.text = (c.motherAge != null && c.motherAge!.isNotEmpty) ? c.motherAge! : _calculateAgeString(c.motherDOB);
      _controllers['spouseAge']!.text = (c.spouseAge != null && c.spouseAge!.isNotEmpty) ? c.spouseAge! : _calculateAgeString(c.spouseDOB);
      _controllers['nomineeAge']!.text = (c.nomineeAge != null && c.nomineeAge!.isNotEmpty) ? c.nomineeAge! : _calculateAgeString(c.nomineeDOB);
      _controllers['appointeeAge']!.text = (c.appointeeAge != null && c.appointeeAge!.isNotEmpty) ? c.appointeeAge! : _calculateAgeString(c.appointeeDOB);
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
      _controllers['nomineeFatherName']!.text = c.nomineeFatherName ?? '';
      _controllers['nomineePan']!.text = c.nomineePan ?? '';
      _controllers['nomineeMobile1']!.text = c.nomineeMobile1 ?? '';
      _controllers['nomineeMobile2']!.text = c.nomineeMobile2 ?? '';
      _controllers['nomineeEmail']!.text = c.nomineeEmail ?? '';
      _controllers['appointeeName']!.text = c.appointeeName ?? '';
      _controllers['appointeeOtherRelationship']!.text = c.appointeeOtherRelationship ?? '';
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
      _controllers['existingPolicyNumber']!.text = c.existingPolicyNumber ?? '';
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
      _controllers['reminderNote3']!.text = c.reminderNote3 ?? '';
      _controllers['reminderNote4']!.text = c.reminderNote4 ?? '';
      _controllers['reminderNote5']!.text = c.reminderNote5 ?? '';
      _controllers['notes']!.text = c.notes ?? '';

      // Date fields
      _dates['dateOfBirth'] = c.dateOfBirth;
      _dates['fatherDOB'] = c.fatherDOB;
      _dates['motherDOB'] = c.motherDOB;
      _dates['spouseDOB'] = c.spouseDOB;
      _dates['weddingAnniversary'] = c.weddingAnniversary;
      _dates['nomineeDOB'] = c.nomineeDOB;
      _dates['appointeeDOB'] = c.appointeeDOB;
      _dates['existingDocDate'] = c.existingDocDate;
      _dates['personalAccidentDate'] = c.personalAccidentDate;
      _dates['reminderDate1'] = c.reminderDate1;
      _dates['reminderDate2'] = c.reminderDate2;
      _dates['reminderDate3'] = c.reminderDate3;
      _dates['reminderDate4'] = c.reminderDate4;
      _dates['reminderDate5'] = c.reminderDate5;

      if (c.childrenDOBs != null) {
        _childrenDOBs = List.from(c.childrenDOBs!);
      }

      if (c.childrenPolicyNumbers != null && c.childrenPolicyNumbers!.isNotEmpty) {
        _childrenPolicyNumbers = List<String>.from(c.childrenPolicyNumbers!);
        _childrenCompanies = List<String>.from(c.childrenCompanies ?? []);
      } else if (c.childrenPolicyNumber != null && c.childrenPolicyNumber!.isNotEmpty) {
        _childrenPolicyNumbers = c.childrenPolicyNumber!.split(',').map((e) => e.trim()).toList();
        _childrenCompanies = (c.childrenCompany ?? '').split(',').map((e) => e.trim()).toList();
      } else {
        _childrenPolicyNumbers = [];
        _childrenCompanies = [];
      }

      // Dropdown fields
      _dropdowns['maritalStatus'] = c.maritalStatus ?? '';
      _dropdowns['nomineeRelationship'] = c.nomineeRelationship ?? '';
      _dropdowns['appointeeRelationship'] = c.appointeeRelationship ?? '';
      _dropdowns['selfCompany'] = c.selfCompany ?? '';
      _dropdowns['hasExistingPolicy'] = c.hasExistingPolicy ?? 'No';
      _dropdowns['existingSelfCompany'] = c.existingSelfCompany ?? '';
      _dropdowns['hasPersonalAccident'] = c.hasPersonalAccident ?? 'No';
      _dropdowns['premiumMode'] = c.premiumMode ?? '';
      _dropdowns['lifestyleHabits'] = c.lifestyleHabits ?? '';

      // Documents
      _documents = List.from(c.documents);

      // Plans
      if (c.plans.isNotEmpty) {
        _plans = c.plans
            .map((p) => CustomerPlanItem()
              ..productName = p.productName
              ..premium = p.premium
              ..mode = p.mode
              ..planSumAssured = p.planSumAssured
              ..rider = p.rider
              ..planDate = p.planDate ?? DateTime.now())
            .toList();
      } else if (c.productName != null || c.planSumAssured != null) {
        _plans = [
          CustomerPlanItem()
            ..productName = c.productName
            ..premium = null
            ..mode = c.premiumMode
            ..planSumAssured = c.planSumAssured
            ..rider = c.rider
            ..planDate = DateTime.now()
        ];
      } else {
        _plans = [CustomerPlanItem()..planDate = DateTime.now()];
      }

      // References
      if (c.references.isNotEmpty) {
        _references = c.references
            .map((r) => CustomerReferenceItem()
              ..name = r.name
              ..mobile = r.mobile
              ..age = r.age)
            .toList();
      } else if (c.referenceFriendName != null || c.referenceMobile != null) {
        _references = [
          CustomerReferenceItem()
            ..name = c.referenceFriendName
            ..mobile = c.referenceMobile
            ..age = c.referenceAge
        ];
      } else {
        _references = [CustomerReferenceItem()];
      }

      // Reminders
      if (c.reminders.isNotEmpty) {
        _reminders = c.reminders
            .map((r) => CustomerReminderItem()
              ..reminderTitle = r.reminderTitle
              ..reminderDate = r.reminderDate ?? DateTime.now()
              ..note = r.note)
            .toList();
      } else {
        _reminders = [];
        if (c.reminderDate1 != null || c.reminderNote1 != null) {
          _reminders.add(CustomerReminderItem()..reminderDate = c.reminderDate1 ?? DateTime.now()..note = c.reminderNote1);
        }
        if (c.reminderDate2 != null || c.reminderNote2 != null) {
          _reminders.add(CustomerReminderItem()..reminderDate = c.reminderDate2 ?? DateTime.now()..note = c.reminderNote2);
        }
        if (c.reminderDate3 != null || c.reminderNote3 != null) {
          _reminders.add(CustomerReminderItem()..reminderDate = c.reminderDate3 ?? DateTime.now()..note = c.reminderNote3);
        }
        if (c.reminderDate4 != null || c.reminderNote4 != null) {
          _reminders.add(CustomerReminderItem()..reminderDate = c.reminderDate4 ?? DateTime.now()..note = c.reminderNote4);
        }
        if (c.reminderDate5 != null || c.reminderNote5 != null) {
          _reminders.add(CustomerReminderItem()..reminderDate = c.reminderDate5 ?? DateTime.now()..note = c.reminderNote5);
        }
        if (_reminders.isEmpty) {
          _reminders = [CustomerReminderItem()..reminderDate = DateTime.now()];
        }
      }
    } else {
      _plans = [CustomerPlanItem()..planDate = DateTime.now()];
      _references = [CustomerReferenceItem()];
      _reminders = [CustomerReminderItem()..reminderDate = DateTime.now()];
    }
  }

  bool _isNomineeMinor(String rel) {
    final norm = rel.trim().toLowerCase();
    return norm.contains('minor');
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    for (final controller in _dateControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  // Helper for Date pickers with separate DD, MM, YYYY boxes
  Widget _buildDateField(String key, String label, {Function(DateTime)? onDatePicked}) {
    final activePattern = ref.watch(dateFormatPatternProvider);
    final value = _dates[key];

    return SegmentedDateInputField(
      label: label,
      initialDate: value,
      pattern: activePattern,
      onDateChanged: (picked) {
        setState(() {
          _dates[key] = picked;
          if (picked != null && onDatePicked != null) {
            onDatePicked(picked);
          }
        });
      },
    );
  }

  Future<void> _pickDocument() async {
    final labels = [
      'Age Proof', 'ID Proof', 'Address Proof', 'Photo', 'School ID',
      'Form 16', 'Bank Statement', 'Bank Cheque 1', 'Bank Cheque 2',
      'Proposal Form 1', 'Proposal Form 2', 'Visiting Card', 'PAN Card Copy',
      'Other'
    ];
    String? selectedLabel = labels.first;

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Select document label:', style: TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(height: 8),
                  KeyCycleDropdownFormField<String>(
                    value: selectedLabel,
                    items: labels.map((l) => DropdownMenuItem(value: l, child: Text(l))).toList(),
                    onChanged: (val) {
                      setDialogState(() {
                        selectedLabel = val;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Document Type / Label',
                      hintText: 'Select document type',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
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
          final localFileName = '${DateTime.now().millisecondsSinceEpoch}_$customFileName';
          await AppStorageService.saveDocumentLocally(srcFile, localFileName);

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
    customer.customerId = _controllers['customerId']!.text.trim().isEmpty ? null : _controllers['customerId']!.text.trim();
    customer.familyId = _controllers['familyId']!.text.trim().isEmpty ? null : _controllers['familyId']!.text.trim();
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
    customer.nomineeRelationship = _dropdowns['nomineeRelationship']?.isEmpty ?? true ? null : _dropdowns['nomineeRelationship'];
    customer.nomineeFatherName = _controllers['nomineeFatherName']!.text;
    customer.nomineePan = _controllers['nomineePan']!.text;
    customer.nomineeMobile1 = _controllers['nomineeMobile1']!.text;
    customer.nomineeMobile2 = _controllers['nomineeMobile2']!.text;
    customer.nomineeEmail = _controllers['nomineeEmail']!.text;
    customer.appointeeName = _controllers['appointeeName']!.text.isEmpty ? null : _controllers['appointeeName']!.text;
    customer.appointeeRelationship = _dropdowns['appointeeRelationship']?.isEmpty ?? true ? null : _dropdowns['appointeeRelationship'];
    customer.appointeeOtherRelationship = _controllers['appointeeOtherRelationship']!.text.isEmpty ? null : _controllers['appointeeOtherRelationship']!.text;
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
    customer.childrenPolicyNumbers = List<String>.from(_childrenPolicyNumbers);
    customer.childrenCompanies = List<String>.from(_childrenCompanies);
    customer.childrenPolicyNumber = _childrenPolicyNumbers.where((s) => s.trim().isNotEmpty).join(', ');
    customer.childrenCompany = _childrenCompanies.where((s) => s.trim().isNotEmpty).join(', ');
    customer.hasExistingPolicy = _dropdowns['hasExistingPolicy'] ?? 'No';
    if (_dropdowns['hasExistingPolicy'] == 'Yes') {
      customer.existingSelfCompany = _dropdowns['existingSelfCompany']?.isEmpty ?? true ? null : _dropdowns['existingSelfCompany'];
      customer.existingPolicyNumber = _controllers['existingPolicyNumber']!.text.isEmpty ? null : _controllers['existingPolicyNumber']!.text;
      customer.existingDocDate = _dates['existingDocDate'];
    } else {
      customer.existingSelfCompany = null;
      customer.existingPolicyNumber = null;
      customer.existingDocDate = null;
    }
    customer.healthProblems = _controllers['healthProblems']!.text;
    customer.pregnancyDetails = _controllers['pregnancyDetails']!.text;
    customer.healthRemarks = _controllers['healthRemarks']!.text;
    customer.hasPersonalAccident = _dropdowns['hasPersonalAccident'] ?? 'No';
    if (_dropdowns['hasPersonalAccident'] == 'Yes') {
      customer.personalAccidentDate = _dates['personalAccidentDate'];
    } else {
      customer.personalAccidentDate = null;
    }
    customer.communicationAddress = _controllers['communicationAddress']!.text;
    customer.plans = _plans;
    if (_plans.isNotEmpty) {
      customer.productName = _plans.first.productName;
      customer.premiumMode = _plans.first.mode;
      customer.planSumAssured = _plans.first.planSumAssured;
      customer.rider = _plans.first.rider;
    }
    customer.riskCover = _controllers['riskCover']!.text;
    customer.pensionPlan = _controllers['pensionPlan']!.text;
    customer.investmentPlan = _controllers['investmentPlan']!.text;
    customer.mutualFunds = _controllers['mutualFunds']!.text;
    customer.mediClaim = _controllers['mediClaim']!.text;
    customer.moneyBackPolicy = _controllers['moneyBackPolicy']!.text;
    customer.childrenEducationPlan = _controllers['childrenEducationPlan']!.text;
    customer.references = _references;
    if (_references.isNotEmpty) {
      customer.referenceFriendName = _references.first.name;
      customer.referenceMobile = _references.first.mobile;
      customer.referenceAge = _references.first.age;
    }
    customer.reminders = _reminders;
    customer.reminderDate1 = _reminders.isNotEmpty ? _reminders[0].reminderDate : null;
    customer.reminderNote1 = _reminders.isNotEmpty ? _reminders[0].note : null;
    customer.reminderDate2 = _reminders.length > 1 ? _reminders[1].reminderDate : null;
    customer.reminderNote2 = _reminders.length > 1 ? _reminders[1].note : null;
    customer.reminderDate3 = _reminders.length > 2 ? _reminders[2].reminderDate : null;
    customer.reminderNote3 = _reminders.length > 2 ? _reminders[2].note : null;
    customer.reminderDate4 = _reminders.length > 3 ? _reminders[3].reminderDate : null;
    customer.reminderNote4 = _reminders.length > 3 ? _reminders[3].note : null;
    customer.reminderDate5 = _reminders.length > 4 ? _reminders[4].reminderDate : null;
    customer.reminderNote5 = _reminders.length > 4 ? _reminders[4].note : null;
    customer.notes = _controllers['notes']!.text;

    // Date assignments
    customer.dateOfBirth = _dates['dateOfBirth'];
    customer.age = _controllers['age']?.text.trim().isNotEmpty == true
        ? _controllers['age']!.text.trim()
        : _calculateAgeString(_dates['dateOfBirth']);
    customer.fatherDOB = _dates['fatherDOB'];
    customer.motherDOB = _dates['motherDOB'];
    customer.spouseDOB = _dates['spouseDOB'];
    customer.childrenDOBs = _childrenDOBs.where((d) => d != null).cast<DateTime>().toList();
    customer.familyDOB = null; // Removed in favor of individual DOBs
    customer.weddingAnniversary = _dates['weddingAnniversary'];
    customer.nomineeDOB = _dates['nomineeDOB'];
    customer.nomineeAge = _controllers['nomineeAge']?.text.trim().isNotEmpty == true
        ? _controllers['nomineeAge']!.text.trim()
        : _calculateAgeString(_dates['nomineeDOB']);
    customer.appointeeDOB = _dates['appointeeDOB'];
    customer.appointeeAge = _controllers['appointeeAge']?.text.trim().isNotEmpty == true
        ? _controllers['appointeeAge']!.text.trim()
        : _calculateAgeString(_dates['appointeeDOB']);

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
  Widget _buildField(
    String key,
    String label, {
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    bool required = false,
    Function(String)? onChanged,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? customValidator,
  }) {
    final isMultiLine = maxLines > 1;
    final isMobileKey = key.toLowerCase().contains('mobile');
    final effectiveFormatters = inputFormatters ??
        (key == 'aadhaarNumber'
            ? [AadhaarNumberFormatter()]
            : isMobileKey
                ? [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(10)]
                : null);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
      child: TextFormField(
        controller: _controllers[key],
        keyboardType: isMultiLine
            ? TextInputType.multiline
            : (key == 'aadhaarNumber'
                ? TextInputType.number
                : isMobileKey
                    ? TextInputType.number
                    : keyboardType),
        maxLines: maxLines,
        inputFormatters: effectiveFormatters,
        textInputAction: isMultiLine ? TextInputAction.newline : TextInputAction.next,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          hintText: key == 'aadhaarNumber'
              ? '1234 5678 9012'
              : isMobileKey
                  ? 'e.g. 9876543210'
                  : null,
          border: const OutlineInputBorder(),
          isDense: true,
          errorStyle: const TextStyle(height: 0.8),
        ),
        validator: (value) {
          if (required && (value == null || value.trim().isEmpty)) {
            return '$label is required';
          }
          if (key == 'aadhaarNumber' && value != null && value.trim().isNotEmpty) {
            final digits = value.trim().replaceAll(RegExp(r'\D'), '');
            if (digits.length != 12) {
              return 'Aadhaar Number must be exactly 12 digits';
            }
          }
          if (isMobileKey && value != null && value.trim().isNotEmpty) {
            final digits = value.trim().replaceAll(RegExp(r'\D'), '');
            if (digits.length != 10) {
              return '$label must be 10 digits';
            }
          }
          if (customValidator != null) {
            return customValidator(value);
          }
          return null;
        },
      ),
    );
  }



  // Helper for Dropdowns (safely handles custom or legacy company values)
  Widget _buildDropdownField(String key, String label, List<String> options) {
    final value = _dropdowns[key] ?? '';
    final effectiveOptions = List<String>.from(options);
    if (value.isNotEmpty && !effectiveOptions.contains(value)) {
      effectiveOptions.insert(0, value);
    }
    final items = effectiveOptions.map((o) => DropdownMenuItem(value: o, child: Text(o))).toList();
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
      child: KeyCycleDropdownFormField<String>(
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

  // Helper for Responsive Layout Rows (side-by-side on desktop, stacked on mobile)
  Widget _buildResponsiveRow(bool isDesktop, List<Widget> fields) {
    if (isDesktop) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: fields.map((f) => Expanded(child: f)).toList(),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: fields,
      );
    }
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
      child: Material(
        color: Colors.transparent,
        child: ExpansionTile(
          leading: Icon(icon, color: Colors.blueAccent),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          initiallyExpanded: false, // ALL COLLAPSED AS REQUESTED
          childrenPadding: const EdgeInsets.all(12.0),
          expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
          children: children,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.customer != null;
    final double width = MediaQuery.of(context).size.width;
    final isDesktop = width > 800;

    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Customer Profile' : 'Add New Customer', style: const TextStyle(color: AppColors.headingText, fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.cardSurface,
        actions: [
          IconButton(
            icon: const Icon(Icons.check, color: AppColors.skyBlue),
            tooltip: 'Save',
            onPressed: _saveForm,
          ),
        ],
      ),
      body: BrandBackground(
        child: Form(
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
                  child: _buildResponsiveRow(isDesktop, [
                    _buildField('name', 'Full Name *', required: true),
                    _buildField('customerId', 'Customer ID (e.g. CUST-001)'),
                    _buildField('familyId', 'Family ID (e.g. FAM-101)'),
                  ]),
                ),
              ),
              const SizedBox(height: 12),

              // Accordion 1: Personal Details
              _buildAccordionSection('Personal Details', Icons.person_outline, [
                _buildResponsiveRow(isDesktop, [
                  _buildField('fatherName', "Proposer’s Name"),
                  _buildDateField('dateOfBirth', 'Date of Birth', onDatePicked: (picked) {
                    _controllers['age']!.text = _calculateAgeString(picked);
                  }),
                  _buildField('age', 'Age', keyboardType: TextInputType.number),
                ]),
                _buildResponsiveRow(isDesktop, [
                  _buildDropdownField('maritalStatus', 'Marital Status', ['Single', 'Married', 'Divorced', 'Widowed']),
                  _buildField('spouseName', 'Spouse Name'),
                ]),
                _buildResponsiveRow(isDesktop, [
                  _buildField('nationality', 'Nationality'),
                  _buildField('aadhaarNumber', 'Aadhaar Number', keyboardType: TextInputType.number),
                ]),
                _buildResponsiveRow(isDesktop, [
                  _buildField('qualification', 'Qualification'),
                  _buildField('height', 'Height'),
                  _buildField('weight', 'Weight'),
                ]),
              ]),

              // Accordion 2: Family Details
              _buildAccordionSection('Family Details', Icons.family_restroom_outlined, [
                _buildResponsiveRow(isDesktop, [
                  _buildDateField('fatherDOB', "Father's DOB", onDatePicked: (picked) {
                    _controllers['fatherAge']!.text = _calculateAgeString(picked);
                  }),
                  _buildField('fatherAge', "Father's Age", keyboardType: TextInputType.number),
                ]),
                _buildResponsiveRow(isDesktop, [
                  _buildDateField('motherDOB', "Mother's DOB", onDatePicked: (picked) {
                    _controllers['motherAge']!.text = _calculateAgeString(picked);
                  }),
                  _buildField('motherAge', "Mother's Age", keyboardType: TextInputType.number),
                ]),
                _buildResponsiveRow(isDesktop, [
                  _buildDateField('spouseDOB', "Spouse's DOB", onDatePicked: (picked) {
                    _controllers['spouseAge']!.text = _calculateAgeString(picked);
                  }),
                  _buildField('spouseAge', "Spouse's Age", keyboardType: TextInputType.number),
                ]),
                _buildResponsiveRow(isDesktop, [
                  _buildField('brotherAge', "Brother's Age", keyboardType: TextInputType.number),
                  _buildField('sisterAge', "Sister's Age", keyboardType: TextInputType.number),
                ]),
                _buildField(
                  'numberOfChildren',
                  'Number of Children',
                  keyboardType: TextInputType.number,
                  onChanged: (val) {
                    final count = int.tryParse(val) ?? 0;
                    setState(() {
                      while (_childrenDOBs.length < count) {
                        _childrenDOBs.add(null);
                      }
                      if (_childrenDOBs.length > count) {
                        _childrenDOBs = _childrenDOBs.sublist(0, count);
                      }

                      while (_childrenPolicyNumbers.length < count) {
                        _childrenPolicyNumbers.add('');
                      }
                      if (_childrenPolicyNumbers.length > count) {
                        _childrenPolicyNumbers = _childrenPolicyNumbers.sublist(0, count);
                      }

                      while (_childrenCompanies.length < count) {
                        _childrenCompanies.add('');
                      }
                      if (_childrenCompanies.length > count) {
                        _childrenCompanies = _childrenCompanies.sublist(0, count);
                      }
                    });
                  },
                ),
                if ((int.tryParse(_controllers['numberOfChildren']?.text ?? '0') ?? 0) > 0) ...[
                  const SizedBox(height: 8),
                  ...List.generate(int.tryParse(_controllers['numberOfChildren']?.text ?? '0') ?? 0, (index) {
                    final DateTime? childDob = index < _childrenDOBs.length ? _childrenDOBs[index] : null;
                    final String childAge = _calculateAgeString(childDob);
                    final dateText = childDob == null ? '' : DateFormat('dd MMM yyyy').format(childDob);

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: _buildResponsiveRow(isDesktop, [
                        SegmentedDateInputField(
                          label: 'Child ${index + 1} DOB',
                          initialDate: childDob,
                          pattern: ref.watch(dateFormatPatternProvider),
                          onDateChanged: (picked) {
                            setState(() {
                              while (_childrenDOBs.length <= index) {
                                _childrenDOBs.add(null);
                              }
                              _childrenDOBs[index] = picked;
                            });
                          },
                        ),
                        InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'Child ${index + 1} Age',
                            border: const OutlineInputBorder(),
                            isDense: true,
                            filled: true,
                            fillColor: Colors.grey.shade100,
                          ),
                          child: Text(
                            childAge.isEmpty ? '' : childAge,
                            style: TextStyle(
                              fontWeight: childAge.isNotEmpty ? FontWeight.w500 : FontWeight.normal,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ]),
                    );
                  }),
                ],
              ]),

              // Accordion 3: Professional Details
              _buildAccordionSection('Professional Information', Icons.business_center_outlined, [
                _buildField('employerBusinessName', 'Employer / Business Name'),
                _buildResponsiveRow(isDesktop, [
                  _buildField('designation', 'Designation'),
                  _buildField('natureOfBusiness', 'Nature of Business / Occupation'),
                ]),
                _buildField('annualIncome', 'Annual Income', keyboardType: TextInputType.number),
              ]),

              // Accordion 4: Contact Information
              _buildAccordionSection('Contact Details', Icons.call_outlined, [
                _buildResponsiveRow(isDesktop, [
                  _buildField('mobileNumber1', 'Mobile Number 1', keyboardType: TextInputType.phone),
                  _buildField('mobileNumber2', 'Mobile Number 2', keyboardType: TextInputType.phone),
                ]),
                _buildResponsiveRow(isDesktop, [
                  _buildField('mobileNumber3', 'Mobile Number 3', keyboardType: TextInputType.phone),
                  _buildField('mobileNumber4', 'Mobile Number 4', keyboardType: TextInputType.phone),
                ]),
                _buildResponsiveRow(isDesktop, [
                  _buildField('officeContactNumber', 'Office Contact', keyboardType: TextInputType.phone),
                  _buildField('emailId', 'Email ID', keyboardType: TextInputType.emailAddress),
                ]),
              ]),

              // Accordion 5: Address Information
              _buildAccordionSection('Address Details', Icons.home_outlined, [
                _buildField('communicationAddress', 'Communication Address', maxLines: 3),
                const SizedBox(height: 8),
                _buildField('permanentAddress', 'Permanent Address', maxLines: 3),
              ]),

              // Accordion 6: Nominee Information
              _buildAccordionSection('Nominee Details', Icons.badge_outlined, [
                _buildResponsiveRow(isDesktop, [
                  _buildField('nomineeName', 'Nominee Name'),
                  _buildDropdownField('nomineeRelationship', 'Relationship', [
                    'Spouse',
                    'Father',
                    'Mother',
                    'Brother',
                    'Sister',
                    'Son',
                    'Daughter',
                    'Minor Son',
                    'Minor Daughter',
                    'Minor Brother',
                    'Minor Sister',
                    'Other',
                  ]),
                ]),
                _buildResponsiveRow(isDesktop, [
                  _buildDateField('nomineeDOB', 'Nominee DOB', onDatePicked: (picked) {
                    _controllers['nomineeAge']!.text = _calculateAgeString(picked);
                  }),
                  _buildField('nomineeAge', 'Nominee Age', keyboardType: TextInputType.number),
                  _buildField('nomineeFatherName', "Nominee's Father's Name"),
                ]),
                _buildField('nomineePan', 'Nominee PAN'),
                _buildResponsiveRow(isDesktop, [
                  _buildField('nomineeMobile1', 'Nominee Mobile 1', keyboardType: TextInputType.phone),
                  _buildField('nomineeMobile2', 'Nominee Mobile 2', keyboardType: TextInputType.phone),
                ]),
                _buildField('nomineeEmail', 'Nominee Email', keyboardType: TextInputType.emailAddress),
                if (_isNomineeMinor(_dropdowns['nomineeRelationship'] ?? '')) ...[
                  const SizedBox(height: 12),
                  const Divider(),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      'Appointee Details (Nominee is Minor)',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.blueAccent),
                    ),
                  ),
                  _buildResponsiveRow(isDesktop, [
                    _buildField('appointeeName', 'Appointee Name'),
                    _buildDateField('appointeeDOB', 'Appointee DOB', onDatePicked: (picked) {
                      _controllers['appointeeAge']!.text = _calculateAgeString(picked);
                    }),
                    _buildField('appointeeAge', 'Appointee Age', keyboardType: TextInputType.number),
                  ]),
                  _buildDropdownField('appointeeRelationship', 'Appointee Relationship', [
                    'Father', 'Mother', 'Other'
                  ]),
                  if ((_dropdowns['appointeeRelationship'] ?? '').toLowerCase() == 'other')
                    _buildField('appointeeOtherRelationship', 'Type Appointee Relationship'),
                ],
              ]),

              // Accordion 7: Insurance Policy Details
              _buildAccordionSection('Insurance Details', Icons.security_outlined, [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: _buildDropdownField('selfCompany', 'Self Assigned Company', _insuranceCompanies),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 4.0, top: 4.0),
                      child: OutlinedButton.icon(
                        onPressed: _showAddInsuranceCompanyDialog,
                        icon: const Icon(Icons.add, size: 18),
                        label: const Text('Add'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0, top: 4.0),
                      child: OutlinedButton.icon(
                        onPressed: _showManageInsuranceCompaniesDialog,
                        icon: const Icon(Icons.settings_outlined, size: 18),
                        label: const Text('Manage'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ),
                  ],
                ),
                _buildResponsiveRow(isDesktop, [
                  _buildField('selfPolicyNumber', 'Self Policy Number'),
                  _buildField('selfYearOfIssue', 'Year of Issue'),
                ]),
                _buildResponsiveRow(isDesktop, [
                  _buildField('selfSumAssured1', 'Sum Assured 1'),
                  _buildField('selfSumAssured2', 'Sum Assured 2'),
                ]),
                _buildDropdownField('premiumMode', 'Mode (Yearly / Half-Yearly / Quarterly / Monthly)', ['Yearly', 'Half-Yearly', 'Quarterly', 'Monthly']),
                const Divider(height: 24),
                _buildResponsiveRow(isDesktop, [
                  _buildField('fatherPolicyNumber', 'Father Policy Number'),
                  _buildDropdownField('fatherCompany', 'Father Company', _insuranceCompanies),
                ]),
                _buildResponsiveRow(isDesktop, [
                  _buildField('motherPolicyNumber', 'Mother Policy Number'),
                  _buildDropdownField('motherCompany', 'Mother Company', _insuranceCompanies),
                ]),
                _buildResponsiveRow(isDesktop, [
                  _buildField('spousePolicyNumber', 'Spouse Policy Number'),
                  _buildDropdownField('spouseCompany', 'Spouse Company', _insuranceCompanies),
                ]),
                Builder(
                  builder: (context) {
                    final count = int.tryParse(_controllers['numberOfChildren']?.text ?? '0') ?? 0;
                    final effectiveCount = count > 0 ? count : 1;

                    while (_childrenPolicyNumbers.length < effectiveCount) {
                      _childrenPolicyNumbers.add('');
                    }
                    while (_childrenCompanies.length < effectiveCount) {
                      _childrenCompanies.add('');
                    }

                    return Column(
                      children: List.generate(effectiveCount, (index) {
                        final childLabel = count > 1 ? 'Child ${index + 1}' : (count == 1 ? 'Child 1' : 'Children');
                        final initialPol = index < _childrenPolicyNumbers.length ? _childrenPolicyNumbers[index] : '';
                        final initialComp = index < _childrenCompanies.length ? _childrenCompanies[index] : '';

                        final effectiveCompOptions = List<String>.from(_insuranceCompanies);
                        if (initialComp.isNotEmpty && !effectiveCompOptions.contains(initialComp)) {
                          effectiveCompOptions.insert(0, initialComp);
                        }

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: _buildResponsiveRow(isDesktop, [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
                              child: TextFormField(
                                key: ValueKey('child_pol_${index}_$effectiveCount'),
                                initialValue: initialPol,
                                decoration: InputDecoration(
                                  labelText: '$childLabel Policy Number',
                                  border: const OutlineInputBorder(),
                                  isDense: true,
                                ),
                                onChanged: (val) {
                                  while (_childrenPolicyNumbers.length <= index) {
                                    _childrenPolicyNumbers.add('');
                                  }
                                  _childrenPolicyNumbers[index] = val;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
                              child: KeyCycleDropdownFormField<String>(
                                key: ValueKey('child_comp_${index}_$effectiveCount'),
                                value: initialComp.isEmpty ? null : initialComp,
                                items: effectiveCompOptions.map((o) => DropdownMenuItem(value: o, child: Text(o))).toList(),
                                onChanged: (val) {
                                  setState(() {
                                    while (_childrenCompanies.length <= index) {
                                      _childrenCompanies.add('');
                                    }
                                    _childrenCompanies[index] = val ?? '';
                                  });
                                },
                                decoration: InputDecoration(
                                  labelText: '$childLabel Company',
                                  border: const OutlineInputBorder(),
                                  isDense: true,
                                ),
                              ),
                            ),
                          ]),
                        );
                      }),
                    );
                  },
                ),
                const Divider(height: 24),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    'Existing Insurance Policy Details',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.blueAccent),
                  ),
                ),
                _buildDropdownField('hasExistingPolicy', 'Existing Insurance Policy?', ['No', 'Yes']),
                if (_dropdowns['hasExistingPolicy'] == 'Yes') ...[
                  const SizedBox(height: 8),
                  _buildDropdownField('existingSelfCompany', 'Existing Self-Assigned Company', _insuranceCompanies),
                  _buildResponsiveRow(isDesktop, [
                    _buildField('existingPolicyNumber', 'Existing Policy Number'),
                    _buildDateField('existingDocDate', 'DOC (Date of Commencement)'),
                  ]),
                ],
              ]),

              // Accordion 8: Health Details
              _buildAccordionSection('Health Details', Icons.health_and_safety_outlined, [
                _buildField('healthProblems', 'Health Problems', maxLines: 3),
                _buildDropdownField('lifestyleHabits', 'Lifestyle Habits', ['None', 'Smoking', 'Drinking', 'Both']),
                _buildField('pregnancyDetails', 'Pregnancy Details (If applicable)', maxLines: 3),
                _buildField('healthRemarks', 'Other Remarks', maxLines: 3),
                const Divider(height: 24),
                _buildDropdownField('hasPersonalAccident', 'Personal Accident Cover?', ['No', 'Yes']),
                if (_dropdowns['hasPersonalAccident'] == 'Yes') ...[
                  const SizedBox(height: 8),
                  _buildDateField('personalAccidentDate', 'Date of Commencement (DOC)'),
                ],
              ]),

              // Accordion 9: Plan Information
              _buildAccordionSection('Plan Details', Icons.article_outlined, [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _plans.length,
                  itemBuilder: (context, index) {
                    final plan = _plans[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Colors.blueAccent.withOpacity(0.3)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    initialValue: plan.planTitle ?? 'Plan #${index + 1}',
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.blueAccent),
                                    decoration: const InputDecoration(
                                      isDense: true,
                                      border: InputBorder.none,
                                      hintText: 'Type Plan Title...',
                                      suffixIcon: Icon(Icons.edit_outlined, size: 16, color: Colors.blueAccent),
                                    ),
                                    onChanged: (val) => plan.planTitle = val,
                                  ),
                                ),
                                if (_plans.length > 1)
                                  IconButton(
                                    icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                                    tooltip: 'Remove Plan',
                                    onPressed: () {
                                      setState(() {
                                        _plans.removeAt(index);
                                      });
                                    },
                                  ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              initialValue: plan.productName,
                              decoration: const InputDecoration(
                                labelText: 'Product Name',
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (val) => plan.productName = val,
                            ),
                            const SizedBox(height: 12),
                            _buildResponsiveRow(isDesktop, [
                              TextFormField(
                                initialValue: plan.premium,
                                decoration: const InputDecoration(
                                  labelText: 'Premium',
                                  hintText: 'e.g. ₹ 15,000',
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (val) => plan.premium = val,
                              ),
                              KeyCycleDropdownFormField<String>(
                                value: (plan.mode != null && ['Yearly', 'Half-Yearly', 'Quarterly', 'Monthly', 'Single', 'Other'].contains(plan.mode))
                                    ? plan.mode
                                    : null,
                                decoration: const InputDecoration(
                                  labelText: 'Mode',
                                  border: OutlineInputBorder(),
                                ),
                                items: ['Yearly', 'Half-Yearly', 'Quarterly', 'Monthly', 'Single', 'Other']
                                    .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                                    .toList(),
                                onChanged: (val) => setState(() => plan.mode = val),
                              ),
                            ]),
                            const SizedBox(height: 12),
                            _buildResponsiveRow(isDesktop, [
                              TextFormField(
                                initialValue: plan.planSumAssured,
                                decoration: const InputDecoration(
                                  labelText: 'Plan Sum Assured',
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (val) => plan.planSumAssured = val,
                              ),
                              TextFormField(
                                initialValue: plan.rider,
                                decoration: const InputDecoration(
                                  labelText: 'Riders Configured',
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (val) => plan.rider = val,
                              ),
                            ]),
                            const SizedBox(height: 12),
                            SegmentedDateInputField(
                              label: 'Plan Date',
                              initialDate: plan.planDate ??= DateTime.now(),
                              pattern: ref.watch(dateFormatPatternProvider),
                              onDateChanged: (picked) {
                                setState(() {
                                  plan.planDate = picked;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _plans.add(CustomerPlanItem()..planDate = DateTime.now());
                    });
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Plan'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ]),

              // Accordion 10: Plan & Mutual Funds
              _buildAccordionSection('Plan & Mutual Funds', Icons.account_balance_outlined, [
                _buildField('panNumber', 'Plan Name'),
                _buildResponsiveRow(isDesktop, [
                  _buildField('riskCover', 'Risk Cover'),
                  _buildField('pensionPlan', 'Pension Plan'),
                ]),
                _buildResponsiveRow(isDesktop, [
                  _buildField('investmentPlan', 'Investment Plan'),
                  _buildField('mutualFunds', 'Mutual Funds'),
                ]),
                _buildResponsiveRow(isDesktop, [
                  _buildField('mediClaim', 'Mediclaim'),
                  _buildField('moneyBackPolicy', 'Money Back Policy'),
                ]),
                _buildField('childrenEducationPlan', "Children's Education Plan"),
              ]),

              // Accordion 11: Reminders
              _buildAccordionSection('Reminders', Icons.alarm_outlined, [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _reminders.length,
                  itemBuilder: (context, index) {
                    final reminder = _reminders[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Colors.orangeAccent.withOpacity(0.3)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    initialValue: reminder.reminderTitle ?? 'Reminder #${index + 1}',
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.orangeAccent),
                                    decoration: const InputDecoration(
                                      isDense: true,
                                      border: InputBorder.none,
                                      hintText: 'Type Reminder Title...',
                                      suffixIcon: Icon(Icons.edit_outlined, size: 16, color: Colors.orangeAccent),
                                    ),
                                    onChanged: (val) => reminder.reminderTitle = val,
                                  ),
                                ),
                                if (_reminders.length > 1)
                                  IconButton(
                                    icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                                    tooltip: 'Remove Reminder',
                                    onPressed: () {
                                      setState(() {
                                        _reminders.removeAt(index);
                                      });
                                    },
                                  ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            SegmentedDateInputField(
                              label: 'Reminder Date',
                              initialDate: reminder.reminderDate ??= DateTime.now(),
                              pattern: ref.watch(dateFormatPatternProvider),
                              onDateChanged: (picked) {
                                setState(() {
                                  reminder.reminderDate = picked;
                                });
                              },
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              initialValue: reminder.note,
                              maxLines: 3,
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.newline,
                              decoration: const InputDecoration(
                                labelText: 'Reminder Remarks / Details',
                                hintText: 'Enter reminder details...',
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (val) => reminder.note = val,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _reminders.add(CustomerReminderItem()..reminderDate = DateTime.now());
                    });
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Reminder'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ]),

              // Accordion 12: Reference Details
              _buildAccordionSection('References', Icons.people_outline, [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _references.length,
                  itemBuilder: (context, index) {
                    final refItem = _references[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Colors.blueAccent.withOpacity(0.3)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Reference #${index + 1}',
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.blueAccent),
                                ),
                                if (_references.length > 1)
                                  IconButton(
                                    icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                                    tooltip: 'Remove Reference #${index + 1}',
                                    onPressed: () {
                                      setState(() {
                                        _references.removeAt(index);
                                      });
                                    },
                                  ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              initialValue: refItem.name,
                              decoration: const InputDecoration(
                                labelText: 'Reference / Friend Name',
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (val) => refItem.name = val,
                            ),
                            const SizedBox(height: 12),
                            _buildResponsiveRow(isDesktop, [
                              TextFormField(
                                initialValue: refItem.mobile,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(10),
                                ],
                                decoration: const InputDecoration(
                                  labelText: 'Mobile Number',
                                  hintText: 'e.g. 9876543210',
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                                validator: (val) {
                                  if (val != null && val.trim().isNotEmpty) {
                                    final digits = val.trim().replaceAll(RegExp(r'\D'), '');
                                    if (digits.length != 10) {
                                      return 'Mobile Number must be 10 digits';
                                    }
                                  }
                                  return null;
                                },
                                onChanged: (val) => refItem.mobile = val,
                              ),
                              TextFormField(
                                initialValue: refItem.age,
                                decoration: const InputDecoration(
                                  labelText: 'Age',
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                                onChanged: (val) => refItem.age = val,
                              ),
                            ]),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _references.add(CustomerReferenceItem());
                    });
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Reference'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
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
                      return Material(
                        color: Colors.transparent,
                        child: ListTile(
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
    ),
    );
  }
}
