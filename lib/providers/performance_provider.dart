import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/performance_record.dart';
import '../services/database_service.dart';

final selectedPerformanceYearProvider = StateProvider<int>((ref) => DateTime.now().year);
final selectedPerformanceMonthProvider = StateProvider<int>((ref) => DateTime.now().month);

class PerformanceNotifier extends StateNotifier<PerformanceRecord> {
  final DatabaseService db;
  final int year;
  final int month;

  PerformanceNotifier(this.db, this.year, this.month)
      : super(PerformanceRecord()
          ..year = year
          ..month = month) {
    _loadRecord();
  }

  Future<void> _loadRecord() async {
    final record = await db.getPerformanceRecord(year, month);
    if (record != null) {
      state = record;
    } else {
      state = PerformanceRecord()
        ..year = year
        ..month = month;
    }
  }

  Future<void> updateBox1({
    String? urgent,
    String? newBusiness,
    String? life,
    String? fireHealthPa,
    String? earned,
  }) async {
    final updated = PerformanceRecord()
      ..id = state.id
      ..year = year
      ..month = month
      ..urgent = urgent ?? state.urgent
      ..newBusiness = newBusiness ?? state.newBusiness
      ..life = life ?? state.life
      ..fireHealthPa = fireHealthPa ?? state.fireHealthPa
      ..earned = earned ?? state.earned
      ..box2Row1Days = state.box2Row1Days
      ..box2EarningsOnWorkedDays = state.box2EarningsOnWorkedDays
      ..box2Row2Days = state.box2Row2Days
      ..box2TotalWorkingDay = state.box2TotalWorkingDay
      ..box3JjWorkwayCol1 = state.box3JjWorkwayCol1
      ..box3JjWorkwayCol2 = state.box3JjWorkwayCol2
      ..box3JjWorkwayCol3 = state.box3JjWorkwayCol3
      ..box3JjWorkwayCol4 = state.box3JjWorkwayCol4
      ..box3TargetCol1 = state.box3TargetCol1
      ..box3TargetCol2 = state.box3TargetCol2
      ..box3TargetCol3 = state.box3TargetCol3
      ..box3TargetCol4 = state.box3TargetCol4
      ..box3YyCol1 = state.box3YyCol1
      ..box3YyCol2 = state.box3YyCol2
      ..box3YyCol3 = state.box3YyCol3
      ..box3YyCol4 = state.box3YyCol4
      ..box3ZzCol1 = state.box3ZzCol1
      ..box3ZzCol2 = state.box3ZzCol2
      ..box3ZzCol3 = state.box3ZzCol3
      ..box3ZzCol4 = state.box3ZzCol4
      ..box3PercentageCol1 = state.box3PercentageCol1
      ..box3PercentageCol2 = state.box3PercentageCol2
      ..box3PercentageCol3 = state.box3PercentageCol3
      ..box3PercentageCol4 = state.box3PercentageCol4
      ..box4Balance = state.box4Balance
      ..box4Target = state.box4Target
      ..box4Achieved = state.box4Achieved
      ..updatedAt = DateTime.now();

    await db.savePerformanceRecord(updated);
    state = updated;
  }

  Future<void> updateBox2({
    String? box2Row1Days,
    String? box2EarningsOnWorkedDays,
    String? box2Row2Days,
    String? box2TotalWorkingDay,
  }) async {
    final updated = PerformanceRecord()
      ..id = state.id
      ..year = year
      ..month = month
      ..urgent = state.urgent
      ..newBusiness = state.newBusiness
      ..life = state.life
      ..fireHealthPa = state.fireHealthPa
      ..earned = state.earned
      ..box2Row1Days = box2Row1Days ?? state.box2Row1Days
      ..box2EarningsOnWorkedDays = box2EarningsOnWorkedDays ?? state.box2EarningsOnWorkedDays
      ..box2Row2Days = box2Row2Days ?? state.box2Row2Days
      ..box2TotalWorkingDay = box2TotalWorkingDay ?? state.box2TotalWorkingDay
      ..box3JjWorkwayCol1 = state.box3JjWorkwayCol1
      ..box3JjWorkwayCol2 = state.box3JjWorkwayCol2
      ..box3JjWorkwayCol3 = state.box3JjWorkwayCol3
      ..box3JjWorkwayCol4 = state.box3JjWorkwayCol4
      ..box3TargetCol1 = state.box3TargetCol1
      ..box3TargetCol2 = state.box3TargetCol2
      ..box3TargetCol3 = state.box3TargetCol3
      ..box3TargetCol4 = state.box3TargetCol4
      ..box3YyCol1 = state.box3YyCol1
      ..box3YyCol2 = state.box3YyCol2
      ..box3YyCol3 = state.box3YyCol3
      ..box3YyCol4 = state.box3YyCol4
      ..box3ZzCol1 = state.box3ZzCol1
      ..box3ZzCol2 = state.box3ZzCol2
      ..box3ZzCol3 = state.box3ZzCol3
      ..box3ZzCol4 = state.box3ZzCol4
      ..box3PercentageCol1 = state.box3PercentageCol1
      ..box3PercentageCol2 = state.box3PercentageCol2
      ..box3PercentageCol3 = state.box3PercentageCol3
      ..box3PercentageCol4 = state.box3PercentageCol4
      ..box4Balance = state.box4Balance
      ..box4Target = state.box4Target
      ..box4Achieved = state.box4Achieved
      ..updatedAt = DateTime.now();

    await db.savePerformanceRecord(updated);
    state = updated;
  }

