import 'dart:convert';
import 'dart:io';
import 'package:archive/archive.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path/path.dart' as p;
import 'app_storage_service.dart';
import 'database_service.dart';
import '../models/customer.dart';
import '../models/company.dart';
import '../models/work_task.dart';
import '../models/marketing_lead.dart';
import '../models/performance_record.dart';

final backupServiceProvider = Provider<BackupService>((ref) {
  final db = ref.watch(databaseServiceProvider);
  return BackupService(db);
});

class BackupService {
  final DatabaseService db;
  BackupService(this.db);

  /// Exports database records and all attached photos/documents into a single compressed ZIP file.
  Future<List<int>> exportZipBackup() async {
    final customers = await db.isar.customers.where().findAll();
    final companies = await db.isar.companys.where().findAll();
    final tasks = await db.isar.workTasks.where().findAll();
    final marketingLeads = await db.isar.marketingLeads.where().findAll();
    final performanceRecords = await db.isar.performanceRecords.where().findAll();

    final customersJson = customers.map((c) => _customerToJson(c)).toList();
    final companiesJson = companies.map((c) => _companyToJson(c)).toList();
    final tasksJson = tasks.map((t) => _taskToJson(t)).toList();
    final marketingLeadsJson = marketingLeads.map((m) => _marketingLeadToJson(m)).toList();
    final performanceRecordsJson = performanceRecords.map((p) => _performanceRecordToJson(p)).toList();

    final Map<String, dynamic> dbJsonMap = {
      'version': 2,
      'exportedAt': DateTime.now().toIso8601String(),
      'customers': customersJson,
      'companies': companiesJson,
      'tasks': tasksJson,
      'marketingLeads': marketingLeadsJson,
      'performanceRecords': performanceRecordsJson,
    };

    final archive = Archive();

    // 1. Add database JSON file to archive
    final jsonBytes = utf8.encode(jsonEncode(dbJsonMap));
    archive.addFile(ArchiveFile('backup_data.json', jsonBytes.length, jsonBytes));

    // 2. Add all physical photo & document files to customer_documents/ subfolder inside ZIP archive
    final docsDir = await AppStorageService.getCustomerDocumentsDirectory();
    if (await docsDir.exists()) {
      final List<FileSystemEntity> files = docsDir.listSync();
      for (final entity in files) {
        if (entity is File) {
          final fileName = p.basename(entity.path);
          final bytes = await entity.readAsBytes();
          archive.addFile(ArchiveFile('customer_documents/$fileName', bytes.length, bytes));
        }
      }
    }

    // 3. Compress ZIP archive
    final encoder = ZipEncoder();
    final zipData = encoder.encode(archive);
    return zipData ?? [];
  }

