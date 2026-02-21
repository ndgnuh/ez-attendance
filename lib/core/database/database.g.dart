// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $CourseTable extends Course with TableInfo<$CourseTable, CourseData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CourseTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _searchKeyMeta = const VerificationMeta(
    'searchKey',
  );
  @override
  late final GeneratedColumn<String> searchKey = GeneratedColumn<String>(
    'search_key',
    aliasedName,
    false,
    generatedAs: GeneratedAs(
      FunctionCallExpression("createSearchKey", [name, id]),
      false,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, searchKey];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'course';
  @override
  VerificationContext validateIntegrity(
    Insertable<CourseData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('search_key')) {
      context.handle(
        _searchKeyMeta,
        searchKey.isAcceptableOrUnknown(data['search_key']!, _searchKeyMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CourseData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CourseData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      searchKey:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}search_key'],
          )!,
    );
  }

  @override
  $CourseTable createAlias(String alias) {
    return $CourseTable(attachedDatabase, alias);
  }
}

class CourseData extends DataClass implements Insertable<CourseData> {
  final String id;
  final String name;

  /// generated search key
  final String searchKey;
  const CourseData({
    required this.id,
    required this.name,
    required this.searchKey,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  CourseCompanion toCompanion(bool nullToAbsent) {
    return CourseCompanion(id: Value(id), name: Value(name));
  }

  factory CourseData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CourseData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      searchKey: serializer.fromJson<String>(json['searchKey']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'searchKey': serializer.toJson<String>(searchKey),
    };
  }

  CourseData copyWith({String? id, String? name, String? searchKey}) =>
      CourseData(
        id: id ?? this.id,
        name: name ?? this.name,
        searchKey: searchKey ?? this.searchKey,
      );
  @override
  String toString() {
    return (StringBuffer('CourseData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('searchKey: $searchKey')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, searchKey);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CourseData &&
          other.id == this.id &&
          other.name == this.name &&
          other.searchKey == this.searchKey);
}

class CourseCompanion extends UpdateCompanion<CourseData> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> rowid;
  const CourseCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CourseCompanion.insert({
    required String id,
    required String name,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name);
  static Insertable<CourseData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CourseCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<int>? rowid,
  }) {
    return CourseCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CourseCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SemesterTable extends Semester
    with TableInfo<$SemesterTable, SemesterData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SemesterTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'semester';
  @override
  VerificationContext validateIntegrity(
    Insertable<SemesterData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SemesterData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SemesterData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
    );
  }

  @override
  $SemesterTable createAlias(String alias) {
    return $SemesterTable(attachedDatabase, alias);
  }
}

class SemesterData extends DataClass implements Insertable<SemesterData> {
  final int id;
  final String name;
  const SemesterData({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  SemesterCompanion toCompanion(bool nullToAbsent) {
    return SemesterCompanion(id: Value(id), name: Value(name));
  }

  factory SemesterData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SemesterData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  SemesterData copyWith({int? id, String? name}) =>
      SemesterData(id: id ?? this.id, name: name ?? this.name);
  SemesterData copyWithCompanion(SemesterCompanion data) {
    return SemesterData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SemesterData(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SemesterData && other.id == this.id && other.name == this.name);
}

class SemesterCompanion extends UpdateCompanion<SemesterData> {
  final Value<int> id;
  final Value<String> name;
  const SemesterCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  SemesterCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<SemesterData> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  SemesterCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return SemesterCompanion(id: id ?? this.id, name: name ?? this.name);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SemesterCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $CourseClassTable extends CourseClass
    with TableInfo<$CourseClassTable, CourseClassData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CourseClassTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _classCodeMeta = const VerificationMeta(
    'classCode',
  );
  @override
  late final GeneratedColumn<String> classCode = GeneratedColumn<String>(
    'class_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dayOfWeekMeta = const VerificationMeta(
    'dayOfWeek',
  );
  @override
  late final GeneratedColumn<int> dayOfWeek = GeneratedColumn<int>(
    'day_of_week',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fromPeriodMeta = const VerificationMeta(
    'fromPeriod',
  );
  @override
  late final GeneratedColumn<int> fromPeriod = GeneratedColumn<int>(
    'from_period',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _toPeriodMeta = const VerificationMeta(
    'toPeriod',
  );
  @override
  late final GeneratedColumn<int> toPeriod = GeneratedColumn<int>(
    'to_period',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _courseIdMeta = const VerificationMeta(
    'courseId',
  );
  @override
  late final GeneratedColumn<String> courseId = GeneratedColumn<String>(
    'course_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES course (id) ON UPDATE CASCADE',
    ),
  );
  static const VerificationMeta _semesterIdMeta = const VerificationMeta(
    'semesterId',
  );
  @override
  late final GeneratedColumn<int> semesterId = GeneratedColumn<int>(
    'semester_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES semester (id) ON UPDATE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    classCode,
    dayOfWeek,
    fromPeriod,
    toPeriod,
    location,
    courseId,
    semesterId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'course_class';
  @override
  VerificationContext validateIntegrity(
    Insertable<CourseClassData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('class_code')) {
      context.handle(
        _classCodeMeta,
        classCode.isAcceptableOrUnknown(data['class_code']!, _classCodeMeta),
      );
    } else if (isInserting) {
      context.missing(_classCodeMeta);
    }
    if (data.containsKey('day_of_week')) {
      context.handle(
        _dayOfWeekMeta,
        dayOfWeek.isAcceptableOrUnknown(data['day_of_week']!, _dayOfWeekMeta),
      );
    }
    if (data.containsKey('from_period')) {
      context.handle(
        _fromPeriodMeta,
        fromPeriod.isAcceptableOrUnknown(data['from_period']!, _fromPeriodMeta),
      );
    }
    if (data.containsKey('to_period')) {
      context.handle(
        _toPeriodMeta,
        toPeriod.isAcceptableOrUnknown(data['to_period']!, _toPeriodMeta),
      );
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    }
    if (data.containsKey('course_id')) {
      context.handle(
        _courseIdMeta,
        courseId.isAcceptableOrUnknown(data['course_id']!, _courseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_courseIdMeta);
    }
    if (data.containsKey('semester_id')) {
      context.handle(
        _semesterIdMeta,
        semesterId.isAcceptableOrUnknown(data['semester_id']!, _semesterIdMeta),
      );
    } else if (isInserting) {
      context.missing(_semesterIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CourseClassData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CourseClassData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      classCode:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}class_code'],
          )!,
      dayOfWeek: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}day_of_week'],
      ),
      fromPeriod: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}from_period'],
      ),
      toPeriod: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}to_period'],
      ),
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      ),
      courseId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}course_id'],
          )!,
      semesterId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}semester_id'],
          )!,
    );
  }

  @override
  $CourseClassTable createAlias(String alias) {
    return $CourseClassTable(attachedDatabase, alias);
  }
}

class CourseClassData extends DataClass implements Insertable<CourseClassData> {
  final int id;
  final String classCode;
  final int? dayOfWeek;
  final int? fromPeriod;
  final int? toPeriod;
  final String? location;
  final String courseId;
  final int semesterId;
  const CourseClassData({
    required this.id,
    required this.classCode,
    this.dayOfWeek,
    this.fromPeriod,
    this.toPeriod,
    this.location,
    required this.courseId,
    required this.semesterId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['class_code'] = Variable<String>(classCode);
    if (!nullToAbsent || dayOfWeek != null) {
      map['day_of_week'] = Variable<int>(dayOfWeek);
    }
    if (!nullToAbsent || fromPeriod != null) {
      map['from_period'] = Variable<int>(fromPeriod);
    }
    if (!nullToAbsent || toPeriod != null) {
      map['to_period'] = Variable<int>(toPeriod);
    }
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<String>(location);
    }
    map['course_id'] = Variable<String>(courseId);
    map['semester_id'] = Variable<int>(semesterId);
    return map;
  }

  CourseClassCompanion toCompanion(bool nullToAbsent) {
    return CourseClassCompanion(
      id: Value(id),
      classCode: Value(classCode),
      dayOfWeek:
          dayOfWeek == null && nullToAbsent
              ? const Value.absent()
              : Value(dayOfWeek),
      fromPeriod:
          fromPeriod == null && nullToAbsent
              ? const Value.absent()
              : Value(fromPeriod),
      toPeriod:
          toPeriod == null && nullToAbsent
              ? const Value.absent()
              : Value(toPeriod),
      location:
          location == null && nullToAbsent
              ? const Value.absent()
              : Value(location),
      courseId: Value(courseId),
      semesterId: Value(semesterId),
    );
  }

