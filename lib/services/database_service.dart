import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'app_storage_service.dart';
import '../models/customer.dart';
import '../models/company.dart';
import '../models/insurance_company.dart';
import '../models/work_task.dart';
import '../models/marketing_lead.dart';
import '../models/performance_record.dart';
import '../models/daily_note.dart';


final databaseServiceProvider = Provider<DatabaseService>((ref) {
  throw UnimplementedError('databaseServiceProvider must be overridden in main');
});

class DatabaseService {
  final Isar isar;
  final Uuid _uuid = const Uuid();

  DatabaseService(this.isar);

  static Future<DatabaseService> init() async {
    final dir = await getApplicationDocumentsDirectory();
    final isarInstance = await Isar.open(
      [CustomerSchema, CompanySchema, InsuranceCompanySchema, WorkTaskSchema, MarketingLeadSchema, PerformanceRecordSchema, DailyNoteSchema],
      directory: dir.path,
      inspector: true, // Enables Isar Inspector in debug mode
    );

    final service = DatabaseService(isarInstance);
    await service._seedCompaniesIfNeeded();
    return service;
  }

  // --- INSURANCE COMPANY OPERATIONS ---

  Future<List<InsuranceCompany>> getInsuranceCompanies() async {
    return await isar.insuranceCompanys.filter().isDeletedEqualTo(false).sortByName().findAll();
  }

  Future<void> saveInsuranceCompany(String name) async {
    final cleanName = name.trim();
    if (cleanName.isEmpty) return;

    final activeCount = await isar.insuranceCompanys.filter().isDeletedEqualTo(false).count();
    if (activeCount >= 15) {
      throw Exception('Maximum limit of 15 insurance companies reached.');
    }

    final existing = await isar.insuranceCompanys.filter().nameEqualTo(cleanName, caseSensitive: false).findFirst();
    if (existing != null) {
      if (existing.isDeleted) {
        existing.isDeleted = false;
        existing.updatedAt = DateTime.now();
        await isar.writeTxn(() async {
          await isar.insuranceCompanys.put(existing);
        });
      }
      return;
    }

    final company = InsuranceCompany()
      ..uuid = _uuid.v4()
      ..name = cleanName
      ..updatedAt = DateTime.now()
      ..isDeleted = false;

    await isar.writeTxn(() async {
      await isar.insuranceCompanys.put(company);
    });
  }

  Future<void> deleteInsuranceCompany(int id) async {
    final company = await isar.insuranceCompanys.get(id);
    if (company != null) {
      company.isDeleted = true;
      company.updatedAt = DateTime.now();
      await isar.writeTxn(() async {
        await isar.insuranceCompanys.put(company);
      });
    }
  }

  Future<void> renameInsuranceCompany(InsuranceCompany company, String oldName, String newName) async {
    final cleanNewName = newName.trim();
    if (cleanNewName.isEmpty || oldName == cleanNewName) return;

    final existing = await isar.insuranceCompanys.filter().nameEqualTo(cleanNewName, caseSensitive: false).findFirst();
    if (existing != null && existing.id != company.id && !existing.isDeleted) {
      throw Exception('An insurance company with this name already exists.');
    }

    await isar.writeTxn(() async {
      company.name = cleanNewName;
      company.updatedAt = DateTime.now();
      await isar.insuranceCompanys.put(company);

      // Cascade updated name across customer insurance fields
      final customers = await isar.customers.filter().isDeletedEqualTo(false).findAll();
      for (final c in customers) {
        bool updated = false;
        if (c.selfCompany == oldName) {
          c.selfCompany = cleanNewName;
          updated = true;
        }
        if (c.fatherCompany == oldName) {
          c.fatherCompany = cleanNewName;
          updated = true;
        }
        if (c.motherCompany == oldName) {
          c.motherCompany = cleanNewName;
          updated = true;
        }
        if (c.spouseCompany == oldName) {
          c.spouseCompany = cleanNewName;
          updated = true;
        }
        if (c.childrenCompany == oldName) {
          c.childrenCompany = cleanNewName;
          updated = true;
        }
        if (updated) {
          await isar.customers.put(c);
        }
      }
    });
  }

  // --- COMPANY OPERATIONS ---

  Future<void> _seedCompaniesIfNeeded() async {
    final existingCompanies = await isar.companys.filter().isDeletedEqualTo(false).findAll();

    if (existingCompanies.isEmpty) {
      await isar.writeTxn(() async {
        // Tab 1 (Index 0): 15 Companies
        for (int i = 1; i <= 15; i++) {
          final company = Company()
            ..uuid = 'seed_company_uuid_tab1_$i'
            ..name = 'Company $i'
            ..referenceNumber = 'REF-${100 + i}'
            ..tabIndex = 0
            ..updatedAt = DateTime.now()
            ..isDeleted = false;
          await isar.companys.put(company);
        }
        // Tab 2 (Index 1): 10 Companies
        for (int i = 1; i <= 10; i++) {
          final company = Company()
            ..uuid = 'seed_company_uuid_tab2_$i'
            ..name = 'Company ${15 + i}'
            ..referenceNumber = 'REF-${115 + i}'
            ..tabIndex = 1
            ..updatedAt = DateTime.now()
            ..isDeleted = false;
          await isar.companys.put(company);
        }
        // Tab 3 (Index 2): 5 Companies
        for (int i = 1; i <= 5; i++) {
          final company = Company()
            ..uuid = 'seed_company_uuid_tab3_$i'
            ..name = 'Company ${25 + i}'
            ..referenceNumber = 'REF-${125 + i}'
            ..tabIndex = 2
            ..updatedAt = DateTime.now()
            ..isDeleted = false;
          await isar.companys.put(company);
        }
      });
    } else {
      // Re-save existing companies to ensure new tabIndex field is persisted on disk
      await isar.writeTxn(() async {
        for (final c in existingCompanies) {
          await isar.companys.put(c);
        }
      });

      // Migration: Ensure Tab 2 and Tab 3 have initial seed data if upgrading from previous single-tab version
      final tab2Count = existingCompanies.where((c) => c.tabIndex == 1).length;
      final tab3Count = existingCompanies.where((c) => c.tabIndex == 2).length;

      if (tab2Count == 0 && tab3Count == 0) {
        await isar.writeTxn(() async {
          for (int i = 1; i <= 10; i++) {
            final company = Company()
              ..uuid = 'seed_company_uuid_tab2_$i'
              ..name = 'Company ${15 + i}'
              ..referenceNumber = 'REF-${115 + i}'
              ..tabIndex = 1
              ..updatedAt = DateTime.now()
              ..isDeleted = false;
            await isar.companys.put(company);
          }
          for (int i = 1; i <= 5; i++) {
            final company = Company()
              ..uuid = 'seed_company_uuid_tab3_$i'
              ..name = 'Company ${25 + i}'
              ..referenceNumber = 'REF-${125 + i}'
              ..tabIndex = 2
              ..updatedAt = DateTime.now()
              ..isDeleted = false;
            await isar.companys.put(company);
          }
        });
      }
    }
  }

  Future<List<Company>> getCompanies() async {
    return await isar.companys.filter().isDeletedEqualTo(false).findAll();
  }

  Future<List<Company>> getCompaniesForTab(int tabIndex) async {
    final all = await isar.companys.filter().isDeletedEqualTo(false).findAll();
    return all.where((c) => c.tabIndex == tabIndex).toList();
  }

  Future<Company?> getCompanyById(int id) async {
    return await isar.companys.get(id);
  }

