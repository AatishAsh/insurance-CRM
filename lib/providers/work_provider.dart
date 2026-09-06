import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/company.dart';
import '../models/work_task.dart';
import '../services/database_service.dart';

final selectedWorkTabIndexProvider = StateProvider<int>((ref) => 0);

class WorkTabNamesNotifier extends StateNotifier<List<String>> {
  static const _storage = FlutterSecureStorage();

  WorkTabNamesNotifier() : super(['Tab 1', 'Tab 2', 'Tab 3']) {
    _loadTabNames();
  }

  Future<void> _loadTabNames() async {
    try {
      final tab0 = await _storage.read(key: 'work_tab_title_0');
      final tab1 = await _storage.read(key: 'work_tab_title_1');
      final tab2 = await _storage.read(key: 'work_tab_title_2');

      final currentList = [...state];
      if (tab0 != null && tab0.isNotEmpty) currentList[0] = tab0;
      if (tab1 != null && tab1.isNotEmpty) currentList[1] = tab1;
      if (tab2 != null && tab2.isNotEmpty) currentList[2] = tab2;
      state = currentList;
    } catch (_) {}
  }

  Future<void> renameTab(int index, String newName) async {
    if (index < 0 || index >= state.length) return;
    final cleanName = newName.trim();
    if (cleanName.isEmpty) return;

    final newList = [...state];
    newList[index] = cleanName;
    state = newList;

    try {
      await _storage.write(key: 'work_tab_title_$index', value: cleanName);
    } catch (_) {}
  }
}

final workTabNamesProvider = StateNotifierProvider<WorkTabNamesNotifier, List<String>>((ref) {
  return WorkTabNamesNotifier();
});

final companiesProvider = FutureProvider<List<Company>>((ref) async {
  final db = ref.watch(databaseServiceProvider);
  return db.getCompanies();
});

final companiesForTabProvider = FutureProvider.family<List<Company>, int>((ref, tabIndex) async {
  final db = ref.watch(databaseServiceProvider);
  return db.getCompaniesForTab(tabIndex);
});

final companiesForSelectedTabProvider = FutureProvider<List<Company>>((ref) async {
  final tabIndex = ref.watch(selectedWorkTabIndexProvider);
  final db = ref.watch(databaseServiceProvider);
  return db.getCompaniesForTab(tabIndex);
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
