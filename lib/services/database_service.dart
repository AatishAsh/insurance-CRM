import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import '../models/customer.dart';
import '../models/company.dart';
import '../models/work_task.dart';
import '../models/marketing_lead.dart';
import '../models/performance_record.dart';


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
      [CustomerSchema, CompanySchema, WorkTaskSchema, MarketingLeadSchema, PerformanceRecordSchema],
      directory: dir.path,
      inspector: true, // Enables Isar Inspector in debug mode
    );

    final service = DatabaseService(isarInstance);
    await service._seedCompaniesIfNeeded();
    return service;
  }

  // --- COMPANY OPERATIONS ---

  Future<void> _seedCompaniesIfNeeded() async {
    final count = await isar.companys.count();
    if (count == 0) {
      await isar.writeTxn(() async {
        for (int i = 1; i <= 15; i++) {
          final company = Company()
            ..uuid = _uuid.v4()
            ..name = 'Company $i'
            ..referenceNumber = 'REF-${100 + i}'
            ..updatedAt = DateTime.now()
            ..isDeleted = false;
          await isar.companys.put(company);
        }
      });
    }
  }

  Future<List<Company>> getCompanies() async {
    return await isar.companys.filter().isDeletedEqualTo(false).findAll();
  }

  Future<Company?> getCompanyById(int id) async {
    return await isar.companys.get(id);
  }

  Future<void> saveCompany(Company company) async {
    company.updatedAt = DateTime.now();
    await isar.writeTxn(() async {
      await isar.companys.put(company);
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
        final fatherMatch = cust.fatherName?.toLowerCase().contains(keyword) ?? false;
        final mobileMatch = (cust.mobileNumber1?.toLowerCase().contains(keyword) ?? false) ||
            (cust.mobileNumber2?.toLowerCase().contains(keyword) ?? false);
        final policyMatch = cust.selfPolicyNumber?.toLowerCase().contains(keyword) ?? false;
        final docMatch = cust.documents.any((doc) =>
            (doc.documentName?.toLowerCase().contains(keyword) ?? false) ||
            (doc.fileName?.toLowerCase().contains(keyword) ?? false));
        return nameMatch || idMatch || fatherMatch || mobileMatch || policyMatch || docMatch;
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

  Future<List<WorkTask>> getTasksForCompany(int companyId, DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
    
    return await isar.workTasks
        .filter()
        .companyIdEqualTo(companyId)
        .workDateBetween(startOfDay, endOfDay)
        .isDeletedEqualTo(false)
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

  Future<void> seedDummyData() async {
    final today = DateTime.now();
    final yesterday = today.subtract(const Duration(days: 1));

    await isar.writeTxn(() async {
      // Clear existing records to ensure a fresh clean state
      await isar.customers.clear();
      await isar.workTasks.clear();
      await isar.marketingLeads.clear();

      // 1. Seed Companies (already done by init, but let's retrieve their IDs)
      final companies = await isar.companys.where().findAll();
      final company1Id = companies.isNotEmpty ? companies[0].id : null;
      final company2Id = companies.length > 1 ? companies[1].id : null;

      // 2. Seed Customers
      final c1 = Customer()
        ..uuid = _uuid.v4()
        ..customerId = 'CUST-001'
        ..name = 'Amit Sharma'
        ..fatherName = 'Rajesh Sharma'
        ..dateOfBirth = DateTime(1988, today.month, today.day).add(const Duration(days: 3)) // Birthday in 3 days!
        ..maritalStatus = 'Married'
        ..spouseName = 'Kiran Sharma'
        ..nationality = 'Indian'
        ..aadhaarNumber = '1234-5678-9012'
        ..qualification = 'MBA'
        ..height = '175 cm'
        ..weight = '70 kg'
        ..mobileNumber1 = '9876543210'
        ..emailId = 'amit.sharma@email.com'
        ..communicationAddress = '123, Green Park, New Delhi'
        ..permanentAddress = '123, Green Park, New Delhi'
        ..selfCompany = companies.isNotEmpty ? companies[0].name : 'LIC of India'
        ..selfPolicyNumber = 'POL-889900'
        ..selfSumAssured1 = '₹ 15,00,000'
        ..selfYearOfIssue = '2021'
        ..healthProblems = 'Mild hypertension'
        ..lifestyleHabits = 'None'
        ..reminderDate1 = today.add(const Duration(days: 1)) // Reminder tomorrow!
        ..notes = 'Client interested in buying new child plan.'
        ..updatedAt = DateTime.now()
        ..isDeleted = false
        ..assignedCompanyId = company1Id;

      final c2 = Customer()
        ..uuid = _uuid.v4()
        ..customerId = 'CUST-002'
        ..name = 'Priya Patel'
        ..fatherName = 'Arvind Patel'
        ..dateOfBirth = DateTime(1993, today.month, today.day).add(const Duration(days: 15)) // Birthday in 15 days
        ..maritalStatus = 'Married'
        ..spouseName = 'Vikram Patel'
        ..nationality = 'Indian'
        ..aadhaarNumber = '9876-5432-1098'
        ..qualification = 'B.Tech'
        ..mobileNumber1 = '8765432109'
        ..emailId = 'priya.patel@email.com'
        ..communicationAddress = '456, satellite road, Ahmedabad'
        ..weddingAnniversary = DateTime(2018, today.month, today.day).add(const Duration(days: 10)) // Anniversary in 10 days
        ..selfCompany = companies.length > 1 ? companies[1].name : 'HDFC Life'
        ..selfPolicyNumber = 'POL-776655'
        ..selfSumAssured1 = '₹ 20,00,000'
        ..updatedAt = DateTime.now()
        ..isDeleted = false
        ..assignedCompanyId = company2Id;

      final c3 = Customer()
        ..uuid = _uuid.v4()
        ..customerId = 'CUST-003'
        ..name = 'Rohan Desai'
        ..fatherName = 'Sanjay Desai'
        ..dateOfBirth = DateTime(1995, today.month, today.day).subtract(const Duration(days: 5)) // Birthday was 5 days ago
        ..maritalStatus = 'Single'
        ..nationality = 'Indian'
        ..mobileNumber1 = '7654321098'
        ..emailId = 'rohan.desai@email.com'
        ..communicationAddress = '789, MG Road, Pune'
        ..updatedAt = DateTime.now()
        ..isDeleted = false;

      final c4 = Customer()
        ..uuid = _uuid.v4()
        ..customerId = 'CUST-004'
        ..name = 'Sneha Reddy'
        ..fatherName = 'Prabhakar Reddy'
        ..dateOfBirth = DateTime(1990, 8, 22)
        ..maritalStatus = 'Married'
        ..spouseName = 'Madhusudhan Reddy'
        ..nationality = 'Indian'
        ..mobileNumber1 = '6543210987'
        ..communicationAddress = '55, Jubilee Hills, Hyderabad'
        ..weddingAnniversary = DateTime(2015, today.month, today.day).add(const Duration(days: 1)) // Anniversary tomorrow!
        ..updatedAt = DateTime.now()
        ..isDeleted = false;

      final c5 = Customer()
        ..uuid = _uuid.v4()
        ..customerId = 'CUST-005'
        ..name = 'Vikram Singh'
        ..fatherName = 'Karan Singh'
        ..dateOfBirth = DateTime(1980, 11, 5)
        ..maritalStatus = 'Married'
        ..mobileNumber1 = '5432109876'
        ..panNumber = 'ABCDE1234F'
        ..riskCover = 'High'
        ..pensionPlan = 'VRS Annuity'
        ..mutualFunds = 'SBI Bluechip Growth'
        ..reminderDate2 = today.add(const Duration(days: 2)) // Reminder in 2 days!
        ..notes = 'High net worth client, focuses on mutual funds.'
        ..updatedAt = DateTime.now()
        ..isDeleted = false;

      await isar.customers.putAll([c1, c2, c3, c4, c5]);

      // 3. Seed Work Tasks
      final t1 = WorkTask()
        ..uuid = _uuid.v4()
        ..companyId = company1Id
        ..description = 'Carry Forward Test: Policy renewal follow-up with Amit'
        ..workDate = yesterday
        ..assignedDate = yesterday
        ..priority = 'Urgent'
        ..status = 'Pending' // Incomplete! Should carry forward!
        ..carryForwardRequired = true
        ..carryForwardReason = 'Client asked to call back next day'
        ..updatedAt = yesterday
        ..isDeleted = false;

      final t2 = WorkTask()
        ..uuid = _uuid.v4()
        ..companyId = company2Id
        ..description = 'Signature collection from Priya'
        ..workDate = yesterday
        ..assignedDate = yesterday
        ..priority = 'Normal'
        ..status = 'Completed' // Completed! Should NOT carry forward!
        ..carryForwardRequired = true
        ..updatedAt = yesterday
        ..isDeleted = false;

      final t3 = WorkTask()
        ..uuid = _uuid.v4()
        ..companyId = company1Id
        ..description = "Verify Sneha's bank details for child policy"
        ..workDate = today
        ..assignedDate = today
        ..priority = 'Important'
        ..status = 'Pending'
        ..carryForwardRequired = true
        ..updatedAt = today
        ..isDeleted = false;

      await isar.workTasks.putAll([t1, t2, t3]);

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
      await isar.performanceRecords.put(record);
    });
  }
}