  /// Restores database records and extracted document/photo files from a ZIP archive or legacy JSON.
  Future<void> importZipBackup(File backupFile) async {
    final bytes = await backupFile.readAsBytes();
    final docsDir = await AppStorageService.getCustomerDocumentsDirectory();

    Map<String, dynamic>? backupData;

    if (backupFile.path.toLowerCase().endsWith('.zip') || _isZipBytes(bytes)) {
      final archive = ZipDecoder().decodeBytes(bytes);

      // Clean local documents directory before restoring
      if (await docsDir.exists()) {
        await docsDir.delete(recursive: true);
      }
      await docsDir.create(recursive: true);

      for (final file in archive) {
        final filename = file.name;
        if (file.isFile) {
          if (filename == 'backup_data.json' || filename.endsWith('/backup_data.json')) {
            final jsonStr = utf8.decode(file.content as List<int>);
            backupData = jsonDecode(jsonStr) as Map<String, dynamic>;
          } else if (filename.startsWith('customer_documents/')) {
            final subFileName = filename.replaceFirst('customer_documents/', '');
            if (subFileName.isNotEmpty) {
              final outFile = File('${docsDir.path}/$subFileName');
              await outFile.writeAsBytes(file.content as List<int>, flush: true);
            }
          }
        }
      }
    } else {
      // Legacy JSON support
      final jsonStr = utf8.decode(bytes);
      backupData = jsonDecode(jsonStr) as Map<String, dynamic>;

      final Map<String, dynamic> documentFiles = backupData['documentFiles'] ?? {};
      if (await docsDir.exists()) {
        await docsDir.delete(recursive: true);
      }
      await docsDir.create(recursive: true);

      for (final entry in documentFiles.entries) {
        final fileName = entry.key;
        final base64Str = entry.value as String;
        final fileBytes = base64Decode(base64Str);
        final file = File('${docsDir.path}/$fileName');
        await file.writeAsBytes(fileBytes, flush: true);
      }
    }

    if (backupData == null) {
      throw Exception('Invalid or corrupted backup archive');
    }

    final List<dynamic> customersJson = backupData['customers'] ?? [];
    final List<dynamic> companiesJson = backupData['companies'] ?? [];
    final List<dynamic> tasksJson = backupData['tasks'] ?? [];
    final List<dynamic> marketingLeadsJson = backupData['marketingLeads'] ?? [];
    final List<dynamic> performanceRecordsJson = backupData['performanceRecords'] ?? [];

    // Clear database and restore records in a single transaction
    await db.isar.writeTxn(() async {
      await db.isar.customers.clear();
      await db.isar.companys.clear();
      await db.isar.workTasks.clear();
      await db.isar.marketingLeads.clear();
      await db.isar.performanceRecords.clear();

      for (final json in companiesJson) {
        final company = _companyFromJson(json as Map<String, dynamic>);
        await db.isar.companys.put(company);
      }
      for (final json in customersJson) {
        final customer = _customerFromJson(json as Map<String, dynamic>);
        await db.isar.customers.put(customer);
      }
      for (final json in tasksJson) {
        final task = _taskFromJson(json as Map<String, dynamic>);
        await db.isar.workTasks.put(task);
      }
      for (final json in marketingLeadsJson) {
        final lead = _marketingLeadFromJson(json as Map<String, dynamic>);
        await db.isar.marketingLeads.put(lead);
      }
      for (final json in performanceRecordsJson) {
        final record = _performanceRecordFromJson(json as Map<String, dynamic>);
        await db.isar.performanceRecords.put(record);
      }
    });
  }

  bool _isZipBytes(List<int> bytes) {
    if (bytes.length < 4) return false;
    return bytes[0] == 0x50 && bytes[1] == 0x4B && bytes[2] == 0x03 && bytes[3] == 0x04;
  }

  // --- Serialization Mappers ---