  factory CourseClassData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CourseClassData(
      id: serializer.fromJson<int>(json['id']),
      classCode: serializer.fromJson<String>(json['classCode']),
      dayOfWeek: serializer.fromJson<int?>(json['dayOfWeek']),
      fromPeriod: serializer.fromJson<int?>(json['fromPeriod']),
      toPeriod: serializer.fromJson<int?>(json['toPeriod']),
      location: serializer.fromJson<String?>(json['location']),
      courseId: serializer.fromJson<String>(json['courseId']),
      semesterId: serializer.fromJson<int>(json['semesterId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'classCode': serializer.toJson<String>(classCode),
      'dayOfWeek': serializer.toJson<int?>(dayOfWeek),
      'fromPeriod': serializer.toJson<int?>(fromPeriod),
      'toPeriod': serializer.toJson<int?>(toPeriod),
      'location': serializer.toJson<String?>(location),
      'courseId': serializer.toJson<String>(courseId),
      'semesterId': serializer.toJson<int>(semesterId),
    };
  }

  CourseClassData copyWith({
    int? id,
    String? classCode,
    Value<int?> dayOfWeek = const Value.absent(),
    Value<int?> fromPeriod = const Value.absent(),
    Value<int?> toPeriod = const Value.absent(),
    Value<String?> location = const Value.absent(),
    String? courseId,
    int? semesterId,
  }) => CourseClassData(
    id: id ?? this.id,
    classCode: classCode ?? this.classCode,
    dayOfWeek: dayOfWeek.present ? dayOfWeek.value : this.dayOfWeek,
    fromPeriod: fromPeriod.present ? fromPeriod.value : this.fromPeriod,
    toPeriod: toPeriod.present ? toPeriod.value : this.toPeriod,
    location: location.present ? location.value : this.location,
    courseId: courseId ?? this.courseId,
    semesterId: semesterId ?? this.semesterId,
  );
  CourseClassData copyWithCompanion(CourseClassCompanion data) {
    return CourseClassData(
      id: data.id.present ? data.id.value : this.id,
      classCode: data.classCode.present ? data.classCode.value : this.classCode,
      dayOfWeek: data.dayOfWeek.present ? data.dayOfWeek.value : this.dayOfWeek,
      fromPeriod:
          data.fromPeriod.present ? data.fromPeriod.value : this.fromPeriod,
      toPeriod: data.toPeriod.present ? data.toPeriod.value : this.toPeriod,
      location: data.location.present ? data.location.value : this.location,
      courseId: data.courseId.present ? data.courseId.value : this.courseId,
      semesterId:
          data.semesterId.present ? data.semesterId.value : this.semesterId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CourseClassData(')
          ..write('id: $id, ')
          ..write('classCode: $classCode, ')
          ..write('dayOfWeek: $dayOfWeek, ')
          ..write('fromPeriod: $fromPeriod, ')
          ..write('toPeriod: $toPeriod, ')
          ..write('location: $location, ')
          ..write('courseId: $courseId, ')
          ..write('semesterId: $semesterId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    classCode,
    dayOfWeek,
    fromPeriod,
    toPeriod,
    location,
    courseId,
    semesterId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CourseClassData &&
          other.id == this.id &&
          other.classCode == this.classCode &&
          other.dayOfWeek == this.dayOfWeek &&
          other.fromPeriod == this.fromPeriod &&
          other.toPeriod == this.toPeriod &&
          other.location == this.location &&
          other.courseId == this.courseId &&
          other.semesterId == this.semesterId);
}

class CourseClassCompanion extends UpdateCompanion<CourseClassData> {
  final Value<int> id;
  final Value<String> classCode;
  final Value<int?> dayOfWeek;
  final Value<int?> fromPeriod;
  final Value<int?> toPeriod;
  final Value<String?> location;
  final Value<String> courseId;
  final Value<int> semesterId;
  const CourseClassCompanion({
    this.id = const Value.absent(),
    this.classCode = const Value.absent(),
    this.dayOfWeek = const Value.absent(),
    this.fromPeriod = const Value.absent(),
    this.toPeriod = const Value.absent(),
    this.location = const Value.absent(),
    this.courseId = const Value.absent(),
    this.semesterId = const Value.absent(),
  });
  CourseClassCompanion.insert({
    this.id = const Value.absent(),
    required String classCode,
    this.dayOfWeek = const Value.absent(),
    this.fromPeriod = const Value.absent(),
    this.toPeriod = const Value.absent(),
    this.location = const Value.absent(),
    required String courseId,
    required int semesterId,
  }) : classCode = Value(classCode),
       courseId = Value(courseId),
       semesterId = Value(semesterId);
  static Insertable<CourseClassData> custom({
    Expression<int>? id,
    Expression<String>? classCode,
    Expression<int>? dayOfWeek,
    Expression<int>? fromPeriod,
    Expression<int>? toPeriod,
    Expression<String>? location,
    Expression<String>? courseId,
    Expression<int>? semesterId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (classCode != null) 'class_code': classCode,
      if (dayOfWeek != null) 'day_of_week': dayOfWeek,
      if (fromPeriod != null) 'from_period': fromPeriod,
      if (toPeriod != null) 'to_period': toPeriod,
      if (location != null) 'location': location,
      if (courseId != null) 'course_id': courseId,
      if (semesterId != null) 'semester_id': semesterId,
    });
  }

  CourseClassCompanion copyWith({
    Value<int>? id,
    Value<String>? classCode,
    Value<int?>? dayOfWeek,
    Value<int?>? fromPeriod,
    Value<int?>? toPeriod,
    Value<String?>? location,
    Value<String>? courseId,
    Value<int>? semesterId,
  }) {
    return CourseClassCompanion(
      id: id ?? this.id,
      classCode: classCode ?? this.classCode,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      fromPeriod: fromPeriod ?? this.fromPeriod,
      toPeriod: toPeriod ?? this.toPeriod,
      location: location ?? this.location,
      courseId: courseId ?? this.courseId,
      semesterId: semesterId ?? this.semesterId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (classCode.present) {
      map['class_code'] = Variable<String>(classCode.value);
    }
    if (dayOfWeek.present) {
      map['day_of_week'] = Variable<int>(dayOfWeek.value);
    }
    if (fromPeriod.present) {
      map['from_period'] = Variable<int>(fromPeriod.value);
    }
    if (toPeriod.present) {
      map['to_period'] = Variable<int>(toPeriod.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (courseId.present) {
      map['course_id'] = Variable<String>(courseId.value);
    }
    if (semesterId.present) {
      map['semester_id'] = Variable<int>(semesterId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CourseClassCompanion(')
          ..write('id: $id, ')
          ..write('classCode: $classCode, ')
          ..write('dayOfWeek: $dayOfWeek, ')
          ..write('fromPeriod: $fromPeriod, ')
          ..write('toPeriod: $toPeriod, ')
          ..write('location: $location, ')
          ..write('courseId: $courseId, ')
          ..write('semesterId: $semesterId')
          ..write(')'))
        .toString();
  }
}

class $SessionTable extends Session with TableInfo<$SessionTable, SessionData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SessionTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _courseClassIdMeta = const VerificationMeta(
    'courseClassId',
  );
  @override
  late final GeneratedColumn<int> courseClassId = GeneratedColumn<int>(
    'course_class_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES course_class (id) ON UPDATE CASCADE',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, courseClassId, date];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'session';
  @override
  VerificationContext validateIntegrity(
    Insertable<SessionData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('course_class_id')) {
      context.handle(
        _courseClassIdMeta,
        courseClassId.isAcceptableOrUnknown(
          data['course_class_id']!,
          _courseClassIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_courseClassIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SessionData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SessionData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      courseClassId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}course_class_id'],
          )!,
      date:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}date'],
          )!,
    );
  }

  @override
  $SessionTable createAlias(String alias) {
    return $SessionTable(attachedDatabase, alias);
  }
}

class SessionData extends DataClass implements Insertable<SessionData> {
  final int id;
  final int courseClassId;
  final DateTime date;
  const SessionData({
    required this.id,
    required this.courseClassId,
    required this.date,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['course_class_id'] = Variable<int>(courseClassId);
    map['date'] = Variable<DateTime>(date);
    return map;
  }

  SessionCompanion toCompanion(bool nullToAbsent) {
    return SessionCompanion(
      id: Value(id),
      courseClassId: Value(courseClassId),
      date: Value(date),
    );
  }

  factory SessionData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SessionData(
      id: serializer.fromJson<int>(json['id']),
      courseClassId: serializer.fromJson<int>(json['courseClassId']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'courseClassId': serializer.toJson<int>(courseClassId),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  SessionData copyWith({int? id, int? courseClassId, DateTime? date}) =>
      SessionData(
        id: id ?? this.id,
        courseClassId: courseClassId ?? this.courseClassId,
        date: date ?? this.date,
      );
  SessionData copyWithCompanion(SessionCompanion data) {
    return SessionData(
      id: data.id.present ? data.id.value : this.id,
      courseClassId:
          data.courseClassId.present
              ? data.courseClassId.value
              : this.courseClassId,
      date: data.date.present ? data.date.value : this.date,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SessionData(')
          ..write('id: $id, ')
          ..write('courseClassId: $courseClassId, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, courseClassId, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SessionData &&
          other.id == this.id &&
          other.courseClassId == this.courseClassId &&
          other.date == this.date);
}

class SessionCompanion extends UpdateCompanion<SessionData> {
  final Value<int> id;
  final Value<int> courseClassId;
  final Value<DateTime> date;
  const SessionCompanion({
    this.id = const Value.absent(),
    this.courseClassId = const Value.absent(),
    this.date = const Value.absent(),
  });
  SessionCompanion.insert({
    this.id = const Value.absent(),
    required int courseClassId,
    required DateTime date,
  }) : courseClassId = Value(courseClassId),
       date = Value(date);
  static Insertable<SessionData> custom({
    Expression<int>? id,
    Expression<int>? courseClassId,
    Expression<DateTime>? date,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (courseClassId != null) 'course_class_id': courseClassId,
      if (date != null) 'date': date,
    });
  }

  SessionCompanion copyWith({
    Value<int>? id,
    Value<int>? courseClassId,
    Value<DateTime>? date,
  }) {
    return SessionCompanion(
      id: id ?? this.id,
      courseClassId: courseClassId ?? this.courseClassId,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (courseClassId.present) {
      map['course_class_id'] = Variable<int>(courseClassId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SessionCompanion(')
          ..write('id: $id, ')
          ..write('courseClassId: $courseClassId, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

class $StudentTable extends Student with TableInfo<$StudentTable, StudentData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudentTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _firstNameMeta = const VerificationMeta(
    'firstName',
  );
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
    'first_name',
    aliasedName,
    false,
    generatedAs: GeneratedAs(
      FunctionCallExpression("getFirstName", [name]),
      false,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _searchKeyMeta = const VerificationMeta(
    'searchKey',
  );
  @override
  late final GeneratedColumn<String> searchKey = GeneratedColumn<String>(
    'search_key',
    aliasedName,
    false,
    generatedAs: GeneratedAs(
      FunctionCallExpression("createSearchKey", [name, id]),
      false,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, email, name, firstName, searchKey];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'student';
  @override
  VerificationContext validateIntegrity(
    Insertable<StudentData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('first_name')) {
      context.handle(
        _firstNameMeta,
        firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta),
      );
    }
    if (data.containsKey('search_key')) {
      context.handle(
        _searchKeyMeta,
        searchKey.isAcceptableOrUnknown(data['search_key']!, _searchKeyMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StudentData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StudentData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      email:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}email'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      firstName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}first_name'],
          )!,
      searchKey:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}search_key'],
          )!,
    );
  }

  @override
  $StudentTable createAlias(String alias) {
    return $StudentTable(attachedDatabase, alias);
  }
}

class StudentData extends DataClass implements Insertable<StudentData> {
  final String id;
  final String email;
  final String name;
  final String firstName;
  final String searchKey;
  const StudentData({
    required this.id,
    required this.email,
    required this.name,
    required this.firstName,
    required this.searchKey,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['email'] = Variable<String>(email);
    map['name'] = Variable<String>(name);
    return map;
  }

  StudentCompanion toCompanion(bool nullToAbsent) {
    return StudentCompanion(
      id: Value(id),
      email: Value(email),
      name: Value(name),
    );
  }

  factory StudentData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StudentData(
      id: serializer.fromJson<String>(json['id']),
      email: serializer.fromJson<String>(json['email']),
      name: serializer.fromJson<String>(json['name']),
      firstName: serializer.fromJson<String>(json['firstName']),
      searchKey: serializer.fromJson<String>(json['searchKey']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'email': serializer.toJson<String>(email),
      'name': serializer.toJson<String>(name),
      'firstName': serializer.toJson<String>(firstName),
      'searchKey': serializer.toJson<String>(searchKey),
    };
  }

  StudentData copyWith({
    String? id,
    String? email,
    String? name,
    String? firstName,
    String? searchKey,
  }) => StudentData(
    id: id ?? this.id,
    email: email ?? this.email,
    name: name ?? this.name,
    firstName: firstName ?? this.firstName,
    searchKey: searchKey ?? this.searchKey,
  );
  @override
  String toString() {
    return (StringBuffer('StudentData(')
          ..write('id: $id, ')
          ..write('email: $email, ')
          ..write('name: $name, ')
          ..write('firstName: $firstName, ')
          ..write('searchKey: $searchKey')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, email, name, firstName, searchKey);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudentData &&
          other.id == this.id &&
          other.email == this.email &&
          other.name == this.name &&
          other.firstName == this.firstName &&
          other.searchKey == this.searchKey);
}

class StudentCompanion extends UpdateCompanion<StudentData> {
  final Value<String> id;
  final Value<String> email;
  final Value<String> name;
  final Value<int> rowid;
  const StudentCompanion({
    this.id = const Value.absent(),
    this.email = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StudentCompanion.insert({
    required String id,
    required String email,
    required String name,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       email = Value(email),
       name = Value(name);
  static Insertable<StudentData> custom({
    Expression<String>? id,
    Expression<String>? email,
    Expression<String>? name,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (email != null) 'email': email,
      if (name != null) 'name': name,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StudentCompanion copyWith({
    Value<String>? id,
    Value<String>? email,
    Value<String>? name,
    Value<int>? rowid,
  }) {
    return StudentCompanion(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudentCompanion(')
          ..write('id: $id, ')
          ..write('email: $email, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AttendanceTable extends Attendance
    with TableInfo<$AttendanceTable, AttendanceData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AttendanceTable(this.attachedDatabase, [this._alias]);
  @override
  late final GeneratedColumnWithTypeConverter<AttendanceStatus, String>
  attendanceStatus = GeneratedColumn<String>(
    'attendance_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<AttendanceStatus>(
    $AttendanceTable.$converterattendanceStatus,
  );
  static const VerificationMeta _numContributionsMeta = const VerificationMeta(
    'numContributions',
  );
  @override
  late final GeneratedColumn<int> numContributions = GeneratedColumn<int>(
    'num_contributions',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<int> sessionId = GeneratedColumn<int>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES session (id) ON UPDATE CASCADE ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _studentIdMeta = const VerificationMeta(
    'studentId',
  );
  @override
  late final GeneratedColumn<String> studentId = GeneratedColumn<String>(
    'student_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES student (id) ON UPDATE CASCADE ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    attendanceStatus,
    numContributions,
    sessionId,
    studentId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'attendance';
  @override
  VerificationContext validateIntegrity(
    Insertable<AttendanceData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('num_contributions')) {
      context.handle(
        _numContributionsMeta,
        numContributions.isAcceptableOrUnknown(
          data['num_contributions']!,
          _numContributionsMeta,
        ),
      );
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('student_id')) {
      context.handle(
        _studentIdMeta,
        studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_studentIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {sessionId, studentId};
  @override
  AttendanceData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AttendanceData(
      attendanceStatus: $AttendanceTable.$converterattendanceStatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}attendance_status'],
        )!,
      ),
      numContributions:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}num_contributions'],
          )!,
      sessionId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}session_id'],
          )!,
      studentId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}student_id'],
          )!,
    );
  }

  @override
  $AttendanceTable createAlias(String alias) {
    return $AttendanceTable(attachedDatabase, alias);
  }

  static TypeConverter<AttendanceStatus, String> $converterattendanceStatus =
      const AttendanceConverter();
}

class AttendanceData extends DataClass implements Insertable<AttendanceData> {
  final AttendanceStatus attendanceStatus;
  final int numContributions;
  final int sessionId;
  final String studentId;
  const AttendanceData({
    required this.attendanceStatus,
    required this.numContributions,
    required this.sessionId,
    required this.studentId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    {
      map['attendance_status'] = Variable<String>(
        $AttendanceTable.$converterattendanceStatus.toSql(attendanceStatus),
      );
    }
    map['num_contributions'] = Variable<int>(numContributions);
    map['session_id'] = Variable<int>(sessionId);
    map['student_id'] = Variable<String>(studentId);
    return map;
  }

  AttendanceCompanion toCompanion(bool nullToAbsent) {
    return AttendanceCompanion(
      attendanceStatus: Value(attendanceStatus),
      numContributions: Value(numContributions),
      sessionId: Value(sessionId),
      studentId: Value(studentId),
    );
  }

  factory AttendanceData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AttendanceData(
      attendanceStatus: serializer.fromJson<AttendanceStatus>(
        json['attendanceStatus'],
      ),
      numContributions: serializer.fromJson<int>(json['numContributions']),
      sessionId: serializer.fromJson<int>(json['sessionId']),
      studentId: serializer.fromJson<String>(json['studentId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'attendanceStatus': serializer.toJson<AttendanceStatus>(attendanceStatus),
      'numContributions': serializer.toJson<int>(numContributions),
      'sessionId': serializer.toJson<int>(sessionId),
      'studentId': serializer.toJson<String>(studentId),
    };
  }

  AttendanceData copyWith({
    AttendanceStatus? attendanceStatus,
    int? numContributions,
    int? sessionId,
    String? studentId,
  }) => AttendanceData(
    attendanceStatus: attendanceStatus ?? this.attendanceStatus,
    numContributions: numContributions ?? this.numContributions,
    sessionId: sessionId ?? this.sessionId,
    studentId: studentId ?? this.studentId,
  );
  AttendanceData copyWithCompanion(AttendanceCompanion data) {
    return AttendanceData(
      attendanceStatus:
          data.attendanceStatus.present
              ? data.attendanceStatus.value
              : this.attendanceStatus,
      numContributions:
          data.numContributions.present
              ? data.numContributions.value
              : this.numContributions,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AttendanceData(')
          ..write('attendanceStatus: $attendanceStatus, ')
          ..write('numContributions: $numContributions, ')
          ..write('sessionId: $sessionId, ')
          ..write('studentId: $studentId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(attendanceStatus, numContributions, sessionId, studentId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AttendanceData &&
          other.attendanceStatus == this.attendanceStatus &&
          other.numContributions == this.numContributions &&
          other.sessionId == this.sessionId &&
          other.studentId == this.studentId);
}

class AttendanceCompanion extends UpdateCompanion<AttendanceData> {
  final Value<AttendanceStatus> attendanceStatus;
  final Value<int> numContributions;
  final Value<int> sessionId;
  final Value<String> studentId;
  final Value<int> rowid;
  const AttendanceCompanion({
    this.attendanceStatus = const Value.absent(),
    this.numContributions = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.studentId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AttendanceCompanion.insert({
    required AttendanceStatus attendanceStatus,
    this.numContributions = const Value.absent(),
    required int sessionId,
    required String studentId,
    this.rowid = const Value.absent(),
  }) : attendanceStatus = Value(attendanceStatus),
       sessionId = Value(sessionId),
       studentId = Value(studentId);
  static Insertable<AttendanceData> custom({
    Expression<String>? attendanceStatus,
    Expression<int>? numContributions,
    Expression<int>? sessionId,
    Expression<String>? studentId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (attendanceStatus != null) 'attendance_status': attendanceStatus,
      if (numContributions != null) 'num_contributions': numContributions,
      if (sessionId != null) 'session_id': sessionId,
      if (studentId != null) 'student_id': studentId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AttendanceCompanion copyWith({
    Value<AttendanceStatus>? attendanceStatus,
    Value<int>? numContributions,
    Value<int>? sessionId,
    Value<String>? studentId,
    Value<int>? rowid,
  }) {
    return AttendanceCompanion(
      attendanceStatus: attendanceStatus ?? this.attendanceStatus,
      numContributions: numContributions ?? this.numContributions,
      sessionId: sessionId ?? this.sessionId,
      studentId: studentId ?? this.studentId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (attendanceStatus.present) {
      map['attendance_status'] = Variable<String>(
        $AttendanceTable.$converterattendanceStatus.toSql(
          attendanceStatus.value,
        ),
      );
    }
    if (numContributions.present) {
      map['num_contributions'] = Variable<int>(numContributions.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<int>(sessionId.value);
    }
    if (studentId.present) {
      map['student_id'] = Variable<String>(studentId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AttendanceCompanion(')
          ..write('attendanceStatus: $attendanceStatus, ')
          ..write('numContributions: $numContributions, ')
          ..write('sessionId: $sessionId, ')
          ..write('studentId: $studentId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RegistrationTable extends Registration
    with TableInfo<$RegistrationTable, RegistrationData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RegistrationTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _courseClassIdMeta = const VerificationMeta(
    'courseClassId',
  );
  @override
  late final GeneratedColumn<int> courseClassId = GeneratedColumn<int>(
    'course_class_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES course_class (id) ON UPDATE CASCADE',
    ),
  );
  static const VerificationMeta _studentIdMeta = const VerificationMeta(
    'studentId',
  );
  @override
  late final GeneratedColumn<String> studentId = GeneratedColumn<String>(
    'student_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES student (id) ON UPDATE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [courseClassId, studentId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'registration';
  @override
  VerificationContext validateIntegrity(
    Insertable<RegistrationData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('course_class_id')) {
      context.handle(
        _courseClassIdMeta,
        courseClassId.isAcceptableOrUnknown(
          data['course_class_id']!,
          _courseClassIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_courseClassIdMeta);
    }
    if (data.containsKey('student_id')) {
      context.handle(
        _studentIdMeta,
        studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_studentIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {courseClassId, studentId};
  @override
  RegistrationData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RegistrationData(
      courseClassId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}course_class_id'],
          )!,
      studentId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}student_id'],
          )!,
    );
  }

  @override
  $RegistrationTable createAlias(String alias) {
    return $RegistrationTable(attachedDatabase, alias);
  }
}

class RegistrationData extends DataClass
    implements Insertable<RegistrationData> {
  final int courseClassId;
  final String studentId;
  const RegistrationData({
    required this.courseClassId,
    required this.studentId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['course_class_id'] = Variable<int>(courseClassId);
    map['student_id'] = Variable<String>(studentId);
    return map;
  }

  RegistrationCompanion toCompanion(bool nullToAbsent) {
    return RegistrationCompanion(
      courseClassId: Value(courseClassId),
      studentId: Value(studentId),
    );
  }

  factory RegistrationData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RegistrationData(
      courseClassId: serializer.fromJson<int>(json['courseClassId']),
      studentId: serializer.fromJson<String>(json['studentId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'courseClassId': serializer.toJson<int>(courseClassId),
      'studentId': serializer.toJson<String>(studentId),
    };
  }

  RegistrationData copyWith({int? courseClassId, String? studentId}) =>
      RegistrationData(
        courseClassId: courseClassId ?? this.courseClassId,
        studentId: studentId ?? this.studentId,
      );
  RegistrationData copyWithCompanion(RegistrationCompanion data) {
    return RegistrationData(
      courseClassId:
          data.courseClassId.present
              ? data.courseClassId.value
              : this.courseClassId,
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RegistrationData(')
          ..write('courseClassId: $courseClassId, ')
          ..write('studentId: $studentId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(courseClassId, studentId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RegistrationData &&
          other.courseClassId == this.courseClassId &&
          other.studentId == this.studentId);
}

class RegistrationCompanion extends UpdateCompanion<RegistrationData> {
  final Value<int> courseClassId;
  final Value<String> studentId;
  final Value<int> rowid;
  const RegistrationCompanion({
    this.courseClassId = const Value.absent(),
    this.studentId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RegistrationCompanion.insert({
    required int courseClassId,
    required String studentId,
    this.rowid = const Value.absent(),
  }) : courseClassId = Value(courseClassId),
       studentId = Value(studentId);
  static Insertable<RegistrationData> custom({
    Expression<int>? courseClassId,
    Expression<String>? studentId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (courseClassId != null) 'course_class_id': courseClassId,
      if (studentId != null) 'student_id': studentId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RegistrationCompanion copyWith({
    Value<int>? courseClassId,
    Value<String>? studentId,
    Value<int>? rowid,
  }) {
    return RegistrationCompanion(
      courseClassId: courseClassId ?? this.courseClassId,
      studentId: studentId ?? this.studentId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (courseClassId.present) {
      map['course_class_id'] = Variable<int>(courseClassId.value);
    }
    if (studentId.present) {
      map['student_id'] = Variable<String>(studentId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RegistrationCompanion(')
          ..write('courseClassId: $courseClassId, ')
          ..write('studentId: $studentId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CourseTable course = $CourseTable(this);
  late final $SemesterTable semester = $SemesterTable(this);
  late final $CourseClassTable courseClass = $CourseClassTable(this);
  late final $SessionTable session = $SessionTable(this);
  late final $StudentTable student = $StudentTable(this);
  late final $AttendanceTable attendance = $AttendanceTable(this);
  late final $RegistrationTable registration = $RegistrationTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    course,
    semester,
    courseClass,
    session,
    student,
    attendance,
    registration,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'course',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('course_class', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'semester',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('course_class', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'course_class',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('session', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'session',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('attendance', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'session',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('attendance', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'student',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('attendance', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'student',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('attendance', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'course_class',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('registration', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'student',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('registration', kind: UpdateKind.update)],
    ),
  ]);
}

typedef $$CourseTableCreateCompanionBuilder =
    CourseCompanion Function({
      required String id,
      required String name,
      Value<int> rowid,
    });
typedef $$CourseTableUpdateCompanionBuilder =
    CourseCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<int> rowid,
    });

final class $$CourseTableReferences
    extends BaseReferences<_$AppDatabase, $CourseTable, CourseData> {
  $$CourseTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CourseClassTable, List<CourseClassData>>
  _courseClassRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.courseClass,
    aliasName: $_aliasNameGenerator(db.course.id, db.courseClass.courseId),
  );

  $$CourseClassTableProcessedTableManager get courseClassRefs {
    final manager = $$CourseClassTableTableManager(
      $_db,
      $_db.courseClass,
    ).filter((f) => f.courseId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_courseClassRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CourseTableFilterComposer
    extends Composer<_$AppDatabase, $CourseTable> {
  $$CourseTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get searchKey => $composableBuilder(
    column: $table.searchKey,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> courseClassRefs(
    Expression<bool> Function($$CourseClassTableFilterComposer f) f,
  ) {
    final $$CourseClassTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.courseClass,
      getReferencedColumn: (t) => t.courseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CourseClassTableFilterComposer(
            $db: $db,
            $table: $db.courseClass,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CourseTableOrderingComposer
    extends Composer<_$AppDatabase, $CourseTable> {
  $$CourseTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get searchKey => $composableBuilder(
    column: $table.searchKey,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CourseTableAnnotationComposer
    extends Composer<_$AppDatabase, $CourseTable> {
  $$CourseTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get searchKey =>
      $composableBuilder(column: $table.searchKey, builder: (column) => column);

  Expression<T> courseClassRefs<T extends Object>(
    Expression<T> Function($$CourseClassTableAnnotationComposer a) f,
  ) {
    final $$CourseClassTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.courseClass,
      getReferencedColumn: (t) => t.courseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CourseClassTableAnnotationComposer(
            $db: $db,
            $table: $db.courseClass,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CourseTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CourseTable,
          CourseData,
          $$CourseTableFilterComposer,
          $$CourseTableOrderingComposer,
          $$CourseTableAnnotationComposer,
          $$CourseTableCreateCompanionBuilder,
          $$CourseTableUpdateCompanionBuilder,
          (CourseData, $$CourseTableReferences),
          CourseData,
          PrefetchHooks Function({bool courseClassRefs})
        > {
  $$CourseTableTableManager(_$AppDatabase db, $CourseTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$CourseTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$CourseTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$CourseTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CourseCompanion(id: id, name: name, rowid: rowid),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<int> rowid = const Value.absent(),
              }) => CourseCompanion.insert(id: id, name: name, rowid: rowid),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$CourseTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({courseClassRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (courseClassRefs) db.courseClass],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (courseClassRefs)
                    await $_getPrefetchedData<
                      CourseData,
                      $CourseTable,
                      CourseClassData
                    >(
                      currentTable: table,
                      referencedTable: $$CourseTableReferences
                          ._courseClassRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$CourseTableReferences(
                                db,
                                table,
                                p0,
                              ).courseClassRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.courseId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CourseTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CourseTable,
      CourseData,
      $$CourseTableFilterComposer,
      $$CourseTableOrderingComposer,
      $$CourseTableAnnotationComposer,
      $$CourseTableCreateCompanionBuilder,
      $$CourseTableUpdateCompanionBuilder,
      (CourseData, $$CourseTableReferences),
      CourseData,
      PrefetchHooks Function({bool courseClassRefs})
    >;
typedef $$SemesterTableCreateCompanionBuilder =
    SemesterCompanion Function({Value<int> id, required String name});
typedef $$SemesterTableUpdateCompanionBuilder =
    SemesterCompanion Function({Value<int> id, Value<String> name});

final class $$SemesterTableReferences
    extends BaseReferences<_$AppDatabase, $SemesterTable, SemesterData> {
  $$SemesterTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CourseClassTable, List<CourseClassData>>
  _courseClassRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.courseClass,
    aliasName: $_aliasNameGenerator(db.semester.id, db.courseClass.semesterId),
  );

  $$CourseClassTableProcessedTableManager get courseClassRefs {
    final manager = $$CourseClassTableTableManager(
      $_db,
      $_db.courseClass,
    ).filter((f) => f.semesterId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_courseClassRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SemesterTableFilterComposer
    extends Composer<_$AppDatabase, $SemesterTable> {
  $$SemesterTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> courseClassRefs(
    Expression<bool> Function($$CourseClassTableFilterComposer f) f,
  ) {
    final $$CourseClassTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.courseClass,
      getReferencedColumn: (t) => t.semesterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CourseClassTableFilterComposer(
            $db: $db,
            $table: $db.courseClass,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SemesterTableOrderingComposer
    extends Composer<_$AppDatabase, $SemesterTable> {
  $$SemesterTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SemesterTableAnnotationComposer
    extends Composer<_$AppDatabase, $SemesterTable> {
  $$SemesterTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  Expression<T> courseClassRefs<T extends Object>(
    Expression<T> Function($$CourseClassTableAnnotationComposer a) f,
  ) {
    final $$CourseClassTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.courseClass,
      getReferencedColumn: (t) => t.semesterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CourseClassTableAnnotationComposer(
            $db: $db,
            $table: $db.courseClass,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SemesterTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SemesterTable,
          SemesterData,
          $$SemesterTableFilterComposer,
          $$SemesterTableOrderingComposer,
          $$SemesterTableAnnotationComposer,
          $$SemesterTableCreateCompanionBuilder,
          $$SemesterTableUpdateCompanionBuilder,
          (SemesterData, $$SemesterTableReferences),
          SemesterData,
          PrefetchHooks Function({bool courseClassRefs})
        > {
  $$SemesterTableTableManager(_$AppDatabase db, $SemesterTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$SemesterTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$SemesterTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$SemesterTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
              }) => SemesterCompanion(id: id, name: name),
          createCompanionCallback:
              ({Value<int> id = const Value.absent(), required String name}) =>
                  SemesterCompanion.insert(id: id, name: name),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$SemesterTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({courseClassRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (courseClassRefs) db.courseClass],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (courseClassRefs)
                    await $_getPrefetchedData<
                      SemesterData,
                      $SemesterTable,
                      CourseClassData
                    >(
                      currentTable: table,
                      referencedTable: $$SemesterTableReferences
                          ._courseClassRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$SemesterTableReferences(
                                db,
                                table,
                                p0,
                              ).courseClassRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.semesterId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$SemesterTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SemesterTable,
      SemesterData,
      $$SemesterTableFilterComposer,
      $$SemesterTableOrderingComposer,
      $$SemesterTableAnnotationComposer,
      $$SemesterTableCreateCompanionBuilder,
      $$SemesterTableUpdateCompanionBuilder,
      (SemesterData, $$SemesterTableReferences),
      SemesterData,
      PrefetchHooks Function({bool courseClassRefs})
    >;
typedef $$CourseClassTableCreateCompanionBuilder =
    CourseClassCompanion Function({
      Value<int> id,
      required String classCode,
      Value<int?> dayOfWeek,
      Value<int?> fromPeriod,
      Value<int?> toPeriod,
      Value<String?> location,
      required String courseId,
      required int semesterId,
    });
typedef $$CourseClassTableUpdateCompanionBuilder =
    CourseClassCompanion Function({
      Value<int> id,
      Value<String> classCode,
      Value<int?> dayOfWeek,
      Value<int?> fromPeriod,
      Value<int?> toPeriod,
      Value<String?> location,
      Value<String> courseId,
      Value<int> semesterId,
    });

final class $$CourseClassTableReferences
    extends BaseReferences<_$AppDatabase, $CourseClassTable, CourseClassData> {
  $$CourseClassTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CourseTable _courseIdTable(_$AppDatabase db) => db.course.createAlias(
    $_aliasNameGenerator(db.courseClass.courseId, db.course.id),
  );

  $$CourseTableProcessedTableManager get courseId {
    final $_column = $_itemColumn<String>('course_id')!;

    final manager = $$CourseTableTableManager(
      $_db,
      $_db.course,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_courseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $SemesterTable _semesterIdTable(_$AppDatabase db) =>
      db.semester.createAlias(
        $_aliasNameGenerator(db.courseClass.semesterId, db.semester.id),
      );

  $$SemesterTableProcessedTableManager get semesterId {
    final $_column = $_itemColumn<int>('semester_id')!;

    final manager = $$SemesterTableTableManager(
      $_db,
      $_db.semester,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_semesterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$SessionTable, List<SessionData>>
  _sessionRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.session,
    aliasName: $_aliasNameGenerator(
      db.courseClass.id,
      db.session.courseClassId,
    ),
  );

  $$SessionTableProcessedTableManager get sessionRefs {
    final manager = $$SessionTableTableManager(
      $_db,
      $_db.session,
    ).filter((f) => f.courseClassId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_sessionRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RegistrationTable, List<RegistrationData>>
  _registrationRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.registration,
    aliasName: $_aliasNameGenerator(
      db.courseClass.id,
      db.registration.courseClassId,
    ),
  );

  $$RegistrationTableProcessedTableManager get registrationRefs {
    final manager = $$RegistrationTableTableManager(
      $_db,
      $_db.registration,
    ).filter((f) => f.courseClassId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_registrationRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CourseClassTableFilterComposer
    extends Composer<_$AppDatabase, $CourseClassTable> {
  $$CourseClassTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get classCode => $composableBuilder(
    column: $table.classCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dayOfWeek => $composableBuilder(
    column: $table.dayOfWeek,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fromPeriod => $composableBuilder(
    column: $table.fromPeriod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get toPeriod => $composableBuilder(
    column: $table.toPeriod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  $$CourseTableFilterComposer get courseId {
    final $$CourseTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.courseId,
      referencedTable: $db.course,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CourseTableFilterComposer(
            $db: $db,
            $table: $db.course,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SemesterTableFilterComposer get semesterId {
    final $$SemesterTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.semesterId,
      referencedTable: $db.semester,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SemesterTableFilterComposer(
            $db: $db,
            $table: $db.semester,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> sessionRefs(
    Expression<bool> Function($$SessionTableFilterComposer f) f,
  ) {
    final $$SessionTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.session,
      getReferencedColumn: (t) => t.courseClassId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionTableFilterComposer(
            $db: $db,
            $table: $db.session,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> registrationRefs(
    Expression<bool> Function($$RegistrationTableFilterComposer f) f,
  ) {
    final $$RegistrationTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.registration,
      getReferencedColumn: (t) => t.courseClassId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RegistrationTableFilterComposer(
            $db: $db,
            $table: $db.registration,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CourseClassTableOrderingComposer
    extends Composer<_$AppDatabase, $CourseClassTable> {
  $$CourseClassTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get classCode => $composableBuilder(
    column: $table.classCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dayOfWeek => $composableBuilder(
    column: $table.dayOfWeek,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fromPeriod => $composableBuilder(
    column: $table.fromPeriod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get toPeriod => $composableBuilder(
    column: $table.toPeriod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  $$CourseTableOrderingComposer get courseId {
    final $$CourseTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.courseId,
      referencedTable: $db.course,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CourseTableOrderingComposer(
            $db: $db,
            $table: $db.course,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SemesterTableOrderingComposer get semesterId {
    final $$SemesterTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.semesterId,
      referencedTable: $db.semester,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SemesterTableOrderingComposer(
            $db: $db,
            $table: $db.semester,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CourseClassTableAnnotationComposer
    extends Composer<_$AppDatabase, $CourseClassTable> {
  $$CourseClassTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get classCode =>
      $composableBuilder(column: $table.classCode, builder: (column) => column);

  GeneratedColumn<int> get dayOfWeek =>
      $composableBuilder(column: $table.dayOfWeek, builder: (column) => column);

  GeneratedColumn<int> get fromPeriod => $composableBuilder(
    column: $table.fromPeriod,
    builder: (column) => column,
  );

  GeneratedColumn<int> get toPeriod =>
      $composableBuilder(column: $table.toPeriod, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  $$CourseTableAnnotationComposer get courseId {
    final $$CourseTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.courseId,
      referencedTable: $db.course,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CourseTableAnnotationComposer(
            $db: $db,
            $table: $db.course,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SemesterTableAnnotationComposer get semesterId {
    final $$SemesterTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.semesterId,
      referencedTable: $db.semester,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SemesterTableAnnotationComposer(
            $db: $db,
            $table: $db.semester,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> sessionRefs<T extends Object>(
    Expression<T> Function($$SessionTableAnnotationComposer a) f,
  ) {
    final $$SessionTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.session,
      getReferencedColumn: (t) => t.courseClassId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionTableAnnotationComposer(
            $db: $db,
            $table: $db.session,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> registrationRefs<T extends Object>(
    Expression<T> Function($$RegistrationTableAnnotationComposer a) f,
  ) {
    final $$RegistrationTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.registration,
      getReferencedColumn: (t) => t.courseClassId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RegistrationTableAnnotationComposer(
            $db: $db,
            $table: $db.registration,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CourseClassTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CourseClassTable,
          CourseClassData,
          $$CourseClassTableFilterComposer,
          $$CourseClassTableOrderingComposer,
          $$CourseClassTableAnnotationComposer,
          $$CourseClassTableCreateCompanionBuilder,
          $$CourseClassTableUpdateCompanionBuilder,
          (CourseClassData, $$CourseClassTableReferences),
          CourseClassData,
          PrefetchHooks Function({
            bool courseId,
            bool semesterId,
            bool sessionRefs,
            bool registrationRefs,
          })
        > {
  $$CourseClassTableTableManager(_$AppDatabase db, $CourseClassTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$CourseClassTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$CourseClassTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$CourseClassTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> classCode = const Value.absent(),
                Value<int?> dayOfWeek = const Value.absent(),
                Value<int?> fromPeriod = const Value.absent(),
                Value<int?> toPeriod = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<String> courseId = const Value.absent(),
                Value<int> semesterId = const Value.absent(),
              }) => CourseClassCompanion(
                id: id,
                classCode: classCode,
                dayOfWeek: dayOfWeek,
                fromPeriod: fromPeriod,
                toPeriod: toPeriod,
                location: location,
                courseId: courseId,
                semesterId: semesterId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String classCode,
                Value<int?> dayOfWeek = const Value.absent(),
                Value<int?> fromPeriod = const Value.absent(),
                Value<int?> toPeriod = const Value.absent(),
                Value<String?> location = const Value.absent(),
                required String courseId,
                required int semesterId,
              }) => CourseClassCompanion.insert(
                id: id,
                classCode: classCode,
                dayOfWeek: dayOfWeek,
                fromPeriod: fromPeriod,
                toPeriod: toPeriod,
                location: location,
                courseId: courseId,
                semesterId: semesterId,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$CourseClassTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({
            courseId = false,
            semesterId = false,
            sessionRefs = false,
            registrationRefs = false,
          }) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (sessionRefs) db.session,
                if (registrationRefs) db.registration,
              ],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (courseId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.courseId,
                            referencedTable: $$CourseClassTableReferences
                                ._courseIdTable(db),
                            referencedColumn:
                                $$CourseClassTableReferences
                                    ._courseIdTable(db)
                                    .id,
                          )
                          as T;
                }
                if (semesterId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.semesterId,
                            referencedTable: $$CourseClassTableReferences
                                ._semesterIdTable(db),
                            referencedColumn:
                                $$CourseClassTableReferences
                                    ._semesterIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (sessionRefs)
                    await $_getPrefetchedData<
                      CourseClassData,
                      $CourseClassTable,
                      SessionData
                    >(
                      currentTable: table,
                      referencedTable: $$CourseClassTableReferences
                          ._sessionRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$CourseClassTableReferences(
                                db,
                                table,
                                p0,
                              ).sessionRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.courseClassId == item.id,
                          ),
                      typedResults: items,
                    ),
                  if (registrationRefs)
                    await $_getPrefetchedData<
                      CourseClassData,
                      $CourseClassTable,
                      RegistrationData
                    >(
                      currentTable: table,
                      referencedTable: $$CourseClassTableReferences
                          ._registrationRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$CourseClassTableReferences(
                                db,
                                table,
                                p0,
                              ).registrationRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.courseClassId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CourseClassTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CourseClassTable,
      CourseClassData,
      $$CourseClassTableFilterComposer,
      $$CourseClassTableOrderingComposer,
      $$CourseClassTableAnnotationComposer,
      $$CourseClassTableCreateCompanionBuilder,
      $$CourseClassTableUpdateCompanionBuilder,
      (CourseClassData, $$CourseClassTableReferences),
      CourseClassData,
      PrefetchHooks Function({
        bool courseId,
        bool semesterId,
        bool sessionRefs,
        bool registrationRefs,
      })
    >;
typedef $$SessionTableCreateCompanionBuilder =
    SessionCompanion Function({
      Value<int> id,
      required int courseClassId,
      required DateTime date,
    });
typedef $$SessionTableUpdateCompanionBuilder =
    SessionCompanion Function({
      Value<int> id,
      Value<int> courseClassId,
      Value<DateTime> date,
    });

final class $$SessionTableReferences
    extends BaseReferences<_$AppDatabase, $SessionTable, SessionData> {
  $$SessionTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CourseClassTable _courseClassIdTable(_$AppDatabase db) =>
      db.courseClass.createAlias(
        $_aliasNameGenerator(db.session.courseClassId, db.courseClass.id),
      );

  $$CourseClassTableProcessedTableManager get courseClassId {
    final $_column = $_itemColumn<int>('course_class_id')!;

    final manager = $$CourseClassTableTableManager(
      $_db,
      $_db.courseClass,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_courseClassIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$AttendanceTable, List<AttendanceData>>
  _attendanceRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.attendance,
    aliasName: $_aliasNameGenerator(db.session.id, db.attendance.sessionId),
  );

  $$AttendanceTableProcessedTableManager get attendanceRefs {
    final manager = $$AttendanceTableTableManager(
      $_db,
      $_db.attendance,
    ).filter((f) => f.sessionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_attendanceRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SessionTableFilterComposer
    extends Composer<_$AppDatabase, $SessionTable> {
  $$SessionTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  $$CourseClassTableFilterComposer get courseClassId {
    final $$CourseClassTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.courseClassId,
      referencedTable: $db.courseClass,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CourseClassTableFilterComposer(
            $db: $db,
            $table: $db.courseClass,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> attendanceRefs(
    Expression<bool> Function($$AttendanceTableFilterComposer f) f,
  ) {
    final $$AttendanceTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.attendance,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AttendanceTableFilterComposer(
            $db: $db,
            $table: $db.attendance,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SessionTableOrderingComposer
    extends Composer<_$AppDatabase, $SessionTable> {
  $$SessionTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  $$CourseClassTableOrderingComposer get courseClassId {
    final $$CourseClassTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.courseClassId,
      referencedTable: $db.courseClass,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CourseClassTableOrderingComposer(
            $db: $db,
            $table: $db.courseClass,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SessionTableAnnotationComposer
    extends Composer<_$AppDatabase, $SessionTable> {
  $$SessionTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  $$CourseClassTableAnnotationComposer get courseClassId {
    final $$CourseClassTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.courseClassId,
      referencedTable: $db.courseClass,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CourseClassTableAnnotationComposer(
            $db: $db,
            $table: $db.courseClass,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> attendanceRefs<T extends Object>(
    Expression<T> Function($$AttendanceTableAnnotationComposer a) f,
  ) {
    final $$AttendanceTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.attendance,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AttendanceTableAnnotationComposer(
            $db: $db,
            $table: $db.attendance,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SessionTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SessionTable,
          SessionData,
          $$SessionTableFilterComposer,
          $$SessionTableOrderingComposer,
          $$SessionTableAnnotationComposer,
          $$SessionTableCreateCompanionBuilder,
          $$SessionTableUpdateCompanionBuilder,
          (SessionData, $$SessionTableReferences),
          SessionData,
          PrefetchHooks Function({bool courseClassId, bool attendanceRefs})
        > {
  $$SessionTableTableManager(_$AppDatabase db, $SessionTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$SessionTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$SessionTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$SessionTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> courseClassId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
              }) => SessionCompanion(
                id: id,
                courseClassId: courseClassId,
                date: date,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int courseClassId,
                required DateTime date,
              }) => SessionCompanion.insert(
                id: id,
                courseClassId: courseClassId,
                date: date,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$SessionTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({
            courseClassId = false,
            attendanceRefs = false,
          }) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (attendanceRefs) db.attendance],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (courseClassId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.courseClassId,
                            referencedTable: $$SessionTableReferences
                                ._courseClassIdTable(db),
                            referencedColumn:
                                $$SessionTableReferences
                                    ._courseClassIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (attendanceRefs)
                    await $_getPrefetchedData<
                      SessionData,
                      $SessionTable,
                      AttendanceData
                    >(
                      currentTable: table,
                      referencedTable: $$SessionTableReferences
                          ._attendanceRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$SessionTableReferences(
                                db,
                                table,
                                p0,
                              ).attendanceRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.sessionId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$SessionTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SessionTable,
      SessionData,
      $$SessionTableFilterComposer,
      $$SessionTableOrderingComposer,
      $$SessionTableAnnotationComposer,
      $$SessionTableCreateCompanionBuilder,
      $$SessionTableUpdateCompanionBuilder,
      (SessionData, $$SessionTableReferences),
      SessionData,
      PrefetchHooks Function({bool courseClassId, bool attendanceRefs})
    >;
typedef $$StudentTableCreateCompanionBuilder =
    StudentCompanion Function({
      required String id,
      required String email,
      required String name,
      Value<int> rowid,
    });
typedef $$StudentTableUpdateCompanionBuilder =
    StudentCompanion Function({
      Value<String> id,
      Value<String> email,
      Value<String> name,
      Value<int> rowid,
    });

final class $$StudentTableReferences
    extends BaseReferences<_$AppDatabase, $StudentTable, StudentData> {
  $$StudentTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$AttendanceTable, List<AttendanceData>>
  _attendanceRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.attendance,
    aliasName: $_aliasNameGenerator(db.student.id, db.attendance.studentId),
  );

  $$AttendanceTableProcessedTableManager get attendanceRefs {
    final manager = $$AttendanceTableTableManager(
      $_db,
      $_db.attendance,
    ).filter((f) => f.studentId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_attendanceRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RegistrationTable, List<RegistrationData>>
  _registrationRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.registration,
    aliasName: $_aliasNameGenerator(db.student.id, db.registration.studentId),
  );

  $$RegistrationTableProcessedTableManager get registrationRefs {
    final manager = $$RegistrationTableTableManager(
      $_db,
      $_db.registration,
    ).filter((f) => f.studentId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_registrationRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$StudentTableFilterComposer
    extends Composer<_$AppDatabase, $StudentTable> {
  $$StudentTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get searchKey => $composableBuilder(
    column: $table.searchKey,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> attendanceRefs(
    Expression<bool> Function($$AttendanceTableFilterComposer f) f,
  ) {
    final $$AttendanceTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.attendance,
      getReferencedColumn: (t) => t.studentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AttendanceTableFilterComposer(
            $db: $db,
            $table: $db.attendance,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> registrationRefs(
    Expression<bool> Function($$RegistrationTableFilterComposer f) f,
  ) {
    final $$RegistrationTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.registration,
      getReferencedColumn: (t) => t.studentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RegistrationTableFilterComposer(
            $db: $db,
            $table: $db.registration,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$StudentTableOrderingComposer
    extends Composer<_$AppDatabase, $StudentTable> {
  $$StudentTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get searchKey => $composableBuilder(
    column: $table.searchKey,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StudentTableAnnotationComposer
    extends Composer<_$AppDatabase, $StudentTable> {
  $$StudentTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get searchKey =>
      $composableBuilder(column: $table.searchKey, builder: (column) => column);

  Expression<T> attendanceRefs<T extends Object>(
    Expression<T> Function($$AttendanceTableAnnotationComposer a) f,
  ) {
    final $$AttendanceTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.attendance,
      getReferencedColumn: (t) => t.studentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AttendanceTableAnnotationComposer(
            $db: $db,
            $table: $db.attendance,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> registrationRefs<T extends Object>(
    Expression<T> Function($$RegistrationTableAnnotationComposer a) f,
  ) {
    final $$RegistrationTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.registration,
      getReferencedColumn: (t) => t.studentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RegistrationTableAnnotationComposer(
            $db: $db,
            $table: $db.registration,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$StudentTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StudentTable,
          StudentData,
          $$StudentTableFilterComposer,
          $$StudentTableOrderingComposer,
          $$StudentTableAnnotationComposer,
          $$StudentTableCreateCompanionBuilder,
          $$StudentTableUpdateCompanionBuilder,
          (StudentData, $$StudentTableReferences),
          StudentData,
          PrefetchHooks Function({bool attendanceRefs, bool registrationRefs})
        > {
  $$StudentTableTableManager(_$AppDatabase db, $StudentTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$StudentTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$StudentTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$StudentTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StudentCompanion(
                id: id,
                email: email,
                name: name,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String email,
                required String name,
                Value<int> rowid = const Value.absent(),
              }) => StudentCompanion.insert(
                id: id,
                email: email,
                name: name,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$StudentTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({
            attendanceRefs = false,
            registrationRefs = false,
          }) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (attendanceRefs) db.attendance,
                if (registrationRefs) db.registration,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (attendanceRefs)
                    await $_getPrefetchedData<
                      StudentData,
                      $StudentTable,
                      AttendanceData
                    >(
                      currentTable: table,
                      referencedTable: $$StudentTableReferences
                          ._attendanceRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$StudentTableReferences(
                                db,
                                table,
                                p0,
                              ).attendanceRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.studentId == item.id,
                          ),
                      typedResults: items,
                    ),
                  if (registrationRefs)
                    await $_getPrefetchedData<
                      StudentData,
                      $StudentTable,
                      RegistrationData
                    >(
                      currentTable: table,
                      referencedTable: $$StudentTableReferences
                          ._registrationRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$StudentTableReferences(
                                db,
                                table,
                                p0,
                              ).registrationRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.studentId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$StudentTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StudentTable,
      StudentData,
      $$StudentTableFilterComposer,
      $$StudentTableOrderingComposer,
      $$StudentTableAnnotationComposer,
      $$StudentTableCreateCompanionBuilder,
      $$StudentTableUpdateCompanionBuilder,
      (StudentData, $$StudentTableReferences),
      StudentData,
      PrefetchHooks Function({bool attendanceRefs, bool registrationRefs})
    >;
typedef $$AttendanceTableCreateCompanionBuilder =
    AttendanceCompanion Function({
      required AttendanceStatus attendanceStatus,
      Value<int> numContributions,
      required int sessionId,
      required String studentId,
      Value<int> rowid,
    });
typedef $$AttendanceTableUpdateCompanionBuilder =
    AttendanceCompanion Function({
      Value<AttendanceStatus> attendanceStatus,
      Value<int> numContributions,
      Value<int> sessionId,
      Value<String> studentId,
      Value<int> rowid,
    });

final class $$AttendanceTableReferences
    extends BaseReferences<_$AppDatabase, $AttendanceTable, AttendanceData> {
  $$AttendanceTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SessionTable _sessionIdTable(_$AppDatabase db) =>
      db.session.createAlias(
        $_aliasNameGenerator(db.attendance.sessionId, db.session.id),
      );

  $$SessionTableProcessedTableManager get sessionId {
    final $_column = $_itemColumn<int>('session_id')!;

    final manager = $$SessionTableTableManager(
      $_db,
      $_db.session,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $StudentTable _studentIdTable(_$AppDatabase db) =>
      db.student.createAlias(
        $_aliasNameGenerator(db.attendance.studentId, db.student.id),
      );

  $$StudentTableProcessedTableManager get studentId {
    final $_column = $_itemColumn<String>('student_id')!;

    final manager = $$StudentTableTableManager(
      $_db,
      $_db.student,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_studentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AttendanceTableFilterComposer
    extends Composer<_$AppDatabase, $AttendanceTable> {
  $$AttendanceTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnWithTypeConverterFilters<AttendanceStatus, AttendanceStatus, String>
  get attendanceStatus => $composableBuilder(
    column: $table.attendanceStatus,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get numContributions => $composableBuilder(
    column: $table.numContributions,
    builder: (column) => ColumnFilters(column),
  );

  $$SessionTableFilterComposer get sessionId {
    final $$SessionTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.session,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionTableFilterComposer(
            $db: $db,
            $table: $db.session,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StudentTableFilterComposer get studentId {
    final $$StudentTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentId,
      referencedTable: $db.student,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentTableFilterComposer(
            $db: $db,
            $table: $db.student,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AttendanceTableOrderingComposer
    extends Composer<_$AppDatabase, $AttendanceTable> {
  $$AttendanceTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get attendanceStatus => $composableBuilder(
    column: $table.attendanceStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get numContributions => $composableBuilder(
    column: $table.numContributions,
    builder: (column) => ColumnOrderings(column),
  );

  $$SessionTableOrderingComposer get sessionId {
    final $$SessionTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.session,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionTableOrderingComposer(
            $db: $db,
            $table: $db.session,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StudentTableOrderingComposer get studentId {
    final $$StudentTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentId,
      referencedTable: $db.student,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentTableOrderingComposer(
            $db: $db,
            $table: $db.student,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AttendanceTableAnnotationComposer
    extends Composer<_$AppDatabase, $AttendanceTable> {
  $$AttendanceTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumnWithTypeConverter<AttendanceStatus, String>
  get attendanceStatus => $composableBuilder(
    column: $table.attendanceStatus,
    builder: (column) => column,
  );

  GeneratedColumn<int> get numContributions => $composableBuilder(
    column: $table.numContributions,
    builder: (column) => column,
  );

  $$SessionTableAnnotationComposer get sessionId {
    final $$SessionTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.session,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionTableAnnotationComposer(
            $db: $db,
            $table: $db.session,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StudentTableAnnotationComposer get studentId {
    final $$StudentTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentId,
      referencedTable: $db.student,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentTableAnnotationComposer(
            $db: $db,
            $table: $db.student,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AttendanceTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AttendanceTable,
          AttendanceData,
          $$AttendanceTableFilterComposer,
          $$AttendanceTableOrderingComposer,
          $$AttendanceTableAnnotationComposer,
          $$AttendanceTableCreateCompanionBuilder,
          $$AttendanceTableUpdateCompanionBuilder,
          (AttendanceData, $$AttendanceTableReferences),
          AttendanceData,
          PrefetchHooks Function({bool sessionId, bool studentId})
        > {
  $$AttendanceTableTableManager(_$AppDatabase db, $AttendanceTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$AttendanceTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$AttendanceTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$AttendanceTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<AttendanceStatus> attendanceStatus = const Value.absent(),
                Value<int> numContributions = const Value.absent(),
                Value<int> sessionId = const Value.absent(),
                Value<String> studentId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AttendanceCompanion(
                attendanceStatus: attendanceStatus,
                numContributions: numContributions,
                sessionId: sessionId,
                studentId: studentId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required AttendanceStatus attendanceStatus,
                Value<int> numContributions = const Value.absent(),
                required int sessionId,
                required String studentId,
                Value<int> rowid = const Value.absent(),
              }) => AttendanceCompanion.insert(
                attendanceStatus: attendanceStatus,
                numContributions: numContributions,
                sessionId: sessionId,
                studentId: studentId,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$AttendanceTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({sessionId = false, studentId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (sessionId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.sessionId,
                            referencedTable: $$AttendanceTableReferences
                                ._sessionIdTable(db),
                            referencedColumn:
                                $$AttendanceTableReferences
                                    ._sessionIdTable(db)
                                    .id,
                          )
                          as T;
                }
                if (studentId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.studentId,
                            referencedTable: $$AttendanceTableReferences
                                ._studentIdTable(db),
                            referencedColumn:
                                $$AttendanceTableReferences
                                    ._studentIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$AttendanceTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AttendanceTable,
      AttendanceData,
      $$AttendanceTableFilterComposer,
      $$AttendanceTableOrderingComposer,
      $$AttendanceTableAnnotationComposer,
      $$AttendanceTableCreateCompanionBuilder,
      $$AttendanceTableUpdateCompanionBuilder,
      (AttendanceData, $$AttendanceTableReferences),
      AttendanceData,
      PrefetchHooks Function({bool sessionId, bool studentId})
    >;
typedef $$RegistrationTableCreateCompanionBuilder =
    RegistrationCompanion Function({
      required int courseClassId,
      required String studentId,
      Value<int> rowid,
    });
typedef $$RegistrationTableUpdateCompanionBuilder =
    RegistrationCompanion Function({
      Value<int> courseClassId,
      Value<String> studentId,
      Value<int> rowid,
    });

final class $$RegistrationTableReferences
    extends
        BaseReferences<_$AppDatabase, $RegistrationTable, RegistrationData> {
  $$RegistrationTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CourseClassTable _courseClassIdTable(_$AppDatabase db) =>
      db.courseClass.createAlias(
        $_aliasNameGenerator(db.registration.courseClassId, db.courseClass.id),
      );

  $$CourseClassTableProcessedTableManager get courseClassId {
    final $_column = $_itemColumn<int>('course_class_id')!;

    final manager = $$CourseClassTableTableManager(
      $_db,
      $_db.courseClass,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_courseClassIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $StudentTable _studentIdTable(_$AppDatabase db) =>
      db.student.createAlias(
        $_aliasNameGenerator(db.registration.studentId, db.student.id),
      );

  $$StudentTableProcessedTableManager get studentId {
    final $_column = $_itemColumn<String>('student_id')!;

    final manager = $$StudentTableTableManager(
      $_db,
      $_db.student,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_studentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RegistrationTableFilterComposer
    extends Composer<_$AppDatabase, $RegistrationTable> {
  $$RegistrationTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$CourseClassTableFilterComposer get courseClassId {
    final $$CourseClassTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.courseClassId,
      referencedTable: $db.courseClass,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CourseClassTableFilterComposer(
            $db: $db,
            $table: $db.courseClass,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StudentTableFilterComposer get studentId {
    final $$StudentTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentId,
      referencedTable: $db.student,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentTableFilterComposer(
            $db: $db,
            $table: $db.student,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RegistrationTableOrderingComposer
    extends Composer<_$AppDatabase, $RegistrationTable> {
  $$RegistrationTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$CourseClassTableOrderingComposer get courseClassId {
    final $$CourseClassTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.courseClassId,
      referencedTable: $db.courseClass,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CourseClassTableOrderingComposer(
            $db: $db,
            $table: $db.courseClass,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StudentTableOrderingComposer get studentId {
    final $$StudentTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentId,
      referencedTable: $db.student,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentTableOrderingComposer(
            $db: $db,
            $table: $db.student,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RegistrationTableAnnotationComposer
    extends Composer<_$AppDatabase, $RegistrationTable> {
  $$RegistrationTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$CourseClassTableAnnotationComposer get courseClassId {
    final $$CourseClassTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.courseClassId,
      referencedTable: $db.courseClass,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CourseClassTableAnnotationComposer(
            $db: $db,
            $table: $db.courseClass,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StudentTableAnnotationComposer get studentId {
    final $$StudentTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.studentId,
      referencedTable: $db.student,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentTableAnnotationComposer(
            $db: $db,
            $table: $db.student,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RegistrationTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RegistrationTable,
          RegistrationData,
          $$RegistrationTableFilterComposer,
          $$RegistrationTableOrderingComposer,
          $$RegistrationTableAnnotationComposer,
          $$RegistrationTableCreateCompanionBuilder,
          $$RegistrationTableUpdateCompanionBuilder,
          (RegistrationData, $$RegistrationTableReferences),
          RegistrationData,
          PrefetchHooks Function({bool courseClassId, bool studentId})
        > {
  $$RegistrationTableTableManager(_$AppDatabase db, $RegistrationTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$RegistrationTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$RegistrationTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$RegistrationTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> courseClassId = const Value.absent(),
                Value<String> studentId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RegistrationCompanion(
                courseClassId: courseClassId,
                studentId: studentId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int courseClassId,
                required String studentId,
                Value<int> rowid = const Value.absent(),
              }) => RegistrationCompanion.insert(
                courseClassId: courseClassId,
                studentId: studentId,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$RegistrationTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({courseClassId = false, studentId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (courseClassId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.courseClassId,
                            referencedTable: $$RegistrationTableReferences
                                ._courseClassIdTable(db),
                            referencedColumn:
                                $$RegistrationTableReferences
                                    ._courseClassIdTable(db)
                                    .id,
                          )
                          as T;
                }
                if (studentId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.studentId,
                            referencedTable: $$RegistrationTableReferences
                                ._studentIdTable(db),
                            referencedColumn:
                                $$RegistrationTableReferences
                                    ._studentIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RegistrationTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RegistrationTable,
      RegistrationData,
      $$RegistrationTableFilterComposer,
      $$RegistrationTableOrderingComposer,
      $$RegistrationTableAnnotationComposer,
      $$RegistrationTableCreateCompanionBuilder,
      $$RegistrationTableUpdateCompanionBuilder,
      (RegistrationData, $$RegistrationTableReferences),
      RegistrationData,
      PrefetchHooks Function({bool courseClassId, bool studentId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CourseTableTableManager get course =>
      $$CourseTableTableManager(_db, _db.course);
  $$SemesterTableTableManager get semester =>
      $$SemesterTableTableManager(_db, _db.semester);
  $$CourseClassTableTableManager get courseClass =>
      $$CourseClassTableTableManager(_db, _db.courseClass);
  $$SessionTableTableManager get session =>
      $$SessionTableTableManager(_db, _db.session);
  $$StudentTableTableManager get student =>
      $$StudentTableTableManager(_db, _db.student);
  $$AttendanceTableTableManager get attendance =>
      $$AttendanceTableTableManager(_db, _db.attendance);
  $$RegistrationTableTableManager get registration =>
      $$RegistrationTableTableManager(_db, _db.registration);
}
