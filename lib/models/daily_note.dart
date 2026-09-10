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