  Map<String, dynamic> _customerToJson(Customer c) {
    return {
      'uuid': c.uuid,
      'customerId': c.customerId,
      'name': c.name,
      'fatherName': c.fatherName,
      'dateOfBirth': c.dateOfBirth?.toIso8601String(),
      'age': c.age,
      'maritalStatus': c.maritalStatus,
      'spouseName': c.spouseName,
      'nationality': c.nationality,
      'aadhaarNumber': c.aadhaarNumber,
      'qualification': c.qualification,
      'height': c.height,
      'weight': c.weight,
      'numberOfChildren': c.numberOfChildren,
      'childrenDOBs': c.childrenDOBs?.map((d) => d.toIso8601String()).toList(),
      'fatherAge': c.fatherAge,
      'motherAge': c.motherAge,
      'spouseAge': c.spouseAge,
      'brotherAge': c.brotherAge,
      'sisterAge': c.sisterAge,
      'familyDOB': c.familyDOB?.toIso8601String(),
      'employerBusinessName': c.employerBusinessName,
      'designation': c.designation,
      'natureOfBusiness': c.natureOfBusiness,
      'annualIncome': c.annualIncome,
      'officeContactNumber': c.officeContactNumber,
      'mobileNumber1': c.mobileNumber1,
      'mobileNumber2': c.mobileNumber2,
      'mobileNumber3': c.mobileNumber3,
      'mobileNumber4': c.mobileNumber4,
      'emailId': c.emailId,
      'panNumber': c.panNumber,
      'weddingAnniversary': c.weddingAnniversary?.toIso8601String(),
      'nomineeName': c.nomineeName,
      'nomineeRelationship': c.nomineeRelationship,
      'nomineeDOB': c.nomineeDOB?.toIso8601String(),
      'nomineeAge': c.nomineeAge,
      'nomineeFatherName': c.nomineeFatherName,
      'nomineePan': c.nomineePan,
      'nomineeMobile1': c.nomineeMobile1,
      'nomineeMobile2': c.nomineeMobile2,
      'nomineeEmail': c.nomineeEmail,
      'selfPolicyNumber': c.selfPolicyNumber,
      'selfAadhaarNumber': c.selfAadhaarNumber,
      'selfSumAssured1': c.selfSumAssured1,
      'selfSumAssured2': c.selfSumAssured2,
      'selfYearOfIssue': c.selfYearOfIssue,
      'selfCompany': c.selfCompany,
      'fatherPolicyNumber': c.fatherPolicyNumber,
      'fatherCompany': c.fatherCompany,
      'motherPolicyNumber': c.motherPolicyNumber,
      'motherCompany': c.motherCompany,
      'spousePolicyNumber': c.spousePolicyNumber,
      'spouseCompany': c.spouseCompany,
      'childrenPolicyNumber': c.childrenPolicyNumber,
      'childrenCompany': c.childrenCompany,
      'childrenPolicyNumbers': c.childrenPolicyNumbers,
      'childrenCompanies': c.childrenCompanies,
      'hasExistingPolicy': c.hasExistingPolicy,
      'existingSelfCompany': c.existingSelfCompany,
      'existingPolicyNumber': c.existingPolicyNumber,
      'existingDocDate': c.existingDocDate?.toIso8601String(),
      'healthProblems': c.healthProblems,
      'lifestyleHabits': c.lifestyleHabits,
      'pregnancyDetails': c.pregnancyDetails,
      'healthRemarks': c.healthRemarks,
      'hasPersonalAccident': c.hasPersonalAccident,
      'personalAccidentDate': c.personalAccidentDate?.toIso8601String(),
      'communicationAddress': c.communicationAddress,
      'permanentAddress': c.permanentAddress,
      'productName': c.productName,
      'premiumMode': c.premiumMode,
      'planSumAssured': c.planSumAssured,
      'rider': c.rider,
      'riskCover': c.riskCover,
      'pensionPlan': c.pensionPlan,
      'investmentPlan': c.investmentPlan,
      'mutualFunds': c.mutualFunds,
      'mediClaim': c.mediClaim,
      'moneyBackPolicy': c.moneyBackPolicy,
      'childrenEducationPlan': c.childrenEducationPlan,
      'reminderDate1': c.reminderDate1?.toIso8601String(),
      'reminderNote1': c.reminderNote1,
      'reminderDate2': c.reminderDate2?.toIso8601String(),
      'reminderNote2': c.reminderNote2,
      'referenceFriendName': c.referenceFriendName,
      'referenceMobile': c.referenceMobile,
      'referenceAge': c.referenceAge,
      'notes': c.notes,
      'updatedAt': c.updatedAt.toIso8601String(),
      'isDeleted': c.isDeleted,
      'assignedCompanyId': c.assignedCompanyId,
      'documents': c.documents.map((d) => {'documentName': d.documentName, 'fileName': d.fileName}).toList(),
      'plans': c.plans.map((p) => {
        'planTitle': p.planTitle,
        'productName': p.productName,
        'premium': p.premium,
        'mode': p.mode,
        'planSumAssured': p.planSumAssured,
        'rider': p.rider,
        'planDate': p.planDate?.toIso8601String(),
      }).toList(),
      'references': c.references.map((r) => {
        'name': r.name,
        'mobile': r.mobile,
        'age': r.age,
      }).toList(),
      'reminders': c.reminders.map((rem) => {
        'reminderTitle': rem.reminderTitle,
        'reminderDate': rem.reminderDate?.toIso8601String(),
        'note': rem.note,
      }).toList(),
    };
  }

