import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/company.dart';
import '../models/work_task.dart';
import '../services/database_service.dart';

final companiesProvider = FutureProvider<List<Company>>((ref) async {
  final db = ref.watch(databaseServiceProvider);
  return db.getCompanies();
});

final selectedCompanyIdProvider = StateProvider<int?>((ref) => null);

final selectedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());

final taskListProvider = StreamProvider<List<WorkTask>>((ref) async* {
  final db = ref.watch(databaseServiceProvider);
  final companyId = ref.watch(selectedCompanyIdProvider);
  final date = ref.watch(selectedDateProvider);

  if (companyId == null) {
    yield [];
    return;
  }

  // Automatically carry forward incomplete tasks to the selected date
  await db.carryForwardIncompleteTasks(date);

  yield await db.getTasksForCompany(companyId, date);

  // Watch for changes in Isar workTasks collection and emit updates automatically
  await for (final _ in db.isar.workTasks.watchLazy()) {
    yield await db.getTasksForCompany(companyId, date);
  }
});

final todayTasksProvider = StreamProvider<List<WorkTask>>((ref) async* {
  final db = ref.watch(databaseServiceProvider);
  final today = DateTime.now();

  // Automatically carry forward incomplete tasks to today
  await db.carryForwardIncompleteTasks(today);

  yield await db.getTasksForDate(today);

  await for (final _ in db.isar.workTasks.watchLazy()) {
    yield await db.getTasksForDate(today);
  }
});
