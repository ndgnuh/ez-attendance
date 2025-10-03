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
  static const VerificationMeta _altNameMeta = const VerificationMeta(
    'altName',
  );
  @override
  late final GeneratedColumn<String> altName = GeneratedColumn<String>(
    'alt_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, altName];
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
    if (data.containsKey('alt_name')) {
      context.handle(
        _altNameMeta,
        altName.isAcceptableOrUnknown(data['alt_name']!, _altNameMeta),
      );
    } else if (isInserting) {
      context.missing(_altNameMeta);
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
      altName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}alt_name'],
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
  final String altName;
  const CourseData({
    required this.id,
    required this.name,
    required this.altName,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['alt_name'] = Variable<String>(altName);
    return map;
  }

  CourseCompanion toCompanion(bool nullToAbsent) {
    return CourseCompanion(
      id: Value(id),
      name: Value(name),
      altName: Value(altName),
    );
  }

  factory CourseData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CourseData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      altName: serializer.fromJson<String>(json['altName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'altName': serializer.toJson<String>(altName),
    };
  }

  CourseData copyWith({String? id, String? name, String? altName}) =>
      CourseData(
        id: id ?? this.id,
        name: name ?? this.name,
        altName: altName ?? this.altName,
      );
  CourseData copyWithCompanion(CourseCompanion data) {
    return CourseData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      altName: data.altName.present ? data.altName.value : this.altName,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CourseData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('altName: $altName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, altName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CourseData &&
          other.id == this.id &&
          other.name == this.name &&
          other.altName == this.altName);
}

class CourseCompanion extends UpdateCompanion<CourseData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> altName;
  final Value<int> rowid;
  const CourseCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.altName = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CourseCompanion.insert({
    required String id,
    required String name,
    required String altName,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       altName = Value(altName);
  static Insertable<CourseData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? altName,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (altName != null) 'alt_name': altName,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CourseCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? altName,
    Value<int>? rowid,
  }) {
    return CourseCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      altName: altName ?? this.altName,
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
    if (altName.present) {
      map['alt_name'] = Variable<String>(altName.value);
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
          ..write('altName: $altName, ')
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
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _yearStartMeta = const VerificationMeta(
    'yearStart',
  );
  @override
  late final GeneratedColumn<int> yearStart = GeneratedColumn<int>(
    'year_start',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _yearEndMeta = const VerificationMeta(
    'yearEnd',
  );
  @override
  late final GeneratedColumn<int> yearEnd = GeneratedColumn<int>(
    'year_end',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, yearStart, yearEnd];
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
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('year_start')) {
      context.handle(
        _yearStartMeta,
        yearStart.isAcceptableOrUnknown(data['year_start']!, _yearStartMeta),
      );
    } else if (isInserting) {
      context.missing(_yearStartMeta);
    }
    if (data.containsKey('year_end')) {
      context.handle(
        _yearEndMeta,
        yearEnd.isAcceptableOrUnknown(data['year_end']!, _yearEndMeta),
      );
    } else if (isInserting) {
      context.missing(_yearEndMeta);
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
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      yearStart:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}year_start'],
          )!,
      yearEnd:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}year_end'],
          )!,
    );
  }

  @override
  $SemesterTable createAlias(String alias) {
    return $SemesterTable(attachedDatabase, alias);
  }
}