  Customer _customerFromJson(Map<String, dynamic> json) {
    final c = Customer();
    c.uuid = json['uuid'] as String;
    c.customerId = json['customerId'] as String?;
    c.name = json['name'] as String;
    c.fatherName = json['fatherName'] as String?;
    c.dateOfBirth = json['dateOfBirth'] != null ? DateTime.parse(json['dateOfBirth'] as String) : null;
    c.age = json['age'] as String?;
    c.maritalStatus = json['maritalStatus'] as String?;
    c.spouseName = json['spouseName'] as String?;
    c.nationality = json['nationality'] as String?;
    c.aadhaarNumber = json['aadhaarNumber'] as String?;
    c.qualification = json['qualification'] as String?;
    c.height = json['height'] as String?;
    c.weight = json['weight'] as String?;
    c.numberOfChildren = json['numberOfChildren'] as int?;
    c.childrenDOBs = (json['childrenDOBs'] as List?)?.map((d) => DateTime.parse(d as String)).toList();
    c.fatherAge = json['fatherAge'] as String?;
    c.motherAge = json['motherAge'] as String?;
    c.spouseAge = json['spouseAge'] as String?;
    c.brotherAge = json['brotherAge'] as String?;
    c.sisterAge = json['sisterAge'] as String?;
    c.familyDOB = json['familyDOB'] != null ? DateTime.parse(json['familyDOB'] as String) : null;
    c.employerBusinessName = json['employerBusinessName'] as String?;
    c.designation = json['designation'] as String?;
    c.natureOfBusiness = json['natureOfBusiness'] as String?;
    c.annualIncome = json['annualIncome'] as String?;
    c.officeContactNumber = json['officeContactNumber'] as String?;
    c.mobileNumber1 = json['mobileNumber1'] as String?;
    c.mobileNumber2 = json['mobileNumber2'] as String?;
    c.mobileNumber3 = json['mobileNumber3'] as String?;
    c.mobileNumber4 = json['mobileNumber4'] as String?;
    c.emailId = json['emailId'] as String?;
    c.panNumber = json['panNumber'] as String?;
    c.weddingAnniversary = json['weddingAnniversary'] != null ? DateTime.parse(json['weddingAnniversary'] as String) : null;
    c.nomineeName = json['nomineeName'] as String?;
    c.nomineeRelationship = json['nomineeRelationship'] as String?;
    c.nomineeDOB = json['nomineeDOB'] != null ? DateTime.parse(json['nomineeDOB'] as String) : null;
    c.nomineeAge = json['nomineeAge'] as String?;
    c.nomineeFatherName = json['nomineeFatherName'] as String?;
    c.nomineePan = json['nomineePan'] as String?;
    c.nomineeMobile1 = json['nomineeMobile1'] as String?;
    c.nomineeMobile2 = json['nomineeMobile2'] as String?;
    c.nomineeEmail = json['nomineeEmail'] as String?;
    c.selfPolicyNumber = json['selfPolicyNumber'] as String?;
    c.selfAadhaarNumber = json['selfAadhaarNumber'] as String?;
    c.selfSumAssured1 = json['selfSumAssured1'] as String?;
    c.selfSumAssured2 = json['selfSumAssured2'] as String?;
    c.selfYearOfIssue = json['selfYearOfIssue'] as String?;
    c.selfCompany = json['selfCompany'] as String?;
    c.fatherPolicyNumber = json['fatherPolicyNumber'] as String?;
    c.fatherCompany = json['fatherCompany'] as String?;
    c.motherPolicyNumber = json['motherPolicyNumber'] as String?;
    c.motherCompany = json['motherCompany'] as String?;
    c.spousePolicyNumber = json['spousePolicyNumber'] as String?;
    c.spouseCompany = json['spouseCompany'] as String?;
    c.childrenPolicyNumber = json['childrenPolicyNumber'] as String?;
    c.childrenCompany = json['childrenCompany'] as String?;
    c.childrenPolicyNumbers = (json['childrenPolicyNumbers'] as List?)?.map((e) => e as String).toList();
    c.childrenCompanies = (json['childrenCompanies'] as List?)?.map((e) => e as String).toList();
    c.hasExistingPolicy = json['hasExistingPolicy'] as String?;
    c.existingSelfCompany = json['existingSelfCompany'] as String?;
    c.existingPolicyNumber = json['existingPolicyNumber'] as String?;
    c.existingDocDate = json['existingDocDate'] != null ? DateTime.parse(json['existingDocDate'] as String) : null;
    c.healthProblems = json['healthProblems'] as String?;
    c.lifestyleHabits = json['lifestyleHabits'] as String?;
    c.pregnancyDetails = json['pregnancyDetails'] as String?;
    c.healthRemarks = json['healthRemarks'] as String?;
    c.hasPersonalAccident = json['hasPersonalAccident'] as String?;
    c.personalAccidentDate = json['personalAccidentDate'] != null ? DateTime.parse(json['personalAccidentDate'] as String) : null;
    c.communicationAddress = json['communicationAddress'] as String?;
    c.permanentAddress = json['permanentAddress'] as String?;
    c.productName = json['productName'] as String?;
    c.premiumMode = json['premiumMode'] as String?;
    c.planSumAssured = json['planSumAssured'] as String?;
    c.rider = json['rider'] as String?;
    c.riskCover = json['riskCover'] as String?;
    c.pensionPlan = json['pensionPlan'] as String?;
    c.investmentPlan = json['investmentPlan'] as String?;
    c.mutualFunds = json['mutualFunds'] as String?;
    c.mediClaim = json['mediClaim'] as String?;
    c.moneyBackPolicy = json['moneyBackPolicy'] as String?;
    c.childrenEducationPlan = json['childrenEducationPlan'] as String?;
    c.reminderDate1 = json['reminderDate1'] != null ? DateTime.parse(json['reminderDate1'] as String) : null;
    c.reminderNote1 = json['reminderNote1'] as String?;
    c.reminderDate2 = json['reminderDate2'] != null ? DateTime.parse(json['reminderDate2'] as String) : null;
    c.reminderNote2 = json['reminderNote2'] as String?;
    c.referenceFriendName = json['referenceFriendName'] as String?;
    c.referenceMobile = json['referenceMobile'] as String?;
    c.referenceAge = json['referenceAge'] as String?;
    c.notes = json['notes'] as String?;
    c.updatedAt = DateTime.parse(json['updatedAt'] as String);
    c.isDeleted = json['isDeleted'] as bool? ?? false;
    c.assignedCompanyId = json['assignedCompanyId'] as int?;
    if (json['documents'] != null) {
      c.documents = (json['documents'] as List)
          .map((d) => CustomerDocument()
            ..documentName = d['documentName'] as String?
            ..fileName = d['fileName'] as String?)
          .toList();
    }
    if (json['plans'] != null) {
      c.plans = (json['plans'] as List)
          .map((p) => CustomerPlanItem()
            ..planTitle = p['planTitle'] as String?
            ..productName = p['productName'] as String?
            ..premium = p['premium'] as String?
            ..mode = p['mode'] as String?
            ..planSumAssured = p['planSumAssured'] as String?
            ..rider = p['rider'] as String?
            ..planDate = p['planDate'] != null ? DateTime.parse(p['planDate'] as String) : null)
          .toList();
    }
    if (json['references'] != null) {
      c.references = (json['references'] as List)
          .map((r) => CustomerReferenceItem()
            ..name = r['name'] as String?
            ..mobile = r['mobile'] as String?
            ..age = r['age'] as String?)
          .toList();
    }
    if (json['reminders'] != null) {
      c.reminders = (json['reminders'] as List)
          .map((rem) => CustomerReminderItem()
            ..reminderTitle = rem['reminderTitle'] as String?
            ..reminderDate = rem['reminderDate'] != null ? DateTime.parse(rem['reminderDate'] as String) : null
            ..note = rem['note'] as String?)
          .toList();
    }
    return c;
  }

