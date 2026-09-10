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
  static Future<void> shareDashboardPdf(List<TodayEventSummaryItem> items, {List<DailyNote>? dailyNotes}) async {
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
    await Printing.sharePdf(
      bytes: bytes,
      filename: 'Today_Event_Summary_${DateFormat('yyyyMMdd').format(today)}.pdf',
    );
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
      );
    } catch (_) {}

    if (savePath == null) {
      final Directory? dir = await getDownloadsDirectory() ?? await getApplicationDocumentsDirectory();
      if (dir != null) {
        savePath = '${dir.path}/$defaultFileName';
      }
    }

    if (savePath != null) {
      final file = File(savePath);
      await file.writeAsBytes(pngBytes);

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

  /// Generates an official, comprehensive PDF report for a Customer Profile and launches system print/share dialog.
  static Future<void> shareCustomerProfilePdf(Customer customer) async {
    final pdf = pw.Document();
    final today = DateTime.now();
    final dateStr = DateFormat('dd MMM yyyy, hh:mm a').format(today);
    final dobStr = customer.dateOfBirth != null ? DateFormat('dd MMM yyyy').format(customer.dateOfBirth!.toLocal()) : 'N/A';
    final anniversaryStr = customer.weddingAnniversary != null ? DateFormat('dd MMM yyyy').format(customer.weddingAnniversary!.toLocal()) : 'N/A';

    pw.MemoryImage? logoImage;
    try {
      final logoBytes = (await rootBundle.load('assets/images/logo.png')).buffer.asUint8List();
      logoImage = pw.MemoryImage(logoBytes);
    } catch (_) {}

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(28),
        build: (pw.Context context) {
          return [
            // Header Box
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
                        pw.Image(logoImage, width: 36, height: 36),
                        pw.SizedBox(width: 10),
                      ],
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            'JJ CRM - CUSTOMER PROFILE',
                            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold, color: PdfColors.blue900),
                          ),
                          pw.SizedBox(height: 2),
                          pw.Text(
                            customer.name.toUpperCase(),
                            style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold, color: PdfColors.black),
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
                      pw.Text('Report Date: $dateStr', style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey700)),
                    ],
                  ),
                ],
              ),
            ),

            pw.SizedBox(height: 14),

            // Personal & Contact Information Table
            _buildPdfSectionHeader('Personal & Contact Information'),
            pw.SizedBox(height: 6),
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.grey300),
              children: [
                _buildPdfGridRow('Full Name', customer.name, 'Customer ID / Family ID', '${customer.customerId ?? 'N/A'}${customer.familyId != null && customer.familyId!.isNotEmpty ? " [Fam: ${customer.familyId}]" : ""}'),
                _buildPdfGridRow('Father\'s Name', customer.fatherName ?? 'N/A', 'Date of Birth', dobStr),
                _buildPdfGridRow('Mobile Number 1', customer.mobileNumber1 ?? 'N/A', 'Mobile Number 2', customer.mobileNumber2 ?? 'N/A'),
                _buildPdfGridRow('Email Address', customer.emailId ?? 'N/A', 'Marital Status', customer.maritalStatus ?? 'N/A'),
                _buildPdfGridRow('Wedding Anniversary', anniversaryStr, 'PAN Number', customer.panNumber ?? 'N/A'),
                _buildPdfGridRow('Aadhaar Number', customer.aadhaarNumber ?? 'N/A', 'Annual Income', customer.annualIncome ?? 'N/A'),
                _buildPdfGridRow('Designation', customer.designation ?? 'N/A', 'Employer/Business', customer.employerBusinessName ?? 'N/A'),
              ],
            ),

            pw.SizedBox(height: 14),

            // Address Details
            _buildPdfSectionHeader('Address Information'),
            pw.SizedBox(height: 6),
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.grey300),
              children: [
                _buildPdfGridRow('Communication Address', customer.communicationAddress ?? 'N/A', 'Permanent Address', customer.permanentAddress ?? 'N/A'),
              ],
            ),

            pw.SizedBox(height: 14),

            // Insurance Plans & Policies
            _buildPdfSectionHeader('Insurance Plans & Policies'),
            pw.SizedBox(height: 6),
            if (customer.plans.isEmpty)
              pw.Container(
                padding: const pw.EdgeInsets.all(10),
                alignment: pw.Alignment.centerLeft,
                child: pw.Text('No insurance plans recorded.', style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey600)),
              )
            else
              pw.Table(
                border: pw.TableBorder.all(color: PdfColors.grey300),
                children: [
                  pw.TableRow(
                    decoration: const pw.BoxDecoration(color: PdfColors.grey200),
                    children: [
                      _buildTableCell('#', isHeader: true),
                      _buildTableCell('Product Name', isHeader: true),
                      _buildTableCell('Mode', isHeader: true),
                      _buildTableCell('Sum Assured', isHeader: true),
                      _buildTableCell('Premium', isHeader: true),
                      _buildTableCell('Rider', isHeader: true),
                    ],
                  ),
                  ...customer.plans.asMap().entries.map((entry) {
                    final idx = entry.key + 1;
                    final p = entry.value;
                    return pw.TableRow(
                      children: [
                        _buildTableCell('$idx', isBold: true),
                        _buildTableCell(p.productName ?? 'N/A'),
                        _buildTableCell(p.mode ?? 'N/A'),
                        _buildTableCell(p.planSumAssured ?? 'N/A'),
                        _buildTableCell(p.premium ?? 'N/A'),
                        _buildTableCell(p.rider ?? 'N/A'),
                      ],
                    );
                  }).toList(),
                ],
              ),

            pw.SizedBox(height: 14),

            // Health & Additional Cover
            _buildPdfSectionHeader('Health & Cover Details'),
            pw.SizedBox(height: 6),
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.grey300),
              children: [
                _buildPdfGridRow('Health Problems', customer.healthProblems ?? 'None', 'Lifestyle Habits', customer.lifestyleHabits ?? 'None'),
                _buildPdfGridRow(
                  'Personal Accident Cover',
                  customer.hasPersonalAccident ?? 'No',
                  'Accident Incident Date',
                  customer.personalAccidentDate != null ? DateFormat('dd MMM yyyy').format(customer.personalAccidentDate!.toLocal()) : 'N/A',
                ),
              ],
            ),

            pw.SizedBox(height: 14),

            // Nominee Details
            if (customer.nomineeName != null && customer.nomineeName!.isNotEmpty) ...[
              _buildPdfSectionHeader('Nominee Information'),
              pw.SizedBox(height: 6),
              pw.Table(
                border: pw.TableBorder.all(color: PdfColors.grey300),
                children: [
                  _buildPdfGridRow('Nominee Name', customer.nomineeName ?? 'N/A', 'Relationship', customer.nomineeRelationship ?? 'N/A'),
                  _buildPdfGridRow('Nominee Mobile', customer.nomineeMobile1 ?? 'N/A', 'Nominee PAN', customer.nomineePan ?? 'N/A'),
                  if (customer.appointeeName != null && customer.appointeeName!.isNotEmpty)
                    _buildPdfGridRow('Appointee Name', customer.appointeeName!, 'Appointee Relation', customer.appointeeRelationship ?? 'N/A'),
                ],
              ),
              pw.SizedBox(height: 14),
            ],

            // Reminders & Notes
            _buildPdfSectionHeader('Scheduled Reminders & Notes'),
            pw.SizedBox(height: 6),
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.grey300),
              children: [
                _buildPdfGridRow(
                  'Reminder 1 Date',
                  customer.reminderDate1 != null ? DateFormat('dd MMM yyyy').format(customer.reminderDate1!.toLocal()) : 'N/A',
                  'Reminder 1 Note',
                  customer.reminderNote1 ?? 'N/A',
                ),
                _buildPdfGridRow(
                  'Reminder 2 Date',
                  customer.reminderDate2 != null ? DateFormat('dd MMM yyyy').format(customer.reminderDate2!.toLocal()) : 'N/A',
                  'Reminder 2 Note',
                  customer.reminderNote2 ?? 'N/A',
                ),
                _buildPdfGridRow(
                  'Reminder 3 Date',
                  customer.reminderDate3 != null ? DateFormat('dd MMM yyyy').format(customer.reminderDate3!.toLocal()) : 'N/A',
                  'Reminder 3 Note',
                  customer.reminderNote3 ?? 'N/A',
                ),
                _buildPdfGridRow(
                  'Reminder 4 Date',
                  customer.reminderDate4 != null ? DateFormat('dd MMM yyyy').format(customer.reminderDate4!.toLocal()) : 'N/A',
                  'Reminder 4 Note',
                  customer.reminderNote4 ?? 'N/A',
                ),
                _buildPdfGridRow(
                  'Reminder 5 Date',
                  customer.reminderDate5 != null ? DateFormat('dd MMM yyyy').format(customer.reminderDate5!.toLocal()) : 'N/A',
                  'Reminder 5 Note',
                  customer.reminderNote5 ?? 'N/A',
                ),
                if (customer.notes != null && customer.notes!.isNotEmpty)
                  _buildPdfGridRow('Customer Notes', customer.notes!, '', ''),
              ],
            ),

            pw.SizedBox(height: 20),
            pw.Divider(color: PdfColors.grey400),
            pw.SizedBox(height: 4),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Confidential Customer Profile - JJ CRM', style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey600)),
                pw.Text('Page 1 of 1', style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey600)),
              ],
            ),
          ];
        },
      ),
    );

    final bytes = await pdf.save();
    final sanitizedName = customer.name.replaceAll(RegExp(r'[^\w\s]+'), '').replaceAll(' ', '_');
    await Printing.sharePdf(
      bytes: bytes,
      filename: 'Customer_Profile_${sanitizedName}_${customer.customerId ?? customer.id}.pdf',
    );
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
