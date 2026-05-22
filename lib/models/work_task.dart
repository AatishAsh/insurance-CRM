import 'package:isar/isar.dart';

part 'work_task.g.dart';

@collection
class WorkTask {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  // Link to a specific company (1-15)
  int? companyId;
  
  late String description;
  late DateTime workDate;
  DateTime? assignedDate;
  
  // Urgent, Important, Normal
  late String priority; 
  
  String? assignedTo;
  String? communicationMethod; // In Person, WhatsApp, Email, Call
  
  // Completed, Pending, Under Process, No Response
  late String status;

  bool carryForwardRequired = false;
  DateTime? carryForwardDate;
  String? carryForwardReason;

  String? remarks;

  @Index()
  late DateTime updatedAt;
  
  bool isDeleted = false;
}
