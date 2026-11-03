import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import '../models/customer.dart';
import '../models/daily_note.dart';
import '../providers/events_provider.dart';

class DashboardExportService {
  /// Generates a professional PDF report of today's event summary and opens the system Share/Print dialog.
  static Future<void> shareDashboardPdf(List<TodayEventSummaryItem> items, {List<DailyNote>? dailyNotes, BuildContext? context}) async {
    final notes = dailyNotes ?? [];
    final pdf = pw.Document();
    final today = DateTime.now();
    final dateStr = DateFormat('EEEE, dd MMMM yyyy').format(today);

    final reminderCount = items.where((i) => i.type == TodayEventType.reminder).length;
    final taskCount = items.where((i) => i.type == TodayEventType.workTask).length;
    final marketingCount = items.where((i) => i.type == TodayEventType.marketing).length;
    final noteCount = notes.length;

    pw.MemoryImage? logoImage;
    try {
      final logoBytes = (await rootBundle.load('assets/images/logo.png')).buffer.asUint8List();
      logoImage = pw.MemoryImage(logoBytes);
    } catch (_) {}

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return [
            // Header Title Box
            pw.Container(
              padding: const pw.EdgeInsets.all(14),
              decoration: pw.BoxDecoration(
                color: PdfColors.blue50,
                borderRadius: pw.BorderRadius.circular(8),
                border: pw.Border.all(color: PdfColors.blue300),
              ),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      if (logoImage != null) ...[
                        pw.Image(logoImage, width: 40, height: 40),
                        pw.SizedBox(width: 12),
                      ],
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            'JJ CRM',
                            style: pw.TextStyle(
                              fontSize: 18,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.blue900,
                            ),
                          ),
                          pw.SizedBox(height: 2),
                          pw.Text(
                            'Tomorrow\'s Work & Event Summary Report',
                            style: pw.TextStyle(
                              fontSize: 12,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.grey800,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(
                        dateStr,
                        style: pw.TextStyle(
                          fontSize: 11,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.blue800,
                        ),
                      ),
                      pw.SizedBox(height: 4),
                      pw.Text(
                        'Generated: ${DateFormat('hh:mm a').format(today)}',
                        style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            pw.SizedBox(height: 20),

            // Metrics Summary Grid / Table
            pw.Text(
              'Summary Metrics',
              style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold, color: PdfColors.blue900),
            ),
            pw.SizedBox(height: 8),

            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.grey300),
              children: [
                pw.TableRow(
                  decoration: const pw.BoxDecoration(color: PdfColors.grey100),
                  children: [
                    _buildTableCell('Total Items', isHeader: true),
                    _buildTableCell('Reminders', isHeader: true),
                    _buildTableCell('Work Tasks', isHeader: true),
                    _buildTableCell('Marketing Leads', isHeader: true),
                    _buildTableCell('Day Task Notes', isHeader: true),
                  ],
                ),
                pw.TableRow(
                  children: [
                    _buildTableCell('${items.length + noteCount}', isBold: true),
                    _buildTableCell('$reminderCount'),
                    _buildTableCell('$taskCount'),
                    _buildTableCell('$marketingCount'),
                    _buildTableCell('$noteCount'),
                  ],
                ),
              ],
            ),

            pw.SizedBox(height: 24),

            // Detailed Schedule List Table
            pw.Text(
              'Detailed Schedule (${items.length} Items)',
              style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold, color: PdfColors.blue900),
            ),
            pw.SizedBox(height: 8),

            if (items.isEmpty)
              pw.Container(
                padding: const pw.EdgeInsets.all(20),
                alignment: pw.Alignment.center,
                child: pw.Text(
                  'No events or follow-ups scheduled for today.',
                  style: pw.TextStyle(fontSize: 12, color: PdfColors.grey700, fontStyle: pw.FontStyle.italic),
                ),
              )
            else
              pw.Table(
                border: pw.TableBorder.all(color: PdfColors.grey300),
                columnWidths: {
                  0: const pw.FlexColumnWidth(1.2),
                  1: const pw.FlexColumnWidth(2.5),
                  2: const pw.FlexColumnWidth(3.5),
                  3: const pw.FlexColumnWidth(1.2),
                },
                children: [
                  pw.TableRow(
                    decoration: const pw.BoxDecoration(color: PdfColors.grey200),
                    children: [
                      _buildTableCell('Category', isHeader: true),
                      _buildTableCell('Title / Customer', isHeader: true),
                      _buildTableCell('Details / Notes', isHeader: true),
                      _buildTableCell('Status', isHeader: true),
                    ],
                  ),
                  ...items.map((item) {
                    return pw.TableRow(
                      children: [
                        _buildTableCell(item.categoryLabel, isBold: true),
                        _buildTableCell(item.title),
                        _buildTableCell(item.subtitle),
                        _buildTableCell(item.isCompleted ? 'Completed' : 'Scheduled'),
                      ],
                    );
                  }).toList(),
                ],
              ),

            pw.SizedBox(height: 24),

            // Day Task Notes Section
            pw.Text(
              'Day Task Notes & Checklist (${notes.length} Notes)',
              style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold, color: PdfColors.blue900),
            ),
            pw.SizedBox(height: 8),

