// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_task.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetWorkTaskCollection on Isar {
  IsarCollection<WorkTask> get workTasks => this.collection();
}

const WorkTaskSchema = CollectionSchema(
  name: r'WorkTask',
  id: 3925704855328831075,
  properties: {
    r'assignedDate': PropertySchema(
      id: 0,
      name: r'assignedDate',
      type: IsarType.dateTime,
    ),
    r'assignedTo': PropertySchema(
      id: 1,
      name: r'assignedTo',
      type: IsarType.string,
    ),
    r'carryForwardDate': PropertySchema(
      id: 2,
      name: r'carryForwardDate',
      type: IsarType.dateTime,
    ),
    r'carryForwardReason': PropertySchema(
      id: 3,
      name: r'carryForwardReason',
      type: IsarType.string,
    ),
    r'carryForwardRequired': PropertySchema(
      id: 4,
      name: r'carryForwardRequired',
      type: IsarType.bool,
    ),
    r'communicationMethod': PropertySchema(
      id: 5,
      name: r'communicationMethod',
      type: IsarType.string,
    ),
    r'companyId': PropertySchema(
      id: 6,
      name: r'companyId',
      type: IsarType.long,
    ),
    r'description': PropertySchema(
      id: 7,
      name: r'description',
      type: IsarType.string,
    ),
    r'isDeleted': PropertySchema(
      id: 8,
      name: r'isDeleted',
      type: IsarType.bool,
    ),
    r'priority': PropertySchema(
      id: 9,
      name: r'priority',
      type: IsarType.string,
    ),
    r'remarks': PropertySchema(
      id: 10,
      name: r'remarks',
      type: IsarType.string,
    ),
    r'status': PropertySchema(
      id: 11,
      name: r'status',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 12,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'uuid': PropertySchema(
      id: 13,
      name: r'uuid',
      type: IsarType.string,
    ),
    r'workDate': PropertySchema(
      id: 14,
      name: r'workDate',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _workTaskEstimateSize,
  serialize: _workTaskSerialize,
  deserialize: _workTaskDeserialize,
  deserializeProp: _workTaskDeserializeProp,
  idName: r'id',
  indexes: {
    r'uuid': IndexSchema(
      id: 2134397340427724972,
      name: r'uuid',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'uuid',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'updatedAt': IndexSchema(
      id: -6238191080293565125,
      name: r'updatedAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'updatedAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _workTaskGetId,
  getLinks: _workTaskGetLinks,
  attach: _workTaskAttach,
  version: '3.1.0+1',
);

int _workTaskEstimateSize(
  WorkTask object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.assignedTo;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.carryForwardReason;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.communicationMethod;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.description.length * 3;
  bytesCount += 3 + object.priority.length * 3;
  {
    final value = object.remarks;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.status.length * 3;
  bytesCount += 3 + object.uuid.length * 3;
  return bytesCount;
}

void _workTaskSerialize(
  WorkTask object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.assignedDate);
  writer.writeString(offsets[1], object.assignedTo);
  writer.writeDateTime(offsets[2], object.carryForwardDate);
  writer.writeString(offsets[3], object.carryForwardReason);
  writer.writeBool(offsets[4], object.carryForwardRequired);
  writer.writeString(offsets[5], object.communicationMethod);
  writer.writeLong(offsets[6], object.companyId);
  writer.writeString(offsets[7], object.description);
  writer.writeBool(offsets[8], object.isDeleted);
  writer.writeString(offsets[9], object.priority);
  writer.writeString(offsets[10], object.remarks);
  writer.writeString(offsets[11], object.status);
  writer.writeDateTime(offsets[12], object.updatedAt);
  writer.writeString(offsets[13], object.uuid);
  writer.writeDateTime(offsets[14], object.workDate);
}

WorkTask _workTaskDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = WorkTask();
  object.assignedDate = reader.readDateTimeOrNull(offsets[0]);
  object.assignedTo = reader.readStringOrNull(offsets[1]);
  object.carryForwardDate = reader.readDateTimeOrNull(offsets[2]);
  object.carryForwardReason = reader.readStringOrNull(offsets[3]);
  object.carryForwardRequired = reader.readBool(offsets[4]);
  object.communicationMethod = reader.readStringOrNull(offsets[5]);
  object.companyId = reader.readLongOrNull(offsets[6]);
  object.description = reader.readString(offsets[7]);
  object.id = id;
  object.isDeleted = reader.readBool(offsets[8]);
  object.priority = reader.readString(offsets[9]);
  object.remarks = reader.readStringOrNull(offsets[10]);
  object.status = reader.readString(offsets[11]);
  object.updatedAt = reader.readDateTime(offsets[12]);
  object.uuid = reader.readString(offsets[13]);
  object.workDate = reader.readDateTime(offsets[14]);
  return object;
}

P _workTaskDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readLongOrNull(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readBool(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readString(offset)) as P;
    case 12:
      return (reader.readDateTime(offset)) as P;
    case 13:
      return (reader.readString(offset)) as P;
    case 14:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _workTaskGetId(WorkTask object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _workTaskGetLinks(WorkTask object) {
  return [];
}

void _workTaskAttach(IsarCollection<dynamic> col, Id id, WorkTask object) {
  object.id = id;
}

extension WorkTaskByIndex on IsarCollection<WorkTask> {
  Future<WorkTask?> getByUuid(String uuid) {
    return getByIndex(r'uuid', [uuid]);
  }

  WorkTask? getByUuidSync(String uuid) {
    return getByIndexSync(r'uuid', [uuid]);
  }

  Future<bool> deleteByUuid(String uuid) {
    return deleteByIndex(r'uuid', [uuid]);
  }

  bool deleteByUuidSync(String uuid) {
    return deleteByIndexSync(r'uuid', [uuid]);
  }

  Future<List<WorkTask?>> getAllByUuid(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndex(r'uuid', values);
  }

  List<WorkTask?> getAllByUuidSync(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'uuid', values);
  }

  Future<int> deleteAllByUuid(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'uuid', values);
  }

  int deleteAllByUuidSync(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'uuid', values);
  }

  Future<Id> putByUuid(WorkTask object) {
    return putByIndex(r'uuid', object);
  }

  Id putByUuidSync(WorkTask object, {bool saveLinks = true}) {
    return putByIndexSync(r'uuid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUuid(List<WorkTask> objects) {
    return putAllByIndex(r'uuid', objects);
  }

  List<Id> putAllByUuidSync(List<WorkTask> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'uuid', objects, saveLinks: saveLinks);
  }
}

extension WorkTaskQueryWhereSort on QueryBuilder<WorkTask, WorkTask, QWhere> {
  QueryBuilder<WorkTask, WorkTask, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterWhere> anyUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'updatedAt'),
      );
    });
  }
}

