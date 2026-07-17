import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/marketing_lead.dart';
import '../services/database_service.dart';

final marketingListProvider = StreamProvider<List<MarketingLead>>((ref) async* {
  final db = ref.watch(databaseServiceProvider);

  // Yield initial data
  yield await db.getMarketingLeads();

  // Watch for changes in Isar marketingLeads collection and emit updates automatically
  await for (final _ in db.isar.marketingLeads.watchLazy()) {
    yield await db.getMarketingLeads();
  }
});
