import 'dart:convert';
import 'package:isar/isar.dart';

part 'daily_note.g.dart';

@collection
class DailyNote {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String noteId;

  @Index()
  late String dateKey; // 'YYYY-MM-DD'

  late String content;

  String? category;

  bool isCompleted = false;

  late DateTime createdAt;

  DateTime? updatedAt;
}

extension DailyNoteTaskDetails on DailyNote {
  Map<String, dynamic>? get _taskMap {
    try {
      final trimmed = content.trim();
      if (trimmed.startsWith('{') && trimmed.endsWith('}')) {
        final decoded = jsonDecode(trimmed);
        if (decoded is Map<String, dynamic>) {
          return decoded;
        }
      }
    } catch (_) {}
    return null;
  }

  bool get isStructuredTask => _taskMap != null;

  String get taskName => _taskMap?['name']?.toString().trim() ?? '';
  String get taskLocation => _taskMap?['location']?.toString().trim() ?? '';
  String get taskPurpose =>
      _taskMap?['purpose']?.toString().trim() ?? (isStructuredTask ? '' : content.trim());
  String get taskTime => _taskMap?['time']?.toString().trim() ?? '';
  String get documentsRequired =>
      _taskMap?['documentsRequired']?.toString().trim() ?? '';

  String get displayTitle {
    if (!isStructuredTask) return content;
    final n = taskName;
    final p = taskPurpose;
    if (n.isNotEmpty && p.isNotEmpty) return '$n: $p';
    if (n.isNotEmpty) return n;
    if (p.isNotEmpty) return p;
    return 'Daily Task';
  }

  String get formattedPdfSummary {
    if (!isStructuredTask) return content;
    final lines = <String>[];
    if (taskName.isNotEmpty) lines.add('Name: $taskName');
    if (taskTime.isNotEmpty) lines.add('Time: $taskTime');
    if (taskLocation.isNotEmpty) lines.add('Location: $taskLocation');
    if (taskPurpose.isNotEmpty) lines.add('Purpose: $taskPurpose');
    if (documentsRequired.isNotEmpty) {
      lines.add('Documents Required: $documentsRequired');
    }
    return lines.join('\n');
  }
}

