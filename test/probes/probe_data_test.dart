@Tags(['probe'])
// -----------------------------------------------------------------------------
// --[probe]--  PROBE CODE (TEMPORARY DISCOVERY TOOLING)
//              Used to inspect UI layout and rendered data only.
//              Remove these files before production release.
// -----------------------------------------------------------------------------
import 'dart:convert';
import 'dart:ffi' show Abi;
import 'dart:io';
import 'package:customer_detail_management/models/company.dart';
import 'package:customer_detail_management/models/customer.dart';
import 'package:customer_detail_management/models/daily_note.dart';
import 'package:customer_detail_management/models/marketing_lead.dart';
import 'package:customer_detail_management/models/performance_record.dart';
import 'package:customer_detail_management/models/work_task.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import '../helpers/test_harness.dart';
import 'probe_dumper.dart';

void main() {
  late DatabaseContext dbContext;

  setUpAll(() async {
    await initIsarCoreForTest();
  });

  setUp(() async {
    dbContext = await openTestDatabase();
  });

  tearDown(() async {
    await dbContext.close();
  });

  test('Probe Isar Collections after Dummy Data Seed', () async {
    await dbContext.service.seedDummyData();
    final isar = dbContext.isar;

    final customers = await isar.customers.where().findAll();
    final companies = await isar.companys.where().findAll();
    final tasks = await isar.workTasks.where().findAll();
    final leads = await isar.marketingLeads.where().findAll();
    final perfRecords = await isar.performanceRecords.where().findAll();
    final notes = await isar.dailyNotes.where().findAll();

    final structuredData = {
      'customersCount': customers.length,
      'companiesCount': companies.length,
      'tasksCount': tasks.length,
      'leadsCount': leads.length,
      'performanceRecordsCount': perfRecords.length,
      'dailyNotesCount': notes.length,
      'sampleCustomers': customers.map((c) => {
        'id': c.id,
        'customerId': c.customerId,
        'name': c.name,
        'mobile': c.mobileNumber1,
        'plansCount': c.plans.length,
        'docsCount': c.documents.length,
      }).toList(),
      'sampleTasks': tasks.map((t) => {
        'id': t.id,
        'desc': t.description,
        'priority': t.priority,
        'status': t.status,
      }).toList(),
    };

    ProbeDumper.writeProbeReport(
      'data__seeded_collections',
      textReport: const JsonEncoder.withIndent('  ').convert(structuredData),
      structuredData: structuredData,
    );
  });
}