  Map<String, dynamic> _companyToJson(Company c) {
    return {
      'uuid': c.uuid,
      'name': c.name,
      'referenceNumber': c.referenceNumber,
      'tabIndex': c.tabIndex,
      'updatedAt': c.updatedAt.toIso8601String(),
      'isDeleted': c.isDeleted,
    };
  }

  Company _companyFromJson(Map<String, dynamic> json) {
    final c = Company();
    c.uuid = json['uuid'] as String;
    c.name = json['name'] as String;
    c.referenceNumber = json['referenceNumber'] as String?;
    c.tabIndex = json['tabIndex'] as int? ?? 0;
    c.updatedAt = DateTime.parse(json['updatedAt'] as String);
    c.isDeleted = json['isDeleted'] as bool? ?? false;
    return c;
  }

  Map<String, dynamic> _taskToJson(WorkTask t) {
    return {
      'uuid': t.uuid,
      'companyId': t.companyId,
      'description': t.description,
      'workDate': t.workDate.toIso8601String(),
      'assignedDate': t.assignedDate?.toIso8601String(),
      'priority': t.priority,
      'assignedTo': t.assignedTo,
      'communicationMethod': t.communicationMethod,
      'status': t.status,
      'carryForwardRequired': t.carryForwardRequired,
      'carryForwardDate': t.carryForwardDate?.toIso8601String(),
      'carryForwardReason': t.carryForwardReason,
      'remarks': t.remarks,
      'updatedAt': t.updatedAt.toIso8601String(),
      'isDeleted': t.isDeleted,
    };
  }