  Future<void> addCompanyToTab(String name, int tabIndex, {String? referenceNumber}) async {
    final cleanName = name.trim();
    if (cleanName.isEmpty) return;

    final activeInTab = await getCompaniesForTab(tabIndex);
    if (activeInTab.length >= 15) {
      throw Exception('Maximum limit of 15 companies reached for this tab.');
    }

    final company = Company()
      ..uuid = _uuid.v4()
      ..name = cleanName
      ..referenceNumber = referenceNumber?.trim().isNotEmpty == true ? referenceNumber!.trim() : null
      ..tabIndex = tabIndex
      ..updatedAt = DateTime.now()
      ..isDeleted = false;

    await isar.writeTxn(() async {
      await isar.companys.put(company);
    });
  }

  Future<void> saveCompany(Company company) async {
    company.updatedAt = DateTime.now();
    await isar.writeTxn(() async {
      await isar.companys.put(company);
    });
  }

  Future<void> renameCompany(Company company, String oldName, String newName) async {
    company.name = newName;
    company.updatedAt = DateTime.now();

    await isar.writeTxn(() async {
      await isar.companys.put(company);

      if (oldName.trim().isNotEmpty && oldName != newName) {
        final customers = await isar.customers.filter().isDeletedEqualTo(false).findAll();
        for (final c in customers) {
          bool updated = false;
          if (c.selfCompany == oldName) {
            c.selfCompany = newName;
            updated = true;
          }
          if (c.fatherCompany == oldName) {
            c.fatherCompany = newName;
            updated = true;
          }
          if (c.motherCompany == oldName) {
            c.motherCompany = newName;
            updated = true;
          }
          if (c.spouseCompany == oldName) {
            c.spouseCompany = newName;
            updated = true;
          }
          if (c.childrenCompany == oldName) {
            c.childrenCompany = newName;
            updated = true;
          }
          if (updated) {
            c.updatedAt = DateTime.now();
            await isar.customers.put(c);
          }
        }
      }
    });
  }

  // --- CUSTOMER OPERATIONS ---

  Future<List<Customer>> getCustomers({String? searchQuery}) async {
    final all = await isar.customers.filter().isDeletedEqualTo(false).findAll();
    if (searchQuery == null || searchQuery.trim().isEmpty) {
      return all;
    }

    final keywords = searchQuery.toLowerCase().split(' ').where((k) => k.isNotEmpty).toList();
    return all.where((cust) {
      return keywords.every((keyword) {
        final nameMatch = cust.name.toLowerCase().contains(keyword);
        final idMatch = cust.customerId?.toLowerCase().contains(keyword) ?? false;
        final familyMatch = cust.familyId?.toLowerCase().contains(keyword) ?? false;
        final fatherMatch = cust.fatherName?.toLowerCase().contains(keyword) ?? false;
        final mobileMatch = (cust.mobileNumber1?.toLowerCase().contains(keyword) ?? false) ||
            (cust.mobileNumber2?.toLowerCase().contains(keyword) ?? false);
        final policyMatch = cust.selfPolicyNumber?.toLowerCase().contains(keyword) ?? false;
        final docMatch = cust.documents.any((doc) =>
            (doc.documentName?.toLowerCase().contains(keyword) ?? false) ||
            (doc.fileName?.toLowerCase().contains(keyword) ?? false));
        return nameMatch || idMatch || familyMatch || fatherMatch || mobileMatch || policyMatch || docMatch;
      });
    }).toList();
  }

  Future<Customer?> getCustomerById(int id) async {
    return await isar.customers.get(id);
  }

  Future<void> saveCustomer(Customer customer) async {
    if (customer.uuid.isEmpty) {
      customer.uuid = _uuid.v4();
    }
    customer.updatedAt = DateTime.now();
    await isar.writeTxn(() async {
      await isar.customers.put(customer);
    });
  }

  Future<void> deleteCustomer(int id) async {
    final customer = await isar.customers.get(id);
    if (customer != null) {
      customer.isDeleted = true;
      customer.updatedAt = DateTime.now();
      await isar.writeTxn(() async {
        await isar.customers.put(customer);
      });
    }
  }

  // --- WORK TASK OPERATIONS ---

  Future<List<WorkTask>> getTasksForCompany(int companyId, [DateTime? date]) async {
    if (date == null) {
      return await isar.workTasks
          .filter()
          .companyIdEqualTo(companyId)
          .isDeletedEqualTo(false)
          .sortByWorkDateDesc()
          .findAll();
    }
    
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
    
    return await isar.workTasks
        .filter()
        .companyIdEqualTo(companyId)
        .workDateBetween(startOfDay, endOfDay)
        .isDeletedEqualTo(false)
        .sortByWorkDateDesc()
        .findAll();
  }

  Future<List<WorkTask>> getTasksForDate(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
    
    return await isar.workTasks
        .filter()
        .workDateBetween(startOfDay, endOfDay)
        .isDeletedEqualTo(false)
        .findAll();
  }

  Future<void> saveTask(WorkTask task) async {
    if (task.uuid.isEmpty) {
      task.uuid = _uuid.v4();
    }
    task.updatedAt = DateTime.now();
    await isar.writeTxn(() async {
      await isar.workTasks.put(task);
    });
  }

  Future<void> deleteTask(int id) async {
    final task = await isar.workTasks.get(id);
    if (task != null) {
      task.isDeleted = true;
      task.updatedAt = DateTime.now();
      await isar.writeTxn(() async {
        await isar.workTasks.put(task);
      });
    }
  }

  /// Automatically carries forward incomplete tasks that are flagged for carry forward from previous days.
  /// Cloning them to the specified date.
  Future<int> carryForwardIncompleteTasks(DateTime targetDate) async {
    final targetStart = DateTime(targetDate.year, targetDate.month, targetDate.day);
    final targetEnd = DateTime(targetDate.year, targetDate.month, targetDate.day, 23, 59, 59, 999);

    // Find all incomplete tasks before the target date that need carry forward and aren't deleted
    final carryForwardableTasks = await isar.workTasks
        .filter()
        .workDateLessThan(targetStart)
        .not()
        .statusEqualTo('Completed')
        .carryForwardRequiredEqualTo(true)
        .isDeletedEqualTo(false)
        .findAll();

    int carriedCount = 0;
    await isar.writeTxn(() async {
      for (final oldTask in carryForwardableTasks) {
        // Check if we already carried this task forward to the target date to avoid duplicates
        final alreadyCarried = await isar.workTasks
            .filter()
            .companyIdEqualTo(oldTask.companyId)
            .descriptionEqualTo(oldTask.description)
            .workDateBetween(targetStart, targetEnd)
            .isDeletedEqualTo(false)
            .count();

        if (alreadyCarried == 0) {
          final newTask = WorkTask()
            ..uuid = _uuid.v4()
            ..companyId = oldTask.companyId
            ..description = oldTask.description
            ..workDate = targetDate
            ..assignedDate = oldTask.assignedDate
            ..priority = oldTask.priority
            ..assignedTo = oldTask.assignedTo
            ..communicationMethod = oldTask.communicationMethod
            ..status = 'Pending' // Reset to pending for the new day
            ..carryForwardRequired = true
            ..carryForwardDate = oldTask.workDate // Record source date
            ..carryForwardReason = oldTask.carryForwardReason ?? 'Auto carry forward'
            ..remarks = 'Carried forward from ${oldTask.workDate.year}-${oldTask.workDate.month}-${oldTask.workDate.day}'
            ..updatedAt = DateTime.now()
            ..isDeleted = false;

          await isar.workTasks.put(newTask);
          carriedCount++;
        }
      }
    });

    return carriedCount;
  }

