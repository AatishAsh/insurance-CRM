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
    final universalHeaders = await db.getLatestPerformanceHeaders();

    if (record != null) {
      if (universalHeaders != null) {
        if (universalHeaders['topicHeaders'] != null && universalHeaders['topicHeaders']!.isNotEmpty) {
          record.topicHeaders = List<String>.from(universalHeaders['topicHeaders']!);
        }
        if (universalHeaders['box3ColHeaders'] != null && universalHeaders['box3ColHeaders']!.isNotEmpty) {
          record.box3ColHeaders = List<String>.from(universalHeaders['box3ColHeaders']!);
        }
        if (universalHeaders['box3RowHeaders'] != null && universalHeaders['box3RowHeaders']!.isNotEmpty) {
          record.box3RowHeaders = List<String>.from(universalHeaders['box3RowHeaders']!);
        }
      }
      state = record;
    } else {
      final newRecord = PerformanceRecord()
        ..year = year
        ..month = month;
      if (universalHeaders != null) {
        if (universalHeaders['topicHeaders'] != null && universalHeaders['topicHeaders']!.isNotEmpty) {
          newRecord.topicHeaders = List<String>.from(universalHeaders['topicHeaders']!);
        }
        if (universalHeaders['box3ColHeaders'] != null && universalHeaders['box3ColHeaders']!.isNotEmpty) {
          newRecord.box3ColHeaders = List<String>.from(universalHeaders['box3ColHeaders']!);
        }
        if (universalHeaders['box3RowHeaders'] != null && universalHeaders['box3RowHeaders']!.isNotEmpty) {
          newRecord.box3RowHeaders = List<String>.from(universalHeaders['box3RowHeaders']!);
        }
      }
      state = newRecord;
    }
  }

  PerformanceRecord _cloneState() {
    return PerformanceRecord()
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
      ..box3Col6Col1 = state.box3Col6Col1
      ..box3Col6Col2 = state.box3Col6Col2
      ..box3Col6Col3 = state.box3Col6Col3
      ..box3Col6Col4 = state.box3Col6Col4
      ..box3Col7Col1 = state.box3Col7Col1
      ..box3Col7Col2 = state.box3Col7Col2
      ..box3Col7Col3 = state.box3Col7Col3
      ..box3Col7Col4 = state.box3Col7Col4
      ..box3ColHeaders = List<String>.from(state.box3ColHeaders)
      ..box3RowHeaders = List<String>.from(state.box3RowHeaders)
      ..box4Balance = state.box4Balance
      ..box4Target = state.box4Target
      ..box4Achieved = state.box4Achieved
      ..topicHeaders = List<String>.from(state.topicHeaders)
      ..topicRows = List<TopicTableRow>.from(
        state.topicRows.map((r) => TopicTableRow()
          ..dateStr = r.dateStr
          ..values = List<String>.from(r.values)),
      )
      ..updatedAt = DateTime.now();
  }

  Future<void> updateBox1({
    String? urgent,
    String? newBusiness,
    String? life,
    String? fireHealthPa,
    String? earned,
  }) async {
    final updated = _cloneState()
      ..urgent = urgent ?? state.urgent
      ..newBusiness = newBusiness ?? state.newBusiness
      ..life = life ?? state.life
      ..fireHealthPa = fireHealthPa ?? state.fireHealthPa
      ..earned = earned ?? state.earned;

    await db.savePerformanceRecord(updated);
    state = updated;
  }

  Future<void> updateBox2({
    String? box2Row1Days,
    String? box2EarningsOnWorkedDays,
    String? box2Row2Days,
    String? box2TotalWorkingDay,
  }) async {
    final updated = _cloneState()
      ..box2Row1Days = box2Row1Days ?? state.box2Row1Days
      ..box2EarningsOnWorkedDays = box2EarningsOnWorkedDays ?? state.box2EarningsOnWorkedDays
      ..box2Row2Days = box2Row2Days ?? state.box2Row2Days
      ..box2TotalWorkingDay = box2TotalWorkingDay ?? state.box2TotalWorkingDay;

    await db.savePerformanceRecord(updated);
    state = updated;
  }

  Future<void> updateBox3Field(String fieldName, String value) async {
    final updated = _cloneState();
    switch (fieldName) {
      case 'box3JjWorkwayCol1': updated.box3JjWorkwayCol1 = value; break;
      case 'box3JjWorkwayCol2': updated.box3JjWorkwayCol2 = value; break;
      case 'box3JjWorkwayCol3': updated.box3JjWorkwayCol3 = value; break;
      case 'box3JjWorkwayCol4': updated.box3JjWorkwayCol4 = value; break;
      case 'box3TargetCol1': updated.box3TargetCol1 = value; break;
      case 'box3TargetCol2': updated.box3TargetCol2 = value; break;
      case 'box3TargetCol3': updated.box3TargetCol3 = value; break;
      case 'box3TargetCol4': updated.box3TargetCol4 = value; break;
      case 'box3YyCol1': updated.box3YyCol1 = value; break;
      case 'box3YyCol2': updated.box3YyCol2 = value; break;
      case 'box3YyCol3': updated.box3YyCol3 = value; break;
      case 'box3YyCol4': updated.box3YyCol4 = value; break;
      case 'box3ZzCol1': updated.box3ZzCol1 = value; break;
      case 'box3ZzCol2': updated.box3ZzCol2 = value; break;
      case 'box3ZzCol3': updated.box3ZzCol3 = value; break;
      case 'box3ZzCol4': updated.box3ZzCol4 = value; break;
      case 'box3PercentageCol1': updated.box3PercentageCol1 = value; break;
      case 'box3PercentageCol2': updated.box3PercentageCol2 = value; break;
      case 'box3PercentageCol3': updated.box3PercentageCol3 = value; break;
      case 'box3PercentageCol4': updated.box3PercentageCol4 = value; break;
      case 'box3Col6Col1': updated.box3Col6Col1 = value; break;
      case 'box3Col6Col2': updated.box3Col6Col2 = value; break;
      case 'box3Col6Col3': updated.box3Col6Col3 = value; break;
      case 'box3Col6Col4': updated.box3Col6Col4 = value; break;
      case 'box3Col7Col1': updated.box3Col7Col1 = value; break;
      case 'box3Col7Col2': updated.box3Col7Col2 = value; break;
      case 'box3Col7Col3': updated.box3Col7Col3 = value; break;
      case 'box3Col7Col4': updated.box3Col7Col4 = value; break;
    }

    await db.savePerformanceRecord(updated);
    state = updated;
  }

  Future<void> updateBox3ColHeader(int colIndex, String newTitle) async {
    final defaultHeaders = ['JJ workway', 'Target', 'YY', 'ZZ', 'Percentage', 'Column 6', 'Column 7'];
    final headers = List<String>.from(
      state.box3ColHeaders.isEmpty ? defaultHeaders : state.box3ColHeaders,
    );
    while (headers.length < 7) {
      headers.add(defaultHeaders[headers.length]);
    }
    if (colIndex >= 0 && colIndex < headers.length) {
      headers[colIndex] = newTitle;
    }

    final updated = _cloneState()..box3ColHeaders = headers;
    await db.savePerformanceRecord(updated);
    await db.updateAllPerformanceHeaders(box3ColHeaders: headers);
    state = updated;
  }

  Future<void> updateBox3RowHeader(int rowIndex, String newTitle) async {
    final defaultHeaders = ['Row 1', 'Row 2', 'Row 3', 'Row 4'];
    final headers = List<String>.from(
      state.box3RowHeaders.isEmpty ? defaultHeaders : state.box3RowHeaders,
    );
    while (headers.length < 4) {
      headers.add(defaultHeaders[headers.length]);
    }
    if (rowIndex >= 0 && rowIndex < headers.length) {
      headers[rowIndex] = newTitle;
    }

    final updated = _cloneState()..box3RowHeaders = headers;
    await db.savePerformanceRecord(updated);
    await db.updateAllPerformanceHeaders(box3RowHeaders: headers);
    state = updated;
  }

  Future<void> updateBox4({
    String? box4Balance,
    String? box4Target,
    String? box4Achieved,
  }) async {
    final updated = _cloneState()
      ..box4Balance = box4Balance ?? state.box4Balance
      ..box4Target = box4Target ?? state.box4Target
      ..box4Achieved = box4Achieved ?? state.box4Achieved;

    await db.savePerformanceRecord(updated);
    state = updated;
  }

  // Monthly Topic Table Methods (14 Columns: Date + 13 Topics)
  Future<void> updateTopicHeader(int colIndex, String newTitle) async {
    final headers = List<String>.from(
      state.topicHeaders.isEmpty
          ? List.generate(13, (i) => 'Topic ${i + 1}')
          : state.topicHeaders,
    );
    while (headers.length < 13) {
      headers.add('Topic ${headers.length + 1}');
    }
    if (colIndex >= 0 && colIndex < headers.length) {
      headers[colIndex] = newTitle;
    }

    final updated = _cloneState()..topicHeaders = headers;
    await db.savePerformanceRecord(updated);
    await db.updateAllPerformanceHeaders(topicHeaders: headers);
    state = updated;
  }

  Future<void> addTopicRow({String? dateStr}) async {
    final now = DateTime.now();
    final defaultDate = dateStr ?? '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}';
    final newRow = TopicTableRow()
      ..dateStr = defaultDate
      ..values = List.generate(13, (_) => '');

    final currentRows = List<TopicTableRow>.from(
      state.topicRows.map((r) => TopicTableRow()
        ..dateStr = r.dateStr
        ..values = List<String>.from(r.values)),
    );
    currentRows.add(newRow);

    final currentHeaders = List<String>.from(
      state.topicHeaders.isEmpty
          ? List.generate(13, (i) => 'Topic ${i + 1}')
          : state.topicHeaders,
    );

    final updated = _cloneState()
      ..topicHeaders = currentHeaders
      ..topicRows = currentRows;

    await db.savePerformanceRecord(updated);
    state = updated;
  }

  Future<void> updateTopicRowDate(int rowIndex, String dateStr) async {
    final currentRows = List<TopicTableRow>.from(
      state.topicRows.map((r) => TopicTableRow()
        ..dateStr = r.dateStr
        ..values = List<String>.from(r.values)),
    );
    if (rowIndex >= 0 && rowIndex < currentRows.length) {
      currentRows[rowIndex].dateStr = dateStr;
    }

    final updated = _cloneState()..topicRows = currentRows;
    await db.savePerformanceRecord(updated);
    state = updated;
  }

  Future<void> updateTopicCell(int rowIndex, int topicIndex, String value) async {
    final currentRows = List<TopicTableRow>.from(
      state.topicRows.map((r) => TopicTableRow()
        ..dateStr = r.dateStr
        ..values = List<String>.from(r.values)),
    );
    if (rowIndex >= 0 && rowIndex < currentRows.length) {
      while (currentRows[rowIndex].values.length < 13) {
        currentRows[rowIndex].values.add('');
      }
      currentRows[rowIndex].values[topicIndex] = value;
    }

    final updated = _cloneState()..topicRows = currentRows;
    await db.savePerformanceRecord(updated);
    state = updated;
  }

  Future<void> deleteTopicRow(int rowIndex) async {
    final currentRows = List<TopicTableRow>.from(
      state.topicRows.map((r) => TopicTableRow()
        ..dateStr = r.dateStr
        ..values = List<String>.from(r.values)),
    );
    if (rowIndex >= 0 && rowIndex < currentRows.length) {
      currentRows.removeAt(rowIndex);
    }

    final updated = _cloneState()..topicRows = currentRows;
    await db.savePerformanceRecord(updated);
    state = updated;
  }
}

final performanceRecordProvider =
    StateNotifierProvider.family<PerformanceNotifier, PerformanceRecord, String>((ref, key) {
  final db = ref.watch(databaseServiceProvider);
  final parts = key.split('_');
  final year = int.tryParse(parts.isNotEmpty ? parts[0] : '') ?? DateTime.now().year;
  final month = int.tryParse(parts.length > 1 ? parts[1] : '') ?? DateTime.now().month;
  return PerformanceNotifier(db, year, month);
});