  WorkTask _taskFromJson(Map<String, dynamic> json) {
    final t = WorkTask();
    t.uuid = json['uuid'] as String;
    t.companyId = json['companyId'] as int?;
    t.description = json['description'] as String;
    t.workDate = DateTime.parse(json['workDate'] as String);
    t.assignedDate = json['assignedDate'] != null ? DateTime.parse(json['assignedDate'] as String) : null;
    t.priority = json['priority'] as String;
    t.assignedTo = json['assignedTo'] as String?;
    t.communicationMethod = json['communicationMethod'] as String?;
    t.status = json['status'] as String;
    t.carryForwardRequired = json['carryForwardRequired'] as bool? ?? false;
    t.carryForwardDate = json['carryForwardDate'] != null ? DateTime.parse(json['carryForwardDate'] as String) : null;
    t.carryForwardReason = json['carryForwardReason'] as String?;
    t.remarks = json['remarks'] as String?;
    t.updatedAt = DateTime.parse(json['updatedAt'] as String);
    t.isDeleted = json['isDeleted'] as bool? ?? false;
    return t;
  }

  Map<String, dynamic> _marketingLeadToJson(MarketingLead m) {
    return {
      'uuid': m.uuid,
      'name': m.name,
      'mobile': m.mobile,
      'status': m.status,
      'updatedAt': m.updatedAt.toIso8601String(),
      'isDeleted': m.isDeleted,
      'visits': m.visits.map((v) => {
        'visitDate': v.visitDate?.toIso8601String(),
        'visitTime': v.visitTime,
        'visitNote': v.visitNote,
        'attachedPhoto': v.attachedPhoto,
        'attachedPhotos': v.attachedPhotos,
      }).toList(),
    };
  }