  /// Completely clears all database collections and physical attachment files from local storage.
  Future<void> clearAllData() async {
    await isar.writeTxn(() async {
      await isar.customers.clear();
      await isar.companys.clear();
      await isar.workTasks.clear();
      await isar.marketingLeads.clear();
      await isar.performanceRecords.clear();
      await isar.insuranceCompanys.clear();
    });

    // Clean up physical document files
    try {
      final docsDir = await AppStorageService.getCustomerDocumentsDirectory();
      if (await docsDir.exists()) {
        final List<FileSystemEntity> files = docsDir.listSync();
        for (final file in files) {
          if (file is File) {
            await file.delete();
          }
        }
      }
    } catch (_) {}

    // Re-seed default 15 companies so app structure remains ready for use
    await _seedCompaniesIfNeeded();
  }

  Future<void> seedDummyData() async {
    final today = DateTime.now();
    final yesterday = today.subtract(const Duration(days: 1));

    await isar.writeTxn(() async {
      // Clear existing records to ensure a fresh clean state
      await isar.customers.clear();
      await isar.workTasks.clear();
      await isar.marketingLeads.clear();
      await isar.performanceRecords.clear();

      // 1. Seed Companies (already done by init, but let's retrieve their IDs)
      final companies = await isar.companys.where().findAll();
      final company1Id = companies.isNotEmpty ? companies[0].id : null;
      final company2Id = companies.length > 1 ? companies[1].id : null;

      // 2. Seed Customers with rich, comprehensive field population
      final c1 = Customer()
        ..uuid = 'seed_cust_001'
        ..customerId = 'CUST-001'
        ..familyId = 'FAM-101'
        ..name = 'Amit Sharma'
        ..fatherName = 'Rajesh Sharma'
        ..dateOfBirth = DateTime(1988, today.month, today.day).add(const Duration(days: 3)) // Birthday in 3 days!
        ..maritalStatus = 'Married'
        ..spouseName = 'Kiran Sharma'
        ..nationality = 'Indian'
        ..aadhaarNumber = '1234-5678-9012'
        ..qualification = 'MBA in Finance'
        ..height = '175 cm'
        ..weight = '72 kg'
        // Family
        ..numberOfChildren = 2
        ..childrenDOBs = [DateTime(2015, 6, 12), DateTime(2019, 9, 20)]
        ..fatherDOB = DateTime(1958, 4, 15)
        ..motherDOB = DateTime(1962, 8, 10)
        ..spouseDOB = DateTime(1990, 11, 25)
        ..fatherAge = '68'
        ..motherAge = '64'
        ..spouseAge = '35'
        ..brotherAge = '40'
        ..sisterAge = '32'
        // Professional
        ..employerBusinessName = 'TCS Global Ltd'
        ..designation = 'Senior Finance Manager'
        ..natureOfBusiness = 'Information Technology'
        ..annualIncome = '18,50,000'
        // Contact
        ..officeContactNumber = '011-23456789'
        ..mobileNumber1 = '9876543210'
        ..mobileNumber2 = '9876543211'
        ..mobileNumber3 = '9876543212'
        ..emailId = 'amit.sharma@email.com'
        // Identity
        ..panNumber = 'ABCPS1234F'
        ..weddingAnniversary = DateTime(2014, today.month, today.day).add(const Duration(days: 7))
        // Nominee
        ..nomineeName = 'Kiran Sharma'
        ..nomineeRelationship = 'Wife'
        ..nomineeDOB = DateTime(1990, 11, 25)
        ..nomineeFatherName = 'Suresh Gupta'
        ..nomineePan = 'EFGPS5678K'
        ..nomineeMobile1 = '9876543211'
        ..nomineeEmail = 'kiran.sharma@email.com'
        // Existing Insurance Policies
        ..selfCompany = companies.isNotEmpty ? companies[0].name : 'LIC of India'
        ..selfPolicyNumber = 'POL-889900'
        ..selfAadhaarNumber = '1234-5678-9012'
        ..selfSumAssured1 = '₹ 15,00,000'
        ..selfSumAssured2 = '₹ 10,00,000'
        ..selfYearOfIssue = '2021'
        ..fatherPolicyNumber = 'POL-112233'
        ..fatherCompany = 'LIC of India'
        ..motherPolicyNumber = 'POL-445566'
        ..motherCompany = 'Star Health'
        ..spousePolicyNumber = 'POL-778899'
        ..spouseCompany = 'HDFC Life'
        ..childrenPolicyNumber = 'POL-990011'
        ..childrenCompany = 'Max Life'
        ..hasExistingPolicy = 'Yes'
        ..existingSelfCompany = 'LIC of India'
        ..existingPolicyNumber = 'POL-889900'
        ..existingDocDate = DateTime(2021, 3, 15)
        // Health & Cover
        ..healthProblems = 'Mild hypertension (controlled with medication)'
        ..lifestyleHabits = 'Non-smoker, Occasional social drinking'
        ..pregnancyDetails = 'N/A'
        ..healthRemarks = 'Regular annual health checkup completed in Jan 2026.'
        ..hasPersonalAccident = 'Yes'
        ..personalAccidentDate = today
        // Addresses
        ..communicationAddress = '123, Green Park Main Road, Hauz Khas, New Delhi - 110016'
        ..permanentAddress = 'Plot 45, Civil Lines, Jaipur, Rajasthan - 302006'
        // Plan Items
        ..plans = [
          CustomerPlanItem()
            ..productName = 'LIC Jeevan Umang (Plan 945)'
            ..premium = '₹ 48,500'
            ..mode = 'Yearly'
            ..planSumAssured = '₹ 15,00,000'
            ..rider = 'Accidental Death & Disability Benefit',
          CustomerPlanItem()
            ..productName = 'HDFC Life Sanchay Plus'
            ..premium = '₹ 35,000'
            ..mode = 'Half-Yearly'
            ..planSumAssured = '₹ 10,00,000'
            ..rider = 'Critical Illness Rider',
        ]
        ..productName = 'LIC Jeevan Umang'
        ..premiumMode = 'Yearly'
        ..planSumAssured = '₹ 15,00,000'
        ..rider = 'Accidental Benefit'
        // Investments
        ..riskCover = 'High Cover'
        ..pensionPlan = 'NPS Scheme Tier-1'
        ..investmentPlan = 'SIP Equity Mutual Fund'
        ..mutualFunds = 'SBI Bluechip Fund & Mirae Asset Large Cap'
        ..mediClaim = 'Star Health Comprehensive (₹ 10 Lakh)'
        ..moneyBackPolicy = 'LIC Money Back 20 Yrs'
        ..childrenEducationPlan = 'HDFC Young Star Super'
        // Reminders (1 to 5)
        ..reminderDate1 = today.add(const Duration(days: 1))
        ..reminderNote1 = 'Collect premium cheque for Jeevan Umang policy renewal'
        ..reminderDate2 = today.add(const Duration(days: 5))
        ..reminderNote2 = 'Discuss new child higher education endowment plan options'
        ..reminderDate3 = today.add(const Duration(days: 10))
        ..reminderNote3 = 'Health policy Mediclaim sum assured top-up review'
        ..reminderDate4 = today.add(const Duration(days: 15))
        ..reminderNote4 = 'Annual tax saving ELSS Mutual Fund investment review'
        ..reminderDate5 = today.add(const Duration(days: 20))
        ..reminderNote5 = 'Send birthday greetings and anniversary gift voucher'
        // References
        ..references = [
          CustomerReferenceItem()
            ..name = 'Alok Verma'
            ..mobile = '9811223344'
            ..age = '38',
          CustomerReferenceItem()
            ..name = 'Sunil Mehta'
            ..mobile = '9822334455'
            ..age = '42',
        ]
        ..referenceFriendName = 'Alok Verma'
        ..referenceMobile = '9811223344'
        ..referenceAge = '38'
        // Documents
        ..documents = [
          CustomerDocument()
            ..documentName = 'Aadhaar Card'
            ..fileName = 'aadhaar_amit_sharma.pdf',
          CustomerDocument()
            ..documentName = 'PAN Card'
            ..fileName = 'pan_amit_sharma.pdf',
          CustomerDocument()
            ..documentName = 'Previous Policy Bond'
            ..fileName = 'lic_policy_bond.pdf',
        ]
        ..notes = 'Highly valuable HNIs client. Interested in expanding retirement pension corpus and child endowment policies.'
        ..updatedAt = DateTime.now()
        ..isDeleted = false
        ..assignedCompanyId = company1Id;

      final c2 = Customer()
        ..uuid = 'seed_cust_002'
        ..customerId = 'CUST-002'
        ..familyId = 'FAM-101'
        ..name = 'Priya Patel'
        ..fatherName = 'Arvind Patel'
        ..dateOfBirth = DateTime(1993, today.month, today.day).add(const Duration(days: 15)) // Birthday in 15 days
        ..maritalStatus = 'Married'
        ..spouseName = 'Vikram Patel'
        ..nationality = 'Indian'
        ..aadhaarNumber = '9876-5432-1098'
        ..qualification = 'B.Tech Computer Science'
        ..height = '162 cm'
        ..weight = '58 kg'
        ..numberOfChildren = 1
        ..childrenDOBs = [DateTime(2021, 3, 10)]
        ..fatherDOB = DateTime(1960, 5, 20)
        ..motherDOB = DateTime(1964, 9, 14)
        ..spouseDOB = DateTime(1991, 12, 5)
        ..employerBusinessName = 'Infosys Technologies'
        ..designation = 'Lead Software Architect'
        ..natureOfBusiness = 'Software Engineering'
        ..annualIncome = '22,00,000'
        ..mobileNumber1 = '8765432109'
        ..mobileNumber2 = '8765432110'
        ..emailId = 'priya.patel@email.com'
        ..panNumber = 'XYZPP9876K'
        ..weddingAnniversary = DateTime(2018, today.month, today.day).add(const Duration(days: 10)) // Anniversary in 10 days
        ..nomineeName = 'Vikram Patel'
        ..nomineeRelationship = 'Husband'
        ..nomineeDOB = DateTime(1991, 12, 5)
        ..nomineeMobile1 = '8765432110'
        ..selfCompany = companies.length > 1 ? companies[1].name : 'HDFC Life'
        ..selfPolicyNumber = 'POL-776655'
        ..selfSumAssured1 = '₹ 20,00,000'
        ..selfYearOfIssue = '2022'
        ..hasExistingPolicy = 'Yes'
        ..existingSelfCompany = 'HDFC Life'
        ..existingPolicyNumber = 'POL-776655'
        ..existingDocDate = DateTime(2022, 5, 10)
        ..healthProblems = 'None'
        ..lifestyleHabits = 'Non-smoker'
        ..hasPersonalAccident = 'Yes'
        ..personalAccidentDate = DateTime(2025, 4, 18)
        ..communicationAddress = '456, Satellite Road, Near ISRO Colony, Ahmedabad, Gujarat - 380015'
        ..permanentAddress = '456, Satellite Road, Ahmedabad, Gujarat - 380015'
        ..plans = [
          CustomerPlanItem()
            ..productName = 'HDFC Click 2 Protect Super'
            ..premium = '₹ 28,000'
            ..mode = 'Yearly'
            ..planSumAssured = '₹ 20,00,000'
            ..rider = 'Waiver of Premium',
        ]
        ..productName = 'HDFC Click 2 Protect Super'
        ..premiumMode = 'Yearly'
        ..riskCover = 'Moderate'
        ..pensionPlan = 'Corporate NPS'
        ..mutualFunds = 'Nippon India Small Cap & Parag Parikh Flexi Cap'
        ..mediClaim = 'Niva Bupa Health Companion (₹ 15 Lakh)'
        ..reminderDate1 = today.add(const Duration(days: 2))
        ..reminderNote1 = 'Send birthday & anniversary greetings proposal brochure'
        ..reminderDate2 = today.add(const Duration(days: 6))
        ..reminderNote2 = 'Follow up on HDFC Click 2 Protect policy document delivery'
        ..reminderDate3 = today.add(const Duration(days: 12))
        ..reminderNote3 = 'Corporate NPS tax exemption documentation assistance'
        ..reminderDate4 = today.add(const Duration(days: 18))
        ..reminderNote4 = 'Child education plan SIP installment reminder'
        ..reminderDate5 = today.add(const Duration(days: 25))
        ..reminderNote5 = 'Quarterly portfolio performance review call'
        ..notes = 'Prefers digital communication via email and WhatsApp.'
        ..updatedAt = DateTime.now()
        ..isDeleted = false
        ..assignedCompanyId = company2Id;

      final c3 = Customer()
        ..uuid = 'seed_cust_003'
        ..customerId = 'CUST-003'
        ..familyId = 'FAM-102'
        ..name = 'Rohan Desai'
        ..fatherName = 'Sanjay Desai'
        ..dateOfBirth = DateTime(1995, today.month, today.day).subtract(const Duration(days: 5)) // Birthday was 5 days ago
        ..maritalStatus = 'Single'
        ..nationality = 'Indian'
        ..aadhaarNumber = '5566-7788-9900'
        ..qualification = 'M.Sc Data Science'
        ..height = '180 cm'
        ..weight = '76 kg'
        ..employerBusinessName = 'Desai Tech Solutions Consultancy'
        ..designation = 'Founder & Managing Director'
        ..natureOfBusiness = 'IT Services & Consulting'
        ..annualIncome = '32,00,000'
        ..mobileNumber1 = '7654321098'
        ..mobileNumber2 = '7654321099'
        ..emailId = 'rohan.desai@email.com'
        ..panNumber = 'RDXPD4321L'
        ..nomineeName = 'Sanjay Desai'
        ..nomineeRelationship = 'Father'
        ..nomineeDOB = DateTime(1965, 3, 14)
        ..selfCompany = 'ICICI Prudential'
        ..selfPolicyNumber = 'POL-554433'
        ..selfSumAssured1 = '₹ 50,00,000'
        ..selfYearOfIssue = '2023'
        ..hasExistingPolicy = 'Yes'
        ..healthProblems = 'None'
        ..lifestyleHabits = 'Gym & Fitness'
        ..hasPersonalAccident = 'Yes'
        ..personalAccidentDate = today
        ..communicationAddress = '789, MG Road, Camp Area, Pune, Maharashtra - 411001'
        ..permanentAddress = '789, MG Road, Camp Area, Pune, Maharashtra - 411001'
        ..plans = [
          CustomerPlanItem()
            ..productName = 'ICICI Pru iProtect Smart'
            ..premium = '₹ 42,000'
            ..mode = 'Yearly'
            ..planSumAssured = '₹ 50,00,000'
            ..rider = 'Accidental Death Benefit Rider',
        ]
        ..productName = 'ICICI Pru iProtect Smart'
        ..premiumMode = 'Quarterly'
        ..riskCover = 'High Growth'
        ..investmentPlan = 'Direct Equity & Crypto Portfolio'
        ..mutualFunds = 'Mirae Asset Emerging Bluechip'
        ..mediClaim = 'Care Supreme Health Cover (₹ 25 Lakh)'
        ..reminderDate1 = today
        ..reminderNote1 = 'Review high net worth term plan upgrade option'
        ..reminderDate2 = today.add(const Duration(days: 3))
        ..reminderNote2 = 'Send ICICI Pru iProtect Smart proposal quote'
        ..reminderDate3 = today.add(const Duration(days: 8))
        ..reminderNote3 = 'Care Supreme Health Cover policy renewal'
        ..reminderDate4 = today.add(const Duration(days: 14))
        ..reminderNote4 = 'Discuss business keyman insurance policy'
        ..reminderDate5 = today.add(const Duration(days: 22))
        ..reminderNote5 = 'Direct equity portfolio strategy discussion'
        ..notes = 'Tech entrepreneur with interest in tax saving ULIPs and ELSS funds.'
        ..updatedAt = DateTime.now()
        ..isDeleted = false;

      final c4 = Customer()
        ..uuid = 'seed_cust_004'
        ..customerId = 'CUST-004'
        ..familyId = 'FAM-102'
        ..name = 'Sneha Reddy'
        ..fatherName = 'Prabhakar Reddy'
        ..dateOfBirth = DateTime(1990, 8, 22)
        ..maritalStatus = 'Married'
        ..spouseName = 'Madhusudhan Reddy'
        ..nationality = 'Indian'
        ..aadhaarNumber = '4433-2211-0099'
        ..qualification = 'MBBS, MD Pediatrics'
        ..height = '165 cm'
        ..weight = '60 kg'
        ..numberOfChildren = 2
        ..childrenDOBs = [DateTime(2017, 4, 8), DateTime(2020, 10, 14)]
        ..employerBusinessName = 'Apollo Hospitals Jubilee Hills'
        ..designation = 'Consultant Pediatrician'
        ..natureOfBusiness = 'Healthcare & Medicine'
        ..annualIncome = '28,00,000'
        ..mobileNumber1 = '6543210987'
        ..mobileNumber2 = '6543210988'
        ..emailId = 'dr.sneha.reddy@email.com'
        ..panNumber = 'SRXPR9876M'
        ..weddingAnniversary = DateTime(2015, today.month, today.day).add(const Duration(days: 1)) // Anniversary tomorrow!
        ..nomineeName = 'Madhusudhan Reddy'
        ..nomineeRelationship = 'Husband'
        ..nomineeDOB = DateTime(1987, 2, 11)
        ..selfCompany = 'Tata AIA Life'
        ..selfPolicyNumber = 'POL-332211'
        ..selfSumAssured1 = '₹ 30,00,000'
        ..selfYearOfIssue = '2020'
        ..hasExistingPolicy = 'Yes'
        ..healthProblems = 'None'
        ..lifestyleHabits = 'Non-smoker'
        ..hasPersonalAccident = 'No'
        ..communicationAddress = '55, Jubilee Hills Road No. 36, Hyderabad, Telangana - 500033'
        ..permanentAddress = '55, Jubilee Hills Road No. 36, Hyderabad, Telangana - 500033'
        ..plans = [
          CustomerPlanItem()
            ..productName = 'Tata AIA Sampoorna Raksha Supreme'
            ..premium = '₹ 52,000'
            ..mode = 'Yearly'
            ..planSumAssured = '₹ 30,00,000'
            ..rider = 'Criticare Plus Rider',
        ]
        ..productName = 'Tata AIA Sampoorna Raksha Supreme'
        ..premiumMode = 'Monthly'
        ..mediClaim = 'Star Health Doctor\'s Special Policy (₹ 50 Lakh)'
        ..childrenEducationPlan = 'SBI Life Smart Champ Insurance'
        ..reminderDate1 = today.add(const Duration(days: 1))
        ..reminderNote1 = 'Send wedding anniversary greetings & gift voucher'
        ..reminderDate2 = today.add(const Duration(days: 4))
        ..reminderNote2 = 'Doctor special health policy renewal confirmation'
        ..reminderDate3 = today.add(const Duration(days: 9))
        ..reminderNote3 = 'Collect Tata AIA Sampoorna Raksha premium receipt'
        ..reminderDate4 = today.add(const Duration(days: 16))
        ..reminderNote4 = 'Children SBI Life Smart Champ policy review'
        ..reminderDate5 = today.add(const Duration(days: 28))
        ..reminderNote5 = 'Annual family health insurance audit'
        ..notes = 'Doctor by profession. Very punctual with annual premium renewals.'
        ..updatedAt = DateTime.now()
        ..isDeleted = false;

      final c5 = Customer()
        ..uuid = 'seed_cust_005'
        ..customerId = 'CUST-005'
        ..familyId = 'FAM-103'
        ..name = 'Vikram Singh'
        ..fatherName = 'Karan Singh'
        ..dateOfBirth = DateTime(1980, 11, 5)
        ..maritalStatus = 'Married'
        ..spouseName = 'Sunita Singh'
        ..nationality = 'Indian'
        ..aadhaarNumber = '7788-9900-1122'
        ..qualification = 'B.Com, CA'
        ..height = '178 cm'
        ..weight = '82 kg'
        ..numberOfChildren = 1
        ..childrenDOBs = [DateTime(2010, 8, 19)]
        ..employerBusinessName = 'Singh & Associates Chartered Accountants'
        ..designation = 'Senior Partner'
        ..natureOfBusiness = 'Auditing & Accounting'
        ..annualIncome = '45,00,000'
        ..mobileNumber1 = '5432109876'
        ..mobileNumber2 = '5432109877'
        ..emailId = 'ca.vikram.singh@email.com'
        ..panNumber = 'ABCDE1234F'
        ..weddingAnniversary = DateTime(2008, 12, 12)
        ..nomineeName = 'Sunita Singh'
        ..nomineeRelationship = 'Wife'
        ..nomineeDOB = DateTime(1983, 7, 24)
        ..selfCompany = 'SBI Life'
        ..selfPolicyNumber = 'POL-998877'
        ..selfSumAssured1 = '₹ 1,00,00,000'
        ..selfYearOfIssue = '2019'
        ..hasExistingPolicy = 'Yes'
        ..healthProblems = 'Mild Diabetes (controlled)'
        ..lifestyleHabits = 'Occasional smoking'
        ..hasPersonalAccident = 'Yes'
        ..personalAccidentDate = today
        ..communicationAddress = '102, Commercial Street, Connaught Place, New Delhi - 110001'
        ..permanentAddress = '102, Commercial Street, Connaught Place, New Delhi - 110001'
        ..plans = [
          CustomerPlanItem()
            ..productName = 'SBI Life eShield Next'
            ..premium = '₹ 85,000'
            ..mode = 'Yearly'
            ..planSumAssured = '₹ 1,00,00,000'
            ..rider = 'Accidental Total & Permanent Disability',
          CustomerPlanItem()
            ..productName = 'LIC Annuity Pension Plan'
            ..premium = '₹ 1,20,000'
            ..mode = 'Yearly'
            ..planSumAssured = '₹ 25,00,000'
            ..rider = 'None',
        ]
        ..productName = 'SBI Life eShield Next'
        ..premiumMode = 'Half-Yearly'
        ..riskCover = 'High'
        ..pensionPlan = 'VRS Annuity & LIC Jeevan Shanti'
        ..mutualFunds = 'SBI Bluechip Growth & HDFC Flexi Cap'
        ..mediClaim = 'HDFC ERGO Optima Secure (₹ 1 Crore Topup)'
        ..reminderDate1 = today.add(const Duration(days: 1))
        ..reminderNote1 = 'Collect CA office group insurance proposal details'
        ..reminderDate2 = today.add(const Duration(days: 2))
        ..reminderNote2 = 'SBI Life eShield Next premium renewal follow-up'
        ..reminderDate3 = today.add(const Duration(days: 7))
        ..reminderNote3 = 'LIC Jeevan Shanti annuity payout schedule check'
        ..reminderDate4 = today.add(const Duration(days: 13))
        ..reminderNote4 = 'HDFC ERGO 1 Crore Topup policy bond handover'
        ..reminderDate5 = today.add(const Duration(days: 21))
        ..reminderNote5 = 'Year-end wealth management & tax advisory session'
        ..notes = 'High net worth client, focuses on mutual funds and large tax-saving annuity plans.'
        ..updatedAt = DateTime.now()
        ..isDeleted = false;

      await isar.customers.putAll([c1, c2, c3, c4, c5]);

      // 3. Seed Work Tasks (for Tab 1, Tab 2, and Tab 3 companies)
      final tab1Companies = companies.where((c) => c.tabIndex == 0).toList();
      final tab2Companies = companies.where((c) => c.tabIndex == 1).toList();
      final tab3Companies = companies.where((c) => c.tabIndex == 2).toList();
      final tomorrow = today.add(const Duration(days: 1));

      final workTasksToSeed = <WorkTask>[];

      // Tasks for Tab 1 Companies
      if (tab1Companies.isNotEmpty) {
        workTasksToSeed.add(WorkTask()
          ..uuid = _uuid.v4()
          ..companyId = tab1Companies[0].id
          ..description = 'Carry Forward Test: Policy renewal follow-up with Amit'
          ..workDate = yesterday
          ..assignedDate = yesterday
          ..createdAt = yesterday
          ..priority = 'Urgent'
          ..assignedTo = 'Rajesh'
          ..communicationMethod = 'Call'
          ..status = 'Pending'
          ..carryForwardRequired = true
          ..carryForwardReason = 'Client asked to call back next day'
          ..remarks = 'Amit requested callback after 5 PM'
          ..updatedAt = yesterday
          ..isDeleted = false);

        workTasksToSeed.add(WorkTask()
          ..uuid = _uuid.v4()
          ..companyId = tab1Companies[0].id
          ..description = 'Collect KYC documents and cancelled cheque'
          ..workDate = today
          ..assignedDate = today
          ..createdAt = today
          ..priority = 'Important'
          ..assignedTo = 'Kiran'
          ..communicationMethod = 'In Person'
          ..status = 'Pending'
          ..carryForwardRequired = true
          ..remarks = 'Collect Aadhaar copy and PAN copy'
          ..updatedAt = today
          ..isDeleted = false);
      }

      if (tab1Companies.length > 1) {
        workTasksToSeed.add(WorkTask()
          ..uuid = _uuid.v4()
          ..companyId = tab1Companies[1].id
          ..description = 'Dispatch physical policy bond via courier'
          ..workDate = today
          ..assignedDate = today
          ..createdAt = today
          ..priority = 'Normal'
          ..assignedTo = 'Courier Ops'
          ..communicationMethod = 'WhatsApp'
          ..status = 'Completed'
          ..remarks = 'Tracking ID: DTDC99887766'
          ..updatedAt = today
          ..isDeleted = false);
      }

      if (tab1Companies.length > 2) {
        workTasksToSeed.add(WorkTask()
          ..uuid = _uuid.v4()
          ..companyId = tab1Companies[2].id
          ..description = 'Medical check-up scheduling for term plan'
          ..workDate = today
          ..assignedDate = today
          ..createdAt = today
          ..priority = 'Urgent'
          ..assignedTo = 'Health Team'
          ..communicationMethod = 'Call'
          ..status = 'Under Process'
          ..remarks = 'Diagnostic lab appointment fixed for 8 AM'
          ..updatedAt = today
          ..isDeleted = false);
      }

      if (tab1Companies.length > 3) {
        workTasksToSeed.add(WorkTask()
          ..uuid = _uuid.v4()
          ..companyId = tab1Companies[3].id
          ..description = 'Address proof verification and biometric setup'
          ..workDate = tomorrow
          ..assignedDate = today
          ..createdAt = today
          ..priority = 'Normal'
          ..assignedTo = 'Field Agent'
          ..communicationMethod = 'In Person'
          ..status = 'Pending'
          ..remarks = 'Visit client residence in evening'
          ..updatedAt = today
          ..isDeleted = false);
      }

      // Tasks for Tab 2 Companies
      if (tab2Companies.isNotEmpty) {
        workTasksToSeed.add(WorkTask()
          ..uuid = _uuid.v4()
          ..companyId = tab2Companies[0].id
          ..description = 'Signature collection from Priya Verma'
          ..workDate = yesterday
          ..assignedDate = yesterday
          ..createdAt = yesterday
          ..priority = 'Normal'
          ..assignedTo = 'Sunil'
          ..communicationMethod = 'In Person'
          ..status = 'Completed'
          ..remarks = 'Signed proposal form received'
          ..updatedAt = yesterday
          ..isDeleted = false);

        workTasksToSeed.add(WorkTask()
          ..uuid = _uuid.v4()
          ..companyId = tab2Companies[0].id
          ..description = 'Group health policy endorsement review'
          ..workDate = today
          ..assignedDate = today
          ..createdAt = today
          ..priority = 'Urgent'
          ..assignedTo = 'Corporate Desk'
          ..communicationMethod = 'Email'
          ..status = 'Pending'
          ..carryForwardRequired = true
          ..carryForwardReason = 'Awaiting HR list verification'
          ..remarks = 'Check member list of 45 employees'
          ..updatedAt = today
          ..isDeleted = false);
      }

      if (tab2Companies.length > 1) {
        workTasksToSeed.add(WorkTask()
          ..uuid = _uuid.v4()
          ..companyId = tab2Companies[1].id
          ..description = 'Premium calculation for tax saving pension plan'
          ..workDate = today
          ..assignedDate = today
          ..createdAt = today
          ..priority = 'Important'
          ..assignedTo = 'Anil'
          ..communicationMethod = 'WhatsApp'
          ..status = 'Completed'
          ..remarks = 'Illustration sent via PDF'
          ..updatedAt = today
          ..isDeleted = false);
      }

      if (tab2Companies.length > 2) {
        workTasksToSeed.add(WorkTask()
          ..uuid = _uuid.v4()
          ..companyId = tab2Companies[2].id
          ..description = 'Claim settlement document audit'
          ..workDate = tomorrow
          ..assignedDate = today
          ..createdAt = today
          ..priority = 'Important'
          ..assignedTo = 'Claims Team'
          ..communicationMethod = 'Email'
          ..status = 'Pending'
          ..remarks = 'Discharge summary and hospital bills required'
          ..updatedAt = today
          ..isDeleted = false);
      }

      // Tasks for Tab 3 Companies
      if (tab3Companies.isNotEmpty) {
        workTasksToSeed.add(WorkTask()
          ..uuid = _uuid.v4()
          ..companyId = tab3Companies[0].id
          ..description = "Verify Sneha's bank details for child policy"
          ..workDate = today
          ..assignedDate = today
          ..createdAt = today
          ..priority = 'Important'
          ..assignedTo = 'Sneha Desk'
          ..communicationMethod = 'Call'
          ..status = 'Pending'
          ..carryForwardRequired = true
          ..remarks = 'Verify IFSC code and branch details'
          ..updatedAt = today
          ..isDeleted = false);

        workTasksToSeed.add(WorkTask()
          ..uuid = _uuid.v4()
          ..companyId = tab3Companies[0].id
          ..description = 'Corporate presentation preparation for group insurance'
          ..workDate = today
          ..assignedDate = today
          ..createdAt = today
          ..priority = 'Urgent'
          ..assignedTo = 'Sales Lead'
          ..communicationMethod = 'Email'
          ..status = 'Under Process'
          ..remarks = 'Slide deck ready, custom pricing pending'
          ..updatedAt = today
          ..isDeleted = false);
      }

      if (tab3Companies.length > 1) {
        workTasksToSeed.add(WorkTask()
          ..uuid = _uuid.v4()
          ..companyId = tab3Companies[1].id
          ..description = 'Annual portfolio review meeting with Vikram Singh'
          ..workDate = tomorrow
          ..assignedDate = today
          ..createdAt = today
          ..priority = 'Important'
          ..assignedTo = 'Account Manager'
          ..communicationMethod = 'In Person'
          ..status = 'Pending'
          ..remarks = 'Meeting scheduled at CA office'
          ..updatedAt = today
          ..isDeleted = false);
      }

      await isar.workTasks.putAll(workTasksToSeed);

      // 4. Seed Marketing Leads
      final ml1 = MarketingLead()
        ..uuid = _uuid.v4()
        ..name = 'Ramesh Kumar'
        ..mobile = '9988776655'
        ..status = 'Postponed'
        ..visits = [
          MarketingVisit()
            ..visitDate = today
            ..visitTime = '11:00 AM'
            ..visitNote = 'Initial introductory call',
          MarketingVisit()
            ..visitDate = today.add(const Duration(days: 1))
            ..visitTime = '02:30 PM'
            ..visitNote = 'In-person proposal review',
        ]
        ..updatedAt = DateTime.now()
        ..isDeleted = false;

      final ml2 = MarketingLead()
        ..uuid = _uuid.v4()
        ..name = 'Suresh Patel'
        ..mobile = '9876123450'
        ..status = 'Confirmed'
        ..visits = [
          MarketingVisit()
            ..visitDate = today
            ..visitTime = '04:00 PM'
            ..visitNote = 'Documents pickup and KYC verification',
        ]
        ..updatedAt = DateTime.now()
        ..isDeleted = false;

      final ml3 = MarketingLead()
        ..uuid = _uuid.v4()
        ..name = 'Meena Gupta'
        ..mobile = '9090808070'
        ..status = 'Hold'
        ..visits = [
          MarketingVisit()
            ..visitDate = today.add(const Duration(days: 5))
            ..visitTime = '10:30 AM'
            ..visitNote = 'Follow-up on medical checklist',
        ]
        ..updatedAt = DateTime.now()
        ..isDeleted = false;

      await isar.marketingLeads.putAll([ml1, ml2, ml3]);

      // 5. Seed Performance Records (Current Month & Previous Month)
      final universalTopicHeaders = [
        'Calls Made',
        'Meetings Scheduled',
        'Proposals Sent',
        'Closures',
        'Referrals',
        'Policy Audits',
        'Renewals',
        'Group Claims',
        'KYC Updates',
        'Financial Plans',
        'Health Quotes',
        'MDRT Progress',
        'Notes'
      ];
      final universalBox3ColHeaders = [
        'JJ workway',
        'Target',
        'YY',
        'ZZ',
        'Percentage',
        'Achieved %',
        'Status'
      ];
      final universalBox3RowHeaders = [
        'Life Insurance',
        'Health & PA',
        'Mutual Funds',
        'Commercial Policy'
      ];

      // Current Month Performance Record
      final perfCurrent = PerformanceRecord()
        ..year = today.year
        ..month = today.month
        ..urgent = '5'
        ..newBusiness = '12'
        ..life = '₹ 8,50,000'
        ..fireHealthPa = '₹ 3,20,000'
        ..earned = '₹ 1,45,000'
        ..box2Row1Days = '18'
        ..box2EarningsOnWorkedDays = '₹ 1,45,000'
        ..box2Row2Days = '4'
        ..box2TotalWorkingDay = '22'
        ..box3JjWorkwayCol1 = '15,00,000'
        ..box3JjWorkwayCol2 = '12,00,000'
        ..box3JjWorkwayCol3 = '18,00,000'
        ..box3JjWorkwayCol4 = '20,00,000'
        ..box3TargetCol1 = '20,00,000'
        ..box3TargetCol2 = '15,00,000'
        ..box3TargetCol3 = '22,00,000'
        ..box3TargetCol4 = '25,00,000'
        ..box3YyCol1 = '2026'
        ..box3YyCol2 = '2026'
        ..box3YyCol3 = '2026'
        ..box3YyCol4 = '2026'
        ..box3ZzCol1 = 'Q3'
        ..box3ZzCol2 = 'Q3'
        ..box3ZzCol3 = 'Q3'
        ..box3ZzCol4 = 'Q3'
        ..box3PercentageCol1 = '75%'
        ..box3PercentageCol2 = '80%'
        ..box3PercentageCol3 = '81.8%'
        ..box3PercentageCol4 = '80%'
        ..box3Col6Col1 = '75%'
        ..box3Col6Col2 = '80%'
        ..box3Col6Col3 = '82%'
        ..box3Col6Col4 = '80%'
        ..box3Col7Col1 = 'On Track'
        ..box3Col7Col2 = 'Exceeded'
        ..box3Col7Col3 = 'On Track'
        ..box3Col7Col4 = 'On Track'
        ..box3ColHeaders = universalBox3ColHeaders
        ..box3RowHeaders = universalBox3RowHeaders
        ..box4Balance = '₹ 12,50,000'
        ..box4Target = '₹ 35,00,000'
        ..box4Achieved = '₹ 22,50,000'
        ..topicHeaders = universalTopicHeaders
        ..topicRows = [
          TopicTableRow()
            ..dateStr = '02/${today.month.toString().padLeft(2, '0')}/${today.year}'
            ..values = ['25', '8', '5', '2', '3', '4', '6', '1', '2', '2', '3', 'On Track', 'Good initial push'],
          TopicTableRow()
            ..dateStr = '08/${today.month.toString().padLeft(2, '0')}/${today.year}'
            ..values = ['30', '10', '7', '3', '4', '5', '8', '2', '3', '3', '4', 'Ahead', 'Corporate client closed'],
          TopicTableRow()
            ..dateStr = '15/${today.month.toString().padLeft(2, '0')}/${today.year}'
            ..values = ['20', '6', '4', '1', '2', '3', '5', '0', '1', '1', '2', 'On Track', 'Follow-up done'],
        ]
        ..updatedAt = DateTime.now();

      // Previous Month Performance Record
      final prevMonthDate = DateTime(today.year, today.month - 1, 1);
      final perfPrev = PerformanceRecord()
        ..year = prevMonthDate.year
        ..month = prevMonthDate.month
        ..urgent = '3'
        ..newBusiness = '10'
        ..life = '₹ 7,20,000'
        ..fireHealthPa = '₹ 2,80,000'
        ..earned = '₹ 1,20,000'
        ..box2Row1Days = '20'
        ..box2EarningsOnWorkedDays = '₹ 1,20,000'
        ..box2Row2Days = '2'
        ..box2TotalWorkingDay = '22'
        ..box3JjWorkwayCol1 = '14,00,000'
        ..box3JjWorkwayCol2 = '10,00,000'
        ..box3JjWorkwayCol3 = '15,00,000'
        ..box3JjWorkwayCol4 = '18,00,000'
        ..box3TargetCol1 = '18,00,000'
        ..box3TargetCol2 = '12,00,000'
        ..box3TargetCol3 = '20,00,000'
        ..box3TargetCol4 = '22,00,000'
        ..box3YyCol1 = '2026'
        ..box3YyCol2 = '2026'
        ..box3YyCol3 = '2026'
        ..box3YyCol4 = '2026'
        ..box3ZzCol1 = 'Q2'
        ..box3ZzCol2 = 'Q2'
        ..box3ZzCol3 = 'Q2'
        ..box3ZzCol4 = 'Q2'
        ..box3PercentageCol1 = '77.7%'
        ..box3PercentageCol2 = '83.3%'
        ..box3PercentageCol3 = '75%'
        ..box3PercentageCol4 = '81.8%'
        ..box3Col6Col1 = '78%'
        ..box3Col6Col2 = '83%'
        ..box3Col6Col3 = '75%'
        ..box3Col6Col4 = '82%'
        ..box3Col7Col1 = 'Completed'
        ..box3Col7Col2 = 'Exceeded'
        ..box3Col7Col3 = 'Completed'
        ..box3Col7Col4 = 'Completed'
        ..box3ColHeaders = universalBox3ColHeaders
        ..box3RowHeaders = universalBox3RowHeaders
        ..box4Balance = '₹ 15,00,000'
        ..box4Target = '₹ 30,00,000'
        ..box4Achieved = '₹ 18,00,000'
        ..topicHeaders = universalTopicHeaders
        ..topicRows = [
          TopicTableRow()
            ..dateStr = '05/${prevMonthDate.month.toString().padLeft(2, '0')}/${prevMonthDate.year}'
            ..values = ['28', '9', '6', '2', '3', '4', '7', '1', '2', '2', '3', 'On Target', 'Month-start drive'],
          TopicTableRow()
            ..dateStr = '20/${prevMonthDate.month.toString().padLeft(2, '0')}/${prevMonthDate.year}'
            ..values = ['32', '11', '8', '4', '5', '6', '9', '2', '4', '4', '5', 'Completed', 'MDRT month target hit'],
        ]
        ..updatedAt = prevMonthDate;

      await isar.performanceRecords.putAll([perfCurrent, perfPrev]);
    });
  }

