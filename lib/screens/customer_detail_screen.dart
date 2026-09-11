import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../models/customer.dart';
import '../services/database_service.dart';
import '../services/app_storage_service.dart';
import '../services/dashboard_export_service.dart';
import 'customer_form_screen.dart';
import '../providers/customer_provider.dart';
import '../providers/events_provider.dart';
import '../providers/settings_provider.dart';
import '../widgets/segmented_date_input_field.dart';
import '../theme/app_colors.dart';
import '../widgets/color_badge.dart';
import '../widgets/brand_background.dart';
import '../widgets/key_cycle_dropdown.dart';

class CustomerDetailScreen extends ConsumerStatefulWidget {
  final int customerId;

  const CustomerDetailScreen({super.key, required this.customerId});

  @override
  ConsumerState<CustomerDetailScreen> createState() => _CustomerDetailScreenState();
}

class _CustomerDetailScreenState extends ConsumerState<CustomerDetailScreen> {
  Customer? _customer;
  bool _isLoading = true;
  String? _localDocsDirPath;

  @override
  void initState() {
    super.initState();
    _loadCustomerData();
    _initLocalDirPath();
  }

  void _initLocalDirPath() async {
    final docsDir = await AppStorageService.getCustomerDocumentsDirectory();
    if (mounted) {
      setState(() {
        _localDocsDirPath = docsDir.path;
      });
    }
  }

  void _loadCustomerData() async {
    setState(() => _isLoading = true);
    final db = ref.read(databaseServiceProvider);
    final cust = await db.getCustomerById(widget.customerId);
    setState(() {
      _customer = cust;
      _isLoading = false;
    });
  }