  MarketingLead _marketingLeadFromJson(Map<String, dynamic> json) {
    final m = MarketingLead();
    m.uuid = json['uuid'] as String;
    m.name = json['name'] as String;
    m.mobile = json['mobile'] as String;
    m.status = json['status'] as String;
    m.updatedAt = DateTime.parse(json['updatedAt'] as String);
    m.isDeleted = json['isDeleted'] as bool? ?? false;
    if (json['visits'] != null) {
      m.visits = (json['visits'] as List).map((v) {
        final visit = MarketingVisit();
        visit.visitDate = v['visitDate'] != null ? DateTime.parse(v['visitDate'] as String) : null;
        visit.visitTime = v['visitTime'] as String?;
        visit.visitNote = v['visitNote'] as String?;
        visit.attachedPhoto = v['attachedPhoto'] as String?;
        visit.attachedPhotos = (v['attachedPhotos'] as List?)?.map((e) => e as String).toList() ?? [];
        return visit;
      }).toList();
    }
    return m;
  }

  Map<String, dynamic> _performanceRecordToJson(PerformanceRecord p) {
    return {
      'year': p.year,
      'month': p.month,
      'urgent': p.urgent,
      'newBusiness': p.newBusiness,
      'life': p.life,
      'fireHealthPa': p.fireHealthPa,
      'earned': p.earned,
      'box2Row1Days': p.box2Row1Days,
      'box2EarningsOnWorkedDays': p.box2EarningsOnWorkedDays,
      'box2Row2Days': p.box2Row2Days,
      'box2TotalWorkingDay': p.box2TotalWorkingDay,
      'box3JjWorkwayCol1': p.box3JjWorkwayCol1,
      'box3JjWorkwayCol2': p.box3JjWorkwayCol2,
      'box3JjWorkwayCol3': p.box3JjWorkwayCol3,
      'box3JjWorkwayCol4': p.box3JjWorkwayCol4,
      'box3TargetCol1': p.box3TargetCol1,
      'box3TargetCol2': p.box3TargetCol2,
      'box3TargetCol3': p.box3TargetCol3,
      'box3TargetCol4': p.box3TargetCol4,
      'box3YyCol1': p.box3YyCol1,
      'box3YyCol2': p.box3YyCol2,
      'box3YyCol3': p.box3YyCol3,
      'box3YyCol4': p.box3YyCol4,
      'box3ZzCol1': p.box3ZzCol1,
      'box3ZzCol2': p.box3ZzCol2,
      'box3ZzCol3': p.box3ZzCol3,
      'box3ZzCol4': p.box3ZzCol4,
      'box3PercentageCol1': p.box3PercentageCol1,
      'box3PercentageCol2': p.box3PercentageCol2,
      'box3PercentageCol3': p.box3PercentageCol3,
      'box3PercentageCol4': p.box3PercentageCol4,
      'box3Col6Col1': p.box3Col6Col1,
      'box3Col6Col2': p.box3Col6Col2,
      'box3Col6Col3': p.box3Col6Col3,
      'box3Col6Col4': p.box3Col6Col4,
      'box3Col7Col1': p.box3Col7Col1,
      'box3Col7Col2': p.box3Col7Col2,
      'box3Col7Col3': p.box3Col7Col3,
      'box3Col7Col4': p.box3Col7Col4,
      'box3ColHeaders': p.box3ColHeaders,
      'box3RowHeaders': p.box3RowHeaders,
      'box4Balance': p.box4Balance,
      'box4Target': p.box4Target,
      'box4Achieved': p.box4Achieved,
      'topicHeaders': p.topicHeaders,
      'updatedAt': p.updatedAt.toIso8601String(),
      'topicRows': p.topicRows.map((r) => {
        'dateStr': r.dateStr,
        'values': r.values,
      }).toList(),
    };
  }