  Future<void> updateBox3Field(String fieldName, String value) async {
    final updated = PerformanceRecord()
      ..id = state.id
      ..year = year
      ..month = month
      ..urgent = state.urgent
      ..newBusiness = state.newBusiness
      ..life = state.life
      ..fireHealthPa = state.fireHealthPa
      ..earned = state.earned
      ..box2Row1Days = state.box2Row1Days
      ..box2EarningsOnWorkedDays = state.box2EarningsOnWorkedDays
      ..box2Row2Days = state.box2Row2Days
      ..box2TotalWorkingDay = state.box2TotalWorkingDay
      ..box3JjWorkwayCol1 = fieldName == 'box3JjWorkwayCol1' ? value : state.box3JjWorkwayCol1
      ..box3JjWorkwayCol2 = fieldName == 'box3JjWorkwayCol2' ? value : state.box3JjWorkwayCol2
      ..box3JjWorkwayCol3 = fieldName == 'box3JjWorkwayCol3' ? value : state.box3JjWorkwayCol3
      ..box3JjWorkwayCol4 = fieldName == 'box3JjWorkwayCol4' ? value : state.box3JjWorkwayCol4
      ..box3TargetCol1 = fieldName == 'box3TargetCol1' ? value : state.box3TargetCol1
      ..box3TargetCol2 = fieldName == 'box3TargetCol2' ? value : state.box3TargetCol2
      ..box3TargetCol3 = fieldName == 'box3TargetCol3' ? value : state.box3TargetCol3
      ..box3TargetCol4 = fieldName == 'box3TargetCol4' ? value : state.box3TargetCol4
      ..box3YyCol1 = fieldName == 'box3YyCol1' ? value : state.box3YyCol1
      ..box3YyCol2 = fieldName == 'box3YyCol2' ? value : state.box3YyCol2
      ..box3YyCol3 = fieldName == 'box3YyCol3' ? value : state.box3YyCol3
      ..box3YyCol4 = fieldName == 'box3YyCol4' ? value : state.box3YyCol4
      ..box3ZzCol1 = fieldName == 'box3ZzCol1' ? value : state.box3ZzCol1
      ..box3ZzCol2 = fieldName == 'box3ZzCol2' ? value : state.box3ZzCol2
      ..box3ZzCol3 = fieldName == 'box3ZzCol3' ? value : state.box3ZzCol3
      ..box3ZzCol4 = fieldName == 'box3ZzCol4' ? value : state.box3ZzCol4
      ..box3PercentageCol1 = fieldName == 'box3PercentageCol1' ? value : state.box3PercentageCol1
      ..box3PercentageCol2 = fieldName == 'box3PercentageCol2' ? value : state.box3PercentageCol2
      ..box3PercentageCol3 = fieldName == 'box3PercentageCol3' ? value : state.box3PercentageCol3
      ..box3PercentageCol4 = fieldName == 'box3PercentageCol4' ? value : state.box3PercentageCol4
      ..box4Balance = state.box4Balance
      ..box4Target = state.box4Target
      ..box4Achieved = state.box4Achieved
      ..updatedAt = DateTime.now();

    await db.savePerformanceRecord(updated);
    state = updated;
  }

  Future<void> updateBox4({
    String? box4Balance,
    String? box4Target,
    String? box4Achieved,
  }) async {
    final updated = PerformanceRecord()
      ..id = state.id
      ..year = year
      ..month = month
      ..urgent = state.urgent
      ..newBusiness = state.newBusiness
      ..life = state.life
      ..fireHealthPa = state.fireHealthPa
      ..earned = state.earned
      ..box2Row1Days = state.box2Row1Days
      ..box2EarningsOnWorkedDays = state.box2EarningsOnWorkedDays
      ..box2Row2Days = state.box2Row2Days
      ..box2TotalWorkingDay = state.box2TotalWorkingDay
      ..box3JjWorkwayCol1 = state.box3JjWorkwayCol1
      ..box3JjWorkwayCol2 = state.box3JjWorkwayCol2
      ..box3JjWorkwayCol3 = state.box3JjWorkwayCol3
      ..box3JjWorkwayCol4 = state.box3JjWorkwayCol4
      ..box3TargetCol1 = state.box3TargetCol1
      ..box3TargetCol2 = state.box3TargetCol2
      ..box3TargetCol3 = state.box3TargetCol3
      ..box3TargetCol4 = state.box3TargetCol4
      ..box3YyCol1 = state.box3YyCol1
      ..box3YyCol2 = state.box3YyCol2
      ..box3YyCol3 = state.box3YyCol3
      ..box3YyCol4 = state.box3YyCol4
      ..box3ZzCol1 = state.box3ZzCol1
      ..box3ZzCol2 = state.box3ZzCol2
      ..box3ZzCol3 = state.box3ZzCol3
      ..box3ZzCol4 = state.box3ZzCol4
      ..box3PercentageCol1 = state.box3PercentageCol1
      ..box3PercentageCol2 = state.box3PercentageCol2
      ..box3PercentageCol3 = state.box3PercentageCol3
      ..box3PercentageCol4 = state.box3PercentageCol4
      ..box4Balance = box4Balance ?? state.box4Balance
      ..box4Target = box4Target ?? state.box4Target
      ..box4Achieved = box4Achieved ?? state.box4Achieved
      ..updatedAt = DateTime.now();

    await db.savePerformanceRecord(updated);
    state = updated;
  }
}

final performanceRecordProvider =
    StateNotifierProvider.family<PerformanceNotifier, PerformanceRecord, String>((ref, key) {
  final db = ref.watch(databaseServiceProvider);
  final year = ref.watch(selectedPerformanceYearProvider);
  final month = ref.watch(selectedPerformanceMonthProvider);
  return PerformanceNotifier(db, year, month);
});
