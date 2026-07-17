import 'package:isar/isar.dart';

part 'marketing_lead.g.dart';

@embedded
class MarketingVisit {
  DateTime? visitDate;
  String? visitTime; // e.g. "10:30 AM"
  String? visitNote;
  String? attachedPhoto; // Filename of the locally saved image
}

@collection
class MarketingLead {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  late String name;
  late String mobile;
  late String status; // e.g. "New", "Contacted", "Interested", "Follow Up Required", "Closed"

  List<MarketingVisit> visits = [];

  @Index()
  late DateTime updatedAt;

  bool isDeleted = false;
}
