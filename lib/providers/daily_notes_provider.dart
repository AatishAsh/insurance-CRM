import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/daily_note.dart';
import '../services/database_service.dart';

final tomorrowNotesProvider = FutureProvider<List<DailyNote>>((ref) async {
  final db = ref.watch(databaseServiceProvider);
  final tomorrow = DateTime.now().add(const Duration(days: 1));
  return await db.getDailyNotesForDate(tomorrow);
});

final todayNotesProvider = FutureProvider<List<DailyNote>>((ref) async {
  final db = ref.watch(databaseServiceProvider);
  final today = DateTime.now();
  return await db.getDailyNotesForDate(today);
});
