import 'package:checkin_tool/core/database/database.dart';
import 'package:checkin_tool/core/enums.dart';
import 'package:drift/drift.dart';
import 'package:material_ui/material_ui.dart';

const TimeOfDay _fallbackTimeOfDay = TimeOfDay(hour: 0, minute: 0);

/// Default status of the form fields
typedef UserDefaults =
    ({
      DateTime day,
      TimeOfDay startTime,
      TimeOfDay endTime,
    });

/// Add session from inputs
Future<void> addSession({
  required final AppDatabase db,
  required final int classId,
  required final DateTime day,
  required final TimeOfDay startTime,
  required final TimeOfDay endTime,
}) async {
  final startTime_ = day.copyWith(
    hour: startTime.hour,
    minute: startTime.minute,
  );
  final endTime_ = day.copyWith(
    hour: endTime.hour,
    minute: endTime.minute,
  );

  final comp = SessionCompanion.insert(
    courseClassId: classId,
    startTime: startTime_,
    endTime: endTime_,
  );
  await db.into(db.session).insert(comp);
}

/// Get default session time from the db and current time
Future<UserDefaults> getDefaultSessionTime({
  required final AppDatabase db,
  required final int classId,
}) async {
  final dbStartPeriod = db.period.createAlias("startPeriod");
  final dbEndPeriod = db.period.createAlias("dbEndPeriod");

  /// Filter
  final stmt = db.select(db.courseClass);
  stmt.where((r) => r.id.equals(classId));

  // Then join
  final joined = stmt.join([
    rightOuterJoin(
      dbStartPeriod,
      dbStartPeriod.id.equalsExp(db.courseClass.fromPeriod),
    ),
    rightOuterJoin(
      dbEndPeriod,
      dbEndPeriod.id.equalsExp(db.courseClass.toPeriod),
    ),
  ]);

  /// Map to objects
  final mapped = joined.map((row) {
    final courseClass = row.readTable(db.courseClass);
    final startPeriod = row.readTableOrNull(dbStartPeriod);
    final endPeriod = row.readTableOrNull(dbEndPeriod);

    final startTime = startPeriod?.startTime ?? _fallbackTimeOfDay;
    final endTime = endPeriod?.endTime ?? _fallbackTimeOfDay;
    final day = _findNextDayOfWeek(courseClass.dayOfWeek);

    return (day: day, startTime: startTime, endTime: endTime);
  });

  return await mapped.getSingle();
}

DateTime _findNextDayOfWeek(DayOfWeek? dayOfWeek) {
  final now = DateTime.now();

  //  No information, just returns today
  if (dayOfWeek == null) {
    return now;
  }

  // Today is the day, return it
  final today = DayOfWeek.fromIso8601(now.weekday);
  if (today == dayOfWeek) {
    return now;
  }

  // Today is before the day, returns that day of the same week
  if (today.index < dayOfWeek.index) {
    final delta = dayOfWeek.index - today.index;
    return now.add(Duration(days: delta));
  }

  // Today is after the day, returns that day of the next week
  if (today.index > dayOfWeek.index) {
    final delta = dayOfWeek.index - today.index + 7;
    return now.add(Duration(days: delta));
  }

  // Fallback routine, i don't think this code should be run?
  throw AssertionError(
    "This code shouldn't be reached, now: $now, target-day: $dayOfWeek",
  );
}