class SemesterData extends DataClass implements Insertable<SemesterData> {
  final String id;
  final int yearStart;
  final int yearEnd;
  const SemesterData({
    required this.id,
    required this.yearStart,
    required this.yearEnd,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['year_start'] = Variable<int>(yearStart);
    map['year_end'] = Variable<int>(yearEnd);
    return map;
  }

  SemesterCompanion toCompanion(bool nullToAbsent) {
    return SemesterCompanion(
      id: Value(id),
      yearStart: Value(yearStart),
      yearEnd: Value(yearEnd),
    );
  }

  factory SemesterData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SemesterData(
      id: serializer.fromJson<String>(json['id']),
      yearStart: serializer.fromJson<int>(json['yearStart']),
      yearEnd: serializer.fromJson<int>(json['yearEnd']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'yearStart': serializer.toJson<int>(yearStart),
      'yearEnd': serializer.toJson<int>(yearEnd),
    };
  }

  SemesterData copyWith({String? id, int? yearStart, int? yearEnd}) =>
      SemesterData(
        id: id ?? this.id,
        yearStart: yearStart ?? this.yearStart,
        yearEnd: yearEnd ?? this.yearEnd,
      );
  SemesterData copyWithCompanion(SemesterCompanion data) {
    return SemesterData(
      id: data.id.present ? data.id.value : this.id,
      yearStart: data.yearStart.present ? data.yearStart.value : this.yearStart,
      yearEnd: data.yearEnd.present ? data.yearEnd.value : this.yearEnd,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SemesterData(')
          ..write('id: $id, ')
          ..write('yearStart: $yearStart, ')
          ..write('yearEnd: $yearEnd')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, yearStart, yearEnd);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SemesterData &&
          other.id == this.id &&
          other.yearStart == this.yearStart &&
          other.yearEnd == this.yearEnd);
}

class SemesterCompanion extends UpdateCompanion<SemesterData> {
  final Value<String> id;
  final Value<int> yearStart;
  final Value<int> yearEnd;
  final Value<int> rowid;
  const SemesterCompanion({
    this.id = const Value.absent(),
    this.yearStart = const Value.absent(),
    this.yearEnd = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SemesterCompanion.insert({
    required String id,
    required int yearStart,
    required int yearEnd,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       yearStart = Value(yearStart),
       yearEnd = Value(yearEnd);
  static Insertable<SemesterData> custom({
    Expression<String>? id,
    Expression<int>? yearStart,
    Expression<int>? yearEnd,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (yearStart != null) 'year_start': yearStart,
      if (yearEnd != null) 'year_end': yearEnd,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SemesterCompanion copyWith({
    Value<String>? id,
    Value<int>? yearStart,
    Value<int>? yearEnd,
    Value<int>? rowid,
  }) {
    return SemesterCompanion(
      id: id ?? this.id,
      yearStart: yearStart ?? this.yearStart,
      yearEnd: yearEnd ?? this.yearEnd,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (yearStart.present) {
      map['year_start'] = Variable<int>(yearStart.value);
    }
    if (yearEnd.present) {
      map['year_end'] = Variable<int>(yearEnd.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SemesterCompanion(')
          ..write('id: $id, ')
          ..write('yearStart: $yearStart, ')
          ..write('yearEnd: $yearEnd, ')
          ..write('rowid: $rowid')
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
    type: DriftSqlType.int,
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
      'REFERENCES course (id)',
    ),
  );
  static const VerificationMeta _semesterMeta = const VerificationMeta(
    'semester',
  );
  @override
  late final GeneratedColumn<String> semester = GeneratedColumn<String>(
    'semester',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES semester (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [id, courseId, semester];
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
    if (data.containsKey('course_id')) {
      context.handle(
        _courseIdMeta,
        courseId.isAcceptableOrUnknown(data['course_id']!, _courseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_courseIdMeta);
    }
    if (data.containsKey('semester')) {
      context.handle(
        _semesterMeta,
        semester.isAcceptableOrUnknown(data['semester']!, _semesterMeta),
      );
    } else if (isInserting) {
      context.missing(_semesterMeta);
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
      courseId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}course_id'],
          )!,
      semester:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}semester'],
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
  final String courseId;
  final String semester;
  const CourseClassData({
    required this.id,
    required this.courseId,
    required this.semester,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['course_id'] = Variable<String>(courseId);
    map['semester'] = Variable<String>(semester);
    return map;
  }

  CourseClassCompanion toCompanion(bool nullToAbsent) {
    return CourseClassCompanion(
      id: Value(id),
      courseId: Value(courseId),
      semester: Value(semester),
    );
  }

  factory CourseClassData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CourseClassData(
      id: serializer.fromJson<int>(json['id']),
      courseId: serializer.fromJson<String>(json['courseId']),
      semester: serializer.fromJson<String>(json['semester']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'courseId': serializer.toJson<String>(courseId),
      'semester': serializer.toJson<String>(semester),
    };
  }

  CourseClassData copyWith({int? id, String? courseId, String? semester}) =>
      CourseClassData(
        id: id ?? this.id,
        courseId: courseId ?? this.courseId,
        semester: semester ?? this.semester,
      );
  CourseClassData copyWithCompanion(CourseClassCompanion data) {
    return CourseClassData(
      id: data.id.present ? data.id.value : this.id,
      courseId: data.courseId.present ? data.courseId.value : this.courseId,
      semester: data.semester.present ? data.semester.value : this.semester,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CourseClassData(')
          ..write('id: $id, ')
          ..write('courseId: $courseId, ')
          ..write('semester: $semester')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, courseId, semester);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CourseClassData &&
          other.id == this.id &&
          other.courseId == this.courseId &&
          other.semester == this.semester);
}

class CourseClassCompanion extends UpdateCompanion<CourseClassData> {
  final Value<int> id;
  final Value<String> courseId;
  final Value<String> semester;
  const CourseClassCompanion({
    this.id = const Value.absent(),
    this.courseId = const Value.absent(),
    this.semester = const Value.absent(),
  });
  CourseClassCompanion.insert({
    this.id = const Value.absent(),
    required String courseId,
    required String semester,
  }) : courseId = Value(courseId),
       semester = Value(semester);
  static Insertable<CourseClassData> custom({
    Expression<int>? id,
    Expression<String>? courseId,
    Expression<String>? semester,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (courseId != null) 'course_id': courseId,
      if (semester != null) 'semester': semester,
    });
  }

  CourseClassCompanion copyWith({
    Value<int>? id,
    Value<String>? courseId,
    Value<String>? semester,
  }) {
    return CourseClassCompanion(
      id: id ?? this.id,
      courseId: courseId ?? this.courseId,
      semester: semester ?? this.semester,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (courseId.present) {
      map['course_id'] = Variable<String>(courseId.value);
    }
    if (semester.present) {
      map['semester'] = Variable<String>(semester.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CourseClassCompanion(')
          ..write('id: $id, ')
          ..write('courseId: $courseId, ')
          ..write('semester: $semester')
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
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
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
  late final GeneratedColumnWithTypeConverter<Gender, String> gender =
      GeneratedColumn<String>(
        'gender',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Gender>($StudentTable.$convertergender);
  static const VerificationMeta _managementGroupMeta = const VerificationMeta(
    'managementGroup',
  );
  @override
  late final GeneratedColumn<String> managementGroup = GeneratedColumn<String>(
    'management_group',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateOfBirthMeta = const VerificationMeta(
    'dateOfBirth',
  );
  @override
  late final GeneratedColumn<DateTime> dateOfBirth = GeneratedColumn<DateTime>(
    'date_of_birth',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    gender,
    managementGroup,
    dateOfBirth,
  ];
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
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('management_group')) {
      context.handle(
        _managementGroupMeta,
        managementGroup.isAcceptableOrUnknown(
          data['management_group']!,
          _managementGroupMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_managementGroupMeta);
    }
    if (data.containsKey('date_of_birth')) {
      context.handle(
        _dateOfBirthMeta,
        dateOfBirth.isAcceptableOrUnknown(
          data['date_of_birth']!,
          _dateOfBirthMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dateOfBirthMeta);
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
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      gender: $StudentTable.$convertergender.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}gender'],
        )!,
      ),
      managementGroup:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}management_group'],
          )!,
      dateOfBirth:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}date_of_birth'],
          )!,
    );
  }

  @override
  $StudentTable createAlias(String alias) {
    return $StudentTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Gender, String, String> $convertergender =
      const EnumNameConverter<Gender>(Gender.values);
}

class StudentData extends DataClass implements Insertable<StudentData> {
  final int id;
  final String name;
  final Gender gender;
  final String managementGroup;
  final DateTime dateOfBirth;
  const StudentData({
    required this.id,
    required this.name,
    required this.gender,
    required this.managementGroup,
    required this.dateOfBirth,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    {
      map['gender'] = Variable<String>(
        $StudentTable.$convertergender.toSql(gender),
      );
    }
    map['management_group'] = Variable<String>(managementGroup);
    map['date_of_birth'] = Variable<DateTime>(dateOfBirth);
    return map;
  }

  StudentCompanion toCompanion(bool nullToAbsent) {
    return StudentCompanion(
      id: Value(id),
      name: Value(name),
      gender: Value(gender),
      managementGroup: Value(managementGroup),
      dateOfBirth: Value(dateOfBirth),
    );
  }

  factory StudentData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StudentData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      gender: $StudentTable.$convertergender.fromJson(
        serializer.fromJson<String>(json['gender']),
      ),
      managementGroup: serializer.fromJson<String>(json['managementGroup']),
      dateOfBirth: serializer.fromJson<DateTime>(json['dateOfBirth']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'gender': serializer.toJson<String>(
        $StudentTable.$convertergender.toJson(gender),
      ),
      'managementGroup': serializer.toJson<String>(managementGroup),
      'dateOfBirth': serializer.toJson<DateTime>(dateOfBirth),
    };
  }

  StudentData copyWith({
    int? id,
    String? name,
    Gender? gender,
    String? managementGroup,
    DateTime? dateOfBirth,
  }) => StudentData(
    id: id ?? this.id,
    name: name ?? this.name,
    gender: gender ?? this.gender,
    managementGroup: managementGroup ?? this.managementGroup,
    dateOfBirth: dateOfBirth ?? this.dateOfBirth,
  );
  StudentData copyWithCompanion(StudentCompanion data) {
    return StudentData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      gender: data.gender.present ? data.gender.value : this.gender,
      managementGroup:
          data.managementGroup.present
              ? data.managementGroup.value
              : this.managementGroup,
      dateOfBirth:
          data.dateOfBirth.present ? data.dateOfBirth.value : this.dateOfBirth,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StudentData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('gender: $gender, ')
          ..write('managementGroup: $managementGroup, ')
          ..write('dateOfBirth: $dateOfBirth')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, gender, managementGroup, dateOfBirth);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudentData &&
          other.id == this.id &&
          other.name == this.name &&
          other.gender == this.gender &&
          other.managementGroup == this.managementGroup &&
          other.dateOfBirth == this.dateOfBirth);
}

class StudentCompanion extends UpdateCompanion<StudentData> {
  final Value<int> id;
  final Value<String> name;
  final Value<Gender> gender;
  final Value<String> managementGroup;
  final Value<DateTime> dateOfBirth;
  const StudentCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.gender = const Value.absent(),
    this.managementGroup = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
  });
  StudentCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required Gender gender,
    required String managementGroup,
    required DateTime dateOfBirth,
  }) : name = Value(name),
       gender = Value(gender),
       managementGroup = Value(managementGroup),
       dateOfBirth = Value(dateOfBirth);
  static Insertable<StudentData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? gender,
    Expression<String>? managementGroup,
    Expression<DateTime>? dateOfBirth,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (gender != null) 'gender': gender,
      if (managementGroup != null) 'management_group': managementGroup,
      if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
    });
  }

  StudentCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<Gender>? gender,
    Value<String>? managementGroup,
    Value<DateTime>? dateOfBirth,
  }) {
    return StudentCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      managementGroup: managementGroup ?? this.managementGroup,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    );
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
    if (gender.present) {
      map['gender'] = Variable<String>(
        $StudentTable.$convertergender.toSql(gender.value),
      );
    }
    if (managementGroup.present) {
      map['management_group'] = Variable<String>(managementGroup.value);
    }
    if (dateOfBirth.present) {
      map['date_of_birth'] = Variable<DateTime>(dateOfBirth.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudentCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('gender: $gender, ')
          ..write('managementGroup: $managementGroup, ')
          ..write('dateOfBirth: $dateOfBirth')
          ..write(')'))
        .toString();
  }
}

class $CourseClassRegisterTable extends CourseClassRegister
    with TableInfo<$CourseClassRegisterTable, CourseClassRegisterData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CourseClassRegisterTable(this.attachedDatabase, [this._alias]);
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
      'REFERENCES course_class (id)',
    ),
  );
  static const VerificationMeta _studentIdMeta = const VerificationMeta(
    'studentId',
  );
  @override
  late final GeneratedColumn<int> studentId = GeneratedColumn<int>(
    'student_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES student (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [courseClassId, studentId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'course_class_register';
  @override
  VerificationContext validateIntegrity(
    Insertable<CourseClassRegisterData> instance, {
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
  CourseClassRegisterData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CourseClassRegisterData(
      courseClassId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}course_class_id'],
          )!,
      studentId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}student_id'],
          )!,
    );
  }

  @override
  $CourseClassRegisterTable createAlias(String alias) {
    return $CourseClassRegisterTable(attachedDatabase, alias);
  }
}