  PerformanceRecord _performanceRecordFromJson(Map<String, dynamic> json) {
    final p = PerformanceRecord();
    p.year = json['year'] as int;
    p.month = json['month'] as int;
    p.urgent = json['urgent'] as String? ?? '';
    p.newBusiness = json['newBusiness'] as String? ?? '';
    p.life = json['life'] as String? ?? '';
    p.fireHealthPa = json['fireHealthPa'] as String? ?? '';
    p.earned = json['earned'] as String? ?? '';
    p.box2Row1Days = json['box2Row1Days'] as String? ?? '';
    p.box2EarningsOnWorkedDays = json['box2EarningsOnWorkedDays'] as String? ?? '';
    p.box2Row2Days = json['box2Row2Days'] as String? ?? '';
    p.box2TotalWorkingDay = json['box2TotalWorkingDay'] as String? ?? '';
    p.box3JjWorkwayCol1 = json['box3JjWorkwayCol1'] as String? ?? '';
    p.box3JjWorkwayCol2 = json['box3JjWorkwayCol2'] as String? ?? '';
    p.box3JjWorkwayCol3 = json['box3JjWorkwayCol3'] as String? ?? '';
    p.box3JjWorkwayCol4 = json['box3JjWorkwayCol4'] as String? ?? '';
    p.box3TargetCol1 = json['box3TargetCol1'] as String? ?? '';
    p.box3TargetCol2 = json['box3TargetCol2'] as String? ?? '';
    p.box3TargetCol3 = json['box3TargetCol3'] as String? ?? '';
    p.box3TargetCol4 = json['box3TargetCol4'] as String? ?? '';
    p.box3YyCol1 = json['box3YyCol1'] as String? ?? '';
    p.box3YyCol2 = json['box3YyCol2'] as String? ?? '';
    p.box3YyCol3 = json['box3YyCol3'] as String? ?? '';
    p.box3YyCol4 = json['box3YyCol4'] as String? ?? '';
    p.box3ZzCol1 = json['box3ZzCol1'] as String? ?? '';
    p.box3ZzCol2 = json['box3ZzCol2'] as String? ?? '';
    p.box3ZzCol3 = json['box3ZzCol3'] as String? ?? '';
    p.box3ZzCol4 = json['box3ZzCol4'] as String? ?? '';
    p.box3PercentageCol1 = json['box3PercentageCol1'] as String? ?? '';
    p.box3PercentageCol2 = json['box3PercentageCol2'] as String? ?? '';
    p.box3PercentageCol3 = json['box3PercentageCol3'] as String? ?? '';
    p.box3PercentageCol4 = json['box3PercentageCol4'] as String? ?? '';
    p.box3Col6Col1 = json['box3Col6Col1'] as String? ?? '';
    p.box3Col6Col2 = json['box3Col6Col2'] as String? ?? '';
    p.box3Col6Col3 = json['box3Col6Col3'] as String? ?? '';
    p.box3Col6Col4 = json['box3Col6Col4'] as String? ?? '';
    p.box3Col7Col1 = json['box3Col7Col1'] as String? ?? '';
    p.box3Col7Col2 = json['box3Col7Col2'] as String? ?? '';
    p.box3Col7Col3 = json['box3Col7Col3'] as String? ?? '';
    p.box3Col7Col4 = json['box3Col7Col4'] as String? ?? '';
    p.box3ColHeaders = (json['box3ColHeaders'] as List?)?.map((e) => e as String).toList() ?? [];
    p.box3RowHeaders = (json['box3RowHeaders'] as List?)?.map((e) => e as String).toList() ?? [];
    p.box4Balance = json['box4Balance'] as String? ?? '';
    p.box4Target = json['box4Target'] as String? ?? '';
    p.box4Achieved = json['box4Achieved'] as String? ?? '';
    p.topicHeaders = (json['topicHeaders'] as List?)?.map((e) => e as String).toList() ?? [];
    p.updatedAt = json['updatedAt'] != null ? DateTime.parse(json['updatedAt'] as String) : DateTime.now();
    if (json['topicRows'] != null) {
      p.topicRows = (json['topicRows'] as List).map((r) {
        final row = TopicTableRow();
        row.dateStr = r['dateStr'] as String? ?? '';
        row.values = (r['values'] as List?)?.map((e) => e as String).toList() ?? [];
        return row;
      }).toList();
    }
    return p;
  }
}
