// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCustomerCollection on Isar {
  IsarCollection<Customer> get customers => this.collection();
}

const CustomerSchema = CollectionSchema(
  name: r'Customer',
  id: -7623823084711604343,
  properties: {
    r'aadhaarNumber': PropertySchema(
      id: 0,
      name: r'aadhaarNumber',
      type: IsarType.string,
    ),
    r'annualIncome': PropertySchema(
      id: 1,
      name: r'annualIncome',
      type: IsarType.string,
    ),
    r'assignedCompanyId': PropertySchema(
      id: 2,
      name: r'assignedCompanyId',
      type: IsarType.long,
    ),
    r'brotherAge': PropertySchema(
      id: 3,
      name: r'brotherAge',
      type: IsarType.string,
    ),
    r'childrenCompany': PropertySchema(
      id: 4,
      name: r'childrenCompany',
      type: IsarType.string,
    ),
    r'childrenDOBs': PropertySchema(
      id: 5,
      name: r'childrenDOBs',
      type: IsarType.dateTimeList,
    ),
    r'childrenEducationPlan': PropertySchema(
      id: 6,
      name: r'childrenEducationPlan',
      type: IsarType.string,
    ),
    r'childrenPolicyNumber': PropertySchema(
      id: 7,
      name: r'childrenPolicyNumber',
      type: IsarType.string,
    ),
    r'communicationAddress': PropertySchema(
      id: 8,
      name: r'communicationAddress',
      type: IsarType.string,
    ),
    r'customerId': PropertySchema(
      id: 9,
      name: r'customerId',
      type: IsarType.string,
    ),
    r'dateOfBirth': PropertySchema(
      id: 10,
      name: r'dateOfBirth',
      type: IsarType.dateTime,
    ),
    r'designation': PropertySchema(
      id: 11,
      name: r'designation',
      type: IsarType.string,
    ),
    r'documents': PropertySchema(
      id: 12,
      name: r'documents',
      type: IsarType.objectList,
      target: r'CustomerDocument',
    ),
    r'emailId': PropertySchema(
      id: 13,
      name: r'emailId',
      type: IsarType.string,
    ),
    r'employerBusinessName': PropertySchema(
      id: 14,
      name: r'employerBusinessName',
      type: IsarType.string,
    ),
    r'familyDOB': PropertySchema(
      id: 15,
      name: r'familyDOB',
      type: IsarType.dateTime,
    ),
    r'fatherAge': PropertySchema(
      id: 16,
      name: r'fatherAge',
      type: IsarType.string,
    ),
    r'fatherCompany': PropertySchema(
      id: 17,
      name: r'fatherCompany',
      type: IsarType.string,
    ),
    r'fatherName': PropertySchema(
      id: 18,
      name: r'fatherName',
      type: IsarType.string,
    ),
    r'fatherPolicyNumber': PropertySchema(
      id: 19,
      name: r'fatherPolicyNumber',
      type: IsarType.string,
    ),
    r'healthProblems': PropertySchema(
      id: 20,
      name: r'healthProblems',
      type: IsarType.string,
    ),
    r'healthRemarks': PropertySchema(
      id: 21,
      name: r'healthRemarks',
      type: IsarType.string,
    ),
    r'height': PropertySchema(
      id: 22,
      name: r'height',
      type: IsarType.string,
    ),
    r'investmentPlan': PropertySchema(
      id: 23,
      name: r'investmentPlan',
      type: IsarType.string,
    ),
    r'isDeleted': PropertySchema(
      id: 24,
      name: r'isDeleted',
      type: IsarType.bool,
    ),
    r'lifestyleHabits': PropertySchema(
      id: 25,
      name: r'lifestyleHabits',
      type: IsarType.string,
    ),
    r'maritalStatus': PropertySchema(
      id: 26,
      name: r'maritalStatus',
      type: IsarType.string,
    ),
    r'mediClaim': PropertySchema(
      id: 27,
      name: r'mediClaim',
      type: IsarType.string,
    ),
    r'mobileNumber1': PropertySchema(
      id: 28,
      name: r'mobileNumber1',
      type: IsarType.string,
    ),
    r'mobileNumber2': PropertySchema(
      id: 29,
      name: r'mobileNumber2',
      type: IsarType.string,
    ),
    r'mobileNumber3': PropertySchema(
      id: 30,
      name: r'mobileNumber3',
      type: IsarType.string,
    ),
    r'mobileNumber4': PropertySchema(
      id: 31,
      name: r'mobileNumber4',
      type: IsarType.string,
    ),
    r'moneyBackPolicy': PropertySchema(
      id: 32,
      name: r'moneyBackPolicy',
      type: IsarType.string,
    ),
    r'motherAge': PropertySchema(
      id: 33,
      name: r'motherAge',
      type: IsarType.string,
    ),
    r'motherCompany': PropertySchema(
      id: 34,
      name: r'motherCompany',
      type: IsarType.string,
    ),
    r'motherPolicyNumber': PropertySchema(
      id: 35,
      name: r'motherPolicyNumber',
      type: IsarType.string,
    ),
    r'mutualFunds': PropertySchema(
      id: 36,
      name: r'mutualFunds',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 37,
      name: r'name',
      type: IsarType.string,
    ),
    r'nationality': PropertySchema(
      id: 38,
      name: r'nationality',
      type: IsarType.string,
    ),
    r'natureOfBusiness': PropertySchema(
      id: 39,
      name: r'natureOfBusiness',
      type: IsarType.string,
    ),
    r'nomineeDOB': PropertySchema(
      id: 40,
      name: r'nomineeDOB',
      type: IsarType.dateTime,
    ),
    r'nomineeEmail': PropertySchema(
      id: 41,
      name: r'nomineeEmail',
      type: IsarType.string,
    ),
    r'nomineeFatherName': PropertySchema(
      id: 42,
      name: r'nomineeFatherName',
      type: IsarType.string,
    ),
    r'nomineeMobile1': PropertySchema(
      id: 43,
      name: r'nomineeMobile1',
      type: IsarType.string,
    ),
    r'nomineeMobile2': PropertySchema(
      id: 44,
      name: r'nomineeMobile2',
      type: IsarType.string,
    ),
    r'nomineeName': PropertySchema(
      id: 45,
      name: r'nomineeName',
      type: IsarType.string,
    ),
    r'nomineePan': PropertySchema(
      id: 46,
      name: r'nomineePan',
      type: IsarType.string,
    ),
    r'nomineeRelationship': PropertySchema(
      id: 47,
      name: r'nomineeRelationship',
      type: IsarType.string,
    ),
    r'notes': PropertySchema(
      id: 48,
      name: r'notes',
      type: IsarType.string,
    ),
    r'numberOfChildren': PropertySchema(
      id: 49,
      name: r'numberOfChildren',
      type: IsarType.long,
    ),
    r'officeContactNumber': PropertySchema(
      id: 50,
      name: r'officeContactNumber',
      type: IsarType.string,
    ),
    r'panNumber': PropertySchema(
      id: 51,
      name: r'panNumber',
      type: IsarType.string,
    ),
    r'pensionPlan': PropertySchema(
      id: 52,
      name: r'pensionPlan',
      type: IsarType.string,
    ),
    r'permanentAddress': PropertySchema(
      id: 53,
      name: r'permanentAddress',
      type: IsarType.string,
    ),
    r'planSumAssured': PropertySchema(
      id: 54,
      name: r'planSumAssured',
      type: IsarType.string,
    ),
    r'pregnancyDetails': PropertySchema(
      id: 55,
      name: r'pregnancyDetails',
      type: IsarType.string,
    ),
    r'premiumMode': PropertySchema(
      id: 56,
      name: r'premiumMode',
      type: IsarType.string,
    ),
    r'productName': PropertySchema(
      id: 57,
      name: r'productName',
      type: IsarType.string,
    ),
    r'qualification': PropertySchema(
      id: 58,
      name: r'qualification',
      type: IsarType.string,
    ),
    r'referenceAge': PropertySchema(
      id: 59,
      name: r'referenceAge',
      type: IsarType.string,
    ),
    r'referenceFriendName': PropertySchema(
      id: 60,
      name: r'referenceFriendName',
      type: IsarType.string,
    ),
    r'referenceMobile': PropertySchema(
      id: 61,
      name: r'referenceMobile',
      type: IsarType.string,
    ),
    r'reminderDate1': PropertySchema(
      id: 62,
      name: r'reminderDate1',
      type: IsarType.dateTime,
    ),
    r'reminderDate2': PropertySchema(
      id: 63,
      name: r'reminderDate2',
      type: IsarType.dateTime,
    ),
    r'rider': PropertySchema(
      id: 64,
      name: r'rider',
      type: IsarType.string,
    ),
    r'riskCover': PropertySchema(
      id: 65,
      name: r'riskCover',
      type: IsarType.string,
    ),
    r'selfAadhaarNumber': PropertySchema(
      id: 66,
      name: r'selfAadhaarNumber',
      type: IsarType.string,
    ),
    r'selfCompany': PropertySchema(
      id: 67,
      name: r'selfCompany',
      type: IsarType.string,
    ),
    r'selfPolicyNumber': PropertySchema(
      id: 68,
      name: r'selfPolicyNumber',
      type: IsarType.string,
    ),
    r'selfSumAssured1': PropertySchema(
      id: 69,
      name: r'selfSumAssured1',
      type: IsarType.string,
    ),
    r'selfSumAssured2': PropertySchema(
      id: 70,
      name: r'selfSumAssured2',
      type: IsarType.string,
    ),
    r'selfYearOfIssue': PropertySchema(
      id: 71,
      name: r'selfYearOfIssue',
      type: IsarType.string,
    ),
    r'sisterAge': PropertySchema(
      id: 72,
      name: r'sisterAge',
      type: IsarType.string,
    ),
    r'spouseAge': PropertySchema(
      id: 73,
      name: r'spouseAge',
      type: IsarType.string,
    ),
    r'spouseCompany': PropertySchema(
      id: 74,
      name: r'spouseCompany',
      type: IsarType.string,
    ),
    r'spouseName': PropertySchema(
      id: 75,
      name: r'spouseName',
      type: IsarType.string,
    ),
    r'spousePolicyNumber': PropertySchema(
      id: 76,
      name: r'spousePolicyNumber',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 77,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'uuid': PropertySchema(
      id: 78,
      name: r'uuid',
      type: IsarType.string,
    ),
    r'weddingAnniversary': PropertySchema(
      id: 79,
      name: r'weddingAnniversary',
      type: IsarType.dateTime,
    ),
    r'weight': PropertySchema(
      id: 80,
      name: r'weight',
      type: IsarType.string,
    )
  },
  estimateSize: _customerEstimateSize,
  serialize: _customerSerialize,
  deserialize: _customerDeserialize,
  deserializeProp: _customerDeserializeProp,
  idName: r'id',
  indexes: {
    r'uuid': IndexSchema(
      id: 2134397340427724972,
      name: r'uuid',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'uuid',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'customerId': IndexSchema(
      id: 1498639901530368639,
      name: r'customerId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'customerId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'name': IndexSchema(
      id: 879695947855722453,
      name: r'name',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'name',
          type: IndexType.hash,
          caseSensitive: false,
        )
      ],
    ),
    r'updatedAt': IndexSchema(
      id: -6238191080293565125,
      name: r'updatedAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'updatedAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {r'CustomerDocument': CustomerDocumentSchema},
  getId: _customerGetId,
  getLinks: _customerGetLinks,
  attach: _customerAttach,
  version: '3.1.0+1',
);

int _customerEstimateSize(
  Customer object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.aadhaarNumber;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.annualIncome;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.brotherAge;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.childrenCompany;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.childrenDOBs;
    if (value != null) {
      bytesCount += 3 + value.length * 8;
    }
  }
  {
    final value = object.childrenEducationPlan;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.childrenPolicyNumber;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.communicationAddress;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.customerId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.designation;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.documents.length * 3;
  {
    final offsets = allOffsets[CustomerDocument]!;
    for (var i = 0; i < object.documents.length; i++) {
      final value = object.documents[i];
      bytesCount +=
          CustomerDocumentSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  {
    final value = object.emailId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.employerBusinessName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.fatherAge;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.fatherCompany;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.fatherName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.fatherPolicyNumber;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.healthProblems;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.healthRemarks;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.height;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.investmentPlan;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.lifestyleHabits;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.maritalStatus;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.mediClaim;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.mobileNumber1;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.mobileNumber2;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.mobileNumber3;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.mobileNumber4;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.moneyBackPolicy;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.motherAge;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.motherCompany;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.motherPolicyNumber;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.mutualFunds;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.name.length * 3;
  {
    final value = object.nationality;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.natureOfBusiness;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.nomineeEmail;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.nomineeFatherName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.nomineeMobile1;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.nomineeMobile2;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.nomineeName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.nomineePan;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.nomineeRelationship;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.notes;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.officeContactNumber;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.panNumber;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.pensionPlan;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.permanentAddress;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.planSumAssured;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.pregnancyDetails;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.premiumMode;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.productName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.qualification;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.referenceAge;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.referenceFriendName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.referenceMobile;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.rider;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.riskCover;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.selfAadhaarNumber;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.selfCompany;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.selfPolicyNumber;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.selfSumAssured1;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.selfSumAssured2;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.selfYearOfIssue;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.sisterAge;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.spouseAge;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.spouseCompany;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.spouseName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.spousePolicyNumber;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.uuid.length * 3;
  {
    final value = object.weight;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _customerSerialize(
  Customer object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.aadhaarNumber);
  writer.writeString(offsets[1], object.annualIncome);
  writer.writeLong(offsets[2], object.assignedCompanyId);
  writer.writeString(offsets[3], object.brotherAge);
  writer.writeString(offsets[4], object.childrenCompany);
  writer.writeDateTimeList(offsets[5], object.childrenDOBs);
  writer.writeString(offsets[6], object.childrenEducationPlan);
  writer.writeString(offsets[7], object.childrenPolicyNumber);
  writer.writeString(offsets[8], object.communicationAddress);
  writer.writeString(offsets[9], object.customerId);
  writer.writeDateTime(offsets[10], object.dateOfBirth);
  writer.writeString(offsets[11], object.designation);
  writer.writeObjectList<CustomerDocument>(
    offsets[12],
    allOffsets,
    CustomerDocumentSchema.serialize,
    object.documents,
  );
  writer.writeString(offsets[13], object.emailId);
  writer.writeString(offsets[14], object.employerBusinessName);
  writer.writeDateTime(offsets[15], object.familyDOB);
  writer.writeString(offsets[16], object.fatherAge);
  writer.writeString(offsets[17], object.fatherCompany);
  writer.writeString(offsets[18], object.fatherName);
  writer.writeString(offsets[19], object.fatherPolicyNumber);
  writer.writeString(offsets[20], object.healthProblems);
  writer.writeString(offsets[21], object.healthRemarks);
  writer.writeString(offsets[22], object.height);
  writer.writeString(offsets[23], object.investmentPlan);
  writer.writeBool(offsets[24], object.isDeleted);
  writer.writeString(offsets[25], object.lifestyleHabits);
  writer.writeString(offsets[26], object.maritalStatus);
  writer.writeString(offsets[27], object.mediClaim);
  writer.writeString(offsets[28], object.mobileNumber1);
  writer.writeString(offsets[29], object.mobileNumber2);
  writer.writeString(offsets[30], object.mobileNumber3);
  writer.writeString(offsets[31], object.mobileNumber4);
  writer.writeString(offsets[32], object.moneyBackPolicy);
  writer.writeString(offsets[33], object.motherAge);
  writer.writeString(offsets[34], object.motherCompany);
  writer.writeString(offsets[35], object.motherPolicyNumber);
  writer.writeString(offsets[36], object.mutualFunds);
  writer.writeString(offsets[37], object.name);
  writer.writeString(offsets[38], object.nationality);
  writer.writeString(offsets[39], object.natureOfBusiness);
  writer.writeDateTime(offsets[40], object.nomineeDOB);
  writer.writeString(offsets[41], object.nomineeEmail);
  writer.writeString(offsets[42], object.nomineeFatherName);
  writer.writeString(offsets[43], object.nomineeMobile1);
  writer.writeString(offsets[44], object.nomineeMobile2);
  writer.writeString(offsets[45], object.nomineeName);
  writer.writeString(offsets[46], object.nomineePan);
  writer.writeString(offsets[47], object.nomineeRelationship);
  writer.writeString(offsets[48], object.notes);
  writer.writeLong(offsets[49], object.numberOfChildren);
  writer.writeString(offsets[50], object.officeContactNumber);
  writer.writeString(offsets[51], object.panNumber);
  writer.writeString(offsets[52], object.pensionPlan);
  writer.writeString(offsets[53], object.permanentAddress);
  writer.writeString(offsets[54], object.planSumAssured);
  writer.writeString(offsets[55], object.pregnancyDetails);
  writer.writeString(offsets[56], object.premiumMode);
  writer.writeString(offsets[57], object.productName);
  writer.writeString(offsets[58], object.qualification);
  writer.writeString(offsets[59], object.referenceAge);
  writer.writeString(offsets[60], object.referenceFriendName);
  writer.writeString(offsets[61], object.referenceMobile);
  writer.writeDateTime(offsets[62], object.reminderDate1);
  writer.writeDateTime(offsets[63], object.reminderDate2);
  writer.writeString(offsets[64], object.rider);
  writer.writeString(offsets[65], object.riskCover);
  writer.writeString(offsets[66], object.selfAadhaarNumber);
  writer.writeString(offsets[67], object.selfCompany);
  writer.writeString(offsets[68], object.selfPolicyNumber);
  writer.writeString(offsets[69], object.selfSumAssured1);
  writer.writeString(offsets[70], object.selfSumAssured2);
  writer.writeString(offsets[71], object.selfYearOfIssue);
  writer.writeString(offsets[72], object.sisterAge);
  writer.writeString(offsets[73], object.spouseAge);
  writer.writeString(offsets[74], object.spouseCompany);
  writer.writeString(offsets[75], object.spouseName);
  writer.writeString(offsets[76], object.spousePolicyNumber);
  writer.writeDateTime(offsets[77], object.updatedAt);
  writer.writeString(offsets[78], object.uuid);
  writer.writeDateTime(offsets[79], object.weddingAnniversary);
  writer.writeString(offsets[80], object.weight);
}

Customer _customerDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Customer();
  object.aadhaarNumber = reader.readStringOrNull(offsets[0]);
  object.annualIncome = reader.readStringOrNull(offsets[1]);
  object.assignedCompanyId = reader.readLongOrNull(offsets[2]);
  object.brotherAge = reader.readStringOrNull(offsets[3]);
  object.childrenCompany = reader.readStringOrNull(offsets[4]);
  object.childrenDOBs = reader.readDateTimeList(offsets[5]);
  object.childrenEducationPlan = reader.readStringOrNull(offsets[6]);
  object.childrenPolicyNumber = reader.readStringOrNull(offsets[7]);
  object.communicationAddress = reader.readStringOrNull(offsets[8]);
  object.customerId = reader.readStringOrNull(offsets[9]);
  object.dateOfBirth = reader.readDateTimeOrNull(offsets[10]);
  object.designation = reader.readStringOrNull(offsets[11]);
  object.documents = reader.readObjectList<CustomerDocument>(
        offsets[12],
        CustomerDocumentSchema.deserialize,
        allOffsets,
        CustomerDocument(),
      ) ??
      [];
  object.emailId = reader.readStringOrNull(offsets[13]);
  object.employerBusinessName = reader.readStringOrNull(offsets[14]);
  object.familyDOB = reader.readDateTimeOrNull(offsets[15]);
  object.fatherAge = reader.readStringOrNull(offsets[16]);
  object.fatherCompany = reader.readStringOrNull(offsets[17]);
  object.fatherName = reader.readStringOrNull(offsets[18]);
  object.fatherPolicyNumber = reader.readStringOrNull(offsets[19]);
  object.healthProblems = reader.readStringOrNull(offsets[20]);
  object.healthRemarks = reader.readStringOrNull(offsets[21]);
  object.height = reader.readStringOrNull(offsets[22]);
  object.id = id;
  object.investmentPlan = reader.readStringOrNull(offsets[23]);
  object.isDeleted = reader.readBool(offsets[24]);
  object.lifestyleHabits = reader.readStringOrNull(offsets[25]);
  object.maritalStatus = reader.readStringOrNull(offsets[26]);
  object.mediClaim = reader.readStringOrNull(offsets[27]);
  object.mobileNumber1 = reader.readStringOrNull(offsets[28]);
  object.mobileNumber2 = reader.readStringOrNull(offsets[29]);
  object.mobileNumber3 = reader.readStringOrNull(offsets[30]);
  object.mobileNumber4 = reader.readStringOrNull(offsets[31]);
  object.moneyBackPolicy = reader.readStringOrNull(offsets[32]);
  object.motherAge = reader.readStringOrNull(offsets[33]);
  object.motherCompany = reader.readStringOrNull(offsets[34]);
  object.motherPolicyNumber = reader.readStringOrNull(offsets[35]);
  object.mutualFunds = reader.readStringOrNull(offsets[36]);
  object.name = reader.readString(offsets[37]);
  object.nationality = reader.readStringOrNull(offsets[38]);
  object.natureOfBusiness = reader.readStringOrNull(offsets[39]);
  object.nomineeDOB = reader.readDateTimeOrNull(offsets[40]);
  object.nomineeEmail = reader.readStringOrNull(offsets[41]);
  object.nomineeFatherName = reader.readStringOrNull(offsets[42]);
  object.nomineeMobile1 = reader.readStringOrNull(offsets[43]);
  object.nomineeMobile2 = reader.readStringOrNull(offsets[44]);
  object.nomineeName = reader.readStringOrNull(offsets[45]);
  object.nomineePan = reader.readStringOrNull(offsets[46]);
  object.nomineeRelationship = reader.readStringOrNull(offsets[47]);
  object.notes = reader.readStringOrNull(offsets[48]);
  object.numberOfChildren = reader.readLongOrNull(offsets[49]);
  object.officeContactNumber = reader.readStringOrNull(offsets[50]);
  object.panNumber = reader.readStringOrNull(offsets[51]);
  object.pensionPlan = reader.readStringOrNull(offsets[52]);
  object.permanentAddress = reader.readStringOrNull(offsets[53]);
  object.planSumAssured = reader.readStringOrNull(offsets[54]);
  object.pregnancyDetails = reader.readStringOrNull(offsets[55]);
  object.premiumMode = reader.readStringOrNull(offsets[56]);
  object.productName = reader.readStringOrNull(offsets[57]);
  object.qualification = reader.readStringOrNull(offsets[58]);
  object.referenceAge = reader.readStringOrNull(offsets[59]);
  object.referenceFriendName = reader.readStringOrNull(offsets[60]);
  object.referenceMobile = reader.readStringOrNull(offsets[61]);
  object.reminderDate1 = reader.readDateTimeOrNull(offsets[62]);
  object.reminderDate2 = reader.readDateTimeOrNull(offsets[63]);
  object.rider = reader.readStringOrNull(offsets[64]);
  object.riskCover = reader.readStringOrNull(offsets[65]);
  object.selfAadhaarNumber = reader.readStringOrNull(offsets[66]);
  object.selfCompany = reader.readStringOrNull(offsets[67]);
  object.selfPolicyNumber = reader.readStringOrNull(offsets[68]);
  object.selfSumAssured1 = reader.readStringOrNull(offsets[69]);
  object.selfSumAssured2 = reader.readStringOrNull(offsets[70]);
  object.selfYearOfIssue = reader.readStringOrNull(offsets[71]);
  object.sisterAge = reader.readStringOrNull(offsets[72]);
  object.spouseAge = reader.readStringOrNull(offsets[73]);
  object.spouseCompany = reader.readStringOrNull(offsets[74]);
  object.spouseName = reader.readStringOrNull(offsets[75]);
  object.spousePolicyNumber = reader.readStringOrNull(offsets[76]);
  object.updatedAt = reader.readDateTime(offsets[77]);
  object.uuid = reader.readString(offsets[78]);
  object.weddingAnniversary = reader.readDateTimeOrNull(offsets[79]);
  object.weight = reader.readStringOrNull(offsets[80]);
  return object;
}

P _customerDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readDateTimeList(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readObjectList<CustomerDocument>(
            offset,
            CustomerDocumentSchema.deserialize,
            allOffsets,
            CustomerDocument(),
          ) ??
          []) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readStringOrNull(offset)) as P;
    case 15:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 16:
      return (reader.readStringOrNull(offset)) as P;
    case 17:
      return (reader.readStringOrNull(offset)) as P;
    case 18:
      return (reader.readStringOrNull(offset)) as P;
    case 19:
      return (reader.readStringOrNull(offset)) as P;
    case 20:
      return (reader.readStringOrNull(offset)) as P;
    case 21:
      return (reader.readStringOrNull(offset)) as P;
    case 22:
      return (reader.readStringOrNull(offset)) as P;
    case 23:
      return (reader.readStringOrNull(offset)) as P;
    case 24:
      return (reader.readBool(offset)) as P;
    case 25:
      return (reader.readStringOrNull(offset)) as P;
    case 26:
      return (reader.readStringOrNull(offset)) as P;
    case 27:
      return (reader.readStringOrNull(offset)) as P;
    case 28:
      return (reader.readStringOrNull(offset)) as P;
    case 29:
      return (reader.readStringOrNull(offset)) as P;
    case 30:
      return (reader.readStringOrNull(offset)) as P;
    case 31:
      return (reader.readStringOrNull(offset)) as P;
    case 32:
      return (reader.readStringOrNull(offset)) as P;
    case 33:
      return (reader.readStringOrNull(offset)) as P;
    case 34:
      return (reader.readStringOrNull(offset)) as P;
    case 35:
      return (reader.readStringOrNull(offset)) as P;
    case 36:
      return (reader.readStringOrNull(offset)) as P;
    case 37:
      return (reader.readString(offset)) as P;
    case 38:
      return (reader.readStringOrNull(offset)) as P;
    case 39:
      return (reader.readStringOrNull(offset)) as P;
    case 40:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 41:
      return (reader.readStringOrNull(offset)) as P;
    case 42:
      return (reader.readStringOrNull(offset)) as P;
    case 43:
      return (reader.readStringOrNull(offset)) as P;
    case 44:
      return (reader.readStringOrNull(offset)) as P;
    case 45:
      return (reader.readStringOrNull(offset)) as P;
    case 46:
      return (reader.readStringOrNull(offset)) as P;
    case 47:
      return (reader.readStringOrNull(offset)) as P;
    case 48:
      return (reader.readStringOrNull(offset)) as P;
    case 49:
      return (reader.readLongOrNull(offset)) as P;
    case 50:
      return (reader.readStringOrNull(offset)) as P;
    case 51:
      return (reader.readStringOrNull(offset)) as P;
    case 52:
      return (reader.readStringOrNull(offset)) as P;
    case 53:
      return (reader.readStringOrNull(offset)) as P;
    case 54:
      return (reader.readStringOrNull(offset)) as P;
    case 55:
      return (reader.readStringOrNull(offset)) as P;
    case 56:
      return (reader.readStringOrNull(offset)) as P;
    case 57:
      return (reader.readStringOrNull(offset)) as P;
    case 58:
      return (reader.readStringOrNull(offset)) as P;
    case 59:
      return (reader.readStringOrNull(offset)) as P;
    case 60:
      return (reader.readStringOrNull(offset)) as P;
    case 61:
      return (reader.readStringOrNull(offset)) as P;
    case 62:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 63:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 64:
      return (reader.readStringOrNull(offset)) as P;
    case 65:
      return (reader.readStringOrNull(offset)) as P;
    case 66:
      return (reader.readStringOrNull(offset)) as P;
    case 67:
      return (reader.readStringOrNull(offset)) as P;
    case 68:
      return (reader.readStringOrNull(offset)) as P;
    case 69:
      return (reader.readStringOrNull(offset)) as P;
    case 70:
      return (reader.readStringOrNull(offset)) as P;
    case 71:
      return (reader.readStringOrNull(offset)) as P;
    case 72:
      return (reader.readStringOrNull(offset)) as P;
    case 73:
      return (reader.readStringOrNull(offset)) as P;
    case 74:
      return (reader.readStringOrNull(offset)) as P;
    case 75:
      return (reader.readStringOrNull(offset)) as P;
    case 76:
      return (reader.readStringOrNull(offset)) as P;
    case 77:
      return (reader.readDateTime(offset)) as P;
    case 78:
      return (reader.readString(offset)) as P;
    case 79:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 80:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _customerGetId(Customer object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _customerGetLinks(Customer object) {
  return [];
}

void _customerAttach(IsarCollection<dynamic> col, Id id, Customer object) {
  object.id = id;
}

extension CustomerByIndex on IsarCollection<Customer> {
  Future<Customer?> getByUuid(String uuid) {
    return getByIndex(r'uuid', [uuid]);
  }

  Customer? getByUuidSync(String uuid) {
    return getByIndexSync(r'uuid', [uuid]);
  }

  Future<bool> deleteByUuid(String uuid) {
    return deleteByIndex(r'uuid', [uuid]);
  }

  bool deleteByUuidSync(String uuid) {
    return deleteByIndexSync(r'uuid', [uuid]);
  }

  Future<List<Customer?>> getAllByUuid(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndex(r'uuid', values);
  }

  List<Customer?> getAllByUuidSync(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'uuid', values);
  }

  Future<int> deleteAllByUuid(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'uuid', values);
  }

  int deleteAllByUuidSync(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'uuid', values);
  }

  Future<Id> putByUuid(Customer object) {
    return putByIndex(r'uuid', object);
  }

  Id putByUuidSync(Customer object, {bool saveLinks = true}) {
    return putByIndexSync(r'uuid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUuid(List<Customer> objects) {
    return putAllByIndex(r'uuid', objects);
  }

  List<Id> putAllByUuidSync(List<Customer> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'uuid', objects, saveLinks: saveLinks);
  }
}

extension CustomerQueryWhereSort on QueryBuilder<Customer, Customer, QWhere> {
  QueryBuilder<Customer, Customer, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Customer, Customer, QAfterWhere> anyUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'updatedAt'),
      );
    });
  }
}

