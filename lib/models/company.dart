import 'package:isar/isar.dart';

part 'company.g.dart';

@collection
class Company {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  late String name;
  
  String? referenceNumber;

  int tabIndex = 0;

  late DateTime updatedAt;
  
  bool isDeleted = false;
}