extension WorkTaskQueryWhere on QueryBuilder<WorkTask, WorkTask, QWhereClause> {
  QueryBuilder<WorkTask, WorkTask, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterWhereClause> uuidEqualTo(String uuid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'uuid',
        value: [uuid],
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterWhereClause> uuidNotEqualTo(
      String uuid) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [],
              upper: [uuid],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [uuid],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [uuid],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [],
              upper: [uuid],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterWhereClause> updatedAtEqualTo(
      DateTime updatedAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'updatedAt',
        value: [updatedAt],
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterWhereClause> updatedAtNotEqualTo(
      DateTime updatedAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'updatedAt',
              lower: [],
              upper: [updatedAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'updatedAt',
              lower: [updatedAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'updatedAt',
              lower: [updatedAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'updatedAt',
              lower: [],
              upper: [updatedAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterWhereClause> updatedAtGreaterThan(
    DateTime updatedAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'updatedAt',
        lower: [updatedAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterWhereClause> updatedAtLessThan(
    DateTime updatedAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'updatedAt',
        lower: [],
        upper: [updatedAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterWhereClause> updatedAtBetween(
    DateTime lowerUpdatedAt,
    DateTime upperUpdatedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'updatedAt',
        lower: [lowerUpdatedAt],
        includeLower: includeLower,
        upper: [upperUpdatedAt],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension WorkTaskQueryFilter
    on QueryBuilder<WorkTask, WorkTask, QFilterCondition> {
  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> assignedDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'assignedDate',
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition>
      assignedDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'assignedDate',
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> assignedDateEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'assignedDate',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition>
      assignedDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'assignedDate',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> assignedDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'assignedDate',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> assignedDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'assignedDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> assignedToIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'assignedTo',
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition>
      assignedToIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'assignedTo',
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> assignedToEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'assignedTo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> assignedToGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'assignedTo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> assignedToLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'assignedTo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> assignedToBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'assignedTo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> assignedToStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'assignedTo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> assignedToEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'assignedTo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> assignedToContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'assignedTo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> assignedToMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'assignedTo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> assignedToIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'assignedTo',
        value: '',
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition>
      assignedToIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'assignedTo',
        value: '',
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition>
      carryForwardDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'carryForwardDate',
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition>
      carryForwardDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'carryForwardDate',
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition>
      carryForwardDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'carryForwardDate',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition>
      carryForwardDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'carryForwardDate',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition>
      carryForwardDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'carryForwardDate',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition>
      carryForwardDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'carryForwardDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition>
      carryForwardReasonIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'carryForwardReason',
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition>
      carryForwardReasonIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'carryForwardReason',
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition>
      carryForwardReasonEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'carryForwardReason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition>
      carryForwardReasonGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'carryForwardReason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition>
      carryForwardReasonLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'carryForwardReason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition>
      carryForwardReasonBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'carryForwardReason',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition>
      carryForwardReasonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'carryForwardReason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition>
      carryForwardReasonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'carryForwardReason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition>
      carryForwardReasonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'carryForwardReason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition>
      carryForwardReasonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'carryForwardReason',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition>
      carryForwardReasonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'carryForwardReason',
        value: '',
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition>
      carryForwardReasonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'carryForwardReason',
        value: '',
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition>
      carryForwardRequiredEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'carryForwardRequired',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition>
      communicationMethodIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'communicationMethod',
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition>
      communicationMethodIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'communicationMethod',
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition>
      communicationMethodEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'communicationMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition>
      communicationMethodGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'communicationMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition>
      communicationMethodLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'communicationMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition>
      communicationMethodBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'communicationMethod',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition>
      communicationMethodStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'communicationMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition>
      communicationMethodEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'communicationMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition>
      communicationMethodContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'communicationMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition>
      communicationMethodMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'communicationMethod',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition>
      communicationMethodIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'communicationMethod',
        value: '',
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition>
      communicationMethodIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'communicationMethod',
        value: '',
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> companyIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'companyId',
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> companyIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'companyId',
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> companyIdEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'companyId',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> companyIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'companyId',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> companyIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'companyId',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> companyIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'companyId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> descriptionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition>
      descriptionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> descriptionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> descriptionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> descriptionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> descriptionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> isDeletedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isDeleted',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> priorityEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'priority',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> priorityGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'priority',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> priorityLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'priority',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> priorityBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'priority',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> priorityStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'priority',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> priorityEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'priority',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> priorityContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'priority',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> priorityMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'priority',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> priorityIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'priority',
        value: '',
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> priorityIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'priority',
        value: '',
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> remarksIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'remarks',
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> remarksIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'remarks',
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> remarksEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'remarks',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> remarksGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'remarks',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> remarksLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'remarks',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> remarksBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'remarks',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> remarksStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'remarks',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> remarksEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'remarks',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> remarksContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'remarks',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> remarksMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'remarks',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> remarksIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'remarks',
        value: '',
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> remarksIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'remarks',
        value: '',
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> statusEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> statusGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> statusLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> statusBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> statusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> statusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> statusContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> statusMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'status',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> updatedAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> updatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> updatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> uuidEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> uuidGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> uuidLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> uuidBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'uuid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> uuidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> uuidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> uuidContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> uuidMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'uuid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> workDateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'workDate',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> workDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'workDate',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> workDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'workDate',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterFilterCondition> workDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'workDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension WorkTaskQueryObject
    on QueryBuilder<WorkTask, WorkTask, QFilterCondition> {}

extension WorkTaskQueryLinks
    on QueryBuilder<WorkTask, WorkTask, QFilterCondition> {}

extension WorkTaskQuerySortBy on QueryBuilder<WorkTask, WorkTask, QSortBy> {
  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> sortByAssignedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assignedDate', Sort.asc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> sortByAssignedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assignedDate', Sort.desc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> sortByAssignedTo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assignedTo', Sort.asc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> sortByAssignedToDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assignedTo', Sort.desc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> sortByCarryForwardDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carryForwardDate', Sort.asc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> sortByCarryForwardDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carryForwardDate', Sort.desc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> sortByCarryForwardReason() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carryForwardReason', Sort.asc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy>
      sortByCarryForwardReasonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carryForwardReason', Sort.desc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> sortByCarryForwardRequired() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carryForwardRequired', Sort.asc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy>
      sortByCarryForwardRequiredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carryForwardRequired', Sort.desc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> sortByCommunicationMethod() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'communicationMethod', Sort.asc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy>
      sortByCommunicationMethodDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'communicationMethod', Sort.desc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> sortByCompanyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyId', Sort.asc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> sortByCompanyIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyId', Sort.desc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> sortByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.asc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> sortByIsDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.desc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> sortByPriority() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.asc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> sortByPriorityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.desc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> sortByRemarks() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remarks', Sort.asc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> sortByRemarksDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remarks', Sort.desc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> sortByWorkDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workDate', Sort.asc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> sortByWorkDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workDate', Sort.desc);
    });
  }
}

extension WorkTaskQuerySortThenBy
    on QueryBuilder<WorkTask, WorkTask, QSortThenBy> {
  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> thenByAssignedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assignedDate', Sort.asc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> thenByAssignedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assignedDate', Sort.desc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> thenByAssignedTo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assignedTo', Sort.asc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> thenByAssignedToDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assignedTo', Sort.desc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> thenByCarryForwardDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carryForwardDate', Sort.asc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> thenByCarryForwardDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carryForwardDate', Sort.desc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> thenByCarryForwardReason() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carryForwardReason', Sort.asc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy>
      thenByCarryForwardReasonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carryForwardReason', Sort.desc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> thenByCarryForwardRequired() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carryForwardRequired', Sort.asc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy>
      thenByCarryForwardRequiredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carryForwardRequired', Sort.desc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> thenByCommunicationMethod() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'communicationMethod', Sort.asc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy>
      thenByCommunicationMethodDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'communicationMethod', Sort.desc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> thenByCompanyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyId', Sort.asc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> thenByCompanyIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyId', Sort.desc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> thenByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.asc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> thenByIsDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.desc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> thenByPriority() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.asc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> thenByPriorityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.desc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> thenByRemarks() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remarks', Sort.asc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> thenByRemarksDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remarks', Sort.desc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> thenByWorkDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workDate', Sort.asc);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QAfterSortBy> thenByWorkDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workDate', Sort.desc);
    });
  }
}

extension WorkTaskQueryWhereDistinct
    on QueryBuilder<WorkTask, WorkTask, QDistinct> {
  QueryBuilder<WorkTask, WorkTask, QDistinct> distinctByAssignedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'assignedDate');
    });
  }

  QueryBuilder<WorkTask, WorkTask, QDistinct> distinctByAssignedTo(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'assignedTo', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QDistinct> distinctByCarryForwardDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'carryForwardDate');
    });
  }

  QueryBuilder<WorkTask, WorkTask, QDistinct> distinctByCarryForwardReason(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'carryForwardReason',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QDistinct> distinctByCarryForwardRequired() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'carryForwardRequired');
    });
  }

  QueryBuilder<WorkTask, WorkTask, QDistinct> distinctByCommunicationMethod(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'communicationMethod',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QDistinct> distinctByCompanyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'companyId');
    });
  }

  QueryBuilder<WorkTask, WorkTask, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QDistinct> distinctByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDeleted');
    });
  }

  QueryBuilder<WorkTask, WorkTask, QDistinct> distinctByPriority(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'priority', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QDistinct> distinctByRemarks(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'remarks', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QDistinct> distinctByStatus(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<WorkTask, WorkTask, QDistinct> distinctByUuid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WorkTask, WorkTask, QDistinct> distinctByWorkDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'workDate');
    });
  }
}