  // --- MARKETING LEAD OPERATIONS ---

  Future<List<MarketingLead>> getMarketingLeads() async {
    return await isar.marketingLeads
        .filter()
        .isDeletedEqualTo(false)
        .sortByUpdatedAtDesc()
        .findAll();
  }

  Future<MarketingLead?> getMarketingLeadById(int id) async {
    return await isar.marketingLeads.get(id);
  }

  Future<void> saveMarketingLead(MarketingLead lead) async {
    if (lead.uuid.isEmpty) {
      lead.uuid = _uuid.v4();
    }
    lead.updatedAt = DateTime.now();
    await isar.writeTxn(() async {
      await isar.marketingLeads.put(lead);
    });
  }

  Future<void> deleteMarketingLead(int id) async {
    final lead = await isar.marketingLeads.get(id);
    if (lead != null) {
      lead.isDeleted = true;
      lead.updatedAt = DateTime.now();
      await isar.writeTxn(() async {
        await isar.marketingLeads.put(lead);
      });
    }
  }

  // --- PERFORMANCE RECORD OPERATIONS ---

  Future<PerformanceRecord?> getPerformanceRecord(int year, int month) async {
    return await isar.performanceRecords
        .filter()
        .yearEqualTo(year)
        .and()
        .monthEqualTo(month)
        .findFirst();
  }