extension CustomerQueryWhere on QueryBuilder<Customer, Customer, QWhereClause> {
  QueryBuilder<Customer, Customer, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Customer, Customer, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Customer, Customer, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Customer, Customer, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterWhereClause> uuidEqualTo(String uuid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'uuid',
        value: [uuid],
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterWhereClause> uuidNotEqualTo(
      String uuid) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [],
              upper: [uuid],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [uuid],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [uuid],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [],
              upper: [uuid],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Customer, Customer, QAfterWhereClause> customerIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'customerId',
        value: [null],
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterWhereClause> customerIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'customerId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterWhereClause> customerIdEqualTo(
      String? customerId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'customerId',
        value: [customerId],
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterWhereClause> customerIdNotEqualTo(
      String? customerId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'customerId',
              lower: [],
              upper: [customerId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'customerId',
              lower: [customerId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'customerId',
              lower: [customerId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'customerId',
              lower: [],
              upper: [customerId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Customer, Customer, QAfterWhereClause> nameEqualTo(String name) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [name],
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterWhereClause> nameNotEqualTo(
      String name) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Customer, Customer, QAfterWhereClause> updatedAtEqualTo(
      DateTime updatedAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'updatedAt',
        value: [updatedAt],
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterWhereClause> updatedAtNotEqualTo(
      DateTime updatedAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'updatedAt',
              lower: [],
              upper: [updatedAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'updatedAt',
              lower: [updatedAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'updatedAt',
              lower: [updatedAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'updatedAt',
              lower: [],
              upper: [updatedAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Customer, Customer, QAfterWhereClause> updatedAtGreaterThan(
    DateTime updatedAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'updatedAt',
        lower: [updatedAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterWhereClause> updatedAtLessThan(
    DateTime updatedAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'updatedAt',
        lower: [],
        upper: [updatedAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterWhereClause> updatedAtBetween(
    DateTime lowerUpdatedAt,
    DateTime upperUpdatedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'updatedAt',
        lower: [lowerUpdatedAt],
        includeLower: includeLower,
        upper: [upperUpdatedAt],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CustomerQueryFilter
    on QueryBuilder<Customer, Customer, QFilterCondition> {
  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      aadhaarNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'aadhaarNumber',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      aadhaarNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'aadhaarNumber',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> aadhaarNumberEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'aadhaarNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      aadhaarNumberGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'aadhaarNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> aadhaarNumberLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'aadhaarNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> aadhaarNumberBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'aadhaarNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      aadhaarNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'aadhaarNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> aadhaarNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'aadhaarNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> aadhaarNumberContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'aadhaarNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> aadhaarNumberMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'aadhaarNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      aadhaarNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'aadhaarNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      aadhaarNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'aadhaarNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> annualIncomeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'annualIncome',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      annualIncomeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'annualIncome',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> annualIncomeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'annualIncome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      annualIncomeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'annualIncome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> annualIncomeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'annualIncome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> annualIncomeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'annualIncome',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      annualIncomeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'annualIncome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> annualIncomeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'annualIncome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> annualIncomeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'annualIncome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> annualIncomeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'annualIncome',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      annualIncomeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'annualIncome',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      annualIncomeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'annualIncome',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      assignedCompanyIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'assignedCompanyId',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      assignedCompanyIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'assignedCompanyId',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      assignedCompanyIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'assignedCompanyId',
        value: value,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      assignedCompanyIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'assignedCompanyId',
        value: value,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      assignedCompanyIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'assignedCompanyId',
        value: value,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      assignedCompanyIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'assignedCompanyId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> brotherAgeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'brotherAge',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      brotherAgeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'brotherAge',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> brotherAgeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'brotherAge',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> brotherAgeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'brotherAge',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> brotherAgeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'brotherAge',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> brotherAgeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'brotherAge',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> brotherAgeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'brotherAge',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> brotherAgeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'brotherAge',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> brotherAgeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'brotherAge',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> brotherAgeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'brotherAge',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> brotherAgeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'brotherAge',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      brotherAgeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'brotherAge',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      childrenCompanyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'childrenCompany',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      childrenCompanyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'childrenCompany',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      childrenCompanyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'childrenCompany',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      childrenCompanyGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'childrenCompany',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      childrenCompanyLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'childrenCompany',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      childrenCompanyBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'childrenCompany',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      childrenCompanyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'childrenCompany',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      childrenCompanyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'childrenCompany',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      childrenCompanyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'childrenCompany',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      childrenCompanyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'childrenCompany',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      childrenCompanyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'childrenCompany',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      childrenCompanyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'childrenCompany',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> childrenDOBsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'childrenDOBs',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      childrenDOBsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'childrenDOBs',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      childrenDOBsElementEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'childrenDOBs',
        value: value,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      childrenDOBsElementGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'childrenDOBs',
        value: value,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      childrenDOBsElementLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'childrenDOBs',
        value: value,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      childrenDOBsElementBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'childrenDOBs',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      childrenDOBsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'childrenDOBs',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      childrenDOBsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'childrenDOBs',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      childrenDOBsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'childrenDOBs',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      childrenDOBsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'childrenDOBs',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      childrenDOBsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'childrenDOBs',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      childrenDOBsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'childrenDOBs',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      childrenEducationPlanIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'childrenEducationPlan',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      childrenEducationPlanIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'childrenEducationPlan',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      childrenEducationPlanEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'childrenEducationPlan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      childrenEducationPlanGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'childrenEducationPlan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      childrenEducationPlanLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'childrenEducationPlan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      childrenEducationPlanBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'childrenEducationPlan',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      childrenEducationPlanStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'childrenEducationPlan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      childrenEducationPlanEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'childrenEducationPlan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      childrenEducationPlanContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'childrenEducationPlan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      childrenEducationPlanMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'childrenEducationPlan',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      childrenEducationPlanIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'childrenEducationPlan',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      childrenEducationPlanIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'childrenEducationPlan',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      childrenPolicyNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'childrenPolicyNumber',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      childrenPolicyNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'childrenPolicyNumber',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      childrenPolicyNumberEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'childrenPolicyNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      childrenPolicyNumberGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'childrenPolicyNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      childrenPolicyNumberLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'childrenPolicyNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      childrenPolicyNumberBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'childrenPolicyNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      childrenPolicyNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'childrenPolicyNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      childrenPolicyNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'childrenPolicyNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      childrenPolicyNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'childrenPolicyNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      childrenPolicyNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'childrenPolicyNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      childrenPolicyNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'childrenPolicyNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      childrenPolicyNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'childrenPolicyNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      communicationAddressIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'communicationAddress',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      communicationAddressIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'communicationAddress',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      communicationAddressEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'communicationAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      communicationAddressGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'communicationAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      communicationAddressLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'communicationAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      communicationAddressBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'communicationAddress',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      communicationAddressStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'communicationAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      communicationAddressEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'communicationAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      communicationAddressContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'communicationAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      communicationAddressMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'communicationAddress',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      communicationAddressIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'communicationAddress',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      communicationAddressIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'communicationAddress',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> customerIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'customerId',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      customerIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'customerId',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> customerIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> customerIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'customerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> customerIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'customerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> customerIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'customerId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> customerIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'customerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> customerIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'customerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> customerIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'customerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> customerIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'customerId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> customerIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customerId',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      customerIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'customerId',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> dateOfBirthIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dateOfBirth',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      dateOfBirthIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dateOfBirth',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> dateOfBirthEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateOfBirth',
        value: value,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      dateOfBirthGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dateOfBirth',
        value: value,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> dateOfBirthLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dateOfBirth',
        value: value,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> dateOfBirthBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dateOfBirth',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> designationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'designation',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      designationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'designation',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> designationEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'designation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      designationGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'designation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> designationLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'designation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> designationBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'designation',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> designationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'designation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> designationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'designation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> designationContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'designation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> designationMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'designation',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> designationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'designation',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      designationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'designation',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      documentsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'documents',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> documentsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'documents',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      documentsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'documents',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      documentsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'documents',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      documentsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'documents',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      documentsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'documents',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> emailIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'emailId',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> emailIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'emailId',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> emailIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'emailId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> emailIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'emailId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> emailIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'emailId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> emailIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'emailId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> emailIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'emailId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> emailIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'emailId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> emailIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'emailId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> emailIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'emailId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> emailIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'emailId',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> emailIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'emailId',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      employerBusinessNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'employerBusinessName',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      employerBusinessNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'employerBusinessName',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      employerBusinessNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'employerBusinessName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      employerBusinessNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'employerBusinessName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      employerBusinessNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'employerBusinessName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      employerBusinessNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'employerBusinessName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      employerBusinessNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'employerBusinessName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      employerBusinessNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'employerBusinessName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      employerBusinessNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'employerBusinessName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      employerBusinessNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'employerBusinessName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      employerBusinessNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'employerBusinessName',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      employerBusinessNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'employerBusinessName',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> familyDOBIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'familyDOB',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> familyDOBIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'familyDOB',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> familyDOBEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'familyDOB',
        value: value,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> familyDOBGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'familyDOB',
        value: value,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> familyDOBLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'familyDOB',
        value: value,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> familyDOBBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'familyDOB',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> fatherAgeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fatherAge',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> fatherAgeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fatherAge',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> fatherAgeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fatherAge',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> fatherAgeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fatherAge',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> fatherAgeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fatherAge',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> fatherAgeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fatherAge',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> fatherAgeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fatherAge',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> fatherAgeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fatherAge',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> fatherAgeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fatherAge',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> fatherAgeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fatherAge',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> fatherAgeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fatherAge',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      fatherAgeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fatherAge',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      fatherCompanyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fatherCompany',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      fatherCompanyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fatherCompany',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> fatherCompanyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fatherCompany',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      fatherCompanyGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fatherCompany',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> fatherCompanyLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fatherCompany',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> fatherCompanyBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fatherCompany',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      fatherCompanyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fatherCompany',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> fatherCompanyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fatherCompany',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> fatherCompanyContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fatherCompany',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> fatherCompanyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fatherCompany',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      fatherCompanyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fatherCompany',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      fatherCompanyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fatherCompany',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> fatherNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fatherName',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      fatherNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fatherName',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> fatherNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fatherName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> fatherNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fatherName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> fatherNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fatherName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> fatherNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fatherName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> fatherNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fatherName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> fatherNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fatherName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> fatherNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fatherName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> fatherNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fatherName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> fatherNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fatherName',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      fatherNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fatherName',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      fatherPolicyNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fatherPolicyNumber',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      fatherPolicyNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fatherPolicyNumber',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      fatherPolicyNumberEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fatherPolicyNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      fatherPolicyNumberGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fatherPolicyNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      fatherPolicyNumberLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fatherPolicyNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      fatherPolicyNumberBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fatherPolicyNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      fatherPolicyNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fatherPolicyNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      fatherPolicyNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fatherPolicyNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      fatherPolicyNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fatherPolicyNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      fatherPolicyNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fatherPolicyNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      fatherPolicyNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fatherPolicyNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      fatherPolicyNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fatherPolicyNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      healthProblemsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'healthProblems',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      healthProblemsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'healthProblems',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> healthProblemsEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'healthProblems',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      healthProblemsGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'healthProblems',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      healthProblemsLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'healthProblems',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> healthProblemsBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'healthProblems',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      healthProblemsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'healthProblems',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      healthProblemsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'healthProblems',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      healthProblemsContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'healthProblems',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> healthProblemsMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'healthProblems',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      healthProblemsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'healthProblems',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      healthProblemsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'healthProblems',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      healthRemarksIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'healthRemarks',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      healthRemarksIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'healthRemarks',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> healthRemarksEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'healthRemarks',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      healthRemarksGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'healthRemarks',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> healthRemarksLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'healthRemarks',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> healthRemarksBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'healthRemarks',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      healthRemarksStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'healthRemarks',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> healthRemarksEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'healthRemarks',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> healthRemarksContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'healthRemarks',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> healthRemarksMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'healthRemarks',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      healthRemarksIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'healthRemarks',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      healthRemarksIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'healthRemarks',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> heightIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'height',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> heightIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'height',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> heightEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'height',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> heightGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'height',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> heightLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'height',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> heightBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'height',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> heightStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'height',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> heightEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'height',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> heightContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'height',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> heightMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'height',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> heightIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'height',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> heightIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'height',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      investmentPlanIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'investmentPlan',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      investmentPlanIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'investmentPlan',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> investmentPlanEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'investmentPlan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      investmentPlanGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'investmentPlan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      investmentPlanLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'investmentPlan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> investmentPlanBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'investmentPlan',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      investmentPlanStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'investmentPlan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      investmentPlanEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'investmentPlan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      investmentPlanContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'investmentPlan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> investmentPlanMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'investmentPlan',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      investmentPlanIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'investmentPlan',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      investmentPlanIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'investmentPlan',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> isDeletedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isDeleted',
        value: value,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      lifestyleHabitsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lifestyleHabits',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      lifestyleHabitsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lifestyleHabits',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      lifestyleHabitsEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lifestyleHabits',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      lifestyleHabitsGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lifestyleHabits',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      lifestyleHabitsLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lifestyleHabits',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      lifestyleHabitsBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lifestyleHabits',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      lifestyleHabitsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lifestyleHabits',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      lifestyleHabitsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lifestyleHabits',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      lifestyleHabitsContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lifestyleHabits',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      lifestyleHabitsMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lifestyleHabits',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      lifestyleHabitsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lifestyleHabits',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      lifestyleHabitsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lifestyleHabits',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      maritalStatusIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'maritalStatus',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      maritalStatusIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'maritalStatus',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> maritalStatusEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maritalStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      maritalStatusGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maritalStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> maritalStatusLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maritalStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> maritalStatusBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maritalStatus',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      maritalStatusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'maritalStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> maritalStatusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'maritalStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> maritalStatusContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'maritalStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> maritalStatusMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'maritalStatus',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      maritalStatusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maritalStatus',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      maritalStatusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'maritalStatus',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> mediClaimIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'mediClaim',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> mediClaimIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'mediClaim',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> mediClaimEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mediClaim',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> mediClaimGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mediClaim',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> mediClaimLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mediClaim',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> mediClaimBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mediClaim',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> mediClaimStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'mediClaim',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> mediClaimEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'mediClaim',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> mediClaimContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mediClaim',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> mediClaimMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mediClaim',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> mediClaimIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mediClaim',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      mediClaimIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mediClaim',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      mobileNumber1IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'mobileNumber1',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      mobileNumber1IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'mobileNumber1',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> mobileNumber1EqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mobileNumber1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      mobileNumber1GreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mobileNumber1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> mobileNumber1LessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mobileNumber1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> mobileNumber1Between(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mobileNumber1',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      mobileNumber1StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'mobileNumber1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> mobileNumber1EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'mobileNumber1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> mobileNumber1Contains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mobileNumber1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> mobileNumber1Matches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mobileNumber1',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      mobileNumber1IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mobileNumber1',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      mobileNumber1IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mobileNumber1',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      mobileNumber2IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'mobileNumber2',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      mobileNumber2IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'mobileNumber2',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> mobileNumber2EqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mobileNumber2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      mobileNumber2GreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mobileNumber2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> mobileNumber2LessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mobileNumber2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> mobileNumber2Between(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mobileNumber2',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      mobileNumber2StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'mobileNumber2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> mobileNumber2EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'mobileNumber2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> mobileNumber2Contains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mobileNumber2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> mobileNumber2Matches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mobileNumber2',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      mobileNumber2IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mobileNumber2',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      mobileNumber2IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mobileNumber2',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      mobileNumber3IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'mobileNumber3',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      mobileNumber3IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'mobileNumber3',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> mobileNumber3EqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mobileNumber3',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      mobileNumber3GreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mobileNumber3',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> mobileNumber3LessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mobileNumber3',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> mobileNumber3Between(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mobileNumber3',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      mobileNumber3StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'mobileNumber3',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> mobileNumber3EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'mobileNumber3',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> mobileNumber3Contains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mobileNumber3',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> mobileNumber3Matches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mobileNumber3',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      mobileNumber3IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mobileNumber3',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      mobileNumber3IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mobileNumber3',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      mobileNumber4IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'mobileNumber4',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      mobileNumber4IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'mobileNumber4',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> mobileNumber4EqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mobileNumber4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      mobileNumber4GreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mobileNumber4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> mobileNumber4LessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mobileNumber4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> mobileNumber4Between(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mobileNumber4',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      mobileNumber4StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'mobileNumber4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> mobileNumber4EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'mobileNumber4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> mobileNumber4Contains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mobileNumber4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> mobileNumber4Matches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mobileNumber4',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      mobileNumber4IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mobileNumber4',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      mobileNumber4IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mobileNumber4',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      moneyBackPolicyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'moneyBackPolicy',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      moneyBackPolicyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'moneyBackPolicy',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      moneyBackPolicyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'moneyBackPolicy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      moneyBackPolicyGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'moneyBackPolicy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      moneyBackPolicyLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'moneyBackPolicy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      moneyBackPolicyBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'moneyBackPolicy',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      moneyBackPolicyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'moneyBackPolicy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      moneyBackPolicyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'moneyBackPolicy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      moneyBackPolicyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'moneyBackPolicy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      moneyBackPolicyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'moneyBackPolicy',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      moneyBackPolicyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'moneyBackPolicy',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      moneyBackPolicyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'moneyBackPolicy',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> motherAgeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'motherAge',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> motherAgeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'motherAge',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> motherAgeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'motherAge',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> motherAgeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'motherAge',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> motherAgeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'motherAge',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> motherAgeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'motherAge',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> motherAgeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'motherAge',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> motherAgeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'motherAge',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> motherAgeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'motherAge',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> motherAgeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'motherAge',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> motherAgeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'motherAge',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      motherAgeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'motherAge',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      motherCompanyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'motherCompany',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      motherCompanyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'motherCompany',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> motherCompanyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'motherCompany',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      motherCompanyGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'motherCompany',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> motherCompanyLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'motherCompany',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> motherCompanyBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'motherCompany',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      motherCompanyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'motherCompany',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> motherCompanyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'motherCompany',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> motherCompanyContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'motherCompany',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> motherCompanyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'motherCompany',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      motherCompanyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'motherCompany',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      motherCompanyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'motherCompany',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      motherPolicyNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'motherPolicyNumber',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      motherPolicyNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'motherPolicyNumber',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      motherPolicyNumberEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'motherPolicyNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      motherPolicyNumberGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'motherPolicyNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      motherPolicyNumberLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'motherPolicyNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      motherPolicyNumberBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'motherPolicyNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      motherPolicyNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'motherPolicyNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      motherPolicyNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'motherPolicyNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      motherPolicyNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'motherPolicyNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      motherPolicyNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'motherPolicyNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      motherPolicyNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'motherPolicyNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      motherPolicyNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'motherPolicyNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> mutualFundsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'mutualFunds',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      mutualFundsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'mutualFunds',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> mutualFundsEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mutualFunds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      mutualFundsGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mutualFunds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> mutualFundsLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mutualFunds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> mutualFundsBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mutualFunds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> mutualFundsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'mutualFunds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> mutualFundsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'mutualFunds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> mutualFundsContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mutualFunds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> mutualFundsMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mutualFunds',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> mutualFundsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mutualFunds',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      mutualFundsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mutualFunds',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nationalityIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'nationality',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nationalityIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'nationality',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nationalityEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nationality',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nationalityGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nationality',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nationalityLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nationality',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nationalityBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nationality',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nationalityStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nationality',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nationalityEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nationality',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nationalityContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nationality',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nationalityMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nationality',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nationalityIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nationality',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nationalityIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nationality',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      natureOfBusinessIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'natureOfBusiness',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      natureOfBusinessIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'natureOfBusiness',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      natureOfBusinessEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'natureOfBusiness',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      natureOfBusinessGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'natureOfBusiness',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      natureOfBusinessLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'natureOfBusiness',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      natureOfBusinessBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'natureOfBusiness',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      natureOfBusinessStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'natureOfBusiness',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      natureOfBusinessEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'natureOfBusiness',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      natureOfBusinessContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'natureOfBusiness',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      natureOfBusinessMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'natureOfBusiness',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      natureOfBusinessIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'natureOfBusiness',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      natureOfBusinessIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'natureOfBusiness',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nomineeDOBIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'nomineeDOB',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nomineeDOBIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'nomineeDOB',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nomineeDOBEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nomineeDOB',
        value: value,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nomineeDOBGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nomineeDOB',
        value: value,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nomineeDOBLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nomineeDOB',
        value: value,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nomineeDOBBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nomineeDOB',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nomineeEmailIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'nomineeEmail',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nomineeEmailIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'nomineeEmail',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nomineeEmailEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nomineeEmail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nomineeEmailGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nomineeEmail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nomineeEmailLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nomineeEmail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nomineeEmailBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nomineeEmail',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nomineeEmailStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nomineeEmail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nomineeEmailEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nomineeEmail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nomineeEmailContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nomineeEmail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nomineeEmailMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nomineeEmail',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nomineeEmailIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nomineeEmail',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nomineeEmailIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nomineeEmail',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nomineeFatherNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'nomineeFatherName',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nomineeFatherNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'nomineeFatherName',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nomineeFatherNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nomineeFatherName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nomineeFatherNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nomineeFatherName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nomineeFatherNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nomineeFatherName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nomineeFatherNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nomineeFatherName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nomineeFatherNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nomineeFatherName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nomineeFatherNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nomineeFatherName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nomineeFatherNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nomineeFatherName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nomineeFatherNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nomineeFatherName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nomineeFatherNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nomineeFatherName',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nomineeFatherNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nomineeFatherName',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nomineeMobile1IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'nomineeMobile1',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nomineeMobile1IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'nomineeMobile1',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nomineeMobile1EqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nomineeMobile1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nomineeMobile1GreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nomineeMobile1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nomineeMobile1LessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nomineeMobile1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nomineeMobile1Between(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nomineeMobile1',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nomineeMobile1StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nomineeMobile1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nomineeMobile1EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nomineeMobile1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nomineeMobile1Contains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nomineeMobile1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nomineeMobile1Matches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nomineeMobile1',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nomineeMobile1IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nomineeMobile1',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nomineeMobile1IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nomineeMobile1',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nomineeMobile2IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'nomineeMobile2',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nomineeMobile2IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'nomineeMobile2',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nomineeMobile2EqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nomineeMobile2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nomineeMobile2GreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nomineeMobile2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nomineeMobile2LessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nomineeMobile2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nomineeMobile2Between(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nomineeMobile2',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nomineeMobile2StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nomineeMobile2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nomineeMobile2EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nomineeMobile2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nomineeMobile2Contains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nomineeMobile2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nomineeMobile2Matches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nomineeMobile2',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nomineeMobile2IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nomineeMobile2',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nomineeMobile2IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nomineeMobile2',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nomineeNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'nomineeName',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nomineeNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'nomineeName',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nomineeNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nomineeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nomineeNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nomineeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nomineeNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nomineeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nomineeNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nomineeName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nomineeNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nomineeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nomineeNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nomineeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nomineeNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nomineeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nomineeNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nomineeName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nomineeNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nomineeName',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nomineeNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nomineeName',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nomineePanIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'nomineePan',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nomineePanIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'nomineePan',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nomineePanEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nomineePan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nomineePanGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nomineePan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nomineePanLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nomineePan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nomineePanBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nomineePan',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nomineePanStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nomineePan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nomineePanEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nomineePan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nomineePanContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nomineePan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nomineePanMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nomineePan',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nomineePanIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nomineePan',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nomineePanIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nomineePan',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nomineeRelationshipIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'nomineeRelationship',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nomineeRelationshipIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'nomineeRelationship',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nomineeRelationshipEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nomineeRelationship',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nomineeRelationshipGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nomineeRelationship',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nomineeRelationshipLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nomineeRelationship',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nomineeRelationshipBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nomineeRelationship',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nomineeRelationshipStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nomineeRelationship',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nomineeRelationshipEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nomineeRelationship',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nomineeRelationshipContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nomineeRelationship',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nomineeRelationshipMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nomineeRelationship',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nomineeRelationshipIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nomineeRelationship',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nomineeRelationshipIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nomineeRelationship',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> notesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> notesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> notesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> notesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> notesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> notesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> notesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> notesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> notesContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> notesMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      numberOfChildrenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'numberOfChildren',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      numberOfChildrenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'numberOfChildren',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      numberOfChildrenEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'numberOfChildren',
        value: value,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      numberOfChildrenGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'numberOfChildren',
        value: value,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      numberOfChildrenLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'numberOfChildren',
        value: value,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      numberOfChildrenBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'numberOfChildren',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      officeContactNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'officeContactNumber',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      officeContactNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'officeContactNumber',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      officeContactNumberEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'officeContactNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      officeContactNumberGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'officeContactNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      officeContactNumberLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'officeContactNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      officeContactNumberBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'officeContactNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      officeContactNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'officeContactNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      officeContactNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'officeContactNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      officeContactNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'officeContactNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      officeContactNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'officeContactNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      officeContactNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'officeContactNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      officeContactNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'officeContactNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> panNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'panNumber',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> panNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'panNumber',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> panNumberEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'panNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> panNumberGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'panNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> panNumberLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'panNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> panNumberBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'panNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> panNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'panNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> panNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'panNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> panNumberContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'panNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> panNumberMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'panNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> panNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'panNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      panNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'panNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> pensionPlanIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'pensionPlan',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      pensionPlanIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'pensionPlan',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> pensionPlanEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pensionPlan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      pensionPlanGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pensionPlan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> pensionPlanLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pensionPlan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> pensionPlanBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pensionPlan',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> pensionPlanStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'pensionPlan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> pensionPlanEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'pensionPlan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> pensionPlanContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'pensionPlan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> pensionPlanMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'pensionPlan',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> pensionPlanIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pensionPlan',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      pensionPlanIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'pensionPlan',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      permanentAddressIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'permanentAddress',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      permanentAddressIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'permanentAddress',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      permanentAddressEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'permanentAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      permanentAddressGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'permanentAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      permanentAddressLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'permanentAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      permanentAddressBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'permanentAddress',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      permanentAddressStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'permanentAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      permanentAddressEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'permanentAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      permanentAddressContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'permanentAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      permanentAddressMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'permanentAddress',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      permanentAddressIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'permanentAddress',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      permanentAddressIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'permanentAddress',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      planSumAssuredIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'planSumAssured',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      planSumAssuredIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'planSumAssured',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> planSumAssuredEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'planSumAssured',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      planSumAssuredGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'planSumAssured',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      planSumAssuredLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'planSumAssured',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> planSumAssuredBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'planSumAssured',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      planSumAssuredStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'planSumAssured',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      planSumAssuredEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'planSumAssured',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      planSumAssuredContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'planSumAssured',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> planSumAssuredMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'planSumAssured',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      planSumAssuredIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'planSumAssured',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      planSumAssuredIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'planSumAssured',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      pregnancyDetailsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'pregnancyDetails',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      pregnancyDetailsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'pregnancyDetails',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      pregnancyDetailsEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pregnancyDetails',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      pregnancyDetailsGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pregnancyDetails',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      pregnancyDetailsLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pregnancyDetails',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      pregnancyDetailsBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pregnancyDetails',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      pregnancyDetailsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'pregnancyDetails',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      pregnancyDetailsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'pregnancyDetails',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      pregnancyDetailsContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'pregnancyDetails',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      pregnancyDetailsMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'pregnancyDetails',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      pregnancyDetailsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pregnancyDetails',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      pregnancyDetailsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'pregnancyDetails',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> premiumModeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'premiumMode',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      premiumModeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'premiumMode',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> premiumModeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'premiumMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      premiumModeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'premiumMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> premiumModeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'premiumMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> premiumModeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'premiumMode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> premiumModeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'premiumMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> premiumModeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'premiumMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> premiumModeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'premiumMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> premiumModeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'premiumMode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> premiumModeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'premiumMode',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      premiumModeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'premiumMode',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> productNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'productName',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      productNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'productName',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> productNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'productName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      productNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'productName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> productNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'productName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> productNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'productName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> productNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'productName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> productNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'productName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> productNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'productName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> productNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'productName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> productNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'productName',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      productNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'productName',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      qualificationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'qualification',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      qualificationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'qualification',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> qualificationEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'qualification',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      qualificationGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'qualification',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> qualificationLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'qualification',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> qualificationBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'qualification',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      qualificationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'qualification',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> qualificationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'qualification',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> qualificationContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'qualification',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> qualificationMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'qualification',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      qualificationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'qualification',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      qualificationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'qualification',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> referenceAgeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'referenceAge',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      referenceAgeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'referenceAge',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> referenceAgeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'referenceAge',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      referenceAgeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'referenceAge',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> referenceAgeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'referenceAge',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> referenceAgeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'referenceAge',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      referenceAgeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'referenceAge',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> referenceAgeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'referenceAge',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> referenceAgeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'referenceAge',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> referenceAgeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'referenceAge',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      referenceAgeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'referenceAge',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      referenceAgeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'referenceAge',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      referenceFriendNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'referenceFriendName',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      referenceFriendNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'referenceFriendName',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      referenceFriendNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'referenceFriendName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      referenceFriendNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'referenceFriendName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      referenceFriendNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'referenceFriendName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      referenceFriendNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'referenceFriendName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      referenceFriendNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'referenceFriendName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      referenceFriendNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'referenceFriendName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      referenceFriendNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'referenceFriendName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      referenceFriendNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'referenceFriendName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      referenceFriendNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'referenceFriendName',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      referenceFriendNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'referenceFriendName',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      referenceMobileIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'referenceMobile',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      referenceMobileIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'referenceMobile',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      referenceMobileEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'referenceMobile',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      referenceMobileGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'referenceMobile',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      referenceMobileLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'referenceMobile',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      referenceMobileBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'referenceMobile',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      referenceMobileStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'referenceMobile',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      referenceMobileEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'referenceMobile',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      referenceMobileContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'referenceMobile',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      referenceMobileMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'referenceMobile',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      referenceMobileIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'referenceMobile',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      referenceMobileIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'referenceMobile',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      reminderDate1IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'reminderDate1',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      reminderDate1IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'reminderDate1',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> reminderDate1EqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reminderDate1',
        value: value,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      reminderDate1GreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'reminderDate1',
        value: value,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> reminderDate1LessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'reminderDate1',
        value: value,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> reminderDate1Between(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'reminderDate1',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      reminderDate2IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'reminderDate2',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      reminderDate2IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'reminderDate2',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> reminderDate2EqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reminderDate2',
        value: value,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      reminderDate2GreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'reminderDate2',
        value: value,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> reminderDate2LessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'reminderDate2',
        value: value,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> reminderDate2Between(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'reminderDate2',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> riderIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'rider',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> riderIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'rider',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> riderEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rider',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> riderGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rider',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> riderLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rider',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> riderBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rider',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> riderStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'rider',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> riderEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'rider',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> riderContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'rider',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> riderMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'rider',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> riderIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rider',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> riderIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'rider',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> riskCoverIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'riskCover',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> riskCoverIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'riskCover',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> riskCoverEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'riskCover',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> riskCoverGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'riskCover',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> riskCoverLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'riskCover',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> riskCoverBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'riskCover',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> riskCoverStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'riskCover',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> riskCoverEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'riskCover',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> riskCoverContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'riskCover',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> riskCoverMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'riskCover',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> riskCoverIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'riskCover',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      riskCoverIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'riskCover',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfAadhaarNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'selfAadhaarNumber',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfAadhaarNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'selfAadhaarNumber',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfAadhaarNumberEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'selfAadhaarNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfAadhaarNumberGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'selfAadhaarNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfAadhaarNumberLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'selfAadhaarNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfAadhaarNumberBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'selfAadhaarNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfAadhaarNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'selfAadhaarNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfAadhaarNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'selfAadhaarNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfAadhaarNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'selfAadhaarNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfAadhaarNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'selfAadhaarNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfAadhaarNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'selfAadhaarNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfAadhaarNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'selfAadhaarNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> selfCompanyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'selfCompany',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfCompanyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'selfCompany',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> selfCompanyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'selfCompany',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfCompanyGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'selfCompany',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> selfCompanyLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'selfCompany',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> selfCompanyBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'selfCompany',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> selfCompanyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'selfCompany',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> selfCompanyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'selfCompany',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> selfCompanyContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'selfCompany',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> selfCompanyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'selfCompany',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> selfCompanyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'selfCompany',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfCompanyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'selfCompany',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfPolicyNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'selfPolicyNumber',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfPolicyNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'selfPolicyNumber',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfPolicyNumberEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'selfPolicyNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfPolicyNumberGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'selfPolicyNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfPolicyNumberLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'selfPolicyNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfPolicyNumberBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'selfPolicyNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfPolicyNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'selfPolicyNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfPolicyNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'selfPolicyNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfPolicyNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'selfPolicyNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfPolicyNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'selfPolicyNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfPolicyNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'selfPolicyNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfPolicyNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'selfPolicyNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfSumAssured1IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'selfSumAssured1',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfSumAssured1IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'selfSumAssured1',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfSumAssured1EqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'selfSumAssured1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfSumAssured1GreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'selfSumAssured1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfSumAssured1LessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'selfSumAssured1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfSumAssured1Between(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'selfSumAssured1',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfSumAssured1StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'selfSumAssured1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfSumAssured1EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'selfSumAssured1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfSumAssured1Contains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'selfSumAssured1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfSumAssured1Matches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'selfSumAssured1',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfSumAssured1IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'selfSumAssured1',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfSumAssured1IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'selfSumAssured1',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfSumAssured2IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'selfSumAssured2',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfSumAssured2IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'selfSumAssured2',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfSumAssured2EqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'selfSumAssured2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfSumAssured2GreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'selfSumAssured2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfSumAssured2LessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'selfSumAssured2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfSumAssured2Between(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'selfSumAssured2',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfSumAssured2StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'selfSumAssured2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfSumAssured2EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'selfSumAssured2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfSumAssured2Contains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'selfSumAssured2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfSumAssured2Matches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'selfSumAssured2',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfSumAssured2IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'selfSumAssured2',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfSumAssured2IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'selfSumAssured2',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfYearOfIssueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'selfYearOfIssue',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfYearOfIssueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'selfYearOfIssue',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfYearOfIssueEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'selfYearOfIssue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfYearOfIssueGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'selfYearOfIssue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfYearOfIssueLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'selfYearOfIssue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfYearOfIssueBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'selfYearOfIssue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfYearOfIssueStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'selfYearOfIssue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfYearOfIssueEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'selfYearOfIssue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfYearOfIssueContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'selfYearOfIssue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfYearOfIssueMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'selfYearOfIssue',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfYearOfIssueIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'selfYearOfIssue',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      selfYearOfIssueIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'selfYearOfIssue',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> sisterAgeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sisterAge',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> sisterAgeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sisterAge',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> sisterAgeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sisterAge',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> sisterAgeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sisterAge',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> sisterAgeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sisterAge',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> sisterAgeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sisterAge',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> sisterAgeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sisterAge',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> sisterAgeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sisterAge',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> sisterAgeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sisterAge',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> sisterAgeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sisterAge',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> sisterAgeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sisterAge',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      sisterAgeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sisterAge',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> spouseAgeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'spouseAge',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> spouseAgeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'spouseAge',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> spouseAgeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'spouseAge',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> spouseAgeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'spouseAge',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> spouseAgeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'spouseAge',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> spouseAgeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'spouseAge',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> spouseAgeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'spouseAge',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> spouseAgeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'spouseAge',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> spouseAgeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'spouseAge',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> spouseAgeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'spouseAge',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> spouseAgeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'spouseAge',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      spouseAgeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'spouseAge',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      spouseCompanyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'spouseCompany',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      spouseCompanyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'spouseCompany',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> spouseCompanyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'spouseCompany',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      spouseCompanyGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'spouseCompany',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> spouseCompanyLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'spouseCompany',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> spouseCompanyBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'spouseCompany',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      spouseCompanyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'spouseCompany',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> spouseCompanyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'spouseCompany',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> spouseCompanyContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'spouseCompany',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> spouseCompanyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'spouseCompany',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      spouseCompanyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'spouseCompany',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      spouseCompanyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'spouseCompany',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> spouseNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'spouseName',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      spouseNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'spouseName',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> spouseNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'spouseName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> spouseNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'spouseName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> spouseNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'spouseName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> spouseNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'spouseName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> spouseNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'spouseName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> spouseNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'spouseName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> spouseNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'spouseName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> spouseNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'spouseName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> spouseNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'spouseName',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      spouseNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'spouseName',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      spousePolicyNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'spousePolicyNumber',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      spousePolicyNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'spousePolicyNumber',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      spousePolicyNumberEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'spousePolicyNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      spousePolicyNumberGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'spousePolicyNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      spousePolicyNumberLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'spousePolicyNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      spousePolicyNumberBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'spousePolicyNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      spousePolicyNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'spousePolicyNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      spousePolicyNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'spousePolicyNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      spousePolicyNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'spousePolicyNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      spousePolicyNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'spousePolicyNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      spousePolicyNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'spousePolicyNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      spousePolicyNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'spousePolicyNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> updatedAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> updatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> updatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> uuidEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> uuidGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> uuidLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> uuidBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'uuid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> uuidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> uuidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> uuidContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> uuidMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'uuid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      weddingAnniversaryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'weddingAnniversary',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      weddingAnniversaryIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'weddingAnniversary',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      weddingAnniversaryEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weddingAnniversary',
        value: value,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      weddingAnniversaryGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'weddingAnniversary',
        value: value,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      weddingAnniversaryLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'weddingAnniversary',
        value: value,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      weddingAnniversaryBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'weddingAnniversary',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> weightIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'weight',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> weightIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'weight',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> weightEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weight',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> weightGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'weight',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> weightLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'weight',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> weightBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'weight',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> weightStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'weight',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> weightEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'weight',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> weightContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'weight',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> weightMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'weight',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> weightIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weight',
        value: '',
      ));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> weightIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'weight',
        value: '',
      ));
    });
  }
}

extension CustomerQueryObject
    on QueryBuilder<Customer, Customer, QFilterCondition> {
  QueryBuilder<Customer, Customer, QAfterFilterCondition> documentsElement(
      FilterQuery<CustomerDocument> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'documents');
    });
  }
}

extension CustomerQueryLinks
    on QueryBuilder<Customer, Customer, QFilterCondition> {}

extension CustomerQuerySortBy on QueryBuilder<Customer, Customer, QSortBy> {
  QueryBuilder<Customer, Customer, QAfterSortBy> sortByAadhaarNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aadhaarNumber', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByAadhaarNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aadhaarNumber', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByAnnualIncome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'annualIncome', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByAnnualIncomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'annualIncome', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByAssignedCompanyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assignedCompanyId', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByAssignedCompanyIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assignedCompanyId', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByBrotherAge() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'brotherAge', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByBrotherAgeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'brotherAge', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByChildrenCompany() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'childrenCompany', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByChildrenCompanyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'childrenCompany', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByChildrenEducationPlan() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'childrenEducationPlan', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy>
      sortByChildrenEducationPlanDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'childrenEducationPlan', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByChildrenPolicyNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'childrenPolicyNumber', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy>
      sortByChildrenPolicyNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'childrenPolicyNumber', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByCommunicationAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'communicationAddress', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy>
      sortByCommunicationAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'communicationAddress', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByCustomerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerId', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByCustomerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerId', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByDateOfBirth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateOfBirth', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByDateOfBirthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateOfBirth', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByDesignation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'designation', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByDesignationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'designation', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByEmailId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emailId', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByEmailIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emailId', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByEmployerBusinessName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employerBusinessName', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy>
      sortByEmployerBusinessNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employerBusinessName', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByFamilyDOB() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'familyDOB', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByFamilyDOBDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'familyDOB', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByFatherAge() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fatherAge', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByFatherAgeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fatherAge', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByFatherCompany() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fatherCompany', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByFatherCompanyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fatherCompany', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByFatherName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fatherName', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByFatherNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fatherName', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByFatherPolicyNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fatherPolicyNumber', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy>
      sortByFatherPolicyNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fatherPolicyNumber', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByHealthProblems() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'healthProblems', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByHealthProblemsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'healthProblems', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByHealthRemarks() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'healthRemarks', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByHealthRemarksDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'healthRemarks', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'height', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByHeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'height', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByInvestmentPlan() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'investmentPlan', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByInvestmentPlanDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'investmentPlan', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByIsDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByLifestyleHabits() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lifestyleHabits', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByLifestyleHabitsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lifestyleHabits', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByMaritalStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maritalStatus', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByMaritalStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maritalStatus', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByMediClaim() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediClaim', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByMediClaimDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediClaim', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByMobileNumber1() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mobileNumber1', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByMobileNumber1Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mobileNumber1', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByMobileNumber2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mobileNumber2', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByMobileNumber2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mobileNumber2', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByMobileNumber3() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mobileNumber3', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByMobileNumber3Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mobileNumber3', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByMobileNumber4() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mobileNumber4', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByMobileNumber4Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mobileNumber4', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByMoneyBackPolicy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'moneyBackPolicy', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByMoneyBackPolicyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'moneyBackPolicy', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByMotherAge() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motherAge', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByMotherAgeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motherAge', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByMotherCompany() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motherCompany', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByMotherCompanyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motherCompany', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByMotherPolicyNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motherPolicyNumber', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy>
      sortByMotherPolicyNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motherPolicyNumber', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByMutualFunds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mutualFunds', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByMutualFundsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mutualFunds', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByNationality() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nationality', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByNationalityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nationality', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByNatureOfBusiness() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'natureOfBusiness', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByNatureOfBusinessDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'natureOfBusiness', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByNomineeDOB() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomineeDOB', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByNomineeDOBDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomineeDOB', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByNomineeEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomineeEmail', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByNomineeEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomineeEmail', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByNomineeFatherName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomineeFatherName', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByNomineeFatherNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomineeFatherName', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByNomineeMobile1() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomineeMobile1', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByNomineeMobile1Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomineeMobile1', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByNomineeMobile2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomineeMobile2', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByNomineeMobile2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomineeMobile2', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByNomineeName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomineeName', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByNomineeNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomineeName', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByNomineePan() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomineePan', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByNomineePanDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomineePan', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByNomineeRelationship() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomineeRelationship', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy>
      sortByNomineeRelationshipDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomineeRelationship', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByNumberOfChildren() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numberOfChildren', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByNumberOfChildrenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numberOfChildren', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByOfficeContactNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'officeContactNumber', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy>
      sortByOfficeContactNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'officeContactNumber', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByPanNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'panNumber', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByPanNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'panNumber', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByPensionPlan() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pensionPlan', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByPensionPlanDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pensionPlan', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByPermanentAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'permanentAddress', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByPermanentAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'permanentAddress', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByPlanSumAssured() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'planSumAssured', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByPlanSumAssuredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'planSumAssured', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByPregnancyDetails() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pregnancyDetails', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByPregnancyDetailsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pregnancyDetails', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByPremiumMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'premiumMode', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByPremiumModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'premiumMode', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByProductName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productName', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByProductNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productName', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByQualification() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qualification', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByQualificationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qualification', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByReferenceAge() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'referenceAge', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByReferenceAgeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'referenceAge', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByReferenceFriendName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'referenceFriendName', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy>
      sortByReferenceFriendNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'referenceFriendName', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByReferenceMobile() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'referenceMobile', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByReferenceMobileDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'referenceMobile', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByReminderDate1() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderDate1', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByReminderDate1Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderDate1', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByReminderDate2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderDate2', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByReminderDate2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderDate2', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByRider() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rider', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByRiderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rider', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByRiskCover() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'riskCover', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByRiskCoverDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'riskCover', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortBySelfAadhaarNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selfAadhaarNumber', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortBySelfAadhaarNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selfAadhaarNumber', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortBySelfCompany() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selfCompany', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortBySelfCompanyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selfCompany', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortBySelfPolicyNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selfPolicyNumber', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortBySelfPolicyNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selfPolicyNumber', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortBySelfSumAssured1() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selfSumAssured1', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortBySelfSumAssured1Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selfSumAssured1', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortBySelfSumAssured2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selfSumAssured2', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortBySelfSumAssured2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selfSumAssured2', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortBySelfYearOfIssue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selfYearOfIssue', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortBySelfYearOfIssueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selfYearOfIssue', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortBySisterAge() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sisterAge', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortBySisterAgeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sisterAge', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortBySpouseAge() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spouseAge', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortBySpouseAgeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spouseAge', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortBySpouseCompany() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spouseCompany', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortBySpouseCompanyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spouseCompany', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortBySpouseName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spouseName', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortBySpouseNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spouseName', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortBySpousePolicyNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spousePolicyNumber', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy>
      sortBySpousePolicyNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spousePolicyNumber', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByWeddingAnniversary() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weddingAnniversary', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy>
      sortByWeddingAnniversaryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weddingAnniversary', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weight', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByWeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weight', Sort.desc);
    });
  }
}

extension CustomerQuerySortThenBy
    on QueryBuilder<Customer, Customer, QSortThenBy> {
  QueryBuilder<Customer, Customer, QAfterSortBy> thenByAadhaarNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aadhaarNumber', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByAadhaarNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aadhaarNumber', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByAnnualIncome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'annualIncome', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByAnnualIncomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'annualIncome', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByAssignedCompanyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assignedCompanyId', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByAssignedCompanyIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assignedCompanyId', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByBrotherAge() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'brotherAge', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByBrotherAgeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'brotherAge', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByChildrenCompany() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'childrenCompany', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByChildrenCompanyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'childrenCompany', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByChildrenEducationPlan() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'childrenEducationPlan', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy>
      thenByChildrenEducationPlanDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'childrenEducationPlan', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByChildrenPolicyNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'childrenPolicyNumber', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy>
      thenByChildrenPolicyNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'childrenPolicyNumber', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByCommunicationAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'communicationAddress', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy>
      thenByCommunicationAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'communicationAddress', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByCustomerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerId', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByCustomerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerId', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByDateOfBirth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateOfBirth', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByDateOfBirthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateOfBirth', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByDesignation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'designation', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByDesignationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'designation', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByEmailId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emailId', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByEmailIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emailId', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByEmployerBusinessName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employerBusinessName', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy>
      thenByEmployerBusinessNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employerBusinessName', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByFamilyDOB() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'familyDOB', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByFamilyDOBDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'familyDOB', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByFatherAge() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fatherAge', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByFatherAgeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fatherAge', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByFatherCompany() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fatherCompany', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByFatherCompanyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fatherCompany', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByFatherName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fatherName', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByFatherNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fatherName', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByFatherPolicyNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fatherPolicyNumber', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy>
      thenByFatherPolicyNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fatherPolicyNumber', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByHealthProblems() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'healthProblems', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByHealthProblemsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'healthProblems', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByHealthRemarks() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'healthRemarks', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByHealthRemarksDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'healthRemarks', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'height', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByHeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'height', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByInvestmentPlan() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'investmentPlan', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByInvestmentPlanDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'investmentPlan', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByIsDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByLifestyleHabits() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lifestyleHabits', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByLifestyleHabitsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lifestyleHabits', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByMaritalStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maritalStatus', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByMaritalStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maritalStatus', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByMediClaim() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediClaim', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByMediClaimDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediClaim', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByMobileNumber1() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mobileNumber1', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByMobileNumber1Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mobileNumber1', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByMobileNumber2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mobileNumber2', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByMobileNumber2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mobileNumber2', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByMobileNumber3() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mobileNumber3', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByMobileNumber3Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mobileNumber3', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByMobileNumber4() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mobileNumber4', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByMobileNumber4Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mobileNumber4', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByMoneyBackPolicy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'moneyBackPolicy', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByMoneyBackPolicyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'moneyBackPolicy', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByMotherAge() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motherAge', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByMotherAgeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motherAge', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByMotherCompany() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motherCompany', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByMotherCompanyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motherCompany', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByMotherPolicyNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motherPolicyNumber', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy>
      thenByMotherPolicyNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motherPolicyNumber', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByMutualFunds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mutualFunds', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByMutualFundsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mutualFunds', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByNationality() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nationality', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByNationalityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nationality', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByNatureOfBusiness() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'natureOfBusiness', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByNatureOfBusinessDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'natureOfBusiness', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByNomineeDOB() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomineeDOB', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByNomineeDOBDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomineeDOB', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByNomineeEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomineeEmail', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByNomineeEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomineeEmail', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByNomineeFatherName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomineeFatherName', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByNomineeFatherNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomineeFatherName', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByNomineeMobile1() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomineeMobile1', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByNomineeMobile1Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomineeMobile1', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByNomineeMobile2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomineeMobile2', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByNomineeMobile2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomineeMobile2', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByNomineeName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomineeName', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByNomineeNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomineeName', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByNomineePan() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomineePan', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByNomineePanDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomineePan', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByNomineeRelationship() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomineeRelationship', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy>
      thenByNomineeRelationshipDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomineeRelationship', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByNumberOfChildren() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numberOfChildren', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByNumberOfChildrenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numberOfChildren', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByOfficeContactNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'officeContactNumber', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy>
      thenByOfficeContactNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'officeContactNumber', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByPanNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'panNumber', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByPanNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'panNumber', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByPensionPlan() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pensionPlan', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByPensionPlanDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pensionPlan', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByPermanentAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'permanentAddress', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByPermanentAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'permanentAddress', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByPlanSumAssured() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'planSumAssured', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByPlanSumAssuredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'planSumAssured', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByPregnancyDetails() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pregnancyDetails', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByPregnancyDetailsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pregnancyDetails', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByPremiumMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'premiumMode', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByPremiumModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'premiumMode', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByProductName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productName', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByProductNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productName', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByQualification() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qualification', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByQualificationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qualification', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByReferenceAge() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'referenceAge', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByReferenceAgeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'referenceAge', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByReferenceFriendName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'referenceFriendName', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy>
      thenByReferenceFriendNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'referenceFriendName', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByReferenceMobile() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'referenceMobile', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByReferenceMobileDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'referenceMobile', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByReminderDate1() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderDate1', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByReminderDate1Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderDate1', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByReminderDate2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderDate2', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByReminderDate2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderDate2', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByRider() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rider', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByRiderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rider', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByRiskCover() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'riskCover', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByRiskCoverDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'riskCover', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenBySelfAadhaarNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selfAadhaarNumber', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenBySelfAadhaarNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selfAadhaarNumber', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenBySelfCompany() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selfCompany', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenBySelfCompanyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selfCompany', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenBySelfPolicyNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selfPolicyNumber', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenBySelfPolicyNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selfPolicyNumber', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenBySelfSumAssured1() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selfSumAssured1', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenBySelfSumAssured1Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selfSumAssured1', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenBySelfSumAssured2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selfSumAssured2', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenBySelfSumAssured2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selfSumAssured2', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenBySelfYearOfIssue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selfYearOfIssue', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenBySelfYearOfIssueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selfYearOfIssue', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenBySisterAge() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sisterAge', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenBySisterAgeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sisterAge', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenBySpouseAge() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spouseAge', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenBySpouseAgeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spouseAge', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenBySpouseCompany() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spouseCompany', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenBySpouseCompanyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spouseCompany', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenBySpouseName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spouseName', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenBySpouseNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spouseName', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenBySpousePolicyNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spousePolicyNumber', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy>
      thenBySpousePolicyNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spousePolicyNumber', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByWeddingAnniversary() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weddingAnniversary', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy>
      thenByWeddingAnniversaryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weddingAnniversary', Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weight', Sort.asc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByWeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weight', Sort.desc);
    });
  }
}

extension CustomerQueryWhereDistinct
    on QueryBuilder<Customer, Customer, QDistinct> {
  QueryBuilder<Customer, Customer, QDistinct> distinctByAadhaarNumber(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'aadhaarNumber',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByAnnualIncome(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'annualIncome', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByAssignedCompanyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'assignedCompanyId');
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByBrotherAge(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'brotherAge', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByChildrenCompany(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'childrenCompany',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByChildrenDOBs() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'childrenDOBs');
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByChildrenEducationPlan(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'childrenEducationPlan',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByChildrenPolicyNumber(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'childrenPolicyNumber',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByCommunicationAddress(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'communicationAddress',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByCustomerId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'customerId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByDateOfBirth() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateOfBirth');
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByDesignation(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'designation', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByEmailId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'emailId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByEmployerBusinessName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'employerBusinessName',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByFamilyDOB() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'familyDOB');
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByFatherAge(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fatherAge', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByFatherCompany(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fatherCompany',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByFatherName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fatherName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByFatherPolicyNumber(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fatherPolicyNumber',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByHealthProblems(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'healthProblems',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByHealthRemarks(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'healthRemarks',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByHeight(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'height', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByInvestmentPlan(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'investmentPlan',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDeleted');
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByLifestyleHabits(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lifestyleHabits',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByMaritalStatus(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'maritalStatus',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByMediClaim(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mediClaim', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByMobileNumber1(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mobileNumber1',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByMobileNumber2(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mobileNumber2',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByMobileNumber3(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mobileNumber3',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByMobileNumber4(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mobileNumber4',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByMoneyBackPolicy(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'moneyBackPolicy',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByMotherAge(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'motherAge', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByMotherCompany(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'motherCompany',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByMotherPolicyNumber(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'motherPolicyNumber',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByMutualFunds(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mutualFunds', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByNationality(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nationality', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByNatureOfBusiness(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'natureOfBusiness',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByNomineeDOB() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nomineeDOB');
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByNomineeEmail(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nomineeEmail', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByNomineeFatherName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nomineeFatherName',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByNomineeMobile1(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nomineeMobile1',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByNomineeMobile2(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nomineeMobile2',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByNomineeName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nomineeName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByNomineePan(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nomineePan', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByNomineeRelationship(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nomineeRelationship',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByNotes(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByNumberOfChildren() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'numberOfChildren');
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByOfficeContactNumber(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'officeContactNumber',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByPanNumber(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'panNumber', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByPensionPlan(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pensionPlan', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByPermanentAddress(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'permanentAddress',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByPlanSumAssured(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'planSumAssured',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByPregnancyDetails(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pregnancyDetails',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByPremiumMode(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'premiumMode', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByProductName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'productName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByQualification(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'qualification',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByReferenceAge(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'referenceAge', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByReferenceFriendName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'referenceFriendName',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByReferenceMobile(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'referenceMobile',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByReminderDate1() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'reminderDate1');
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByReminderDate2() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'reminderDate2');
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByRider(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rider', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByRiskCover(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'riskCover', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctBySelfAadhaarNumber(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'selfAadhaarNumber',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctBySelfCompany(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'selfCompany', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctBySelfPolicyNumber(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'selfPolicyNumber',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctBySelfSumAssured1(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'selfSumAssured1',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctBySelfSumAssured2(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'selfSumAssured2',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctBySelfYearOfIssue(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'selfYearOfIssue',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctBySisterAge(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sisterAge', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctBySpouseAge(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'spouseAge', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctBySpouseCompany(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'spouseCompany',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctBySpouseName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'spouseName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctBySpousePolicyNumber(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'spousePolicyNumber',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByUuid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByWeddingAnniversary() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weddingAnniversary');
    });
  }

  QueryBuilder<Customer, Customer, QDistinct> distinctByWeight(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weight', caseSensitive: caseSensitive);
    });
  }
}

extension CustomerQueryProperty
    on QueryBuilder<Customer, Customer, QQueryProperty> {
  QueryBuilder<Customer, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations> aadhaarNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'aadhaarNumber');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations> annualIncomeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'annualIncome');
    });
  }

  QueryBuilder<Customer, int?, QQueryOperations> assignedCompanyIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'assignedCompanyId');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations> brotherAgeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'brotherAge');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations> childrenCompanyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'childrenCompany');
    });
  }

  QueryBuilder<Customer, List<DateTime>?, QQueryOperations>
      childrenDOBsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'childrenDOBs');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations>
      childrenEducationPlanProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'childrenEducationPlan');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations>
      childrenPolicyNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'childrenPolicyNumber');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations>
      communicationAddressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'communicationAddress');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations> customerIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'customerId');
    });
  }

  QueryBuilder<Customer, DateTime?, QQueryOperations> dateOfBirthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateOfBirth');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations> designationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'designation');
    });
  }

  QueryBuilder<Customer, List<CustomerDocument>, QQueryOperations>
      documentsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'documents');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations> emailIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'emailId');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations>
      employerBusinessNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'employerBusinessName');
    });
  }

  QueryBuilder<Customer, DateTime?, QQueryOperations> familyDOBProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'familyDOB');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations> fatherAgeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fatherAge');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations> fatherCompanyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fatherCompany');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations> fatherNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fatherName');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations>
      fatherPolicyNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fatherPolicyNumber');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations> healthProblemsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'healthProblems');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations> healthRemarksProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'healthRemarks');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations> heightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'height');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations> investmentPlanProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'investmentPlan');
    });
  }

  QueryBuilder<Customer, bool, QQueryOperations> isDeletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDeleted');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations> lifestyleHabitsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lifestyleHabits');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations> maritalStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'maritalStatus');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations> mediClaimProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mediClaim');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations> mobileNumber1Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mobileNumber1');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations> mobileNumber2Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mobileNumber2');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations> mobileNumber3Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mobileNumber3');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations> mobileNumber4Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mobileNumber4');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations> moneyBackPolicyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'moneyBackPolicy');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations> motherAgeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'motherAge');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations> motherCompanyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'motherCompany');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations>
      motherPolicyNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'motherPolicyNumber');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations> mutualFundsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mutualFunds');
    });
  }

  QueryBuilder<Customer, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations> nationalityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nationality');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations> natureOfBusinessProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'natureOfBusiness');
    });
  }

  QueryBuilder<Customer, DateTime?, QQueryOperations> nomineeDOBProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nomineeDOB');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations> nomineeEmailProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nomineeEmail');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations>
      nomineeFatherNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nomineeFatherName');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations> nomineeMobile1Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nomineeMobile1');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations> nomineeMobile2Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nomineeMobile2');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations> nomineeNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nomineeName');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations> nomineePanProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nomineePan');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations>
      nomineeRelationshipProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nomineeRelationship');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations> notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }

  QueryBuilder<Customer, int?, QQueryOperations> numberOfChildrenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'numberOfChildren');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations>
      officeContactNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'officeContactNumber');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations> panNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'panNumber');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations> pensionPlanProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pensionPlan');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations> permanentAddressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'permanentAddress');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations> planSumAssuredProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'planSumAssured');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations> pregnancyDetailsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pregnancyDetails');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations> premiumModeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'premiumMode');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations> productNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'productName');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations> qualificationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'qualification');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations> referenceAgeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'referenceAge');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations>
      referenceFriendNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'referenceFriendName');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations> referenceMobileProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'referenceMobile');
    });
  }

  QueryBuilder<Customer, DateTime?, QQueryOperations> reminderDate1Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'reminderDate1');
    });
  }

  QueryBuilder<Customer, DateTime?, QQueryOperations> reminderDate2Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'reminderDate2');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations> riderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rider');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations> riskCoverProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'riskCover');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations>
      selfAadhaarNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'selfAadhaarNumber');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations> selfCompanyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'selfCompany');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations> selfPolicyNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'selfPolicyNumber');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations> selfSumAssured1Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'selfSumAssured1');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations> selfSumAssured2Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'selfSumAssured2');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations> selfYearOfIssueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'selfYearOfIssue');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations> sisterAgeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sisterAge');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations> spouseAgeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'spouseAge');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations> spouseCompanyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'spouseCompany');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations> spouseNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'spouseName');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations>
      spousePolicyNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'spousePolicyNumber');
    });
  }

  QueryBuilder<Customer, DateTime, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<Customer, String, QQueryOperations> uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }

  QueryBuilder<Customer, DateTime?, QQueryOperations>
      weddingAnniversaryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weddingAnniversary');
    });
  }

  QueryBuilder<Customer, String?, QQueryOperations> weightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weight');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const CustomerDocumentSchema = Schema(
  name: r'CustomerDocument',
  id: -8672034887137952600,
  properties: {
    r'documentName': PropertySchema(
      id: 0,
      name: r'documentName',
      type: IsarType.string,
    ),
    r'fileName': PropertySchema(
      id: 1,
      name: r'fileName',
      type: IsarType.string,
    )
  },
  estimateSize: _customerDocumentEstimateSize,
  serialize: _customerDocumentSerialize,
  deserialize: _customerDocumentDeserialize,
  deserializeProp: _customerDocumentDeserializeProp,
);

