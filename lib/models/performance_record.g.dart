// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'performance_record.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPerformanceRecordCollection on Isar {
  IsarCollection<PerformanceRecord> get performanceRecords => this.collection();
}

const PerformanceRecordSchema = CollectionSchema(
  name: r'PerformanceRecord',
  id: -4480166139041150616,
  properties: {
    r'box2EarningsOnWorkedDays': PropertySchema(
      id: 0,
      name: r'box2EarningsOnWorkedDays',
      type: IsarType.string,
    ),
    r'box2Row1Days': PropertySchema(
      id: 1,
      name: r'box2Row1Days',
      type: IsarType.string,
    ),
    r'box2Row2Days': PropertySchema(
      id: 2,
      name: r'box2Row2Days',
      type: IsarType.string,
    ),
    r'box2TotalWorkingDay': PropertySchema(
      id: 3,
      name: r'box2TotalWorkingDay',
      type: IsarType.string,
    ),
    r'box3JjWorkwayCol1': PropertySchema(
      id: 4,
      name: r'box3JjWorkwayCol1',
      type: IsarType.string,
    ),
    r'box3JjWorkwayCol2': PropertySchema(
      id: 5,
      name: r'box3JjWorkwayCol2',
      type: IsarType.string,
    ),
    r'box3JjWorkwayCol3': PropertySchema(
      id: 6,
      name: r'box3JjWorkwayCol3',
      type: IsarType.string,
    ),
    r'box3JjWorkwayCol4': PropertySchema(
      id: 7,
      name: r'box3JjWorkwayCol4',
      type: IsarType.string,
    ),
    r'box3PercentageCol1': PropertySchema(
      id: 8,
      name: r'box3PercentageCol1',
      type: IsarType.string,
    ),
    r'box3PercentageCol2': PropertySchema(
      id: 9,
      name: r'box3PercentageCol2',
      type: IsarType.string,
    ),
    r'box3PercentageCol3': PropertySchema(
      id: 10,
      name: r'box3PercentageCol3',
      type: IsarType.string,
    ),
    r'box3PercentageCol4': PropertySchema(
      id: 11,
      name: r'box3PercentageCol4',
      type: IsarType.string,
    ),
    r'box3TargetCol1': PropertySchema(
      id: 12,
      name: r'box3TargetCol1',
      type: IsarType.string,
    ),
    r'box3TargetCol2': PropertySchema(
      id: 13,
      name: r'box3TargetCol2',
      type: IsarType.string,
    ),
    r'box3TargetCol3': PropertySchema(
      id: 14,
      name: r'box3TargetCol3',
      type: IsarType.string,
    ),
    r'box3TargetCol4': PropertySchema(
      id: 15,
      name: r'box3TargetCol4',
      type: IsarType.string,
    ),
    r'box3YyCol1': PropertySchema(
      id: 16,
      name: r'box3YyCol1',
      type: IsarType.string,
    ),
    r'box3YyCol2': PropertySchema(
      id: 17,
      name: r'box3YyCol2',
      type: IsarType.string,
    ),
    r'box3YyCol3': PropertySchema(
      id: 18,
      name: r'box3YyCol3',
      type: IsarType.string,
    ),
    r'box3YyCol4': PropertySchema(
      id: 19,
      name: r'box3YyCol4',
      type: IsarType.string,
    ),
    r'box3ZzCol1': PropertySchema(
      id: 20,
      name: r'box3ZzCol1',
      type: IsarType.string,
    ),
    r'box3ZzCol2': PropertySchema(
      id: 21,
      name: r'box3ZzCol2',
      type: IsarType.string,
    ),
    r'box3ZzCol3': PropertySchema(
      id: 22,
      name: r'box3ZzCol3',
      type: IsarType.string,
    ),
    r'box3ZzCol4': PropertySchema(
      id: 23,
      name: r'box3ZzCol4',
      type: IsarType.string,
    ),
    r'box4Achieved': PropertySchema(
      id: 24,
      name: r'box4Achieved',
      type: IsarType.string,
    ),
    r'box4Balance': PropertySchema(
      id: 25,
      name: r'box4Balance',
      type: IsarType.string,
    ),
    r'box4Target': PropertySchema(
      id: 26,
      name: r'box4Target',
      type: IsarType.string,
    ),
    r'earned': PropertySchema(
      id: 27,
      name: r'earned',
      type: IsarType.string,
    ),
    r'fireHealthPa': PropertySchema(
      id: 28,
      name: r'fireHealthPa',
      type: IsarType.string,
    ),
    r'life': PropertySchema(
      id: 29,
      name: r'life',
      type: IsarType.string,
    ),
    r'month': PropertySchema(
      id: 30,
      name: r'month',
      type: IsarType.long,
    ),
    r'newBusiness': PropertySchema(
      id: 31,
      name: r'newBusiness',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 32,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'urgent': PropertySchema(
      id: 33,
      name: r'urgent',
      type: IsarType.string,
    ),
    r'year': PropertySchema(
      id: 34,
      name: r'year',
      type: IsarType.long,
    )
  },
  estimateSize: _performanceRecordEstimateSize,
  serialize: _performanceRecordSerialize,
  deserialize: _performanceRecordDeserialize,
  deserializeProp: _performanceRecordDeserializeProp,
  idName: r'id',
  indexes: {
    r'year_month': IndexSchema(
      id: -3509244304425196138,
      name: r'year_month',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'year',
          type: IndexType.value,
          caseSensitive: false,
        ),
        IndexPropertySchema(
          name: r'month',
          type: IndexType.value,
          caseSensitive: false,
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
  getId: _performanceRecordGetId,
  getLinks: _performanceRecordGetLinks,
  attach: _performanceRecordAttach,
  version: '3.1.0+1',
);

int _performanceRecordEstimateSize(
  PerformanceRecord object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.box2EarningsOnWorkedDays.length * 3;
  bytesCount += 3 + object.box2Row1Days.length * 3;
  bytesCount += 3 + object.box2Row2Days.length * 3;
  bytesCount += 3 + object.box2TotalWorkingDay.length * 3;
  bytesCount += 3 + object.box3JjWorkwayCol1.length * 3;
  bytesCount += 3 + object.box3JjWorkwayCol2.length * 3;
  bytesCount += 3 + object.box3JjWorkwayCol3.length * 3;
  bytesCount += 3 + object.box3JjWorkwayCol4.length * 3;
  bytesCount += 3 + object.box3PercentageCol1.length * 3;
  bytesCount += 3 + object.box3PercentageCol2.length * 3;
  bytesCount += 3 + object.box3PercentageCol3.length * 3;
  bytesCount += 3 + object.box3PercentageCol4.length * 3;
  bytesCount += 3 + object.box3TargetCol1.length * 3;
  bytesCount += 3 + object.box3TargetCol2.length * 3;
  bytesCount += 3 + object.box3TargetCol3.length * 3;
  bytesCount += 3 + object.box3TargetCol4.length * 3;
  bytesCount += 3 + object.box3YyCol1.length * 3;
  bytesCount += 3 + object.box3YyCol2.length * 3;
  bytesCount += 3 + object.box3YyCol3.length * 3;
  bytesCount += 3 + object.box3YyCol4.length * 3;
  bytesCount += 3 + object.box3ZzCol1.length * 3;
  bytesCount += 3 + object.box3ZzCol2.length * 3;
  bytesCount += 3 + object.box3ZzCol3.length * 3;
  bytesCount += 3 + object.box3ZzCol4.length * 3;
  bytesCount += 3 + object.box4Achieved.length * 3;
  bytesCount += 3 + object.box4Balance.length * 3;
  bytesCount += 3 + object.box4Target.length * 3;
  bytesCount += 3 + object.earned.length * 3;
  bytesCount += 3 + object.fireHealthPa.length * 3;
  bytesCount += 3 + object.life.length * 3;
  bytesCount += 3 + object.newBusiness.length * 3;
  bytesCount += 3 + object.urgent.length * 3;
  return bytesCount;
}

void _performanceRecordSerialize(
  PerformanceRecord object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.box2EarningsOnWorkedDays);
  writer.writeString(offsets[1], object.box2Row1Days);
  writer.writeString(offsets[2], object.box2Row2Days);
  writer.writeString(offsets[3], object.box2TotalWorkingDay);
  writer.writeString(offsets[4], object.box3JjWorkwayCol1);
  writer.writeString(offsets[5], object.box3JjWorkwayCol2);
  writer.writeString(offsets[6], object.box3JjWorkwayCol3);
  writer.writeString(offsets[7], object.box3JjWorkwayCol4);
  writer.writeString(offsets[8], object.box3PercentageCol1);
  writer.writeString(offsets[9], object.box3PercentageCol2);
  writer.writeString(offsets[10], object.box3PercentageCol3);
  writer.writeString(offsets[11], object.box3PercentageCol4);
  writer.writeString(offsets[12], object.box3TargetCol1);
  writer.writeString(offsets[13], object.box3TargetCol2);
  writer.writeString(offsets[14], object.box3TargetCol3);
  writer.writeString(offsets[15], object.box3TargetCol4);
  writer.writeString(offsets[16], object.box3YyCol1);
  writer.writeString(offsets[17], object.box3YyCol2);
  writer.writeString(offsets[18], object.box3YyCol3);
  writer.writeString(offsets[19], object.box3YyCol4);
  writer.writeString(offsets[20], object.box3ZzCol1);
  writer.writeString(offsets[21], object.box3ZzCol2);
  writer.writeString(offsets[22], object.box3ZzCol3);
  writer.writeString(offsets[23], object.box3ZzCol4);
  writer.writeString(offsets[24], object.box4Achieved);
  writer.writeString(offsets[25], object.box4Balance);
  writer.writeString(offsets[26], object.box4Target);
  writer.writeString(offsets[27], object.earned);
  writer.writeString(offsets[28], object.fireHealthPa);
  writer.writeString(offsets[29], object.life);
  writer.writeLong(offsets[30], object.month);
  writer.writeString(offsets[31], object.newBusiness);
  writer.writeDateTime(offsets[32], object.updatedAt);
  writer.writeString(offsets[33], object.urgent);
  writer.writeLong(offsets[34], object.year);
}

PerformanceRecord _performanceRecordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PerformanceRecord();
  object.box2EarningsOnWorkedDays = reader.readString(offsets[0]);
  object.box2Row1Days = reader.readString(offsets[1]);
  object.box2Row2Days = reader.readString(offsets[2]);
  object.box2TotalWorkingDay = reader.readString(offsets[3]);
  object.box3JjWorkwayCol1 = reader.readString(offsets[4]);
  object.box3JjWorkwayCol2 = reader.readString(offsets[5]);
  object.box3JjWorkwayCol3 = reader.readString(offsets[6]);
  object.box3JjWorkwayCol4 = reader.readString(offsets[7]);
  object.box3PercentageCol1 = reader.readString(offsets[8]);
  object.box3PercentageCol2 = reader.readString(offsets[9]);
  object.box3PercentageCol3 = reader.readString(offsets[10]);
  object.box3PercentageCol4 = reader.readString(offsets[11]);
  object.box3TargetCol1 = reader.readString(offsets[12]);
  object.box3TargetCol2 = reader.readString(offsets[13]);
  object.box3TargetCol3 = reader.readString(offsets[14]);
  object.box3TargetCol4 = reader.readString(offsets[15]);
  object.box3YyCol1 = reader.readString(offsets[16]);
  object.box3YyCol2 = reader.readString(offsets[17]);
  object.box3YyCol3 = reader.readString(offsets[18]);
  object.box3YyCol4 = reader.readString(offsets[19]);
  object.box3ZzCol1 = reader.readString(offsets[20]);
  object.box3ZzCol2 = reader.readString(offsets[21]);
  object.box3ZzCol3 = reader.readString(offsets[22]);
  object.box3ZzCol4 = reader.readString(offsets[23]);
  object.box4Achieved = reader.readString(offsets[24]);
  object.box4Balance = reader.readString(offsets[25]);
  object.box4Target = reader.readString(offsets[26]);
  object.earned = reader.readString(offsets[27]);
  object.fireHealthPa = reader.readString(offsets[28]);
  object.id = id;
  object.life = reader.readString(offsets[29]);
  object.month = reader.readLong(offsets[30]);
  object.newBusiness = reader.readString(offsets[31]);
  object.updatedAt = reader.readDateTime(offsets[32]);
  object.urgent = reader.readString(offsets[33]);
  object.year = reader.readLong(offsets[34]);
  return object;
}

P _performanceRecordDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    case 11:
      return (reader.readString(offset)) as P;
    case 12:
      return (reader.readString(offset)) as P;
    case 13:
      return (reader.readString(offset)) as P;
    case 14:
      return (reader.readString(offset)) as P;
    case 15:
      return (reader.readString(offset)) as P;
    case 16:
      return (reader.readString(offset)) as P;
    case 17:
      return (reader.readString(offset)) as P;
    case 18:
      return (reader.readString(offset)) as P;
    case 19:
      return (reader.readString(offset)) as P;
    case 20:
      return (reader.readString(offset)) as P;
    case 21:
      return (reader.readString(offset)) as P;
    case 22:
      return (reader.readString(offset)) as P;
    case 23:
      return (reader.readString(offset)) as P;
    case 24:
      return (reader.readString(offset)) as P;
    case 25:
      return (reader.readString(offset)) as P;
    case 26:
      return (reader.readString(offset)) as P;
    case 27:
      return (reader.readString(offset)) as P;
    case 28:
      return (reader.readString(offset)) as P;
    case 29:
      return (reader.readString(offset)) as P;
    case 30:
      return (reader.readLong(offset)) as P;
    case 31:
      return (reader.readString(offset)) as P;
    case 32:
      return (reader.readDateTime(offset)) as P;
    case 33:
      return (reader.readString(offset)) as P;
    case 34:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _performanceRecordGetId(PerformanceRecord object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _performanceRecordGetLinks(
    PerformanceRecord object) {
  return [];
}

void _performanceRecordAttach(
    IsarCollection<dynamic> col, Id id, PerformanceRecord object) {
  object.id = id;
}

extension PerformanceRecordByIndex on IsarCollection<PerformanceRecord> {
  Future<PerformanceRecord?> getByYearMonth(int year, int month) {
    return getByIndex(r'year_month', [year, month]);
  }

  PerformanceRecord? getByYearMonthSync(int year, int month) {
    return getByIndexSync(r'year_month', [year, month]);
  }

  Future<bool> deleteByYearMonth(int year, int month) {
    return deleteByIndex(r'year_month', [year, month]);
  }

  bool deleteByYearMonthSync(int year, int month) {
    return deleteByIndexSync(r'year_month', [year, month]);
  }

  Future<List<PerformanceRecord?>> getAllByYearMonth(
      List<int> yearValues, List<int> monthValues) {
    final len = yearValues.length;
    assert(monthValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([yearValues[i], monthValues[i]]);
    }

    return getAllByIndex(r'year_month', values);
  }

  List<PerformanceRecord?> getAllByYearMonthSync(
      List<int> yearValues, List<int> monthValues) {
    final len = yearValues.length;
    assert(monthValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([yearValues[i], monthValues[i]]);
    }

    return getAllByIndexSync(r'year_month', values);
  }

  Future<int> deleteAllByYearMonth(
      List<int> yearValues, List<int> monthValues) {
    final len = yearValues.length;
    assert(monthValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([yearValues[i], monthValues[i]]);
    }

    return deleteAllByIndex(r'year_month', values);
  }

  int deleteAllByYearMonthSync(List<int> yearValues, List<int> monthValues) {
    final len = yearValues.length;
    assert(monthValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([yearValues[i], monthValues[i]]);
    }

    return deleteAllByIndexSync(r'year_month', values);
  }

  Future<Id> putByYearMonth(PerformanceRecord object) {
    return putByIndex(r'year_month', object);
  }

  Id putByYearMonthSync(PerformanceRecord object, {bool saveLinks = true}) {
    return putByIndexSync(r'year_month', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByYearMonth(List<PerformanceRecord> objects) {
    return putAllByIndex(r'year_month', objects);
  }

  List<Id> putAllByYearMonthSync(List<PerformanceRecord> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'year_month', objects, saveLinks: saveLinks);
  }
}

extension PerformanceRecordQueryWhereSort
    on QueryBuilder<PerformanceRecord, PerformanceRecord, QWhere> {
  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterWhere>
      anyYearMonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'year_month'),
      );
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterWhere>
      anyUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'updatedAt'),
      );
    });
  }
}

