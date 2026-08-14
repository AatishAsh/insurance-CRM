import 'package:isar/isar.dart';

part 'customer.g.dart';

@embedded
class CustomerDocument {
  String? documentName;
  String? fileName; // Local filename in app storage
}

@embedded
class CustomerPlanItem {
  String? productName;
  String? premium;
  String? mode;
  String? planSumAssured;
  String? rider;
}

@embedded
class CustomerReferenceItem {
  String? name;
  String? mobile;
  String? age;
}

@collection
class Customer {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index()
  String? customerId; // Business ID like CUST-001

  @Index(caseSensitive: false)
  late String name;

  // Personal
  String? fatherName;
  DateTime? dateOfBirth;
  String? maritalStatus;
  String? spouseName;
  String? nationality;
  String? aadhaarNumber;
  String? qualification;
  String? height;
  String? weight;

  // Family
  int? numberOfChildren;
  List<DateTime>? childrenDOBs;
  DateTime? fatherDOB;
  DateTime? motherDOB;
  DateTime? spouseDOB;
  String? fatherAge;
  String? motherAge;
  String? spouseAge;
  String? brotherAge;
  String? sisterAge;
  DateTime? familyDOB;

  // Professional
  String? employerBusinessName;
  String? designation;
  String? natureOfBusiness;
  String? annualIncome;

  // Contact
  String? officeContactNumber;
  String? mobileNumber1;
  String? mobileNumber2;
  String? mobileNumber3;
  String? mobileNumber4;
  String? emailId;

  // Identity
  String? panNumber;

  // Additional
  DateTime? weddingAnniversary;

  // Nominee & Appointee
  String? nomineeName;
  String? nomineeRelationship;
  DateTime? nomineeDOB;
  String? nomineeFatherName;
  String? nomineePan;
  String? nomineeMobile1;
  String? nomineeMobile2;
  String? nomineeEmail;

  // Appointee (when Nominee is minor)
  String? appointeeName;
  DateTime? appointeeDOB;
  String? appointeeRelationship;
  String? appointeeOtherRelationship;

  // Insurance Details
  String? selfPolicyNumber;
  String? selfAadhaarNumber;
  String? selfSumAssured1;
  String? selfSumAssured2;
  String? selfYearOfIssue;
  String? selfCompany;

  String? fatherPolicyNumber;
  String? fatherCompany;
  String? motherPolicyNumber;
  String? motherCompany;
  String? spousePolicyNumber;
  String? spouseCompany;
  String? childrenPolicyNumber;
  String? childrenCompany;

  // Health
  String? healthProblems;
  String? lifestyleHabits; // Smoking/Drinking
  String? pregnancyDetails;
  String? healthRemarks;

  // Address
  String? communicationAddress;
  String? permanentAddress;

  // Plan Details
  List<CustomerPlanItem> plans = [];
  String? productName;
  String? premiumMode; // Yearly, Half-Yearly, etc.
  String? planSumAssured;
  String? rider;

  // Investment (Mutual Finance specific)
  String? riskCover;
  String? pensionPlan;
  String? investmentPlan;
  String? mutualFunds;
  String? mediClaim;
  String? moneyBackPolicy;
  String? childrenEducationPlan;

  // Reminders
  DateTime? reminderDate1;
  String? reminderNote1;
  DateTime? reminderDate2;
  String? reminderNote2;

  // Reference
  List<CustomerReferenceItem> references = [];
  String? referenceFriendName;
  String? referenceMobile;
  String? referenceAge;

  // Documents
  List<CustomerDocument> documents = [];

  // Notes
  String? notes;

  // Metadata
  @Index()
  late DateTime updatedAt;
  
  bool isDeleted = false;

  // Company Link (ID of the assigned company)
  int? assignedCompanyId;
}