  Future<void> savePerformanceRecord(PerformanceRecord record) async {
    record.updatedAt = DateTime.now();
    await isar.writeTxn(() async {
      final id = await isar.performanceRecords.put(record);
      record.id = id;
    });
  }

  Future<Map<String, List<String>>?> getLatestPerformanceHeaders() async {
    final records = await isar.performanceRecords.where().findAll();
    if (records.isEmpty) return null;

    List<String>? topicHeaders;
    List<String>? box3ColHeaders;
    List<String>? box3RowHeaders;

    for (final r in records.reversed) {
      if (topicHeaders == null && r.topicHeaders.isNotEmpty) {
        topicHeaders = r.topicHeaders;
      }
      if (box3ColHeaders == null && r.box3ColHeaders.isNotEmpty) {
        box3ColHeaders = r.box3ColHeaders;
      }
      if (box3RowHeaders == null && r.box3RowHeaders.isNotEmpty) {
        box3RowHeaders = r.box3RowHeaders;
      }
      if (topicHeaders != null && box3ColHeaders != null && box3RowHeaders != null) {
        break;
      }
    }

    if (topicHeaders == null && box3ColHeaders == null && box3RowHeaders == null) {
      return null;
    }

    return {
      if (topicHeaders != null) 'topicHeaders': topicHeaders,
      if (box3ColHeaders != null) 'box3ColHeaders': box3ColHeaders,
      if (box3RowHeaders != null) 'box3RowHeaders': box3RowHeaders,
    };
  }