extension WorkTaskQueryProperty
    on QueryBuilder<WorkTask, WorkTask, QQueryProperty> {
  QueryBuilder<WorkTask, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<WorkTask, DateTime?, QQueryOperations> assignedDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'assignedDate');
    });
  }

  QueryBuilder<WorkTask, String?, QQueryOperations> assignedToProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'assignedTo');
    });
  }

  QueryBuilder<WorkTask, DateTime?, QQueryOperations>
      carryForwardDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'carryForwardDate');
    });
  }

  QueryBuilder<WorkTask, String?, QQueryOperations>
      carryForwardReasonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'carryForwardReason');
    });
  }

  QueryBuilder<WorkTask, bool, QQueryOperations>
      carryForwardRequiredProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'carryForwardRequired');
    });
  }

  QueryBuilder<WorkTask, String?, QQueryOperations>
      communicationMethodProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'communicationMethod');
    });
  }

  QueryBuilder<WorkTask, int?, QQueryOperations> companyIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'companyId');
    });
  }

  QueryBuilder<WorkTask, String, QQueryOperations> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<WorkTask, bool, QQueryOperations> isDeletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDeleted');
    });
  }

  QueryBuilder<WorkTask, String, QQueryOperations> priorityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'priority');
    });
  }

  QueryBuilder<WorkTask, String?, QQueryOperations> remarksProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'remarks');
    });
  }

  QueryBuilder<WorkTask, String, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<WorkTask, DateTime, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<WorkTask, String, QQueryOperations> uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }

  QueryBuilder<WorkTask, DateTime, QQueryOperations> workDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'workDate');
    });
  }
}
