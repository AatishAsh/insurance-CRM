import 'package:isar/isar.dart';

part 'work_task.g.dart';

@collection
class WorkTask {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  String uuid = '';

  // Link to a specific company (1-15)
  int? companyId;
  
  String description = '';
  DateTime workDate = DateTime.now();
  DateTime? assignedDate;
  
  @Index()
  DateTime? createdAt;
  
  // Urgent, Important, Normal
  String priority = 'Normal'; 
  
  String? assignedTo;
  String? communicationMethod; // In Person, WhatsApp, Email, Call
  
  // Completed, Pending, Under Process, No Response
  String status = 'Pending';

  bool carryForwardRequired = false;
  DateTime? carryForwardDate;
  String? carryForwardReason;

  String? remarks;

  @Index()
  DateTime updatedAt = DateTime.now();
  
  bool isDeleted = false;
}

extension WorkTaskDetails on WorkTask {
  String get clientName => assignedTo ?? '';
  String get purpose => description;

  String? get taskLocation {
    if (remarks == null || remarks!.isEmpty) return null;
    final match = RegExp(r'(?:^|\n)(?:Location|Loc):\s*([^\n]+)', caseSensitive: false).firstMatch(remarks!);
    return match?.group(1)?.trim();
  }

  String? get taskTime {
    if (remarks == null || remarks!.isEmpty) return null;
    final match = RegExp(r'(?:^|\n)(?:Time):\s*([^\n]+)', caseSensitive: false).firstMatch(remarks!);
    return match?.group(1)?.trim();
  }

  String? get documentsRequired {
    if (remarks == null || remarks!.isEmpty) return null;
    final match = RegExp(r'(?:^|\n)(?:Documents Required|Docs Required|Documents|Docs):\s*([^\n]+)', caseSensitive: false).firstMatch(remarks!);
    return match?.group(1)?.trim();
  }

  String? get extraRemarks {
    if (remarks == null || remarks!.isEmpty) return null;
    final lines = remarks!.split('\n').where((l) {
      final lower = l.toLowerCase().trim();
      return !lower.startsWith('location:') &&
             !lower.startsWith('loc:') &&
             !lower.startsWith('time:') &&
             !lower.startsWith('documents required:') &&
             !lower.startsWith('docs required:') &&
             !lower.startsWith('documents:') &&
             !lower.startsWith('docs:');
    }).toList();
    final result = lines.join('\n').trim();
    if (result.isEmpty) return null;
    return result.replaceFirst(RegExp(r'^Remarks:\s*', caseSensitive: false), '').trim();
  }
}

String formatWorkRemarks({
  String? location,
  String? time,
  String? documentsRequired,
  String? generalRemarks,
}) {
  final buffer = StringBuffer();
  if (time != null && time.trim().isNotEmpty) {
    buffer.writeln('Time: ${time.trim()}');
  }
  if (location != null && location.trim().isNotEmpty) {
    buffer.writeln('Location: ${location.trim()}');
  }
  if (documentsRequired != null && documentsRequired.trim().isNotEmpty) {
    buffer.writeln('Documents Required: ${documentsRequired.trim()}');
  }
  if (generalRemarks != null && generalRemarks.trim().isNotEmpty) {
    buffer.writeln('Remarks: ${generalRemarks.trim()}');
  }
  return buffer.toString().trim();
}