  Future<void> updateAllPerformanceHeaders({
    List<String>? topicHeaders,
    List<String>? box3ColHeaders,
    List<String>? box3RowHeaders,
  }) async {
    final allRecords = await isar.performanceRecords.where().findAll();
    if (allRecords.isEmpty) return;

    await isar.writeTxn(() async {
      for (final record in allRecords) {
        bool changed = false;
        if (topicHeaders != null) {
          record.topicHeaders = List<String>.from(topicHeaders);
          changed = true;
        }
        if (box3ColHeaders != null) {
          record.box3ColHeaders = List<String>.from(box3ColHeaders);
          changed = true;
        }
        if (box3RowHeaders != null) {
          record.box3RowHeaders = List<String>.from(box3RowHeaders);
          changed = true;
        }
        if (changed) {
          record.updatedAt = DateTime.now();
          await isar.performanceRecords.put(record);
        }
      }
    });
  }

  // --- DAILY NOTES OPERATIONS ---

  String _getDateKey(DateTime date) {
    final localDate = date.toLocal();
    return "${localDate.year}-${localDate.month.toString().padLeft(2, '0')}-${localDate.day.toString().padLeft(2, '0')}";
  }

  Future<List<DailyNote>> getDailyNotesForDate(DateTime date) async {
    final key = _getDateKey(date);
    return await isar.dailyNotes.filter().dateKeyEqualTo(key).sortByCreatedAt().findAll();
  }

  Future<void> saveDailyNote(String content, DateTime date, {String? category, int? existingId}) async {
    final cleanContent = content.trim();
    if (cleanContent.isEmpty) return;
    final key = _getDateKey(date);

    DailyNote note;
    if (existingId != null) {
      final found = await isar.dailyNotes.get(existingId);
      note = found ?? DailyNote();
    } else {
      note = DailyNote()
        ..noteId = _uuid.v4()
        ..createdAt = DateTime.now();
    }

    note.dateKey = key;
    note.content = cleanContent;
    note.category = (category != null && category.trim().isNotEmpty) ? category.trim() : null;
    note.updatedAt = DateTime.now();

    await isar.writeTxn(() async {
      await isar.dailyNotes.put(note);
    });
  }

  Future<void> toggleDailyNoteCompleted(int id) async {
    final note = await isar.dailyNotes.get(id);
    if (note != null) {
      note.isCompleted = !note.isCompleted;
      note.updatedAt = DateTime.now();
      await isar.writeTxn(() async {
        await isar.dailyNotes.put(note);
      });
    }
  }

  Future<void> deleteDailyNote(int id) async {
    await isar.writeTxn(() async {
      await isar.dailyNotes.delete(id);
    });
  }
}


