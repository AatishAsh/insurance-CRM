import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'database_service.dart';
import '../models/customer.dart';
import '../models/company.dart';
import '../models/work_task.dart';

final backupServiceProvider = Provider<BackupService>((ref) {
  final db = ref.watch(databaseServiceProvider);
  return BackupService(db);
});

class BackupService {
  final DatabaseService db;
  BackupService(this.db);

  Future<Map<String, dynamic>> exportBackup() async {
    final customers = await db.isar.customers.where().findAll();
    final companies = await db.isar.companys.where().findAll();
    final tasks = await db.isar.workTasks.where().findAll();

    final customersJson = customers.map((c) => _customerToJson(c)).toList();
    final companiesJson = companies.map((c) => _companyToJson(c)).toList();
    final tasksJson = tasks.map((t) => _taskToJson(t)).toList();

    // Export files
    final Map<String, String> documentFiles = {};
    final appDir = await getApplicationDocumentsDirectory();
    final docsDir = Directory('${appDir.path}/customer_documents');
    if (await docsDir.exists()) {
      final List<FileSystemEntity> files = docsDir.listSync();
      for (final entity in files) {
        if (entity is File) {
          final bytes = await entity.readAsBytes();
          final base64Str = base64Encode(bytes);
          final fileName = p.basename(entity.path);
          documentFiles[fileName] = base64Str;
        }
      }
    }

    return {
      'version': 1,
      'exportedAt': DateTime.now().toIso8601String(),
      'customers': customersJson,
      'companies': companiesJson,
      'tasks': tasksJson,
      'documentFiles': documentFiles,
    };
  }

  Future<void> importBackup(Map<String, dynamic> backup) async {
    final List<dynamic> customersJson = backup['customers'] ?? [];
    final List<dynamic> companiesJson = backup['companies'] ?? [];
    final List<dynamic> tasksJson = backup['tasks'] ?? [];
    final Map<String, dynamic> documentFiles = backup['documentFiles'] ?? {};

    final appDir = await getApplicationDocumentsDirectory();
    final docsDir = Directory('${appDir.path}/customer_documents');

    // 1. Clear and restore local document files
    if (await docsDir.exists()) {
      await docsDir.delete(recursive: true);
    }
    await docsDir.create(recursive: true);

    for (final entry in documentFiles.entries) {
      final fileName = entry.key;
      final base64Str = entry.value as String;
      final bytes = base64Decode(base64Str);
      final file = File('${docsDir.path}/$fileName');
      await file.writeAsBytes(bytes);
    }

    // 2. Clear database and restore records in a single transaction
    await db.isar.writeTxn(() async {
      await db.isar.customers.clear();
      await db.isar.companys.clear();
      await db.isar.workTasks.clear();

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
    });
  }

  // --- Serialization Mappers ---

  Map<String, dynamic> _customerToJson(Customer c) {
    return {
      'uuid': c.uuid,
      'customerId': c.customerId,
      'name': c.name,
      'fatherName': c.fatherName,
      'dateOfBirth': c.dateOfBirth?.toIso8601String(),
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
      'healthProblems': c.healthProblems,
      'lifestyleHabits': c.lifestyleHabits,
      'pregnancyDetails': c.pregnancyDetails,
      'healthRemarks': c.healthRemarks,
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
        'productName': p.productName,
        'premium': p.premium,
        'mode': p.mode,
        'planSumAssured': p.planSumAssured,
        'rider': p.rider,
      }).toList(),
      'references': c.references.map((r) => {
        'name': r.name,
        'mobile': r.mobile,
        'age': r.age,
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
    c.healthProblems = json['healthProblems'] as String?;
    c.lifestyleHabits = json['lifestyleHabits'] as String?;
    c.pregnancyDetails = json['pregnancyDetails'] as String?;
    c.healthRemarks = json['healthRemarks'] as String?;
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
            ..productName = p['productName'] as String?
            ..premium = p['premium'] as String?
            ..mode = p['mode'] as String?
            ..planSumAssured = p['planSumAssured'] as String?
            ..rider = p['rider'] as String?)
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
    return c;
  }

  Map<String, dynamic> _companyToJson(Company c) {
    return {
      'uuid': c.uuid,
      'name': c.name,
      'referenceNumber': c.referenceNumber,
      'updatedAt': c.updatedAt.toIso8601String(),
      'isDeleted': c.isDeleted,
    };
  }

  Company _companyFromJson(Map<String, dynamic> json) {
    final c = Company();
    c.uuid = json['uuid'] as String;
    c.name = json['name'] as String;
    c.referenceNumber = json['referenceNumber'] as String?;
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
}