extension PerformanceRecordQueryWhere
    on QueryBuilder<PerformanceRecord, PerformanceRecord, QWhereClause> {
  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterWhereClause>
      idBetween(
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

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterWhereClause>
      yearEqualToAnyMonth(int year) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'year_month',
        value: [year],
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterWhereClause>
      yearNotEqualToAnyMonth(int year) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'year_month',
              lower: [],
              upper: [year],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'year_month',
              lower: [year],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'year_month',
              lower: [year],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'year_month',
              lower: [],
              upper: [year],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterWhereClause>
      yearGreaterThanAnyMonth(
    int year, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'year_month',
        lower: [year],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterWhereClause>
      yearLessThanAnyMonth(
    int year, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'year_month',
        lower: [],
        upper: [year],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterWhereClause>
      yearBetweenAnyMonth(
    int lowerYear,
    int upperYear, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'year_month',
        lower: [lowerYear],
        includeLower: includeLower,
        upper: [upperYear],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterWhereClause>
      yearMonthEqualTo(int year, int month) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'year_month',
        value: [year, month],
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterWhereClause>
      yearEqualToMonthNotEqualTo(int year, int month) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'year_month',
              lower: [year],
              upper: [year, month],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'year_month',
              lower: [year, month],
              includeLower: false,
              upper: [year],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'year_month',
              lower: [year, month],
              includeLower: false,
              upper: [year],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'year_month',
              lower: [year],
              upper: [year, month],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterWhereClause>
      yearEqualToMonthGreaterThan(
    int year,
    int month, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'year_month',
        lower: [year, month],
        includeLower: include,
        upper: [year],
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterWhereClause>
      yearEqualToMonthLessThan(
    int year,
    int month, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'year_month',
        lower: [year],
        upper: [year, month],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterWhereClause>
      yearEqualToMonthBetween(
    int year,
    int lowerMonth,
    int upperMonth, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'year_month',
        lower: [year, lowerMonth],
        includeLower: includeLower,
        upper: [year, upperMonth],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterWhereClause>
      updatedAtEqualTo(DateTime updatedAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'updatedAt',
        value: [updatedAt],
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterWhereClause>
      updatedAtNotEqualTo(DateTime updatedAt) {
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

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterWhereClause>
      updatedAtGreaterThan(
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

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterWhereClause>
      updatedAtLessThan(
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

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterWhereClause>
      updatedAtBetween(
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

extension PerformanceRecordQueryFilter
    on QueryBuilder<PerformanceRecord, PerformanceRecord, QFilterCondition> {
  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box2EarningsOnWorkedDaysEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'box2EarningsOnWorkedDays',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box2EarningsOnWorkedDaysGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'box2EarningsOnWorkedDays',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box2EarningsOnWorkedDaysLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'box2EarningsOnWorkedDays',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box2EarningsOnWorkedDaysBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'box2EarningsOnWorkedDays',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box2EarningsOnWorkedDaysStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'box2EarningsOnWorkedDays',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box2EarningsOnWorkedDaysEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'box2EarningsOnWorkedDays',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box2EarningsOnWorkedDaysContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'box2EarningsOnWorkedDays',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box2EarningsOnWorkedDaysMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'box2EarningsOnWorkedDays',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box2EarningsOnWorkedDaysIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'box2EarningsOnWorkedDays',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box2EarningsOnWorkedDaysIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'box2EarningsOnWorkedDays',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box2Row1DaysEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'box2Row1Days',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box2Row1DaysGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'box2Row1Days',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box2Row1DaysLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'box2Row1Days',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box2Row1DaysBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'box2Row1Days',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box2Row1DaysStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'box2Row1Days',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box2Row1DaysEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'box2Row1Days',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box2Row1DaysContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'box2Row1Days',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box2Row1DaysMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'box2Row1Days',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box2Row1DaysIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'box2Row1Days',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box2Row1DaysIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'box2Row1Days',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box2Row2DaysEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'box2Row2Days',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box2Row2DaysGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'box2Row2Days',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box2Row2DaysLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'box2Row2Days',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box2Row2DaysBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'box2Row2Days',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box2Row2DaysStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'box2Row2Days',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box2Row2DaysEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'box2Row2Days',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box2Row2DaysContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'box2Row2Days',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box2Row2DaysMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'box2Row2Days',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box2Row2DaysIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'box2Row2Days',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box2Row2DaysIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'box2Row2Days',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box2TotalWorkingDayEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'box2TotalWorkingDay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box2TotalWorkingDayGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'box2TotalWorkingDay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box2TotalWorkingDayLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'box2TotalWorkingDay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box2TotalWorkingDayBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'box2TotalWorkingDay',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box2TotalWorkingDayStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'box2TotalWorkingDay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box2TotalWorkingDayEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'box2TotalWorkingDay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box2TotalWorkingDayContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'box2TotalWorkingDay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box2TotalWorkingDayMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'box2TotalWorkingDay',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box2TotalWorkingDayIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'box2TotalWorkingDay',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box2TotalWorkingDayIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'box2TotalWorkingDay',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3JjWorkwayCol1EqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'box3JjWorkwayCol1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3JjWorkwayCol1GreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'box3JjWorkwayCol1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3JjWorkwayCol1LessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'box3JjWorkwayCol1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3JjWorkwayCol1Between(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'box3JjWorkwayCol1',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3JjWorkwayCol1StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'box3JjWorkwayCol1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3JjWorkwayCol1EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'box3JjWorkwayCol1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3JjWorkwayCol1Contains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'box3JjWorkwayCol1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3JjWorkwayCol1Matches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'box3JjWorkwayCol1',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3JjWorkwayCol1IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'box3JjWorkwayCol1',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3JjWorkwayCol1IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'box3JjWorkwayCol1',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3JjWorkwayCol2EqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'box3JjWorkwayCol2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3JjWorkwayCol2GreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'box3JjWorkwayCol2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3JjWorkwayCol2LessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'box3JjWorkwayCol2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3JjWorkwayCol2Between(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'box3JjWorkwayCol2',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3JjWorkwayCol2StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'box3JjWorkwayCol2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3JjWorkwayCol2EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'box3JjWorkwayCol2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3JjWorkwayCol2Contains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'box3JjWorkwayCol2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3JjWorkwayCol2Matches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'box3JjWorkwayCol2',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3JjWorkwayCol2IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'box3JjWorkwayCol2',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3JjWorkwayCol2IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'box3JjWorkwayCol2',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3JjWorkwayCol3EqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'box3JjWorkwayCol3',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3JjWorkwayCol3GreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'box3JjWorkwayCol3',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3JjWorkwayCol3LessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'box3JjWorkwayCol3',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3JjWorkwayCol3Between(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'box3JjWorkwayCol3',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3JjWorkwayCol3StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'box3JjWorkwayCol3',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3JjWorkwayCol3EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'box3JjWorkwayCol3',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3JjWorkwayCol3Contains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'box3JjWorkwayCol3',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3JjWorkwayCol3Matches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'box3JjWorkwayCol3',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3JjWorkwayCol3IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'box3JjWorkwayCol3',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3JjWorkwayCol3IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'box3JjWorkwayCol3',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3JjWorkwayCol4EqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'box3JjWorkwayCol4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3JjWorkwayCol4GreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'box3JjWorkwayCol4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3JjWorkwayCol4LessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'box3JjWorkwayCol4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3JjWorkwayCol4Between(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'box3JjWorkwayCol4',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3JjWorkwayCol4StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'box3JjWorkwayCol4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3JjWorkwayCol4EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'box3JjWorkwayCol4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3JjWorkwayCol4Contains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'box3JjWorkwayCol4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3JjWorkwayCol4Matches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'box3JjWorkwayCol4',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3JjWorkwayCol4IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'box3JjWorkwayCol4',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3JjWorkwayCol4IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'box3JjWorkwayCol4',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3PercentageCol1EqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'box3PercentageCol1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3PercentageCol1GreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'box3PercentageCol1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3PercentageCol1LessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'box3PercentageCol1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3PercentageCol1Between(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'box3PercentageCol1',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3PercentageCol1StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'box3PercentageCol1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3PercentageCol1EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'box3PercentageCol1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3PercentageCol1Contains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'box3PercentageCol1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3PercentageCol1Matches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'box3PercentageCol1',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3PercentageCol1IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'box3PercentageCol1',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3PercentageCol1IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'box3PercentageCol1',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3PercentageCol2EqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'box3PercentageCol2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3PercentageCol2GreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'box3PercentageCol2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3PercentageCol2LessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'box3PercentageCol2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3PercentageCol2Between(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'box3PercentageCol2',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3PercentageCol2StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'box3PercentageCol2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3PercentageCol2EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'box3PercentageCol2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3PercentageCol2Contains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'box3PercentageCol2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3PercentageCol2Matches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'box3PercentageCol2',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3PercentageCol2IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'box3PercentageCol2',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3PercentageCol2IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'box3PercentageCol2',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3PercentageCol3EqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'box3PercentageCol3',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3PercentageCol3GreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'box3PercentageCol3',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3PercentageCol3LessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'box3PercentageCol3',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3PercentageCol3Between(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'box3PercentageCol3',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3PercentageCol3StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'box3PercentageCol3',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3PercentageCol3EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'box3PercentageCol3',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3PercentageCol3Contains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'box3PercentageCol3',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3PercentageCol3Matches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'box3PercentageCol3',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3PercentageCol3IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'box3PercentageCol3',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3PercentageCol3IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'box3PercentageCol3',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3PercentageCol4EqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'box3PercentageCol4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3PercentageCol4GreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'box3PercentageCol4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3PercentageCol4LessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'box3PercentageCol4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3PercentageCol4Between(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'box3PercentageCol4',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3PercentageCol4StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'box3PercentageCol4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3PercentageCol4EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'box3PercentageCol4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3PercentageCol4Contains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'box3PercentageCol4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3PercentageCol4Matches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'box3PercentageCol4',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3PercentageCol4IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'box3PercentageCol4',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3PercentageCol4IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'box3PercentageCol4',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3TargetCol1EqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'box3TargetCol1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3TargetCol1GreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'box3TargetCol1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3TargetCol1LessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'box3TargetCol1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3TargetCol1Between(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'box3TargetCol1',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3TargetCol1StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'box3TargetCol1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3TargetCol1EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'box3TargetCol1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3TargetCol1Contains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'box3TargetCol1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3TargetCol1Matches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'box3TargetCol1',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3TargetCol1IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'box3TargetCol1',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3TargetCol1IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'box3TargetCol1',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3TargetCol2EqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'box3TargetCol2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3TargetCol2GreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'box3TargetCol2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3TargetCol2LessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'box3TargetCol2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3TargetCol2Between(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'box3TargetCol2',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3TargetCol2StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'box3TargetCol2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3TargetCol2EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'box3TargetCol2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3TargetCol2Contains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'box3TargetCol2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3TargetCol2Matches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'box3TargetCol2',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3TargetCol2IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'box3TargetCol2',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3TargetCol2IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'box3TargetCol2',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3TargetCol3EqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'box3TargetCol3',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3TargetCol3GreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'box3TargetCol3',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3TargetCol3LessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'box3TargetCol3',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3TargetCol3Between(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'box3TargetCol3',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3TargetCol3StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'box3TargetCol3',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3TargetCol3EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'box3TargetCol3',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3TargetCol3Contains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'box3TargetCol3',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3TargetCol3Matches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'box3TargetCol3',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3TargetCol3IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'box3TargetCol3',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3TargetCol3IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'box3TargetCol3',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3TargetCol4EqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'box3TargetCol4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3TargetCol4GreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'box3TargetCol4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3TargetCol4LessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'box3TargetCol4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3TargetCol4Between(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'box3TargetCol4',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3TargetCol4StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'box3TargetCol4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3TargetCol4EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'box3TargetCol4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3TargetCol4Contains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'box3TargetCol4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3TargetCol4Matches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'box3TargetCol4',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3TargetCol4IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'box3TargetCol4',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3TargetCol4IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'box3TargetCol4',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3YyCol1EqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'box3YyCol1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3YyCol1GreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'box3YyCol1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3YyCol1LessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'box3YyCol1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3YyCol1Between(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'box3YyCol1',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3YyCol1StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'box3YyCol1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3YyCol1EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'box3YyCol1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3YyCol1Contains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'box3YyCol1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3YyCol1Matches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'box3YyCol1',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3YyCol1IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'box3YyCol1',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3YyCol1IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'box3YyCol1',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3YyCol2EqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'box3YyCol2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3YyCol2GreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'box3YyCol2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3YyCol2LessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'box3YyCol2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3YyCol2Between(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'box3YyCol2',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3YyCol2StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'box3YyCol2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3YyCol2EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'box3YyCol2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3YyCol2Contains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'box3YyCol2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3YyCol2Matches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'box3YyCol2',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3YyCol2IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'box3YyCol2',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3YyCol2IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'box3YyCol2',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3YyCol3EqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'box3YyCol3',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3YyCol3GreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'box3YyCol3',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3YyCol3LessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'box3YyCol3',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3YyCol3Between(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'box3YyCol3',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3YyCol3StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'box3YyCol3',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3YyCol3EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'box3YyCol3',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3YyCol3Contains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'box3YyCol3',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3YyCol3Matches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'box3YyCol3',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3YyCol3IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'box3YyCol3',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3YyCol3IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'box3YyCol3',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3YyCol4EqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'box3YyCol4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3YyCol4GreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'box3YyCol4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3YyCol4LessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'box3YyCol4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3YyCol4Between(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'box3YyCol4',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3YyCol4StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'box3YyCol4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3YyCol4EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'box3YyCol4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3YyCol4Contains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'box3YyCol4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3YyCol4Matches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'box3YyCol4',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3YyCol4IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'box3YyCol4',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3YyCol4IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'box3YyCol4',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3ZzCol1EqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'box3ZzCol1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3ZzCol1GreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'box3ZzCol1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3ZzCol1LessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'box3ZzCol1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3ZzCol1Between(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'box3ZzCol1',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3ZzCol1StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'box3ZzCol1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3ZzCol1EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'box3ZzCol1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3ZzCol1Contains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'box3ZzCol1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3ZzCol1Matches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'box3ZzCol1',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3ZzCol1IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'box3ZzCol1',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3ZzCol1IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'box3ZzCol1',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3ZzCol2EqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'box3ZzCol2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3ZzCol2GreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'box3ZzCol2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3ZzCol2LessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'box3ZzCol2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3ZzCol2Between(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'box3ZzCol2',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3ZzCol2StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'box3ZzCol2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3ZzCol2EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'box3ZzCol2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3ZzCol2Contains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'box3ZzCol2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3ZzCol2Matches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'box3ZzCol2',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3ZzCol2IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'box3ZzCol2',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3ZzCol2IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'box3ZzCol2',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3ZzCol3EqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'box3ZzCol3',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3ZzCol3GreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'box3ZzCol3',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3ZzCol3LessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'box3ZzCol3',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3ZzCol3Between(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'box3ZzCol3',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3ZzCol3StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'box3ZzCol3',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3ZzCol3EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'box3ZzCol3',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3ZzCol3Contains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'box3ZzCol3',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3ZzCol3Matches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'box3ZzCol3',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3ZzCol3IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'box3ZzCol3',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3ZzCol3IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'box3ZzCol3',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3ZzCol4EqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'box3ZzCol4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3ZzCol4GreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'box3ZzCol4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3ZzCol4LessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'box3ZzCol4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3ZzCol4Between(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'box3ZzCol4',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3ZzCol4StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'box3ZzCol4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3ZzCol4EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'box3ZzCol4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3ZzCol4Contains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'box3ZzCol4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3ZzCol4Matches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'box3ZzCol4',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3ZzCol4IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'box3ZzCol4',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box3ZzCol4IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'box3ZzCol4',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box4AchievedEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'box4Achieved',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box4AchievedGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'box4Achieved',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box4AchievedLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'box4Achieved',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box4AchievedBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'box4Achieved',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box4AchievedStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'box4Achieved',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box4AchievedEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'box4Achieved',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box4AchievedContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'box4Achieved',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box4AchievedMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'box4Achieved',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box4AchievedIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'box4Achieved',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box4AchievedIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'box4Achieved',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box4BalanceEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'box4Balance',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box4BalanceGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'box4Balance',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box4BalanceLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'box4Balance',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box4BalanceBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'box4Balance',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box4BalanceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'box4Balance',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box4BalanceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'box4Balance',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box4BalanceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'box4Balance',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box4BalanceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'box4Balance',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box4BalanceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'box4Balance',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box4BalanceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'box4Balance',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box4TargetEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'box4Target',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box4TargetGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'box4Target',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box4TargetLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'box4Target',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box4TargetBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'box4Target',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box4TargetStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'box4Target',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box4TargetEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'box4Target',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box4TargetContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'box4Target',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box4TargetMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'box4Target',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box4TargetIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'box4Target',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      box4TargetIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'box4Target',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      earnedEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'earned',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      earnedGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'earned',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      earnedLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'earned',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      earnedBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'earned',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      earnedStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'earned',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      earnedEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'earned',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      earnedContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'earned',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      earnedMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'earned',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      earnedIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'earned',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      earnedIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'earned',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      fireHealthPaEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fireHealthPa',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      fireHealthPaGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fireHealthPa',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      fireHealthPaLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fireHealthPa',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      fireHealthPaBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fireHealthPa',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      fireHealthPaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fireHealthPa',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      fireHealthPaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fireHealthPa',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      fireHealthPaContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fireHealthPa',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      fireHealthPaMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fireHealthPa',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      fireHealthPaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fireHealthPa',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      fireHealthPaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fireHealthPa',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      lifeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'life',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      lifeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'life',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      lifeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'life',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      lifeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'life',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      lifeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'life',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      lifeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'life',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      lifeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'life',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      lifeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'life',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      lifeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'life',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      lifeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'life',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      monthEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'month',
        value: value,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      monthGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'month',
        value: value,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      monthLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'month',
        value: value,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      monthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'month',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      newBusinessEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'newBusiness',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      newBusinessGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'newBusiness',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      newBusinessLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'newBusiness',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      newBusinessBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'newBusiness',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      newBusinessStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'newBusiness',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      newBusinessEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'newBusiness',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      newBusinessContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'newBusiness',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      newBusinessMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'newBusiness',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      newBusinessIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'newBusiness',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      newBusinessIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'newBusiness',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      updatedAtGreaterThan(
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

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      updatedAtLessThan(
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

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      updatedAtBetween(
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

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      urgentEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'urgent',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      urgentGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'urgent',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      urgentLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'urgent',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      urgentBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'urgent',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      urgentStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'urgent',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      urgentEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'urgent',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      urgentContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'urgent',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      urgentMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'urgent',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      urgentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'urgent',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      urgentIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'urgent',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      yearEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'year',
        value: value,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      yearGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'year',
        value: value,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      yearLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'year',
        value: value,
      ));
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterFilterCondition>
      yearBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'year',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension PerformanceRecordQueryObject
    on QueryBuilder<PerformanceRecord, PerformanceRecord, QFilterCondition> {}

extension PerformanceRecordQueryLinks
    on QueryBuilder<PerformanceRecord, PerformanceRecord, QFilterCondition> {}

extension PerformanceRecordQuerySortBy
    on QueryBuilder<PerformanceRecord, PerformanceRecord, QSortBy> {
  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByBox2EarningsOnWorkedDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box2EarningsOnWorkedDays', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByBox2EarningsOnWorkedDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box2EarningsOnWorkedDays', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByBox2Row1Days() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box2Row1Days', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByBox2Row1DaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box2Row1Days', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByBox2Row2Days() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box2Row2Days', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByBox2Row2DaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box2Row2Days', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByBox2TotalWorkingDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box2TotalWorkingDay', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByBox2TotalWorkingDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box2TotalWorkingDay', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByBox3JjWorkwayCol1() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3JjWorkwayCol1', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByBox3JjWorkwayCol1Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3JjWorkwayCol1', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByBox3JjWorkwayCol2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3JjWorkwayCol2', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByBox3JjWorkwayCol2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3JjWorkwayCol2', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByBox3JjWorkwayCol3() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3JjWorkwayCol3', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByBox3JjWorkwayCol3Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3JjWorkwayCol3', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByBox3JjWorkwayCol4() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3JjWorkwayCol4', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByBox3JjWorkwayCol4Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3JjWorkwayCol4', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByBox3PercentageCol1() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3PercentageCol1', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByBox3PercentageCol1Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3PercentageCol1', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByBox3PercentageCol2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3PercentageCol2', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByBox3PercentageCol2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3PercentageCol2', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByBox3PercentageCol3() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3PercentageCol3', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByBox3PercentageCol3Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3PercentageCol3', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByBox3PercentageCol4() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3PercentageCol4', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByBox3PercentageCol4Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3PercentageCol4', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByBox3TargetCol1() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3TargetCol1', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByBox3TargetCol1Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3TargetCol1', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByBox3TargetCol2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3TargetCol2', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByBox3TargetCol2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3TargetCol2', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByBox3TargetCol3() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3TargetCol3', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByBox3TargetCol3Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3TargetCol3', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByBox3TargetCol4() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3TargetCol4', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByBox3TargetCol4Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3TargetCol4', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByBox3YyCol1() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3YyCol1', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByBox3YyCol1Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3YyCol1', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByBox3YyCol2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3YyCol2', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByBox3YyCol2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3YyCol2', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByBox3YyCol3() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3YyCol3', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByBox3YyCol3Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3YyCol3', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByBox3YyCol4() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3YyCol4', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByBox3YyCol4Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3YyCol4', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByBox3ZzCol1() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3ZzCol1', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByBox3ZzCol1Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3ZzCol1', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByBox3ZzCol2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3ZzCol2', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByBox3ZzCol2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3ZzCol2', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByBox3ZzCol3() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3ZzCol3', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByBox3ZzCol3Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3ZzCol3', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByBox3ZzCol4() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3ZzCol4', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByBox3ZzCol4Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3ZzCol4', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByBox4Achieved() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box4Achieved', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByBox4AchievedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box4Achieved', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByBox4Balance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box4Balance', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByBox4BalanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box4Balance', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByBox4Target() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box4Target', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByBox4TargetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box4Target', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByEarned() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'earned', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByEarnedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'earned', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByFireHealthPa() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fireHealthPa', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByFireHealthPaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fireHealthPa', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByLife() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'life', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByLifeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'life', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByMonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'month', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByMonthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'month', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByNewBusiness() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newBusiness', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByNewBusinessDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newBusiness', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByUrgent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'urgent', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByUrgentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'urgent', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'year', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      sortByYearDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'year', Sort.desc);
    });
  }
}

extension PerformanceRecordQuerySortThenBy
    on QueryBuilder<PerformanceRecord, PerformanceRecord, QSortThenBy> {
  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByBox2EarningsOnWorkedDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box2EarningsOnWorkedDays', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByBox2EarningsOnWorkedDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box2EarningsOnWorkedDays', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByBox2Row1Days() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box2Row1Days', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByBox2Row1DaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box2Row1Days', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByBox2Row2Days() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box2Row2Days', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByBox2Row2DaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box2Row2Days', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByBox2TotalWorkingDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box2TotalWorkingDay', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByBox2TotalWorkingDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box2TotalWorkingDay', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByBox3JjWorkwayCol1() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3JjWorkwayCol1', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByBox3JjWorkwayCol1Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3JjWorkwayCol1', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByBox3JjWorkwayCol2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3JjWorkwayCol2', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByBox3JjWorkwayCol2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3JjWorkwayCol2', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByBox3JjWorkwayCol3() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3JjWorkwayCol3', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByBox3JjWorkwayCol3Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3JjWorkwayCol3', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByBox3JjWorkwayCol4() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3JjWorkwayCol4', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByBox3JjWorkwayCol4Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3JjWorkwayCol4', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByBox3PercentageCol1() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3PercentageCol1', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByBox3PercentageCol1Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3PercentageCol1', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByBox3PercentageCol2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3PercentageCol2', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByBox3PercentageCol2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3PercentageCol2', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByBox3PercentageCol3() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3PercentageCol3', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByBox3PercentageCol3Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3PercentageCol3', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByBox3PercentageCol4() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3PercentageCol4', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByBox3PercentageCol4Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3PercentageCol4', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByBox3TargetCol1() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3TargetCol1', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByBox3TargetCol1Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3TargetCol1', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByBox3TargetCol2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3TargetCol2', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByBox3TargetCol2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3TargetCol2', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByBox3TargetCol3() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3TargetCol3', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByBox3TargetCol3Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3TargetCol3', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByBox3TargetCol4() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3TargetCol4', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByBox3TargetCol4Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3TargetCol4', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByBox3YyCol1() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3YyCol1', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByBox3YyCol1Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3YyCol1', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByBox3YyCol2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3YyCol2', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByBox3YyCol2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3YyCol2', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByBox3YyCol3() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3YyCol3', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByBox3YyCol3Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3YyCol3', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByBox3YyCol4() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3YyCol4', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByBox3YyCol4Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3YyCol4', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByBox3ZzCol1() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3ZzCol1', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByBox3ZzCol1Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3ZzCol1', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByBox3ZzCol2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3ZzCol2', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByBox3ZzCol2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3ZzCol2', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByBox3ZzCol3() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3ZzCol3', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByBox3ZzCol3Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3ZzCol3', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByBox3ZzCol4() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3ZzCol4', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByBox3ZzCol4Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box3ZzCol4', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByBox4Achieved() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box4Achieved', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByBox4AchievedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box4Achieved', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByBox4Balance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box4Balance', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByBox4BalanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box4Balance', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByBox4Target() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box4Target', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByBox4TargetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'box4Target', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByEarned() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'earned', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByEarnedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'earned', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByFireHealthPa() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fireHealthPa', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByFireHealthPaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fireHealthPa', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByLife() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'life', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByLifeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'life', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByMonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'month', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByMonthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'month', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByNewBusiness() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newBusiness', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByNewBusinessDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newBusiness', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByUrgent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'urgent', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByUrgentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'urgent', Sort.desc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'year', Sort.asc);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QAfterSortBy>
      thenByYearDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'year', Sort.desc);
    });
  }
}

extension PerformanceRecordQueryWhereDistinct
    on QueryBuilder<PerformanceRecord, PerformanceRecord, QDistinct> {
  QueryBuilder<PerformanceRecord, PerformanceRecord, QDistinct>
      distinctByBox2EarningsOnWorkedDays({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'box2EarningsOnWorkedDays',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QDistinct>
      distinctByBox2Row1Days({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'box2Row1Days', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QDistinct>
      distinctByBox2Row2Days({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'box2Row2Days', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QDistinct>
      distinctByBox2TotalWorkingDay({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'box2TotalWorkingDay',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QDistinct>
      distinctByBox3JjWorkwayCol1({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'box3JjWorkwayCol1',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QDistinct>
      distinctByBox3JjWorkwayCol2({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'box3JjWorkwayCol2',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QDistinct>
      distinctByBox3JjWorkwayCol3({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'box3JjWorkwayCol3',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QDistinct>
      distinctByBox3JjWorkwayCol4({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'box3JjWorkwayCol4',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QDistinct>
      distinctByBox3PercentageCol1({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'box3PercentageCol1',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QDistinct>
      distinctByBox3PercentageCol2({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'box3PercentageCol2',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QDistinct>
      distinctByBox3PercentageCol3({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'box3PercentageCol3',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QDistinct>
      distinctByBox3PercentageCol4({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'box3PercentageCol4',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QDistinct>
      distinctByBox3TargetCol1({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'box3TargetCol1',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QDistinct>
      distinctByBox3TargetCol2({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'box3TargetCol2',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QDistinct>
      distinctByBox3TargetCol3({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'box3TargetCol3',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QDistinct>
      distinctByBox3TargetCol4({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'box3TargetCol4',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QDistinct>
      distinctByBox3YyCol1({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'box3YyCol1', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QDistinct>
      distinctByBox3YyCol2({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'box3YyCol2', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QDistinct>
      distinctByBox3YyCol3({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'box3YyCol3', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QDistinct>
      distinctByBox3YyCol4({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'box3YyCol4', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QDistinct>
      distinctByBox3ZzCol1({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'box3ZzCol1', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QDistinct>
      distinctByBox3ZzCol2({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'box3ZzCol2', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QDistinct>
      distinctByBox3ZzCol3({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'box3ZzCol3', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QDistinct>
      distinctByBox3ZzCol4({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'box3ZzCol4', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QDistinct>
      distinctByBox4Achieved({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'box4Achieved', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QDistinct>
      distinctByBox4Balance({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'box4Balance', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QDistinct>
      distinctByBox4Target({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'box4Target', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QDistinct>
      distinctByEarned({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'earned', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QDistinct>
      distinctByFireHealthPa({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fireHealthPa', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QDistinct> distinctByLife(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'life', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QDistinct>
      distinctByMonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'month');
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QDistinct>
      distinctByNewBusiness({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'newBusiness', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QDistinct>
      distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QDistinct>
      distinctByUrgent({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'urgent', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PerformanceRecord, PerformanceRecord, QDistinct>
      distinctByYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'year');
    });
  }
}

extension PerformanceRecordQueryProperty
    on QueryBuilder<PerformanceRecord, PerformanceRecord, QQueryProperty> {
  QueryBuilder<PerformanceRecord, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PerformanceRecord, String, QQueryOperations>
      box2EarningsOnWorkedDaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'box2EarningsOnWorkedDays');
    });
  }

  QueryBuilder<PerformanceRecord, String, QQueryOperations>
      box2Row1DaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'box2Row1Days');
    });
  }

  QueryBuilder<PerformanceRecord, String, QQueryOperations>
      box2Row2DaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'box2Row2Days');
    });
  }

  QueryBuilder<PerformanceRecord, String, QQueryOperations>
      box2TotalWorkingDayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'box2TotalWorkingDay');
    });
  }

  QueryBuilder<PerformanceRecord, String, QQueryOperations>
      box3JjWorkwayCol1Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'box3JjWorkwayCol1');
    });
  }

  QueryBuilder<PerformanceRecord, String, QQueryOperations>
      box3JjWorkwayCol2Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'box3JjWorkwayCol2');
    });
  }

  QueryBuilder<PerformanceRecord, String, QQueryOperations>
      box3JjWorkwayCol3Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'box3JjWorkwayCol3');
    });
  }

  QueryBuilder<PerformanceRecord, String, QQueryOperations>
      box3JjWorkwayCol4Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'box3JjWorkwayCol4');
    });
  }

  QueryBuilder<PerformanceRecord, String, QQueryOperations>
      box3PercentageCol1Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'box3PercentageCol1');
    });
  }

  QueryBuilder<PerformanceRecord, String, QQueryOperations>
      box3PercentageCol2Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'box3PercentageCol2');
    });
  }

  QueryBuilder<PerformanceRecord, String, QQueryOperations>
      box3PercentageCol3Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'box3PercentageCol3');
    });
  }

  QueryBuilder<PerformanceRecord, String, QQueryOperations>
      box3PercentageCol4Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'box3PercentageCol4');
    });
  }

  QueryBuilder<PerformanceRecord, String, QQueryOperations>
      box3TargetCol1Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'box3TargetCol1');
    });
  }

  QueryBuilder<PerformanceRecord, String, QQueryOperations>
      box3TargetCol2Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'box3TargetCol2');
    });
  }

  QueryBuilder<PerformanceRecord, String, QQueryOperations>
      box3TargetCol3Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'box3TargetCol3');
    });
  }

  QueryBuilder<PerformanceRecord, String, QQueryOperations>
      box3TargetCol4Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'box3TargetCol4');
    });
  }

  QueryBuilder<PerformanceRecord, String, QQueryOperations>
      box3YyCol1Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'box3YyCol1');
    });
  }

  QueryBuilder<PerformanceRecord, String, QQueryOperations>
      box3YyCol2Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'box3YyCol2');
    });
  }

  QueryBuilder<PerformanceRecord, String, QQueryOperations>
      box3YyCol3Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'box3YyCol3');
    });
  }

  QueryBuilder<PerformanceRecord, String, QQueryOperations>
      box3YyCol4Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'box3YyCol4');
    });
  }

  QueryBuilder<PerformanceRecord, String, QQueryOperations>
      box3ZzCol1Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'box3ZzCol1');
    });
  }

  QueryBuilder<PerformanceRecord, String, QQueryOperations>
      box3ZzCol2Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'box3ZzCol2');
    });
  }

  QueryBuilder<PerformanceRecord, String, QQueryOperations>
      box3ZzCol3Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'box3ZzCol3');
    });
  }

  QueryBuilder<PerformanceRecord, String, QQueryOperations>
      box3ZzCol4Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'box3ZzCol4');
    });
  }

  QueryBuilder<PerformanceRecord, String, QQueryOperations>
      box4AchievedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'box4Achieved');
    });
  }

  QueryBuilder<PerformanceRecord, String, QQueryOperations>
      box4BalanceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'box4Balance');
    });
  }

  QueryBuilder<PerformanceRecord, String, QQueryOperations>
      box4TargetProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'box4Target');
    });
  }

  QueryBuilder<PerformanceRecord, String, QQueryOperations> earnedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'earned');
    });
  }

  QueryBuilder<PerformanceRecord, String, QQueryOperations>
      fireHealthPaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fireHealthPa');
    });
  }

  QueryBuilder<PerformanceRecord, String, QQueryOperations> lifeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'life');
    });
  }

  QueryBuilder<PerformanceRecord, int, QQueryOperations> monthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'month');
    });
  }

  QueryBuilder<PerformanceRecord, String, QQueryOperations>
      newBusinessProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'newBusiness');
    });
  }

  QueryBuilder<PerformanceRecord, DateTime, QQueryOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<PerformanceRecord, String, QQueryOperations> urgentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'urgent');
    });
  }

  QueryBuilder<PerformanceRecord, int, QQueryOperations> yearProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'year');
    });
  }
}