            if (notes.isEmpty)
              pw.Container(
                padding: const pw.EdgeInsets.all(14),
                alignment: pw.Alignment.center,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.grey300),
                  borderRadius: pw.BorderRadius.circular(6),
                ),
                child: pw.Text(
                  'No day task notes recorded for tomorrow.',
                  style: pw.TextStyle(fontSize: 11, color: PdfColors.grey700, fontStyle: pw.FontStyle.italic),
                ),
              )
            else
              pw.Table(
                border: pw.TableBorder.all(color: PdfColors.grey300),
                columnWidths: {
                  0: const pw.FlexColumnWidth(1.2),
                  1: const pw.FlexColumnWidth(1.5),
                  2: const pw.FlexColumnWidth(5.5),
                },
                children: [
                  pw.TableRow(
                    decoration: const pw.BoxDecoration(color: PdfColors.amber100),
                    children: [
                      _buildTableCell('Status', isHeader: true),
                      _buildTableCell('Category', isHeader: true),
                      _buildTableCell('Task Note Details', isHeader: true),
                    ],
                  ),
                  ...notes.map((note) {
                    final catText = (note.category != null && note.category!.trim().isNotEmpty)
                        ? note.category!.trim().toUpperCase()
                        : 'GENERAL';
                    return pw.TableRow(
                      children: [
                        _buildTableCell(note.isCompleted ? '[X] Done' : '[  ] Pending', isBold: true),
                        _buildTableCell(catText),
                        _buildTableCell(note.content),
                      ],
                    );
                  }).toList(),
                ],
              ),

            pw.SizedBox(height: 30),
            pw.Divider(color: PdfColors.grey400),
            pw.SizedBox(height: 8),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  'Confidential - JJ CRM Offline Vault Report',
                  style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey600),
                ),
                pw.Text(
                  'Page 1 of 1',
                  style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey600),
                ),
              ],
            ),
          ];
        },
      ),
    );

    final bytes = await pdf.save();
    final fileName = 'Today_Event_Summary_${DateFormat('yyyyMMdd').format(today)}.pdf';
    await saveAndDownloadPdf(bytes, fileName, context: context);
  }

  /// Captures the Dashboard RepaintBoundary widget as a PNG image and opens system share/save dialog.
  static Future<String?> shareDashboardImage(GlobalKey boundaryKey, {BuildContext? context}) async {
    try {
      final boundary = boundaryKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) return null;

      final image = await boundary.toImage(pixelRatio: 2.5);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) return null;

      final pngBytes = byteData.buffer.asUint8List();
      final todayStr = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
      final defaultFileName = 'dashboard_summary_$todayStr.png';

      // On Linux or Desktop platforms, shareXFiles throws UnimplementedError. Use desktop save & open.
      if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
        return await _saveAndOpenImageDesktop(pngBytes, defaultFileName, context);
      }

      try {
        final tempDir = await getTemporaryDirectory();
        final file = File('${tempDir.path}/$defaultFileName');
        await file.writeAsBytes(pngBytes);

        await Share.shareXFiles(
          [XFile(file.path)],
          text: 'Today\'s JJ CRM Event Summary Snapshot (${DateFormat('dd MMM yyyy').format(DateTime.now())})',
        );
        return file.path;
      } catch (e) {
        return await _saveAndOpenImageDesktop(pngBytes, defaultFileName, context);
      }
    } catch (e) {
      debugPrint('Error sharing dashboard image: $e');
      return null;
    }
  }

  static Future<String?> _saveAndOpenImageDesktop(Uint8List pngBytes, String defaultFileName, BuildContext? context) async {
    String? savePath;

    try {
      savePath = await FilePicker.platform.saveFile(
        dialogTitle: 'Save Dashboard Image Snapshot',
        fileName: defaultFileName,
        type: FileType.image,
        bytes: pngBytes,
      );
    } catch (_) {}

    if (savePath != null && savePath.isNotEmpty) {
      final file = File(savePath);
      if (!await file.exists() || (await file.length()) == 0) {
        await file.writeAsBytes(pngBytes);
      }

      // Open saved image automatically on Desktop
      try {
        if (Platform.isLinux) {
          await Process.run('xdg-open', [savePath]);
        } else if (Platform.isMacOS) {
          await Process.run('open', [savePath]);
        } else if (Platform.isWindows) {
          await Process.run('explorer', [savePath]);
        }
      } catch (_) {}

      if (context != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Dashboard snapshot saved and opened:\n$savePath'),
            backgroundColor: const Color(0xFF009EE2),
            duration: const Duration(seconds: 4),
          ),
        );
      }
      return savePath;
    }
    return null;
  }

  static pw.Widget _buildTableCell(String text, {bool isHeader = false, bool isBold = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontSize: isHeader ? 10 : 9.5,
          fontWeight: isHeader || isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
          color: isHeader ? PdfColors.blue900 : PdfColors.black,
        ),
      ),
    );
  }

  /// Generates an official, comprehensive PDF report for a Customer Profile and saves/downloads it directly.
  static Future<void> shareCustomerProfilePdf(Customer customer, {BuildContext? context}) async {
    final pdf = pw.Document();
    final today = DateTime.now();
    final dateStr = DateFormat('dd MMM yyyy, hh:mm a').format(today);
    final dobStr = customer.dateOfBirth != null ? DateFormat('dd MMM yyyy').format(customer.dateOfBirth!.toLocal()) : 'N/A';
    final anniversaryStr = customer.weddingAnniversary != null ? DateFormat('dd MMM yyyy').format(customer.weddingAnniversary!.toLocal()) : 'N/A';
    final fatherDobStr = customer.fatherDOB != null ? DateFormat('dd MMM yyyy').format(customer.fatherDOB!.toLocal()) : 'N/A';
    final motherDobStr = customer.motherDOB != null ? DateFormat('dd MMM yyyy').format(customer.motherDOB!.toLocal()) : 'N/A';
    final spouseDobStr = customer.spouseDOB != null ? DateFormat('dd MMM yyyy').format(customer.spouseDOB!.toLocal()) : 'N/A';
    final nomineeDobStr = customer.nomineeDOB != null ? DateFormat('dd MMM yyyy').format(customer.nomineeDOB!.toLocal()) : 'N/A';
    final appointeeDobStr = customer.appointeeDOB != null ? DateFormat('dd MMM yyyy').format(customer.appointeeDOB!.toLocal()) : 'N/A';
    final accidentDateStr = customer.personalAccidentDate != null ? DateFormat('dd MMM yyyy').format(customer.personalAccidentDate!.toLocal()) : 'N/A';
    final existingDocStr = customer.existingDocDate != null ? DateFormat('dd MMM yyyy').format(customer.existingDocDate!.toLocal()) : 'N/A';

    pw.MemoryImage? logoImage;
    try {
      final logoBytes = (await rootBundle.load('assets/images/logo.png')).buffer.asUint8List();
      logoImage = pw.MemoryImage(logoBytes);
    } catch (_) {}

    // Prepare Reminders list: prefer dynamic list, fallback to slot fields
    List<CustomerReminderItem> effectiveReminders = [];
    if (customer.reminders.isNotEmpty) {
      effectiveReminders = customer.reminders;
    } else {
      if (customer.reminderDate1 != null || customer.reminderNote1 != null) {
        effectiveReminders.add(CustomerReminderItem()..reminderDate = customer.reminderDate1..note = customer.reminderNote1..reminderTitle = 'Reminder #1');
      }
      if (customer.reminderDate2 != null || customer.reminderNote2 != null) {
        effectiveReminders.add(CustomerReminderItem()..reminderDate = customer.reminderDate2..note = customer.reminderNote2..reminderTitle = 'Reminder #2');
      }
      if (customer.reminderDate3 != null || customer.reminderNote3 != null) {
        effectiveReminders.add(CustomerReminderItem()..reminderDate = customer.reminderDate3..note = customer.reminderNote3..reminderTitle = 'Reminder #3');
      }
      if (customer.reminderDate4 != null || customer.reminderNote4 != null) {
        effectiveReminders.add(CustomerReminderItem()..reminderDate = customer.reminderDate4..note = customer.reminderNote4..reminderTitle = 'Reminder #4');
      }
      if (customer.reminderDate5 != null || customer.reminderNote5 != null) {
        effectiveReminders.add(CustomerReminderItem()..reminderDate = customer.reminderDate5..note = customer.reminderNote5..reminderTitle = 'Reminder #5');
      }
    }

    // Filter active reminders that have at least a date or note
    final activeReminders = effectiveReminders.where((r) => r.reminderDate != null || (r.note != null && r.note!.trim().isNotEmpty)).toList();

    // Prepare References list: prefer dynamic list, fallback to slot fields
    List<CustomerReferenceItem> effectiveReferences = [];
    if (customer.references.isNotEmpty) {
      effectiveReferences = customer.references;
    } else if (customer.referenceFriendName != null && customer.referenceFriendName!.trim().isNotEmpty) {
      effectiveReferences.add(CustomerReferenceItem()
        ..name = customer.referenceFriendName
        ..mobile = customer.referenceMobile
        ..age = customer.referenceAge);
    }

    final hasInvestmentDetails = (customer.riskCover != null && customer.riskCover!.isNotEmpty) ||
        (customer.pensionPlan != null && customer.pensionPlan!.isNotEmpty) ||
        (customer.investmentPlan != null && customer.investmentPlan!.isNotEmpty) ||
        (customer.mutualFunds != null && customer.mutualFunds!.isNotEmpty) ||
        (customer.mediClaim != null && customer.mediClaim!.isNotEmpty) ||
        (customer.moneyBackPolicy != null && customer.moneyBackPolicy!.isNotEmpty) ||
        (customer.childrenEducationPlan != null && customer.childrenEducationPlan!.isNotEmpty);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(24),
        footer: (pw.Context context) {
          return pw.Container(
            margin: const pw.EdgeInsets.only(top: 8),
            padding: const pw.EdgeInsets.only(top: 4),
            decoration: const pw.BoxDecoration(
              border: pw.Border(top: pw.BorderSide(color: PdfColors.grey400, width: 0.5)),
            ),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Confidential Customer Profile - JJ CRM', style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey600)),
                pw.Text('Page ${context.pageNumber} of ${context.pagesCount}', style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey600)),
              ],
            ),
          );
        },
        build: (pw.Context context) {
          return [
            // Header Box
            pw.Container(
              padding: const pw.EdgeInsets.all(12),
              decoration: pw.BoxDecoration(
                color: PdfColors.blue50,
                borderRadius: pw.BorderRadius.circular(8),
                border: pw.Border.all(color: PdfColors.blue300),
              ),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      if (logoImage != null) ...[
                        pw.Image(logoImage, width: 34, height: 34),
                        pw.SizedBox(width: 10),
                      ],
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            'JJ CRM - CUSTOMER PROFILE',
                            style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold, color: PdfColors.blue900),
                          ),
                          pw.SizedBox(height: 2),
                          pw.Text(
                            customer.name.toUpperCase(),
                            style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, color: PdfColors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(
                        'ID: ${customer.customerId ?? 'CUST-${customer.id}'}',
                        style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold, color: PdfColors.blue800),
                      ),
                      pw.SizedBox(height: 2),
                      pw.Text('Report Date: $dateStr', style: const pw.TextStyle(fontSize: 8.5, color: PdfColors.grey700)),
                    ],
                  ),
                ],
              ),
            ),

            pw.SizedBox(height: 10),

            // 1. Personal Details
            _buildPdfSectionHeader('Personal Information'),
            pw.SizedBox(height: 4),
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.grey300),
              children: [
                _buildPdfGridRow('Full Name', customer.name, 'Customer ID / Family ID', '${customer.customerId ?? 'CUST-${customer.id}'}${customer.familyId != null && customer.familyId!.isNotEmpty ? " [Fam: ${customer.familyId}]" : ""}'),
                _buildPdfGridRow("Proposer's / Father's Name", customer.fatherName ?? 'N/A', 'Spouse Name', customer.spouseName ?? 'N/A'),
                _buildPdfGridRow('Date of Birth', dobStr, 'Age', customer.age != null && customer.age!.isNotEmpty ? '${customer.age} years' : 'N/A'),
                _buildPdfGridRow('Marital Status', customer.maritalStatus ?? 'N/A', 'Nationality', customer.nationality ?? 'N/A'),
                _buildPdfGridRow('Wedding Anniversary', anniversaryStr, 'PAN Number', customer.panNumber ?? 'N/A'),
                _buildPdfGridRow('Aadhaar Number', customer.aadhaarNumber ?? 'N/A', 'Qualification', customer.qualification ?? 'N/A'),
                _buildPdfGridRow('Height', customer.height ?? 'N/A', 'Weight', customer.weight ?? 'N/A'),
              ],
            ),

            pw.SizedBox(height: 10),

            // 2. Professional Details
            _buildPdfSectionHeader('Professional Information'),
            pw.SizedBox(height: 4),
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.grey300),
              children: [
                _buildPdfGridRow('Employer / Business Name', customer.employerBusinessName ?? 'N/A', 'Designation', customer.designation ?? 'N/A'),
                _buildPdfGridRow('Nature of Business / Occupation', customer.natureOfBusiness ?? 'N/A', 'Annual Income', customer.annualIncome ?? 'N/A'),
              ],
            ),

            pw.SizedBox(height: 10),

            // 3. Contact Details
            _buildPdfSectionHeader('Contact Information'),
            pw.SizedBox(height: 4),
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.grey300),
              children: [
                _buildPdfGridRow('Mobile Number 1', customer.mobileNumber1 ?? 'N/A', 'Mobile Number 2', customer.mobileNumber2 ?? 'N/A'),
                _buildPdfGridRow('Mobile Number 3', customer.mobileNumber3 ?? 'N/A', 'Mobile Number 4', customer.mobileNumber4 ?? 'N/A'),
                _buildPdfGridRow('Office Contact Number', customer.officeContactNumber ?? 'N/A', 'Email Address', customer.emailId ?? 'N/A'),
              ],
            ),

            pw.SizedBox(height: 10),

            // 4. Address Details
            _buildPdfSectionHeader('Address Information'),
            pw.SizedBox(height: 4),
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.grey300),
              children: [
                _buildPdfGridRow('Communication Address', customer.communicationAddress ?? 'N/A', 'Permanent Address', customer.permanentAddress ?? 'N/A'),
              ],
            ),

            pw.SizedBox(height: 10),

            // 5. Family Details
            _buildPdfSectionHeader('Family Details'),
            pw.SizedBox(height: 4),
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.grey300),
              children: [
                _buildPdfGridRow("Father's DOB", fatherDobStr, "Father's Age", customer.fatherAge != null && customer.fatherAge!.isNotEmpty ? '${customer.fatherAge} years' : 'N/A'),
                _buildPdfGridRow("Mother's DOB", motherDobStr, "Mother's Age", customer.motherAge != null && customer.motherAge!.isNotEmpty ? '${customer.motherAge} years' : 'N/A'),
                _buildPdfGridRow("Spouse's DOB", spouseDobStr, "Spouse's Age", customer.spouseAge != null && customer.spouseAge!.isNotEmpty ? '${customer.spouseAge} years' : 'N/A'),
                _buildPdfGridRow("Brother's Age", customer.brotherAge != null && customer.brotherAge!.isNotEmpty ? '${customer.brotherAge} years' : 'N/A', "Sister's Age", customer.sisterAge != null && customer.sisterAge!.isNotEmpty ? '${customer.sisterAge} years' : 'N/A'),
                _buildPdfGridRow('Number of Children', customer.numberOfChildren?.toString() ?? '0', '', ''),
                if (customer.childrenDOBs != null && customer.childrenDOBs!.isNotEmpty)
                  ...List.generate((customer.childrenDOBs!.length / 2).ceil(), (rowIdx) {
                    final idx1 = rowIdx * 2;
                    final idx2 = idx1 + 1;
                    final dob1 = customer.childrenDOBs![idx1];
                    final str1 = DateFormat('dd MMM yyyy').format(dob1.toLocal());
                    String label2 = '';
                    String str2 = '';
                    if (idx2 < customer.childrenDOBs!.length) {
                      final dob2 = customer.childrenDOBs![idx2];
                      label2 = 'Child ${idx2 + 1} DOB';
                      str2 = DateFormat('dd MMM yyyy').format(dob2.toLocal());
                    }
                    return _buildPdfGridRow('Child ${idx1 + 1} DOB', str1, label2, str2);
                  }),
              ],
            ),

            pw.SizedBox(height: 10),

            // 6. Nominee & Appointee Information
            if (customer.nomineeName != null && customer.nomineeName!.isNotEmpty) ...[
              _buildPdfSectionHeader('Nominee & Appointee Information'),
              pw.SizedBox(height: 4),
              pw.Table(
                border: pw.TableBorder.all(color: PdfColors.grey300),
                children: [
                  _buildPdfGridRow('Nominee Name', customer.nomineeName ?? 'N/A', 'Relationship', customer.nomineeRelationship ?? 'N/A'),
                  _buildPdfGridRow('Nominee DOB', nomineeDobStr, 'Nominee Age', customer.nomineeAge != null && customer.nomineeAge!.isNotEmpty ? '${customer.nomineeAge} years' : 'N/A'),
                  _buildPdfGridRow("Nominee's Father's Name", customer.nomineeFatherName ?? 'N/A', 'Nominee PAN', customer.nomineePan ?? 'N/A'),
                  _buildPdfGridRow('Nominee Mobile 1', customer.nomineeMobile1 ?? 'N/A', 'Nominee Mobile 2', customer.nomineeMobile2 ?? 'N/A'),
                  _buildPdfGridRow('Nominee Email', customer.nomineeEmail ?? 'N/A', '', ''),
                  if (customer.appointeeName != null && customer.appointeeName!.isNotEmpty) ...[
                    _buildPdfGridRow(
                      'Appointee Name (for minor)',
                      customer.appointeeName!,
                      'Appointee Relationship',
                      '${customer.appointeeRelationship ?? 'N/A'}${customer.appointeeOtherRelationship != null && customer.appointeeOtherRelationship!.isNotEmpty ? " (${customer.appointeeOtherRelationship})" : ""}',
                    ),
                    _buildPdfGridRow(
                      'Appointee DOB',
                      appointeeDobStr,
                      'Appointee Age',
                      customer.appointeeAge != null && customer.appointeeAge!.isNotEmpty ? '${customer.appointeeAge} years' : 'N/A',
                    ),
                  ],
                ],
              ),
              pw.SizedBox(height: 10),
            ],

            // 7. Insurance Details (Self, Family & Existing)
            _buildPdfSectionHeader('Insurance Policy Details'),
            pw.SizedBox(height: 4),
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.grey300),
              children: [
                _buildPdfGridRow('Self Assigned Company', customer.selfCompany ?? 'N/A', 'Self Policy Number', customer.selfPolicyNumber ?? 'N/A'),
                _buildPdfGridRow('Year of Issue', customer.selfYearOfIssue ?? 'N/A', 'Premium Mode', customer.premiumMode ?? 'N/A'),
                _buildPdfGridRow('Self Sum Assured 1', customer.selfSumAssured1 ?? 'N/A', 'Self Sum Assured 2', customer.selfSumAssured2 ?? 'N/A'),
                _buildPdfGridRow('Father Policy Number', customer.fatherPolicyNumber ?? 'N/A', 'Father Company', customer.fatherCompany ?? 'N/A'),
                _buildPdfGridRow('Mother Policy Number', customer.motherPolicyNumber ?? 'N/A', 'Mother Company', customer.motherCompany ?? 'N/A'),
                _buildPdfGridRow('Spouse Policy Number', customer.spousePolicyNumber ?? 'N/A', 'Spouse Company', customer.spouseCompany ?? 'N/A'),
                if (customer.childrenPolicyNumbers != null && customer.childrenPolicyNumbers!.isNotEmpty)
                  ...List.generate(customer.childrenPolicyNumbers!.length, (cIdx) {
                    final pol = customer.childrenPolicyNumbers![cIdx];
                    final comp = (customer.childrenCompanies != null && cIdx < customer.childrenCompanies!.length) ? customer.childrenCompanies![cIdx] : '';
                    return _buildPdfGridRow('Child ${cIdx + 1} Policy Number', pol.isNotEmpty ? pol : 'N/A', 'Child ${cIdx + 1} Company', comp.isNotEmpty ? comp : 'N/A');
                  })
                else
                  _buildPdfGridRow('Children Policy Number', customer.childrenPolicyNumber ?? 'N/A', 'Children Company', customer.childrenCompany ?? 'N/A'),
                _buildPdfGridRow('Existing Insurance Policy?', customer.hasExistingPolicy ?? 'No', 'Existing Assigned Company', customer.existingSelfCompany ?? 'N/A'),
                if ((customer.hasExistingPolicy ?? '').toLowerCase() == 'yes')
                  _buildPdfGridRow('Existing Policy Number', customer.existingPolicyNumber ?? 'N/A', 'Date of Commencement (DOC)', existingDocStr),
              ],
            ),

            pw.SizedBox(height: 10),

            // 8. Recorded Plans & Policies Table
            _buildPdfSectionHeader('Plan Details'),
            pw.SizedBox(height: 4),
            if (customer.plans.isEmpty)
              pw.Container(
                padding: const pw.EdgeInsets.all(8),
                alignment: pw.Alignment.centerLeft,
                child: pw.Text('No individual plan records listed.', style: const pw.TextStyle(fontSize: 9.5, color: PdfColors.grey600)),
              )
            else
              pw.Table(
                border: pw.TableBorder.all(color: PdfColors.grey300),
                children: [
                  pw.TableRow(
                    decoration: const pw.BoxDecoration(color: PdfColors.grey200),
                    children: [
                      _buildTableCell('#', isHeader: true),
                      _buildTableCell('Plan Title', isHeader: true),
                      _buildTableCell('Product Name', isHeader: true),
                      _buildTableCell('Mode', isHeader: true),
                      _buildTableCell('Sum Assured', isHeader: true),
                      _buildTableCell('Premium', isHeader: true),
                      _buildTableCell('Rider', isHeader: true),
                      _buildTableCell('Plan Date', isHeader: true),
                    ],
                  ),
                  ...customer.plans.asMap().entries.map((entry) {
                    final idx = entry.key + 1;
                    final p = entry.value;
                    final pDateStr = p.planDate != null ? DateFormat('dd MMM yyyy').format(p.planDate!.toLocal()) : 'N/A';
                    return pw.TableRow(
                      children: [
                        _buildTableCell('$idx', isBold: true),
                        _buildTableCell(p.planTitle ?? 'Plan #$idx'),
                        _buildTableCell(p.productName ?? 'N/A'),
                        _buildTableCell(p.mode ?? 'N/A'),
                        _buildTableCell(p.planSumAssured ?? 'N/A'),
                        _buildTableCell(p.premium ?? 'N/A'),
                        _buildTableCell(p.rider ?? 'N/A'),
                        _buildTableCell(pDateStr),
                      ],
                    );
                  }).toList(),
                ],
              ),

            pw.SizedBox(height: 10),

            // 9. Plan & Mutual Funds (Investment Portfolio)
            if (hasInvestmentDetails) ...[
              _buildPdfSectionHeader('Plan & Mutual Funds (Investment Details)'),
              pw.SizedBox(height: 4),
              pw.Table(
                border: pw.TableBorder.all(color: PdfColors.grey300),
                children: [
                  _buildPdfGridRow('Risk Cover', customer.riskCover ?? 'N/A', 'Pension Plan', customer.pensionPlan ?? 'N/A'),
                  _buildPdfGridRow('Investment Plan', customer.investmentPlan ?? 'N/A', 'Mutual Funds', customer.mutualFunds ?? 'N/A'),
                  _buildPdfGridRow('Mediclaim', customer.mediClaim ?? 'N/A', 'Money Back Policy', customer.moneyBackPolicy ?? 'N/A'),
                  _buildPdfGridRow("Children's Education Plan", customer.childrenEducationPlan ?? 'N/A', '', ''),
                ],
              ),
              pw.SizedBox(height: 10),
            ],

            // 10. Health & Accident Cover
            _buildPdfSectionHeader('Health & Cover Details'),
            pw.SizedBox(height: 4),
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.grey300),
              children: [
                _buildPdfGridRow('Health Problems', customer.healthProblems ?? 'None', 'Lifestyle Habits', customer.lifestyleHabits ?? 'None'),
                _buildPdfGridRow('Pregnancy Details', customer.pregnancyDetails ?? 'None', 'Other Remarks', customer.healthRemarks ?? 'None'),
                _buildPdfGridRow('Personal Accident Cover', customer.hasPersonalAccident ?? 'No', 'Date of Commencement (DOC)', accidentDateStr),
              ],
            ),

            pw.SizedBox(height: 10),

            // 11. References
            if (effectiveReferences.isNotEmpty) ...[
              _buildPdfSectionHeader('References'),
              pw.SizedBox(height: 4),
              pw.Table(
                border: pw.TableBorder.all(color: PdfColors.grey300),
                children: [
                  pw.TableRow(
                    decoration: const pw.BoxDecoration(color: PdfColors.grey200),
                    children: [
                      _buildTableCell('#', isHeader: true),
                      _buildTableCell('Reference Name', isHeader: true),
                      _buildTableCell('Mobile Number', isHeader: true),
                      _buildTableCell('Age', isHeader: true),
                    ],
                  ),
                  ...effectiveReferences.asMap().entries.map((entry) {
                    final idx = entry.key + 1;
                    final r = entry.value;
                    return pw.TableRow(
                      children: [
                        _buildTableCell('$idx', isBold: true),
                        _buildTableCell(r.name ?? 'N/A'),
                        _buildTableCell(r.mobile ?? 'N/A'),
                        _buildTableCell(r.age != null && r.age!.isNotEmpty ? '${r.age} years' : 'N/A'),
                      ],
                    );
                  }).toList(),
                ],
              ),
              pw.SizedBox(height: 10),
            ],

            // 12. Scheduled Reminders & Follow-ups
            _buildPdfSectionHeader('Scheduled Reminders & Follow-ups'),
            pw.SizedBox(height: 4),
            if (activeReminders.isEmpty)
              pw.Container(
                padding: const pw.EdgeInsets.all(8),
                alignment: pw.Alignment.centerLeft,
                child: pw.Text('No active reminders or follow-ups scheduled.', style: const pw.TextStyle(fontSize: 9.5, color: PdfColors.grey600)),
              )
            else
              pw.Table(
                border: pw.TableBorder.all(color: PdfColors.grey300),
                children: [
                  pw.TableRow(
                    decoration: const pw.BoxDecoration(color: PdfColors.grey200),
                    children: [
                      _buildTableCell('#', isHeader: true),
                      _buildTableCell('Title', isHeader: true),
                      _buildTableCell('Reminder Date', isHeader: true),
                      _buildTableCell('Follow-up Remarks / Details', isHeader: true),
                    ],
                  ),
                  ...activeReminders.asMap().entries.map((entry) {
                    final idx = entry.key + 1;
                    final rem = entry.value;
                    final rDate = rem.reminderDate != null ? DateFormat('dd MMM yyyy').format(rem.reminderDate!.toLocal()) : 'Not Set';
                    final rTitle = rem.reminderTitle ?? 'Reminder #$idx';
                    final rNote = rem.note ?? 'None';
                    return pw.TableRow(
                      children: [
                        _buildTableCell('$idx', isBold: true),
                        _buildTableCell(rTitle),
                        _buildTableCell(rDate),
                        _buildTableCell(rNote),
                      ],
                    );
                  }).toList(),
                ],
              ),

            pw.SizedBox(height: 10),

            // 13. Additional Notes
            if (customer.notes != null && customer.notes!.trim().isNotEmpty) ...[
              _buildPdfSectionHeader('Customer Remarks & Notes'),
              pw.SizedBox(height: 4),
              pw.Container(
                width: double.infinity,
                padding: const pw.EdgeInsets.all(8),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.grey300),
                  borderRadius: pw.BorderRadius.circular(4),
                ),
                child: pw.Text(
                  customer.notes!.trim(),
                  style: const pw.TextStyle(fontSize: 9.5, color: PdfColors.black),
                ),
              ),
              pw.SizedBox(height: 10),
            ],

            // 14. Document Attachments
            if (customer.documents.isNotEmpty) ...[
              _buildPdfSectionHeader('Document Attachments'),
              pw.SizedBox(height: 4),
              pw.Table(
                border: pw.TableBorder.all(color: PdfColors.grey300),
                children: [
                  pw.TableRow(
                    decoration: const pw.BoxDecoration(color: PdfColors.grey200),
                    children: [
                      _buildTableCell('#', isHeader: true),
                      _buildTableCell('Document Name', isHeader: true),
                      _buildTableCell('File Name', isHeader: true),
                    ],
                  ),
                  ...customer.documents.asMap().entries.map((entry) {
                    final idx = entry.key + 1;
                    final doc = entry.value;
                    return pw.TableRow(
                      children: [
                        _buildTableCell('$idx', isBold: true),
                        _buildTableCell(doc.documentName ?? 'Unnamed Document'),
                        _buildTableCell(doc.fileName ?? 'N/A'),
                      ],
                    );
                  }).toList(),
                ],
              ),
              pw.SizedBox(height: 10),
            ],
          ];
        },
      ),
    );

    final bytes = await pdf.save();
    final sanitizedName = customer.name.replaceAll(RegExp(r'[^\w\s]+'), '').replaceAll(' ', '_');
    final fileName = 'Customer_Profile_${sanitizedName}_${customer.customerId ?? customer.id}.pdf';
    await saveAndDownloadPdf(bytes, fileName, context: context);
  }

  /// Saves PDF bytes by prompting the user for target directory (FilePicker save path) and opens it automatically.
  static Future<String?> saveAndDownloadPdf(Uint8List pdfBytes, String defaultFileName, {BuildContext? context}) async {
    String? savePath;

    try {
      savePath = await FilePicker.platform.saveFile(
        dialogTitle: 'Save PDF Report',
        fileName: defaultFileName,
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        bytes: pdfBytes,
      );
    } catch (e) {
      debugPrint('Error in FilePicker saveFile: $e');
    }

    if (savePath != null && savePath.isNotEmpty) {
      final file = File(savePath);
      if (!await file.exists() || (await file.length()) == 0) {
        await file.writeAsBytes(pdfBytes);
      }

      // Automatically open saved PDF file
      try {
        if (Platform.isLinux) {
          await Process.run('xdg-open', [savePath]);
        } else if (Platform.isMacOS) {
          await Process.run('open', [savePath]);
        } else if (Platform.isWindows) {
          await Process.run('explorer', [savePath]);
        }
      } catch (_) {}

      if (context != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('PDF saved successfully:\n$savePath'),
            backgroundColor: const Color(0xFF009EE2),
            duration: const Duration(seconds: 4),
          ),
        );
      }
      return savePath;
    } else {
      // If FilePicker was cancelled or null, offer system share/print dialog as fallback on mobile
      try {
        if (Platform.isAndroid || Platform.isIOS) {
          await Printing.sharePdf(bytes: pdfBytes, filename: defaultFileName);
        }
      } catch (_) {}
      return null;
    }
  }

  static pw.Widget _buildPdfSectionHeader(String title) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: const pw.BoxDecoration(color: PdfColors.blue100),
      child: pw.Text(
        title,
        style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold, color: PdfColors.blue900),
      ),
    );
  }

  static pw.TableRow _buildPdfGridRow(String label1, String val1, String label2, String val2) {
    return pw.TableRow(
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.all(6),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(label1, style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey700)),
              pw.SizedBox(height: 1),
              pw.Text(val1, style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold)),
            ],
          ),
        ),
        if (label2.isNotEmpty)
          pw.Padding(
            padding: const pw.EdgeInsets.all(6),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(label2, style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey700)),
                pw.SizedBox(height: 1),
                pw.Text(val2, style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold)),
              ],
            ),
          )
        else
          pw.Container(),
      ],
    );
  }
}