int _customerDocumentEstimateSize(
  CustomerDocument object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.documentName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.fileName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _customerDocumentSerialize(
  CustomerDocument object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.documentName);
  writer.writeString(offsets[1], object.fileName);
}

CustomerDocument _customerDocumentDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CustomerDocument();
  object.documentName = reader.readStringOrNull(offsets[0]);
  object.fileName = reader.readStringOrNull(offsets[1]);
  return object;
}

P _customerDocumentDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension CustomerDocumentQueryFilter
    on QueryBuilder<CustomerDocument, CustomerDocument, QFilterCondition> {
  QueryBuilder<CustomerDocument, CustomerDocument, QAfterFilterCondition>
      documentNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'documentName',
      ));
    });
  }

  QueryBuilder<CustomerDocument, CustomerDocument, QAfterFilterCondition>
      documentNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'documentName',
      ));
    });
  }

  QueryBuilder<CustomerDocument, CustomerDocument, QAfterFilterCondition>
      documentNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'documentName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerDocument, CustomerDocument, QAfterFilterCondition>
      documentNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'documentName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerDocument, CustomerDocument, QAfterFilterCondition>
      documentNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'documentName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerDocument, CustomerDocument, QAfterFilterCondition>
      documentNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'documentName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerDocument, CustomerDocument, QAfterFilterCondition>
      documentNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'documentName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerDocument, CustomerDocument, QAfterFilterCondition>
      documentNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'documentName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerDocument, CustomerDocument, QAfterFilterCondition>
      documentNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'documentName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerDocument, CustomerDocument, QAfterFilterCondition>
      documentNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'documentName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerDocument, CustomerDocument, QAfterFilterCondition>
      documentNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'documentName',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerDocument, CustomerDocument, QAfterFilterCondition>
      documentNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'documentName',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerDocument, CustomerDocument, QAfterFilterCondition>
      fileNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fileName',
      ));
    });
  }

  QueryBuilder<CustomerDocument, CustomerDocument, QAfterFilterCondition>
      fileNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fileName',
      ));
    });
  }

  QueryBuilder<CustomerDocument, CustomerDocument, QAfterFilterCondition>
      fileNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerDocument, CustomerDocument, QAfterFilterCondition>
      fileNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerDocument, CustomerDocument, QAfterFilterCondition>
      fileNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerDocument, CustomerDocument, QAfterFilterCondition>
      fileNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fileName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerDocument, CustomerDocument, QAfterFilterCondition>
      fileNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerDocument, CustomerDocument, QAfterFilterCondition>
      fileNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerDocument, CustomerDocument, QAfterFilterCondition>
      fileNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerDocument, CustomerDocument, QAfterFilterCondition>
      fileNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fileName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerDocument, CustomerDocument, QAfterFilterCondition>
      fileNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fileName',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerDocument, CustomerDocument, QAfterFilterCondition>
      fileNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fileName',
        value: '',
      ));
    });
  }
}

extension CustomerDocumentQueryObject
    on QueryBuilder<CustomerDocument, CustomerDocument, QFilterCondition> {}
