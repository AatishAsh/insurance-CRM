import 'package:isar/isar.dart';

part 'performance_record.g.dart';

@embedded
class TopicTableRow {
  String dateStr = '';
  List<String> values = [];
}

@collection
class PerformanceRecord {
  Id id = Isar.autoIncrement;

  @Index(composite: [CompositeIndex('month')], unique: true, replace: true)
  late int year;
  
  late int month; // 1 to 12

  // Box 1 Fields
  String urgent = '';
  String newBusiness = '';
  String life = '';
  String fireHealthPa = '';
  String earned = '';

  // Box 2 Fields
  String box2Row1Days = '';
  String box2EarningsOnWorkedDays = '';
  String box2Row2Days = '';
  String box2TotalWorkingDay = '';

  // Box 3 Fields (5 Row Headings x 4 Input Columns)
  String box3JjWorkwayCol1 = '';
  String box3JjWorkwayCol2 = '';
  String box3JjWorkwayCol3 = '';
  String box3JjWorkwayCol4 = '';

  String box3TargetCol1 = '';
  String box3TargetCol2 = '';
  String box3TargetCol3 = '';
  String box3TargetCol4 = '';

  String box3YyCol1 = '';
  String box3YyCol2 = '';
  String box3YyCol3 = '';
  String box3YyCol4 = '';

  String box3ZzCol1 = '';
  String box3ZzCol2 = '';
  String box3ZzCol3 = '';
  String box3ZzCol4 = '';

  String box3PercentageCol1 = '';
  String box3PercentageCol2 = '';
  String box3PercentageCol3 = '';
  String box3PercentageCol4 = '';

  // Box 4 Fields (For MDRT)
  String box4Balance = '';
  String box4Target = '';
  String box4Achieved = '';

  // Monthly Topic Table (14 Columns: Date + 13 Topics)
  List<String> topicHeaders = [];
  List<TopicTableRow> topicRows = [];

  // Metadata
  @Index()
  DateTime updatedAt = DateTime.now();
}