  void _showAddPlanDialog(Customer c) {
    final planTitleCtrl = TextEditingController(text: 'Plan #${c.plans.length + 1}');
    final productNameCtrl = TextEditingController();
    final premiumCtrl = TextEditingController();
    final sumAssuredCtrl = TextEditingController();
    final riderCtrl = TextEditingController();
    String mode = 'Yearly';
    DateTime selectedPlanDate = DateTime.now();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            final activePattern = ref.watch(dateFormatPatternProvider);
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              title: Row(
                children: [
                  const Icon(Icons.add_card, color: Colors.blueAccent),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Add New Plan for ${c.name}',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: planTitleCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Plan Header Title',
                        hintText: 'e.g. Plan #1 or Jeevan Anand',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: productNameCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Product Name',
                        hintText: 'e.g. LIC Jeevan Labh',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: premiumCtrl,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Premium',
                              hintText: 'e.g. ₹ 15,000',
                              border: OutlineInputBorder(),
                              isDense: true,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: KeyCycleDropdownFormField<String>(
                            value: mode,
                            decoration: const InputDecoration(
                              labelText: 'Mode',
                              border: OutlineInputBorder(),
                              isDense: true,
                            ),
                            items: ['Yearly', 'Half-Yearly', 'Quarterly', 'Monthly', 'Single', 'Other']
                                .map((m) => DropdownMenuItem(value: m, child: Text(m, style: const TextStyle(fontSize: 13))))
                                .toList(),
                            onChanged: (val) {
                              if (val != null) {
                                setDialogState(() => mode = val);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: sumAssuredCtrl,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Plan Sum Assured',
                              border: OutlineInputBorder(),
                              isDense: true,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: riderCtrl,
                            decoration: const InputDecoration(
                              labelText: 'Riders Configured',
                              border: OutlineInputBorder(),
                              isDense: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SegmentedDateInputField(
                      label: 'Plan Date',
                      initialDate: selectedPlanDate,
                      pattern: activePattern,
                      onDateChanged: (picked) {
                        if (picked != null) {
                          setDialogState(() => selectedPlanDate = picked);
                        }
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.check, size: 18),
                  label: const Text('Save New Plan'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    final newPlan = CustomerPlanItem()
                      ..planTitle = planTitleCtrl.text.trim().isNotEmpty ? planTitleCtrl.text.trim() : null
                      ..productName = productNameCtrl.text.trim().isNotEmpty ? productNameCtrl.text.trim() : null
                      ..premium = premiumCtrl.text.trim().isNotEmpty ? premiumCtrl.text.trim() : null
                      ..mode = mode
                      ..planSumAssured = sumAssuredCtrl.text.trim().isNotEmpty ? sumAssuredCtrl.text.trim() : null
                      ..rider = riderCtrl.text.trim().isNotEmpty ? riderCtrl.text.trim() : null
                      ..planDate = selectedPlanDate;

                    final updatedPlans = List<CustomerPlanItem>.from(c.plans)..add(newPlan);
                    c.plans = updatedPlans;
                    c.updatedAt = DateTime.now();

                    final db = ref.read(databaseServiceProvider);
                    await db.saveCustomer(c);
                    ref.invalidate(customerListProvider);

                    if (mounted) {
                      Navigator.pop(context);
                      _loadCustomerData();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('New Plan added to customer profile!')),
                      );
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _confirmDeletePlan(Customer c, int index) {
    final planName = (index >= 0 && index < c.plans.length && c.plans[index].planTitle != null && c.plans[index].planTitle!.isNotEmpty)
        ? c.plans[index].planTitle!
        : (c.productName != null && c.productName!.isNotEmpty ? c.productName! : 'Plan #${index >= 0 ? index + 1 : 1}');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.redAccent),
            SizedBox(width: 8),
            Text('Delete Plan'),
          ],
        ),
        content: Text('Are you sure you want to delete "$planName"?'),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, foregroundColor: Colors.white),
            onPressed: () async {
              if (c.plans.isNotEmpty && index >= 0 && index < c.plans.length) {
                c.plans = List<CustomerPlanItem>.from(c.plans)..removeAt(index);
              }
              if (c.plans.isEmpty) {
                c.productName = null;
                c.premiumMode = null;
                c.planSumAssured = null;
                c.rider = null;
              }
              c.updatedAt = DateTime.now();

              final db = ref.read(databaseServiceProvider);
              await db.saveCustomer(c);
              ref.invalidate(customerListProvider);

              if (mounted) {
                Navigator.pop(context);
                _loadCustomerData();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('"$planName" has been deleted.')),
                );
              }
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    if (value == null || value.trim().isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: const TextStyle(color: AppColors.mutedText, fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: AppColors.headingText),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateRow(String label, DateTime? date) {
    if (date == null) return const SizedBox.shrink();
    final activePattern = ref.watch(dateFormatPatternProvider);
    return _buildDetailRow(label, DateFormat(activePattern).format(date));
  }

  String? _calculateAgeText(DateTime? dob) {
    if (dob == null) return null;
    final now = DateTime.now();
    int age = now.year - dob.year;
    if (now.month < dob.month || (now.month == dob.month && now.day < dob.day)) {
      age--;
    }
    return age < 0 ? '0 years' : '$age years';
  }

  Widget _buildDobAndAgeRow(String label, DateTime? dob, String? manualAge) {
    if (dob == null && (manualAge == null || manualAge.trim().isEmpty)) {
      return const SizedBox.shrink();
    }
    final activePattern = ref.watch(dateFormatPatternProvider);
    final dobStr = dob != null ? DateFormat(activePattern).format(dob) : null;
    final calcAge = _calculateAgeText(dob);
    final displayAge = calcAge ?? (manualAge != null && manualAge.trim().isNotEmpty ? '$manualAge years' : null);

    String valueStr = '';
    if (dobStr != null && displayAge != null) {
      valueStr = '$dobStr ($displayAge)';
    } else if (dobStr != null) {
      valueStr = dobStr;
    } else if (displayAge != null) {
      valueStr = displayAge;
    }

    return _buildDetailRow(label, valueStr);
  }

  Widget _buildAccordionSection(String title, IconData icon, List<Widget> rows) {
    // Filter out empty/null rows to avoid rendering empty boxes
    final validRows = rows.where((r) => r is! SizedBox).toList();
    if (validRows.isEmpty) return const SizedBox.shrink();

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8.0),
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: AppColors.cardBorder),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: Colors.transparent,
        child: ExpansionTile(
          leading: Icon(icon, color: AppColors.skyBlue),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.headingText)),
          initiallyExpanded: false, // ALL COLLAPSED AS REQUESTED
          childrenPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          children: validRows,
        ),
      ),
    );
  }

  Future<void> _downloadCustomerDocument(CustomerDocument doc) async {
    if (_localDocsDirPath == null || doc.fileName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Document path unavailable.')),
      );
      return;
    }
    final file = File('$_localDocsDirPath/${doc.fileName}');
    if (!file.existsSync()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Document file not found on this device.')),
      );
      return;
    }

    try {
      final bytes = await file.readAsBytes();
      final fileName = doc.fileName ?? 'customer_document.pdf';
      await DashboardExportService.saveAndDownloadPdf(bytes, fileName, context: context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to download document: $e')),
        );
      }
    }
  }

  void _previewDocument(CustomerDocument doc) {
    if (_localDocsDirPath == null || doc.fileName == null) return;
    final file = File('$_localDocsDirPath/${doc.fileName}');
    
    if (!file.existsSync()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Document file not found on this device')),
      );
      return;
    }

    final isImage = ['.jpg', '.jpeg', '.png', '.gif']
        .any((ext) => doc.fileName!.toLowerCase().endsWith(ext));

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppBar(
                  title: Text(doc.documentName ?? 'Attachment Preview'),
                  leading: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.download_rounded, color: AppColors.skyBlue),
                      tooltip: 'Download File',
                      onPressed: () => _downloadCustomerDocument(doc),
                    ),
                  ],
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  foregroundColor: Colors.black87,
                ),
                const SizedBox(height: 8),
                if (isImage)
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 450),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: InteractiveViewer(
                        panEnabled: true,
                        minScale: 1.0,
                        maxScale: 5.0,
                        child: Image.file(
                          file,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  )
                else
                  Container(
                    height: 200,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.insert_drive_file_outlined, size: 64, color: Colors.blueAccent),
                        const SizedBox(height: 16),
                        Text(doc.fileName ?? 'Unknown file type', textAlign: TextAlign.center),
                        const SizedBox(height: 8),
                        const Text('Preview only supported for images', style: TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                  ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_customer == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Profile Error')),
        body: const Center(child: Text('Customer profile not found.')),
      );
    }

    final c = _customer!;
    final int hash = c.name.hashCode;
    final List<Color> colors = [Colors.blue, Colors.purple, Colors.teal, Colors.orange, Colors.indigo, Colors.pink, Colors.red, Colors.green];
    final avatarColor = colors[hash.abs() % colors.length];
    final bool isWide = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(
        title: const Text('Customer Profile'),
        backgroundColor: AppColors.cardSurface,
        actions: [
          IconButton(
            tooltip: 'Download Customer Profile PDF',
            icon: const Icon(Icons.picture_as_pdf_rounded, color: AppColors.limeGreen),
            onPressed: () => DashboardExportService.shareCustomerProfilePdf(c, context: context),
          ),
          IconButton(
            tooltip: 'Edit Profile',
            icon: const Icon(Icons.edit, color: AppColors.skyBlue),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CustomerFormScreen(customer: c)),
              );
              _loadCustomerData();
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: AppColors.roseAccent),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Delete Customer?'),
                  content: Text('Are you sure you want to delete ${c.name}? This action can be synced.'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                    TextButton(
                      onPressed: () async {
                        final db = ref.read(databaseServiceProvider);
                        await db.deleteCustomer(c.id);
                        if (context.mounted) {
                          Navigator.pop(context); // Close dialog
                          Navigator.pop(context); // Go back to list
                        }
                      },
                      child: const Text('Delete', style: TextStyle(color: AppColors.roseAccent, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: BrandBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Profile Card
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey[200]!),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 36,
                      backgroundColor: avatarColor.withOpacity(0.15),
                      child: Text(
                        c.name.isNotEmpty ? c.name[0].toUpperCase() : '?',
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: avatarColor),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(c.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.headingText)),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text('ID: ${c.customerId ?? 'CUST-${c.id}'}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.bodyText)),
                              if (c.familyId != null && c.familyId!.isNotEmpty) ...[
                                const SizedBox(width: 8),
                                ColorBadge(text: 'Family: ${c.familyId}', style: BadgeStyle.blue),
                              ],
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const ColorBadge(text: 'ACTIVE', style: BadgeStyle.green),
                              const SizedBox(width: 8),
                              Text(
                                'Updated: ${DateFormat('dd MMM yy, hh:mm a').format(c.updatedAt.toLocal())}',
                                style: const TextStyle(fontSize: 11, color: AppColors.mutedText),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => DashboardExportService.shareCustomerProfilePdf(c, context: context),
                      icon: const Icon(Icons.download_rounded, size: 18),
                      label: const Text('Download PDF'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.badgeGreenBg,
                        foregroundColor: AppColors.limeGreen,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: AppColors.limeGreen, width: 1),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildQuickRemindersPanel(c),
            const SizedBox(height: 16),

            // Exposed Gorgeous Profile Panels (Direct Access UI/UX)
            if (isWide)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: _buildPersonalDetailsSection(c),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 4,
                    child: _buildContactDetailsSection(c),
                  ),
                ],
              )
            else ...[
              _buildPersonalDetailsSection(c),
              const SizedBox(height: 16),
              _buildContactDetailsSection(c),
            ],
            const SizedBox(height: 16),

            // Accordion sections
            _buildAccordionSection('Family Details', Icons.family_restroom_outlined, [
              _buildDobAndAgeRow("Father's DOB & Age", c.fatherDOB, c.fatherAge),
              _buildDobAndAgeRow("Mother's DOB & Age", c.motherDOB, c.motherAge),
              _buildDobAndAgeRow("Spouse's DOB & Age", c.spouseDOB, c.spouseAge),
              _buildDetailRow("Brother's Age", c.brotherAge != null && c.brotherAge!.isNotEmpty ? '${c.brotherAge} years' : null),
              _buildDetailRow("Sister's Age", c.sisterAge != null && c.sisterAge!.isNotEmpty ? '${c.sisterAge} years' : null),
              _buildDetailRow("Number of Children", c.numberOfChildren?.toString()),
              if (c.childrenDOBs != null && c.childrenDOBs!.isNotEmpty)
                ...List.generate(c.childrenDOBs!.length, (i) {
                  return _buildDobAndAgeRow("Child ${i + 1} DOB & Age", c.childrenDOBs![i], null);
                }),
            ]),

            _buildAccordionSection('Professional Information', Icons.business_center_outlined, [
              _buildDetailRow("Employer / Business Name", c.employerBusinessName),
              _buildDetailRow("Designation", c.designation),
              _buildDetailRow("Nature of Business / Occupation", c.natureOfBusiness),
              _buildDetailRow("Annual Income", c.annualIncome != null && c.annualIncome!.isNotEmpty ? '₹ ${c.annualIncome}' : null),
            ]),

            _buildAccordionSection('Nominee Details', Icons.badge_outlined, [
              _buildDetailRow("Nominee Name", c.nomineeName),
              _buildDetailRow("Relationship", c.nomineeRelationship),
              _buildDobAndAgeRow("Nominee DOB & Age", c.nomineeDOB, c.nomineeAge),
              _buildDetailRow("Nominee Father's Name", c.nomineeFatherName),
              _buildDetailRow("Nominee PAN", c.nomineePan),
              _buildDetailRow("Nominee Mobile 1", c.nomineeMobile1),
              _buildDetailRow("Nominee Mobile 2", c.nomineeMobile2),
              _buildDetailRow("Nominee Email", c.nomineeEmail),
              if (c.appointeeName != null && c.appointeeName!.isNotEmpty) ...[
                _buildDetailRow("Appointee Name", c.appointeeName),
                _buildDobAndAgeRow("Appointee DOB & Age", c.appointeeDOB, c.appointeeAge),
                _buildDetailRow(
                  "Appointee Relationship",
                  (c.appointeeRelationship ?? '').toLowerCase() == 'other' && c.appointeeOtherRelationship != null && c.appointeeOtherRelationship!.isNotEmpty
                      ? c.appointeeOtherRelationship
                      : c.appointeeRelationship,
                ),
              ],
            ]),

            _buildAccordionSection('Insurance Details', Icons.security_outlined, [
              _buildDetailRow("Self Company", c.selfCompany),
              _buildDetailRow("Self Policy Number", c.selfPolicyNumber),
              _buildDetailRow("Self Year of Issue", c.selfYearOfIssue),
              _buildDetailRow("Sum Assured 1", c.selfSumAssured1),
              _buildDetailRow("Sum Assured 2", c.selfSumAssured2),
              _buildDetailRow("Mode", c.premiumMode),
              _buildDetailRow("Father Policy", c.fatherPolicyNumber != null && c.fatherPolicyNumber!.isNotEmpty ? '${c.fatherPolicyNumber} (${c.fatherCompany ?? "N/A"})' : null),
              _buildDetailRow("Mother Policy", c.motherPolicyNumber != null && c.motherPolicyNumber!.isNotEmpty ? '${c.motherPolicyNumber} (${c.motherCompany ?? "N/A"})' : null),
              _buildDetailRow("Spouse Policy", c.spousePolicyNumber != null && c.spousePolicyNumber!.isNotEmpty ? '${c.spousePolicyNumber} (${c.spouseCompany ?? "N/A"})' : null),
              if (c.childrenPolicyNumbers != null && c.childrenPolicyNumbers!.isNotEmpty) ...[
                for (int i = 0; i < c.childrenPolicyNumbers!.length; i++)
                  if (c.childrenPolicyNumbers![i].isNotEmpty)
                    _buildDetailRow(
                      c.childrenPolicyNumbers!.length > 1 ? "Child ${i + 1} Policy" : "Child 1 Policy",
                      '${c.childrenPolicyNumbers![i]} (${(c.childrenCompanies != null && i < c.childrenCompanies!.length && c.childrenCompanies![i].isNotEmpty) ? c.childrenCompanies![i] : "N/A"})',
                    ),
              ] else ...[
                _buildDetailRow("Children Policy", c.childrenPolicyNumber != null && c.childrenPolicyNumber!.isNotEmpty ? '${c.childrenPolicyNumber} (${c.childrenCompany ?? "N/A"})' : null),
              ],
              _buildDetailRow("Existing Insurance Policy", c.hasExistingPolicy),
              if ((c.hasExistingPolicy ?? '').toLowerCase() == 'yes') ...[
                _buildDetailRow("Existing Self-Assigned Company", c.existingSelfCompany),
                _buildDetailRow("Existing Policy Number", c.existingPolicyNumber),
                _buildDateRow("DOC (Date of Commencement)", c.existingDocDate),
              ],
            ]),

            _buildAccordionSection('Health Details', Icons.health_and_safety_outlined, [
              _buildDetailRow("Health Problems", c.healthProblems),
              _buildDetailRow("Lifestyle Habits", c.lifestyleHabits),
              _buildDetailRow("Pregnancy Details", c.pregnancyDetails),
              _buildDetailRow("Other Remarks", c.healthRemarks),
              _buildDetailRow("Personal Accident Cover", c.hasPersonalAccident),
              if ((c.hasPersonalAccident ?? '').toLowerCase() == 'yes')
                _buildDateRow("Date of the Incident", c.personalAccidentDate),
            ]),

            _buildAccordionSection('Plan Details', Icons.article_outlined, [
              if (c.plans.isNotEmpty)
                for (int i = 0; i < c.plans.length; i++) ...[
                  if (i > 0) const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        (c.plans[i].planTitle != null && c.plans[i].planTitle!.isNotEmpty)
                            ? c.plans[i].planTitle!
                            : 'Plan #${i + 1}',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.blueAccent),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, size: 20, color: Colors.redAccent),
                        tooltip: 'Delete Plan',
                        onPressed: () => _confirmDeletePlan(c, i),
                      ),
                    ],
                  ),
                  _buildDetailRow("Product Name", c.plans[i].productName),
                  _buildDetailRow("Premium", c.plans[i].premium),
                  _buildDetailRow("Mode", c.plans[i].mode),
                  _buildDetailRow("Plan Sum Assured", c.plans[i].planSumAssured),
                  _buildDetailRow("Riders Configured", c.plans[i].rider),
                  _buildDateRow("Plan Date", c.plans[i].planDate),
                ]
              else if (c.productName != null || c.planSumAssured != null) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      c.productName != null && c.productName!.isNotEmpty ? c.productName! : 'Plan #1',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.blueAccent),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, size: 20, color: Colors.redAccent),
                      tooltip: 'Delete Plan',
                      onPressed: () => _confirmDeletePlan(c, -1),
                    ),
                  ],
                ),
                _buildDetailRow("Product Name", c.productName),
                _buildDetailRow("Premium Mode", c.premiumMode),
                _buildDetailRow("Plan Sum Assured", c.planSumAssured),
                _buildDetailRow("Riders Configured", c.rider),
              ],
              const SizedBox(height: 12),
              ElevatedButton.icon(
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Add New Plan'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () => _showAddPlanDialog(c),
              ),
            ]),

            _buildAccordionSection('Plan & Mutual Funds', Icons.account_balance_outlined, [
              _buildDetailRow("Plan Name", c.panNumber),
              _buildDetailRow("Risk Cover", c.riskCover),
              _buildDetailRow("Pension Plan", c.pensionPlan),
              _buildDetailRow("Investment Plan", c.investmentPlan),
              _buildDetailRow("Mutual Funds", c.mutualFunds),
              _buildDetailRow("Mediclaim", c.mediClaim),
              _buildDetailRow("Money Back Policy", c.moneyBackPolicy),
              _buildDetailRow("Children Education Plan", c.childrenEducationPlan),
            ]),


            _buildAccordionSection('References', Icons.people_outline, [
              if (c.references.isNotEmpty)
                for (int i = 0; i < c.references.length; i++) ...[
                  if (i > 0) const Divider(height: 24),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Text(
                      'Reference #${i + 1}',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.blueAccent),
                    ),
                  ),
                  _buildDetailRow("Reference Name", c.references[i].name),
                  _buildDetailRow("Reference Mobile", c.references[i].mobile),
                  _buildDetailRow("Reference Age", c.references[i].age),
                ]
              else ...[
                _buildDetailRow("Friend's Name", c.referenceFriendName),
                _buildDetailRow("Reference Mobile", c.referenceMobile),
                _buildDetailRow("Reference Age", c.referenceAge),
              ],
            ]),

            // Document Attachments
            if (c.documents.isNotEmpty)
              Card(
                elevation: 0.5,
                margin: const EdgeInsets.only(bottom: 8.0),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey[200]!),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: ExpansionTile(
                    leading: const Icon(Icons.attach_file_outlined, color: Colors.blueAccent),
                    title: const Text('Document Attachments', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    initiallyExpanded: false,
                    childrenPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    children: c.documents.map((doc) {
                      return Material(
                        color: Colors.transparent,
                        child: ListTile(
                          leading: const Icon(Icons.description, color: Colors.blue),
                          title: Text(doc.documentName ?? 'Unnamed Document'),
                          subtitle: Text(doc.fileName ?? ''),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.download_rounded, size: 20, color: AppColors.skyBlue),
                                tooltip: 'Download Document',
                                onPressed: () => _downloadCustomerDocument(doc),
                              ),
                              IconButton(
                                icon: const Icon(Icons.visibility, size: 20),
                                tooltip: 'Preview File',
                                onPressed: () => _previewDocument(doc),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),

            _buildAccordionSection('Remarks / Notes', Icons.notes_outlined, [
              _buildDetailRow("Notes", c.notes),
            ]),

            const SizedBox(height: 100),
          ],
        ),
      ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => CustomerFormScreen(customer: c)),
          );
          _loadCustomerData();
        },
        label: const Text('Edit Profile', style: TextStyle(fontWeight: FontWeight.bold)),
        icon: const Icon(Icons.edit),
        backgroundColor: AppColors.skyBlue,
        foregroundColor: Colors.white,
      ),
    );
  }
  Widget _buildQuickRemindersPanel(Customer c) {
    List<CustomerReminderItem> remList = [];
    if (c.reminders.isNotEmpty) {
      remList = c.reminders;
    } else {
      if (c.reminderDate1 != null || c.reminderNote1 != null) {
        remList.add(CustomerReminderItem()..reminderDate = c.reminderDate1..note = c.reminderNote1..reminderTitle = 'Reminder #1');
      }
      if (c.reminderDate2 != null || c.reminderNote2 != null) {
        remList.add(CustomerReminderItem()..reminderDate = c.reminderDate2..note = c.reminderNote2..reminderTitle = 'Reminder #2');
      }
      if (c.reminderDate3 != null || c.reminderNote3 != null) {
        remList.add(CustomerReminderItem()..reminderDate = c.reminderDate3..note = c.reminderNote3..reminderTitle = 'Reminder #3');
      }
      if (c.reminderDate4 != null || c.reminderNote4 != null) {
        remList.add(CustomerReminderItem()..reminderDate = c.reminderDate4..note = c.reminderNote4..reminderTitle = 'Reminder #4');
      }
      if (c.reminderDate5 != null || c.reminderNote5 != null) {
        remList.add(CustomerReminderItem()..reminderDate = c.reminderDate5..note = c.reminderNote5..reminderTitle = 'Reminder #5');
      }
    }

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.blueAccent.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.blue.withOpacity(0.02),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.alarm, color: Colors.blueAccent, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Reminders & Follow-ups (${remList.length})',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.blue[900]),
                    ),
                  ],
                ),
                TextButton.icon(
                  onPressed: () {
                    _showAddReminderDialog(c);
                  },
                  icon: const Icon(Icons.add, size: 16),
                  label: const Text('Add', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                  style: TextButton.styleFrom(visualDensity: VisualDensity.compact),
                ),
              ],
            ),
            const Divider(height: 16),
            if (remList.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'No reminders set for this customer.',
                  style: TextStyle(color: Colors.grey, fontSize: 13, fontStyle: FontStyle.italic),
                ),
              )
            else
              Column(
                children: [
                  for (int i = 0; i < remList.length; i++) ...[
                    if (i > 0) const SizedBox(height: 8),
                    _buildReminderTile(c, i, remList[i]),
                  ]
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildReminderTile(Customer c, int index, CustomerReminderItem rem) {
    final activePattern = ref.watch(dateFormatPatternProvider);
    final dateFormat = DateFormat(activePattern);
    final titleText = rem.reminderTitle?.isNotEmpty == true ? rem.reminderTitle! : 'Reminder #${index + 1}';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Icon(Icons.event, color: Colors.blue[700], size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$titleText: ${rem.reminderDate != null ? dateFormat.format(rem.reminderDate!) : "No date"}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87),
                ),
                if (rem.note != null && rem.note!.trim().isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    rem.note!,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit_outlined, size: 18, color: Colors.grey),
            onPressed: () => _showAddReminderDialog(c, index: index),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: 12),
          IconButton(
            icon: const Icon(Icons.delete_outline, size: 18, color: Colors.redAccent),
            onPressed: () => _deleteReminder(c, index),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  void _deleteReminder(Customer c, int index) async {
    List<CustomerReminderItem> currentList = List.from(c.reminders);
    if (currentList.isEmpty) {
      if (c.reminderDate1 != null || c.reminderNote1 != null) {
        currentList.add(CustomerReminderItem()..reminderDate = c.reminderDate1..note = c.reminderNote1..reminderTitle = 'Reminder #1');
      }
      if (c.reminderDate2 != null || c.reminderNote2 != null) {
        currentList.add(CustomerReminderItem()..reminderDate = c.reminderDate2..note = c.reminderNote2..reminderTitle = 'Reminder #2');
      }
      if (c.reminderDate3 != null || c.reminderNote3 != null) {
        currentList.add(CustomerReminderItem()..reminderDate = c.reminderDate3..note = c.reminderNote3..reminderTitle = 'Reminder #3');
      }
      if (c.reminderDate4 != null || c.reminderNote4 != null) {
        currentList.add(CustomerReminderItem()..reminderDate = c.reminderDate4..note = c.reminderNote4..reminderTitle = 'Reminder #4');
      }
      if (c.reminderDate5 != null || c.reminderNote5 != null) {
        currentList.add(CustomerReminderItem()..reminderDate = c.reminderDate5..note = c.reminderNote5..reminderTitle = 'Reminder #5');
      }
    }

    final remTitle = (index >= 0 && index < currentList.length && currentList[index].reminderTitle != null && currentList[index].reminderTitle!.isNotEmpty)
        ? currentList[index].reminderTitle!
        : 'Reminder #${index + 1}';

    final check = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.redAccent),
            SizedBox(width: 8),
            Text('Delete Reminder'),
          ],
        ),
        content: Text('Are you sure you want to delete "$remTitle"?'),
        actions: [
          OutlinedButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, foregroundColor: Colors.white),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (check == true) {
      if (index >= 0 && index < currentList.length) {
        currentList.removeAt(index);
      }
      c.reminders = currentList;
      c.reminderDate1 = currentList.isNotEmpty ? currentList[0].reminderDate : null;
      c.reminderNote1 = currentList.isNotEmpty ? currentList[0].note : null;
      c.reminderDate2 = currentList.length > 1 ? currentList[1].reminderDate : null;
      c.reminderNote2 = currentList.length > 1 ? currentList[1].note : null;
      c.reminderDate3 = currentList.length > 2 ? currentList[2].reminderDate : null;
      c.reminderNote3 = currentList.length > 2 ? currentList[2].note : null;
      c.reminderDate4 = currentList.length > 3 ? currentList[3].reminderDate : null;
      c.reminderNote4 = currentList.length > 3 ? currentList[3].note : null;
      c.reminderDate5 = currentList.length > 4 ? currentList[4].reminderDate : null;
      c.reminderNote5 = currentList.length > 4 ? currentList[4].note : null;
      c.updatedAt = DateTime.now();

      final db = ref.read(databaseServiceProvider);
      await db.saveCustomer(c);
      ref.invalidate(customerListProvider);
      ref.invalidate(upcomingEventsProvider);
      _loadCustomerData();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('"$remTitle" deleted.')),
        );
      }
    }
  }

  void _showAddReminderDialog(Customer c, {int? index}) {
    List<CustomerReminderItem> currentList = List.from(c.reminders);
    if (currentList.isEmpty) {
      if (c.reminderDate1 != null || c.reminderNote1 != null) {
        currentList.add(CustomerReminderItem()..reminderDate = c.reminderDate1..note = c.reminderNote1..reminderTitle = 'Reminder #1');
      }
      if (c.reminderDate2 != null || c.reminderNote2 != null) {
        currentList.add(CustomerReminderItem()..reminderDate = c.reminderDate2..note = c.reminderNote2..reminderTitle = 'Reminder #2');
      }
      if (c.reminderDate3 != null || c.reminderNote3 != null) {
        currentList.add(CustomerReminderItem()..reminderDate = c.reminderDate3..note = c.reminderNote3..reminderTitle = 'Reminder #3');
      }
      if (c.reminderDate4 != null || c.reminderNote4 != null) {
        currentList.add(CustomerReminderItem()..reminderDate = c.reminderDate4..note = c.reminderNote4..reminderTitle = 'Reminder #4');
      }
      if (c.reminderDate5 != null || c.reminderNote5 != null) {
        currentList.add(CustomerReminderItem()..reminderDate = c.reminderDate5..note = c.reminderNote5..reminderTitle = 'Reminder #5');
      }
    }

    final isEditing = index != null && index >= 0 && index < currentList.length;
    final existing = isEditing ? currentList[index] : null;

    final titleController = TextEditingController(text: existing?.reminderTitle ?? 'Reminder #${isEditing ? index + 1 : currentList.length + 1}');
    final noteController = TextEditingController(text: existing?.note);
    DateTime selectedDate = existing?.reminderDate ?? DateTime.now();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            const Icon(Icons.alarm_add, color: Colors.blueAccent),
            const SizedBox(width: 8),
            Text(isEditing ? 'Edit Reminder' : 'Add New Reminder'),
          ],
        ),
        content: StatefulBuilder(
          builder: (context, setDialogState) {
            final activePattern = ref.watch(dateFormatPatternProvider);
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Reminder Title',
                      hintText: 'e.g. Premium Due / Follow-up',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SegmentedDateInputField(
                    label: 'Reminder Date',
                    initialDate: selectedDate,
                    pattern: activePattern,
                    onDateChanged: (picked) {
                      if (picked != null) {
                        setDialogState(() {
                          selectedDate = picked;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: noteController,
                    minLines: 2,
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    decoration: const InputDecoration(
                      labelText: 'Reminder Remarks / Details',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.check, size: 18),
            label: Text(isEditing ? 'Save Changes' : 'Add Reminder'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent, foregroundColor: Colors.white),
            onPressed: () async {
              final newRem = CustomerReminderItem()
                ..reminderTitle = titleController.text.trim().isNotEmpty ? titleController.text.trim() : null
                ..reminderDate = selectedDate
                ..note = noteController.text.trim().isNotEmpty ? noteController.text.trim() : null;

              if (isEditing) {
                currentList[index] = newRem;
              } else {
                currentList.add(newRem);
              }

              c.reminders = currentList;
              c.reminderDate1 = currentList.isNotEmpty ? currentList[0].reminderDate : null;
              c.reminderNote1 = currentList.isNotEmpty ? currentList[0].note : null;
              c.reminderDate2 = currentList.length > 1 ? currentList[1].reminderDate : null;
              c.reminderNote2 = currentList.length > 1 ? currentList[1].note : null;
              c.reminderDate3 = currentList.length > 2 ? currentList[2].reminderDate : null;
              c.reminderNote3 = currentList.length > 2 ? currentList[2].note : null;
              c.reminderDate4 = currentList.length > 3 ? currentList[3].reminderDate : null;
              c.reminderNote4 = currentList.length > 3 ? currentList[3].note : null;
              c.reminderDate5 = currentList.length > 4 ? currentList[4].reminderDate : null;
              c.reminderNote5 = currentList.length > 4 ? currentList[4].note : null;
              c.updatedAt = DateTime.now();

              final db = ref.read(databaseServiceProvider);
              await db.saveCustomer(c);
              ref.invalidate(customerListProvider);
              ref.invalidate(upcomingEventsProvider);

              if (mounted) {
                Navigator.pop(context);
                _loadCustomerData();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(isEditing ? 'Reminder updated!' : 'New reminder added!')),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalDetailsSection(Customer c) {
    final activePattern = ref.watch(dateFormatPatternProvider);
    final dateFormat = DateFormat(activePattern);
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.person, color: Colors.blueAccent[700], size: 22),
                const SizedBox(width: 8),
                const Text(
                  'Personal Profile',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
                ),
              ],
            ),
            const Divider(height: 24),
            LayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
                return GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: crossAxisCount == 3 ? 2.5 : 2.2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _buildGridDetailItem(
                      Icons.cake_outlined,
                      'Date of Birth',
                      c.dateOfBirth != null ? dateFormat.format(c.dateOfBirth!) : 'Not Specified',
                    ),
                    _buildGridDetailItem(
                      Icons.numbers_outlined,
                      'Age',
                      (c.age != null && c.age!.isNotEmpty)
                          ? '${c.age} years'
                          : (c.dateOfBirth != null ? '${_calculateAgeText(c.dateOfBirth)}' : 'Not Specified'),
                    ),
                    _buildGridDetailItem(
                      Icons.person_pin_outlined,
                      "Proposer’s Name",
                      c.fatherName ?? 'Not Specified',
                    ),
                    _buildGridDetailItem(
                      Icons.favorite_border,
                      'Marital Status',
                      c.maritalStatus ?? 'Not Specified',
                    ),
                    if (c.spouseName != null && c.spouseName!.isNotEmpty)
                      _buildGridDetailItem(
                        Icons.people_outline,
                        'Spouse Name',
                        c.spouseName!,
                      ),
                    _buildGridDetailItem(
                      Icons.flag_outlined,
                      'Nationality',
                      c.nationality ?? 'Not Specified',
                    ),
                    _buildGridDetailItem(
                      Icons.badge_outlined,
                      'Aadhaar Number',
                      c.aadhaarNumber ?? 'Not Specified',
                    ),
                    _buildGridDetailItem(
                      Icons.school_outlined,
                      'Qualification',
                      c.qualification ?? 'Not Specified',
                    ),
                    _buildGridDetailItem(
                      Icons.height,
                      'Height',
                      c.height ?? 'Not Specified',
                    ),
                    _buildGridDetailItem(
                      Icons.monitor_weight_outlined,
                      'Weight',
                      c.weight ?? 'Not Specified',
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridDetailItem(IconData icon, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: Colors.grey[500]),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                label,
                style: TextStyle(fontSize: 11, color: Colors.grey[500], fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: Colors.black87),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      ],
    );
  }

  Widget _buildContactDetailsSection(Customer c) {
    final List<String> phones = [
      if (c.mobileNumber1 != null && c.mobileNumber1!.isNotEmpty) c.mobileNumber1!,
      if (c.mobileNumber2 != null && c.mobileNumber2!.isNotEmpty) c.mobileNumber2!,
      if (c.mobileNumber3 != null && c.mobileNumber3!.isNotEmpty) c.mobileNumber3!,
      if (c.mobileNumber4 != null && c.mobileNumber4!.isNotEmpty) c.mobileNumber4!,
    ];

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.call, color: Colors.green[700], size: 22),
                const SizedBox(width: 8),
                const Text(
                  'Contact Information',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
                ),
              ],
            ),
            const Divider(height: 24),
            LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth > 600;
                return Column(
                  children: [
                    if (isWide)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: _buildPhoneSection(phones, c.officeContactNumber)),
                          Expanded(child: _buildEmailAndAddressSection(c)),
                        ],
                      )
                    else ...[
                      _buildPhoneSection(phones, c.officeContactNumber),
                      const SizedBox(height: 16),
                      _buildEmailAndAddressSection(c),
                    ],
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneSection(List<String> phones, String? officePhone) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'MOBILE NUMBERS',
          style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 0.8),
        ),
        const SizedBox(height: 8),
        if (phones.isEmpty)
          const Text('No mobile numbers configured', style: TextStyle(color: Colors.grey, fontSize: 13))
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: phones.length,
            itemBuilder: (context, idx) {
              final isPrimary = idx == 0;
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    Icon(
                      isPrimary ? Icons.star : Icons.phone_android,
                      size: 16,
                      color: isPrimary ? Colors.amber[700] : Colors.grey[500],
                    ),
                    const SizedBox(width: 8),
                    Text(
                      phones[idx],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: isPrimary ? FontWeight.bold : FontWeight.normal,
                        color: Colors.black87,
                      ),
                    ),
                    if (isPrimary) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'PRIMARY',
                          style: TextStyle(color: Colors.amber[800], fontSize: 9, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
        if (officePhone != null && officePhone.isNotEmpty) ...[
          const SizedBox(height: 8),
          const Text(
            'OFFICE LINE',
            style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 0.8),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.business, size: 16, color: Colors.grey[500]),
              const SizedBox(width: 8),
              Text(
                officePhone,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildEmailAndAddressSection(Customer c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'EMAIL & ADDRESSES',
          style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 0.8),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.email_outlined, size: 16, color: Colors.grey[500]),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                c.emailId != null && c.emailId!.isNotEmpty ? c.emailId! : 'No Email Registered',
                style: TextStyle(
                  fontSize: 13.5,
                  color: c.emailId != null && c.emailId!.isNotEmpty ? Colors.blueAccent : Colors.grey[600],
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (c.communicationAddress != null && c.communicationAddress!.isNotEmpty) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.home_outlined, size: 16, color: Colors.grey[500]),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Communication Address',
                      style: TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      c.communicationAddress!,
                      style: const TextStyle(fontSize: 13, color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
        if (c.permanentAddress != null && c.permanentAddress!.isNotEmpty) ...[
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.location_on_outlined, size: 16, color: Colors.grey[500]),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Permanent Address',
                      style: TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      c.permanentAddress!,
                      style: const TextStyle(fontSize: 13, color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
