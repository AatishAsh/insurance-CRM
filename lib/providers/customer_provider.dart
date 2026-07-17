import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/customer.dart';
import '../services/database_service.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final navigationTabIndexProvider = StateProvider<int>((ref) => 0);

final customerPageProvider = StateProvider<int>((ref) => 0);

final customerListProvider = StreamProvider<List<Customer>>((ref) async* {
  final db = ref.watch(databaseServiceProvider);
  final query = ref.watch(searchQueryProvider);

  // Yield initial data
  yield await db.getCustomers(searchQuery: query);

  // Watch for changes in Isar customers collection and emit updates automatically
  await for (final _ in db.isar.customers.watchLazy()) {
    yield await db.getCustomers(searchQuery: query);
  }
});