class CourseClassRegisterData extends DataClass
    implements Insertable<CourseClassRegisterData> {
  final int courseClassId;
  final int studentId;
  const CourseClassRegisterData({
    required this.courseClassId,
    required this.studentId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['course_class_id'] = Variable<int>(courseClassId);
    map['student_id'] = Variable<int>(studentId);
    return map;
  }

  CourseClassRegisterCompanion toCompanion(bool nullToAbsent) {
    return CourseClassRegisterCompanion(
      courseClassId: Value(courseClassId),
      studentId: Value(studentId),
    );
  }

  factory CourseClassRegisterData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CourseClassRegisterData(
      courseClassId: serializer.fromJson<int>(json['courseClassId']),
      studentId: serializer.fromJson<int>(json['studentId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'courseClassId': serializer.toJson<int>(courseClassId),
      'studentId': serializer.toJson<int>(studentId),
    };
  }

  CourseClassRegisterData copyWith({int? courseClassId, int? studentId}) =>
      CourseClassRegisterData(
        courseClassId: courseClassId ?? this.courseClassId,
        studentId: studentId ?? this.studentId,
      );
  CourseClassRegisterData copyWithCompanion(CourseClassRegisterCompanion data) {
    return CourseClassRegisterData(
      courseClassId:
          data.courseClassId.present
              ? data.courseClassId.value
              : this.courseClassId,
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CourseClassRegisterData(')
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
      (other is CourseClassRegisterData &&
          other.courseClassId == this.courseClassId &&
          other.studentId == this.studentId);
}

class CourseClassRegisterCompanion
    extends UpdateCompanion<CourseClassRegisterData> {
  final Value<int> courseClassId;
  final Value<int> studentId;
  final Value<int> rowid;
  const CourseClassRegisterCompanion({
    this.courseClassId = const Value.absent(),
    this.studentId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CourseClassRegisterCompanion.insert({
    required int courseClassId,
    required int studentId,
    this.rowid = const Value.absent(),
  }) : courseClassId = Value(courseClassId),
       studentId = Value(studentId);
  static Insertable<CourseClassRegisterData> custom({
    Expression<int>? courseClassId,
    Expression<int>? studentId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (courseClassId != null) 'course_class_id': courseClassId,
      if (studentId != null) 'student_id': studentId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CourseClassRegisterCompanion copyWith({
    Value<int>? courseClassId,
    Value<int>? studentId,
    Value<int>? rowid,
  }) {
    return CourseClassRegisterCompanion(
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
      map['student_id'] = Variable<int>(studentId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CourseClassRegisterCompanion(')
          ..write('courseClassId: $courseClassId, ')
          ..write('studentId: $studentId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CheckInSessionTable extends CheckInSession
    with TableInfo<$CheckInSessionTable, CheckInSessionData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CheckInSessionTable(this.attachedDatabase, [this._alias]);
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
      'REFERENCES course_class (id)',
    ),
  );
  static const VerificationMeta _studentIdMeta = const VerificationMeta(
    'studentId',
  );
  @override
  late final GeneratedColumn<int> studentId = GeneratedColumn<int>(
    'student_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES student (id)',
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
  List<GeneratedColumn> get $columns => [id, courseClassId, studentId, date];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'check_in_session';
  @override
  VerificationContext validateIntegrity(
    Insertable<CheckInSessionData> instance, {
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
    if (data.containsKey('student_id')) {
      context.handle(
        _studentIdMeta,
        studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_studentIdMeta);
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
  CheckInSessionData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CheckInSessionData(
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
      studentId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}student_id'],
          )!,
      date:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}date'],
          )!,
    );
  }

  @override
  $CheckInSessionTable createAlias(String alias) {
    return $CheckInSessionTable(attachedDatabase, alias);
  }
}

class CheckInSessionData extends DataClass
    implements Insertable<CheckInSessionData> {
  final int id;
  final int courseClassId;
  final int studentId;
  final DateTime date;
  const CheckInSessionData({
    required this.id,
    required this.courseClassId,
    required this.studentId,
    required this.date,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['course_class_id'] = Variable<int>(courseClassId);
    map['student_id'] = Variable<int>(studentId);
    map['date'] = Variable<DateTime>(date);
    return map;
  }

  CheckInSessionCompanion toCompanion(bool nullToAbsent) {
    return CheckInSessionCompanion(
      id: Value(id),
      courseClassId: Value(courseClassId),
      studentId: Value(studentId),
      date: Value(date),
    );
  }

  factory CheckInSessionData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CheckInSessionData(
      id: serializer.fromJson<int>(json['id']),
      courseClassId: serializer.fromJson<int>(json['courseClassId']),
      studentId: serializer.fromJson<int>(json['studentId']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'courseClassId': serializer.toJson<int>(courseClassId),
      'studentId': serializer.toJson<int>(studentId),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  CheckInSessionData copyWith({
    int? id,
    int? courseClassId,
    int? studentId,
    DateTime? date,
  }) => CheckInSessionData(
    id: id ?? this.id,
    courseClassId: courseClassId ?? this.courseClassId,
    studentId: studentId ?? this.studentId,
    date: date ?? this.date,
  );
  CheckInSessionData copyWithCompanion(CheckInSessionCompanion data) {
    return CheckInSessionData(
      id: data.id.present ? data.id.value : this.id,
      courseClassId:
          data.courseClassId.present
              ? data.courseClassId.value
              : this.courseClassId,
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
      date: data.date.present ? data.date.value : this.date,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CheckInSessionData(')
          ..write('id: $id, ')
          ..write('courseClassId: $courseClassId, ')
          ..write('studentId: $studentId, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, courseClassId, studentId, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CheckInSessionData &&
          other.id == this.id &&
          other.courseClassId == this.courseClassId &&
          other.studentId == this.studentId &&
          other.date == this.date);
}

class CheckInSessionCompanion extends UpdateCompanion<CheckInSessionData> {
  final Value<int> id;
  final Value<int> courseClassId;
  final Value<int> studentId;
  final Value<DateTime> date;
  const CheckInSessionCompanion({
    this.id = const Value.absent(),
    this.courseClassId = const Value.absent(),
    this.studentId = const Value.absent(),
    this.date = const Value.absent(),
  });
  CheckInSessionCompanion.insert({
    this.id = const Value.absent(),
    required int courseClassId,
    required int studentId,
    required DateTime date,
  }) : courseClassId = Value(courseClassId),
       studentId = Value(studentId),
       date = Value(date);
  static Insertable<CheckInSessionData> custom({
    Expression<int>? id,
    Expression<int>? courseClassId,
    Expression<int>? studentId,
    Expression<DateTime>? date,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (courseClassId != null) 'course_class_id': courseClassId,
      if (studentId != null) 'student_id': studentId,
      if (date != null) 'date': date,
    });
  }

  CheckInSessionCompanion copyWith({
    Value<int>? id,
    Value<int>? courseClassId,
    Value<int>? studentId,
    Value<DateTime>? date,
  }) {
    return CheckInSessionCompanion(
      id: id ?? this.id,
      courseClassId: courseClassId ?? this.courseClassId,
      studentId: studentId ?? this.studentId,
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
    if (studentId.present) {
      map['student_id'] = Variable<int>(studentId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CheckInSessionCompanion(')
          ..write('id: $id, ')
          ..write('courseClassId: $courseClassId, ')
          ..write('studentId: $studentId, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

class $CheckInEntryTable extends CheckInEntry
    with TableInfo<$CheckInEntryTable, CheckInEntryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CheckInEntryTable(this.attachedDatabase, [this._alias]);
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
      'REFERENCES check_in_session (id)',
    ),
  );
  static const VerificationMeta _studentIdMeta = const VerificationMeta(
    'studentId',
  );
  @override
  late final GeneratedColumn<int> studentId = GeneratedColumn<int>(
    'student_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES student (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [sessionId, studentId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'check_in_entry';
  @override
  VerificationContext validateIntegrity(
    Insertable<CheckInEntryData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
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
  CheckInEntryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CheckInEntryData(
      sessionId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}session_id'],
          )!,
      studentId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}student_id'],
          )!,
    );
  }

  @override
  $CheckInEntryTable createAlias(String alias) {
    return $CheckInEntryTable(attachedDatabase, alias);
  }
}

class CheckInEntryData extends DataClass
    implements Insertable<CheckInEntryData> {
  final int sessionId;
  final int studentId;
  const CheckInEntryData({required this.sessionId, required this.studentId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['session_id'] = Variable<int>(sessionId);
    map['student_id'] = Variable<int>(studentId);
    return map;
  }

  CheckInEntryCompanion toCompanion(bool nullToAbsent) {
    return CheckInEntryCompanion(
      sessionId: Value(sessionId),
      studentId: Value(studentId),
    );
  }

  factory CheckInEntryData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CheckInEntryData(
      sessionId: serializer.fromJson<int>(json['sessionId']),
      studentId: serializer.fromJson<int>(json['studentId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'sessionId': serializer.toJson<int>(sessionId),
      'studentId': serializer.toJson<int>(studentId),
    };
  }

  CheckInEntryData copyWith({int? sessionId, int? studentId}) =>
      CheckInEntryData(
        sessionId: sessionId ?? this.sessionId,
        studentId: studentId ?? this.studentId,
      );
  CheckInEntryData copyWithCompanion(CheckInEntryCompanion data) {
    return CheckInEntryData(
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CheckInEntryData(')
          ..write('sessionId: $sessionId, ')
          ..write('studentId: $studentId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(sessionId, studentId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CheckInEntryData &&
          other.sessionId == this.sessionId &&
          other.studentId == this.studentId);
}

class CheckInEntryCompanion extends UpdateCompanion<CheckInEntryData> {
  final Value<int> sessionId;
  final Value<int> studentId;
  final Value<int> rowid;
  const CheckInEntryCompanion({
    this.sessionId = const Value.absent(),
    this.studentId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CheckInEntryCompanion.insert({
    required int sessionId,
    required int studentId,
    this.rowid = const Value.absent(),
  }) : sessionId = Value(sessionId),
       studentId = Value(studentId);
  static Insertable<CheckInEntryData> custom({
    Expression<int>? sessionId,
    Expression<int>? studentId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (sessionId != null) 'session_id': sessionId,
      if (studentId != null) 'student_id': studentId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CheckInEntryCompanion copyWith({
    Value<int>? sessionId,
    Value<int>? studentId,
    Value<int>? rowid,
  }) {
    return CheckInEntryCompanion(
      sessionId: sessionId ?? this.sessionId,
      studentId: studentId ?? this.studentId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (sessionId.present) {
      map['session_id'] = Variable<int>(sessionId.value);
    }
    if (studentId.present) {
      map['student_id'] = Variable<int>(studentId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CheckInEntryCompanion(')
          ..write('sessionId: $sessionId, ')
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
  late final $StudentTable student = $StudentTable(this);
  late final $CourseClassRegisterTable courseClassRegister =
      $CourseClassRegisterTable(this);
  late final $CheckInSessionTable checkInSession = $CheckInSessionTable(this);
  late final $CheckInEntryTable checkInEntry = $CheckInEntryTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    course,
    semester,
    courseClass,
    student,
    courseClassRegister,
    checkInSession,
    checkInEntry,
  ];
}

typedef $$CourseTableCreateCompanionBuilder =
    CourseCompanion Function({
      required String id,
      required String name,
      required String altName,
      Value<int> rowid,
    });
typedef $$CourseTableUpdateCompanionBuilder =
    CourseCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> altName,
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

  ColumnFilters<String> get altName => $composableBuilder(
    column: $table.altName,
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

  ColumnOrderings<String> get altName => $composableBuilder(
    column: $table.altName,
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

  GeneratedColumn<String> get altName =>
      $composableBuilder(column: $table.altName, builder: (column) => column);

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
                Value<String> altName = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CourseCompanion(
                id: id,
                name: name,
                altName: altName,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String altName,
                Value<int> rowid = const Value.absent(),
              }) => CourseCompanion.insert(
                id: id,
                name: name,
                altName: altName,
                rowid: rowid,
              ),
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
    SemesterCompanion Function({
      required String id,
      required int yearStart,
      required int yearEnd,
      Value<int> rowid,
    });
typedef $$SemesterTableUpdateCompanionBuilder =
    SemesterCompanion Function({
      Value<String> id,
      Value<int> yearStart,
      Value<int> yearEnd,
      Value<int> rowid,
    });

final class $$SemesterTableReferences
    extends BaseReferences<_$AppDatabase, $SemesterTable, SemesterData> {
  $$SemesterTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CourseClassTable, List<CourseClassData>>
  _courseClassRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.courseClass,
    aliasName: $_aliasNameGenerator(db.semester.id, db.courseClass.semester),
  );

  $$CourseClassTableProcessedTableManager get courseClassRefs {
    final manager = $$CourseClassTableTableManager(
      $_db,
      $_db.courseClass,
    ).filter((f) => f.semester.id.sqlEquals($_itemColumn<String>('id')!));

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
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get yearStart => $composableBuilder(
    column: $table.yearStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get yearEnd => $composableBuilder(
    column: $table.yearEnd,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> courseClassRefs(
    Expression<bool> Function($$CourseClassTableFilterComposer f) f,
  ) {
    final $$CourseClassTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.courseClass,
      getReferencedColumn: (t) => t.semester,
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
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get yearStart => $composableBuilder(
    column: $table.yearStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get yearEnd => $composableBuilder(
    column: $table.yearEnd,
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
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get yearStart =>
      $composableBuilder(column: $table.yearStart, builder: (column) => column);

  GeneratedColumn<int> get yearEnd =>
      $composableBuilder(column: $table.yearEnd, builder: (column) => column);

  Expression<T> courseClassRefs<T extends Object>(
    Expression<T> Function($$CourseClassTableAnnotationComposer a) f,
  ) {
    final $$CourseClassTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.courseClass,
      getReferencedColumn: (t) => t.semester,
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
                Value<String> id = const Value.absent(),
                Value<int> yearStart = const Value.absent(),
                Value<int> yearEnd = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SemesterCompanion(
                id: id,
                yearStart: yearStart,
                yearEnd: yearEnd,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required int yearStart,
                required int yearEnd,
                Value<int> rowid = const Value.absent(),
              }) => SemesterCompanion.insert(
                id: id,
                yearStart: yearStart,
                yearEnd: yearEnd,
                rowid: rowid,
              ),
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
                            (e) => e.semester == item.id,
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
      required String courseId,
      required String semester,
    });
typedef $$CourseClassTableUpdateCompanionBuilder =
    CourseClassCompanion Function({
      Value<int> id,
      Value<String> courseId,
      Value<String> semester,
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

  static $SemesterTable _semesterTable(_$AppDatabase db) =>
      db.semester.createAlias(
        $_aliasNameGenerator(db.courseClass.semester, db.semester.id),
      );

  $$SemesterTableProcessedTableManager get semester {
    final $_column = $_itemColumn<String>('semester')!;

    final manager = $$SemesterTableTableManager(
      $_db,
      $_db.semester,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_semesterTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $CourseClassRegisterTable,
    List<CourseClassRegisterData>
  >
  _courseClassRegisterRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.courseClassRegister,
        aliasName: $_aliasNameGenerator(
          db.courseClass.id,
          db.courseClassRegister.courseClassId,
        ),
      );

  $$CourseClassRegisterTableProcessedTableManager get courseClassRegisterRefs {
    final manager = $$CourseClassRegisterTableTableManager(
      $_db,
      $_db.courseClassRegister,
    ).filter((f) => f.courseClassId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _courseClassRegisterRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CheckInSessionTable, List<CheckInSessionData>>
  _checkInSessionRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.checkInSession,
    aliasName: $_aliasNameGenerator(
      db.courseClass.id,
      db.checkInSession.courseClassId,
    ),
  );

  $$CheckInSessionTableProcessedTableManager get checkInSessionRefs {
    final manager = $$CheckInSessionTableTableManager(
      $_db,
      $_db.checkInSession,
    ).filter((f) => f.courseClassId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_checkInSessionRefsTable($_db));
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

  $$SemesterTableFilterComposer get semester {
    final $$SemesterTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.semester,
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

  Expression<bool> courseClassRegisterRefs(
    Expression<bool> Function($$CourseClassRegisterTableFilterComposer f) f,
  ) {
    final $$CourseClassRegisterTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.courseClassRegister,
      getReferencedColumn: (t) => t.courseClassId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CourseClassRegisterTableFilterComposer(
            $db: $db,
            $table: $db.courseClassRegister,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> checkInSessionRefs(
    Expression<bool> Function($$CheckInSessionTableFilterComposer f) f,
  ) {
    final $$CheckInSessionTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.checkInSession,
      getReferencedColumn: (t) => t.courseClassId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CheckInSessionTableFilterComposer(
            $db: $db,
            $table: $db.checkInSession,
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

  $$SemesterTableOrderingComposer get semester {
    final $$SemesterTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.semester,
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

  $$SemesterTableAnnotationComposer get semester {
    final $$SemesterTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.semester,
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

  Expression<T> courseClassRegisterRefs<T extends Object>(
    Expression<T> Function($$CourseClassRegisterTableAnnotationComposer a) f,
  ) {
    final $$CourseClassRegisterTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.courseClassRegister,
          getReferencedColumn: (t) => t.courseClassId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CourseClassRegisterTableAnnotationComposer(
                $db: $db,
                $table: $db.courseClassRegister,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> checkInSessionRefs<T extends Object>(
    Expression<T> Function($$CheckInSessionTableAnnotationComposer a) f,
  ) {
    final $$CheckInSessionTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.checkInSession,
      getReferencedColumn: (t) => t.courseClassId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CheckInSessionTableAnnotationComposer(
            $db: $db,
            $table: $db.checkInSession,
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
            bool semester,
            bool courseClassRegisterRefs,
            bool checkInSessionRefs,
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
                Value<String> courseId = const Value.absent(),
                Value<String> semester = const Value.absent(),
              }) => CourseClassCompanion(
                id: id,
                courseId: courseId,
                semester: semester,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String courseId,
                required String semester,
              }) => CourseClassCompanion.insert(
                id: id,
                courseId: courseId,
                semester: semester,
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
            semester = false,
            courseClassRegisterRefs = false,
            checkInSessionRefs = false,
          }) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (courseClassRegisterRefs) db.courseClassRegister,
                if (checkInSessionRefs) db.checkInSession,
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
                if (semester) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.semester,
                            referencedTable: $$CourseClassTableReferences
                                ._semesterTable(db),
                            referencedColumn:
                                $$CourseClassTableReferences
                                    ._semesterTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (courseClassRegisterRefs)
                    await $_getPrefetchedData<
                      CourseClassData,
                      $CourseClassTable,
                      CourseClassRegisterData
                    >(
                      currentTable: table,
                      referencedTable: $$CourseClassTableReferences
                          ._courseClassRegisterRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$CourseClassTableReferences(
                                db,
                                table,
                                p0,
                              ).courseClassRegisterRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.courseClassId == item.id,
                          ),
                      typedResults: items,
                    ),
                  if (checkInSessionRefs)
                    await $_getPrefetchedData<
                      CourseClassData,
                      $CourseClassTable,
                      CheckInSessionData
                    >(
                      currentTable: table,
                      referencedTable: $$CourseClassTableReferences
                          ._checkInSessionRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$CourseClassTableReferences(
                                db,
                                table,
                                p0,
                              ).checkInSessionRefs,
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
        bool semester,
        bool courseClassRegisterRefs,
        bool checkInSessionRefs,
      })
    >;
typedef $$StudentTableCreateCompanionBuilder =
    StudentCompanion Function({
      Value<int> id,
      required String name,
      required Gender gender,
      required String managementGroup,
      required DateTime dateOfBirth,
    });
typedef $$StudentTableUpdateCompanionBuilder =
    StudentCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<Gender> gender,
      Value<String> managementGroup,
      Value<DateTime> dateOfBirth,
    });

final class $$StudentTableReferences
    extends BaseReferences<_$AppDatabase, $StudentTable, StudentData> {
  $$StudentTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<
    $CourseClassRegisterTable,
    List<CourseClassRegisterData>
  >
  _courseClassRegisterRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.courseClassRegister,
        aliasName: $_aliasNameGenerator(
          db.student.id,
          db.courseClassRegister.studentId,
        ),
      );

  $$CourseClassRegisterTableProcessedTableManager get courseClassRegisterRefs {
    final manager = $$CourseClassRegisterTableTableManager(
      $_db,
      $_db.courseClassRegister,
    ).filter((f) => f.studentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _courseClassRegisterRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CheckInSessionTable, List<CheckInSessionData>>
  _checkInSessionRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.checkInSession,
    aliasName: $_aliasNameGenerator(db.student.id, db.checkInSession.studentId),
  );

  $$CheckInSessionTableProcessedTableManager get checkInSessionRefs {
    final manager = $$CheckInSessionTableTableManager(
      $_db,
      $_db.checkInSession,
    ).filter((f) => f.studentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_checkInSessionRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CheckInEntryTable, List<CheckInEntryData>>
  _checkInEntryRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.checkInEntry,
    aliasName: $_aliasNameGenerator(db.student.id, db.checkInEntry.studentId),
  );

  $$CheckInEntryTableProcessedTableManager get checkInEntryRefs {
    final manager = $$CheckInEntryTableTableManager(
      $_db,
      $_db.checkInEntry,
    ).filter((f) => f.studentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_checkInEntryRefsTable($_db));
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
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Gender, Gender, String> get gender =>
      $composableBuilder(
        column: $table.gender,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get managementGroup => $composableBuilder(
    column: $table.managementGroup,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> courseClassRegisterRefs(
    Expression<bool> Function($$CourseClassRegisterTableFilterComposer f) f,
  ) {
    final $$CourseClassRegisterTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.courseClassRegister,
      getReferencedColumn: (t) => t.studentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CourseClassRegisterTableFilterComposer(
            $db: $db,
            $table: $db.courseClassRegister,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> checkInSessionRefs(
    Expression<bool> Function($$CheckInSessionTableFilterComposer f) f,
  ) {
    final $$CheckInSessionTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.checkInSession,
      getReferencedColumn: (t) => t.studentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CheckInSessionTableFilterComposer(
            $db: $db,
            $table: $db.checkInSession,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> checkInEntryRefs(
    Expression<bool> Function($$CheckInEntryTableFilterComposer f) f,
  ) {
    final $$CheckInEntryTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.checkInEntry,
      getReferencedColumn: (t) => t.studentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CheckInEntryTableFilterComposer(
            $db: $db,
            $table: $db.checkInEntry,
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
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get managementGroup => $composableBuilder(
    column: $table.managementGroup,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
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
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Gender, String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<String> get managementGroup => $composableBuilder(
    column: $table.managementGroup,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => column,
  );

  Expression<T> courseClassRegisterRefs<T extends Object>(
    Expression<T> Function($$CourseClassRegisterTableAnnotationComposer a) f,
  ) {
    final $$CourseClassRegisterTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.courseClassRegister,
          getReferencedColumn: (t) => t.studentId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CourseClassRegisterTableAnnotationComposer(
                $db: $db,
                $table: $db.courseClassRegister,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> checkInSessionRefs<T extends Object>(
    Expression<T> Function($$CheckInSessionTableAnnotationComposer a) f,
  ) {
    final $$CheckInSessionTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.checkInSession,
      getReferencedColumn: (t) => t.studentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CheckInSessionTableAnnotationComposer(
            $db: $db,
            $table: $db.checkInSession,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> checkInEntryRefs<T extends Object>(
    Expression<T> Function($$CheckInEntryTableAnnotationComposer a) f,
  ) {
    final $$CheckInEntryTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.checkInEntry,
      getReferencedColumn: (t) => t.studentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CheckInEntryTableAnnotationComposer(
            $db: $db,
            $table: $db.checkInEntry,
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
          PrefetchHooks Function({
            bool courseClassRegisterRefs,
            bool checkInSessionRefs,
            bool checkInEntryRefs,
          })
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
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<Gender> gender = const Value.absent(),
                Value<String> managementGroup = const Value.absent(),
                Value<DateTime> dateOfBirth = const Value.absent(),
              }) => StudentCompanion(
                id: id,
                name: name,
                gender: gender,
                managementGroup: managementGroup,
                dateOfBirth: dateOfBirth,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required Gender gender,
                required String managementGroup,
                required DateTime dateOfBirth,
              }) => StudentCompanion.insert(
                id: id,
                name: name,
                gender: gender,
                managementGroup: managementGroup,
                dateOfBirth: dateOfBirth,
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
            courseClassRegisterRefs = false,
            checkInSessionRefs = false,
            checkInEntryRefs = false,
          }) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (courseClassRegisterRefs) db.courseClassRegister,
                if (checkInSessionRefs) db.checkInSession,
                if (checkInEntryRefs) db.checkInEntry,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (courseClassRegisterRefs)
                    await $_getPrefetchedData<
                      StudentData,
                      $StudentTable,
                      CourseClassRegisterData
                    >(
                      currentTable: table,
                      referencedTable: $$StudentTableReferences
                          ._courseClassRegisterRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$StudentTableReferences(
                                db,
                                table,
                                p0,
                              ).courseClassRegisterRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.studentId == item.id,
                          ),
                      typedResults: items,
                    ),
                  if (checkInSessionRefs)
                    await $_getPrefetchedData<
                      StudentData,
                      $StudentTable,
                      CheckInSessionData
                    >(
                      currentTable: table,
                      referencedTable: $$StudentTableReferences
                          ._checkInSessionRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$StudentTableReferences(
                                db,
                                table,
                                p0,
                              ).checkInSessionRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.studentId == item.id,
                          ),
                      typedResults: items,
                    ),
                  if (checkInEntryRefs)
                    await $_getPrefetchedData<
                      StudentData,
                      $StudentTable,
                      CheckInEntryData
                    >(
                      currentTable: table,
                      referencedTable: $$StudentTableReferences
                          ._checkInEntryRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$StudentTableReferences(
                                db,
                                table,
                                p0,
                              ).checkInEntryRefs,
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
      PrefetchHooks Function({
        bool courseClassRegisterRefs,
        bool checkInSessionRefs,
        bool checkInEntryRefs,
      })
    >;
typedef $$CourseClassRegisterTableCreateCompanionBuilder =
    CourseClassRegisterCompanion Function({
      required int courseClassId,
      required int studentId,
      Value<int> rowid,
    });
typedef $$CourseClassRegisterTableUpdateCompanionBuilder =
    CourseClassRegisterCompanion Function({
      Value<int> courseClassId,
      Value<int> studentId,
      Value<int> rowid,
    });

final class $$CourseClassRegisterTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CourseClassRegisterTable,
          CourseClassRegisterData
        > {
  $$CourseClassRegisterTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CourseClassTable _courseClassIdTable(_$AppDatabase db) =>
      db.courseClass.createAlias(
        $_aliasNameGenerator(
          db.courseClassRegister.courseClassId,
          db.courseClass.id,
        ),
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
        $_aliasNameGenerator(db.courseClassRegister.studentId, db.student.id),
      );

  $$StudentTableProcessedTableManager get studentId {
    final $_column = $_itemColumn<int>('student_id')!;

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

class $$CourseClassRegisterTableFilterComposer
    extends Composer<_$AppDatabase, $CourseClassRegisterTable> {
  $$CourseClassRegisterTableFilterComposer({
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

class $$CourseClassRegisterTableOrderingComposer
    extends Composer<_$AppDatabase, $CourseClassRegisterTable> {
  $$CourseClassRegisterTableOrderingComposer({
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

class $$CourseClassRegisterTableAnnotationComposer
    extends Composer<_$AppDatabase, $CourseClassRegisterTable> {
  $$CourseClassRegisterTableAnnotationComposer({
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

class $$CourseClassRegisterTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CourseClassRegisterTable,
          CourseClassRegisterData,
          $$CourseClassRegisterTableFilterComposer,
          $$CourseClassRegisterTableOrderingComposer,
          $$CourseClassRegisterTableAnnotationComposer,
          $$CourseClassRegisterTableCreateCompanionBuilder,
          $$CourseClassRegisterTableUpdateCompanionBuilder,
          (CourseClassRegisterData, $$CourseClassRegisterTableReferences),
          CourseClassRegisterData,
          PrefetchHooks Function({bool courseClassId, bool studentId})
        > {
  $$CourseClassRegisterTableTableManager(
    _$AppDatabase db,
    $CourseClassRegisterTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$CourseClassRegisterTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$CourseClassRegisterTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$CourseClassRegisterTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> courseClassId = const Value.absent(),
                Value<int> studentId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CourseClassRegisterCompanion(
                courseClassId: courseClassId,
                studentId: studentId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int courseClassId,
                required int studentId,
                Value<int> rowid = const Value.absent(),
              }) => CourseClassRegisterCompanion.insert(
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
                          $$CourseClassRegisterTableReferences(db, table, e),
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
                            referencedTable:
                                $$CourseClassRegisterTableReferences
                                    ._courseClassIdTable(db),
                            referencedColumn:
                                $$CourseClassRegisterTableReferences
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
                            referencedTable:
                                $$CourseClassRegisterTableReferences
                                    ._studentIdTable(db),
                            referencedColumn:
                                $$CourseClassRegisterTableReferences
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

typedef $$CourseClassRegisterTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CourseClassRegisterTable,
      CourseClassRegisterData,
      $$CourseClassRegisterTableFilterComposer,
      $$CourseClassRegisterTableOrderingComposer,
      $$CourseClassRegisterTableAnnotationComposer,
      $$CourseClassRegisterTableCreateCompanionBuilder,
      $$CourseClassRegisterTableUpdateCompanionBuilder,
      (CourseClassRegisterData, $$CourseClassRegisterTableReferences),
      CourseClassRegisterData,
      PrefetchHooks Function({bool courseClassId, bool studentId})
    >;
typedef $$CheckInSessionTableCreateCompanionBuilder =
    CheckInSessionCompanion Function({
      Value<int> id,
      required int courseClassId,
      required int studentId,
      required DateTime date,
    });
typedef $$CheckInSessionTableUpdateCompanionBuilder =
    CheckInSessionCompanion Function({
      Value<int> id,
      Value<int> courseClassId,
      Value<int> studentId,
      Value<DateTime> date,
    });

final class $$CheckInSessionTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CheckInSessionTable,
          CheckInSessionData
        > {
  $$CheckInSessionTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CourseClassTable _courseClassIdTable(_$AppDatabase db) =>
      db.courseClass.createAlias(
        $_aliasNameGenerator(
          db.checkInSession.courseClassId,
          db.courseClass.id,
        ),
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
        $_aliasNameGenerator(db.checkInSession.studentId, db.student.id),
      );

  $$StudentTableProcessedTableManager get studentId {
    final $_column = $_itemColumn<int>('student_id')!;

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

  static MultiTypedResultKey<$CheckInEntryTable, List<CheckInEntryData>>
  _checkInEntryRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.checkInEntry,
    aliasName: $_aliasNameGenerator(
      db.checkInSession.id,
      db.checkInEntry.sessionId,
    ),
  );

  $$CheckInEntryTableProcessedTableManager get checkInEntryRefs {
    final manager = $$CheckInEntryTableTableManager(
      $_db,
      $_db.checkInEntry,
    ).filter((f) => f.sessionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_checkInEntryRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CheckInSessionTableFilterComposer
    extends Composer<_$AppDatabase, $CheckInSessionTable> {
  $$CheckInSessionTableFilterComposer({
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

  Expression<bool> checkInEntryRefs(
    Expression<bool> Function($$CheckInEntryTableFilterComposer f) f,
  ) {
    final $$CheckInEntryTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.checkInEntry,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CheckInEntryTableFilterComposer(
            $db: $db,
            $table: $db.checkInEntry,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CheckInSessionTableOrderingComposer
    extends Composer<_$AppDatabase, $CheckInSessionTable> {
  $$CheckInSessionTableOrderingComposer({
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

class $$CheckInSessionTableAnnotationComposer
    extends Composer<_$AppDatabase, $CheckInSessionTable> {
  $$CheckInSessionTableAnnotationComposer({
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

  Expression<T> checkInEntryRefs<T extends Object>(
    Expression<T> Function($$CheckInEntryTableAnnotationComposer a) f,
  ) {
    final $$CheckInEntryTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.checkInEntry,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CheckInEntryTableAnnotationComposer(
            $db: $db,
            $table: $db.checkInEntry,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CheckInSessionTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CheckInSessionTable,
          CheckInSessionData,
          $$CheckInSessionTableFilterComposer,
          $$CheckInSessionTableOrderingComposer,
          $$CheckInSessionTableAnnotationComposer,
          $$CheckInSessionTableCreateCompanionBuilder,
          $$CheckInSessionTableUpdateCompanionBuilder,
          (CheckInSessionData, $$CheckInSessionTableReferences),
          CheckInSessionData,
          PrefetchHooks Function({
            bool courseClassId,
            bool studentId,
            bool checkInEntryRefs,
          })
        > {
  $$CheckInSessionTableTableManager(
    _$AppDatabase db,
    $CheckInSessionTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$CheckInSessionTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$CheckInSessionTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$CheckInSessionTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> courseClassId = const Value.absent(),
                Value<int> studentId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
              }) => CheckInSessionCompanion(
                id: id,
                courseClassId: courseClassId,
                studentId: studentId,
                date: date,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int courseClassId,
                required int studentId,
                required DateTime date,
              }) => CheckInSessionCompanion.insert(
                id: id,
                courseClassId: courseClassId,
                studentId: studentId,
                date: date,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$CheckInSessionTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({
            courseClassId = false,
            studentId = false,
            checkInEntryRefs = false,
          }) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (checkInEntryRefs) db.checkInEntry],
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
                            referencedTable: $$CheckInSessionTableReferences
                                ._courseClassIdTable(db),
                            referencedColumn:
                                $$CheckInSessionTableReferences
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
                            referencedTable: $$CheckInSessionTableReferences
                                ._studentIdTable(db),
                            referencedColumn:
                                $$CheckInSessionTableReferences
                                    ._studentIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (checkInEntryRefs)
                    await $_getPrefetchedData<
                      CheckInSessionData,
                      $CheckInSessionTable,
                      CheckInEntryData
                    >(
                      currentTable: table,
                      referencedTable: $$CheckInSessionTableReferences
                          ._checkInEntryRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$CheckInSessionTableReferences(
                                db,
                                table,
                                p0,
                              ).checkInEntryRefs,
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

typedef $$CheckInSessionTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CheckInSessionTable,
      CheckInSessionData,
      $$CheckInSessionTableFilterComposer,
      $$CheckInSessionTableOrderingComposer,
      $$CheckInSessionTableAnnotationComposer,
      $$CheckInSessionTableCreateCompanionBuilder,
      $$CheckInSessionTableUpdateCompanionBuilder,
      (CheckInSessionData, $$CheckInSessionTableReferences),
      CheckInSessionData,
      PrefetchHooks Function({
        bool courseClassId,
        bool studentId,
        bool checkInEntryRefs,
      })
    >;
typedef $$CheckInEntryTableCreateCompanionBuilder =
    CheckInEntryCompanion Function({
      required int sessionId,
      required int studentId,
      Value<int> rowid,
    });
typedef $$CheckInEntryTableUpdateCompanionBuilder =
    CheckInEntryCompanion Function({
      Value<int> sessionId,
      Value<int> studentId,
      Value<int> rowid,
    });

final class $$CheckInEntryTableReferences
    extends
        BaseReferences<_$AppDatabase, $CheckInEntryTable, CheckInEntryData> {
  $$CheckInEntryTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CheckInSessionTable _sessionIdTable(_$AppDatabase db) =>
      db.checkInSession.createAlias(
        $_aliasNameGenerator(db.checkInEntry.sessionId, db.checkInSession.id),
      );

  $$CheckInSessionTableProcessedTableManager get sessionId {
    final $_column = $_itemColumn<int>('session_id')!;

    final manager = $$CheckInSessionTableTableManager(
      $_db,
      $_db.checkInSession,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $StudentTable _studentIdTable(_$AppDatabase db) =>
      db.student.createAlias(
        $_aliasNameGenerator(db.checkInEntry.studentId, db.student.id),
      );

  $$StudentTableProcessedTableManager get studentId {
    final $_column = $_itemColumn<int>('student_id')!;

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

class $$CheckInEntryTableFilterComposer
    extends Composer<_$AppDatabase, $CheckInEntryTable> {
  $$CheckInEntryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$CheckInSessionTableFilterComposer get sessionId {
    final $$CheckInSessionTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.checkInSession,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CheckInSessionTableFilterComposer(
            $db: $db,
            $table: $db.checkInSession,
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

class $$CheckInEntryTableOrderingComposer
    extends Composer<_$AppDatabase, $CheckInEntryTable> {
  $$CheckInEntryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$CheckInSessionTableOrderingComposer get sessionId {
    final $$CheckInSessionTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.checkInSession,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CheckInSessionTableOrderingComposer(
            $db: $db,
            $table: $db.checkInSession,
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

class $$CheckInEntryTableAnnotationComposer
    extends Composer<_$AppDatabase, $CheckInEntryTable> {
  $$CheckInEntryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$CheckInSessionTableAnnotationComposer get sessionId {
    final $$CheckInSessionTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.checkInSession,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CheckInSessionTableAnnotationComposer(
            $db: $db,
            $table: $db.checkInSession,
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

class $$CheckInEntryTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CheckInEntryTable,
          CheckInEntryData,
          $$CheckInEntryTableFilterComposer,
          $$CheckInEntryTableOrderingComposer,
          $$CheckInEntryTableAnnotationComposer,
          $$CheckInEntryTableCreateCompanionBuilder,
          $$CheckInEntryTableUpdateCompanionBuilder,
          (CheckInEntryData, $$CheckInEntryTableReferences),
          CheckInEntryData,
          PrefetchHooks Function({bool sessionId, bool studentId})
        > {
  $$CheckInEntryTableTableManager(_$AppDatabase db, $CheckInEntryTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$CheckInEntryTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$CheckInEntryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$CheckInEntryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> sessionId = const Value.absent(),
                Value<int> studentId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CheckInEntryCompanion(
                sessionId: sessionId,
                studentId: studentId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int sessionId,
                required int studentId,
                Value<int> rowid = const Value.absent(),
              }) => CheckInEntryCompanion.insert(
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
                          $$CheckInEntryTableReferences(db, table, e),
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
                            referencedTable: $$CheckInEntryTableReferences
                                ._sessionIdTable(db),
                            referencedColumn:
                                $$CheckInEntryTableReferences
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
                            referencedTable: $$CheckInEntryTableReferences
                                ._studentIdTable(db),
                            referencedColumn:
                                $$CheckInEntryTableReferences
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

typedef $$CheckInEntryTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CheckInEntryTable,
      CheckInEntryData,
      $$CheckInEntryTableFilterComposer,
      $$CheckInEntryTableOrderingComposer,
      $$CheckInEntryTableAnnotationComposer,
      $$CheckInEntryTableCreateCompanionBuilder,
      $$CheckInEntryTableUpdateCompanionBuilder,
      (CheckInEntryData, $$CheckInEntryTableReferences),
      CheckInEntryData,
      PrefetchHooks Function({bool sessionId, bool studentId})
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
  $$StudentTableTableManager get student =>
      $$StudentTableTableManager(_db, _db.student);
  $$CourseClassRegisterTableTableManager get courseClassRegister =>
      $$CourseClassRegisterTableTableManager(_db, _db.courseClassRegister);
  $$CheckInSessionTableTableManager get checkInSession =>
      $$CheckInSessionTableTableManager(_db, _db.checkInSession);
  $$CheckInEntryTableTableManager get checkInEntry =>
      $$CheckInEntryTableTableManager(_db, _db.checkInEntry);
}
