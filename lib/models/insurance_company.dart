import 'package:isar/isar.dart';

part 'insurance_company.g.dart';

@collection
class InsuranceCompany {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index(caseSensitive: false)
  late String name;

  late DateTime updatedAt;

  bool isDeleted = false;
}
