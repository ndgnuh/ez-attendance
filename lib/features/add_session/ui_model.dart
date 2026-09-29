import 'package:checkin_tool/core/database_service.dart';
import 'package:checkin_tool/features/add_session/database.dart';
import 'package:checkin_tool/features/add_session/widgets/time_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

enum AddSessionAspect {
  courseClass,
  day,
  startTime,
  endTime,
  ignoreAttendance,
}

final periodsProvider = StreamProvider((ref) async* {
  final db = await ref.watch(databaseProvider.future);
  final stmt = db.select(db.period);
  yield* stmt.watch();
});

class AddSessionScope extends ConsumerStatefulWidget {
  final Widget child;
  final int classId;
  const AddSessionScope({
    super.key,
    required this.child,
    required this.classId,
  });

  @override
  ConsumerState<AddSessionScope> createState() => _AddSessionScopeState();
}

class _AddSessionScopeState extends ConsumerState<AddSessionScope> {
  DateTime day = DateTime.now();
  TimeOfDay startTime = TimeOfDay(hour: 0, minute: 0);
  TimeOfDay endTime = TimeOfDay(hour: 0, minute: 0);
  bool ignoreAttendance = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> submit() async {
    assert(startTime.isBefore(endTime), "Thời gian bắt đầu phải ở trước");
    final db = await ref.read(databaseProvider.future);
    final classId = widget.classId;
    await addSession(
      db: db,
      classId: classId,
      day: day,
      startTime: startTime,
      endTime: endTime,
    );
  }

  Future<void> fetchData() async {
    final db = await ref.read(databaseProvider.future);
    final classId = widget.classId;
    final userDefaults = await getDefaultSessionTime(db: db, classId: classId);

    setState(() {
      day = userDefaults.day;
      startTime = userDefaults.startTime;
      endTime = userDefaults.endTime;
    });
  }

  void updateFunction({
    DateTime? day,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    bool? ignoreAttendance,
  }) => setState(() {
    this.day = day ?? this.day;
    this.startTime = startTime ?? this.startTime;
    this.endTime = endTime ?? this.endTime;
    this.ignoreAttendance = ignoreAttendance ?? this.ignoreAttendance;
  });

  @override
  Widget build(BuildContext context) {
    final model = AddSessionModel(
      submitFunction: submit,
      classId: widget.classId,
      startTime: startTime,
      endTime: endTime,
      ignoreAttendance: ignoreAttendance,
      updateFunction: updateFunction,
      day: day,
      child: widget.child,
    );
    print(model.day);
    return model;
  }
}

typedef UpdateFunction =
    void Function({
      DateTime? day,
      TimeOfDay? startTime,
      TimeOfDay? endTime,
      bool? ignoreAttendance,
    });

class AddSessionModel extends InheritedModel<AddSessionAspect> {
  final int classId;
  final DateTime day;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final bool ignoreAttendance;
  final UpdateFunction updateFunction;
  final Future<void> Function() submitFunction;

  const AddSessionModel({
    super.key,
    required super.child,
    required this.classId,
    required this.startTime,
    required this.endTime,
    required this.ignoreAttendance,
    required this.updateFunction,
    required this.day,
    required this.submitFunction,
  });

  static UpdateFunction getUpdater(BuildContext context) {
    final model = context.getInheritedWidgetOfExactType<AddSessionModel>();
    return model!.updateFunction;
  }

  static Future<void> Function() getSubmitFunction(BuildContext context) {
    final model = context.getInheritedWidgetOfExactType<AddSessionModel>();
    return model!.submitFunction;
  }

  static DateTime dayOf(BuildContext context) {
    final model = InheritedModel.inheritFrom<AddSessionModel>(
      context,
      aspect: AddSessionAspect.day,
    );
    return model!.day;
  }

  static TimeOfDay startTimeOf(BuildContext context) {
    final model = InheritedModel.inheritFrom<AddSessionModel>(
      context,
      aspect: AddSessionAspect.startTime,
    );
    return model!.startTime;
  }

  static TimeOfDay endTimeOf(BuildContext context) {
    final model = InheritedModel.inheritFrom<AddSessionModel>(
      context,
      aspect: AddSessionAspect.endTime,
    );
    return model!.endTime;
  }

  static bool ignoreAttendanceOf(BuildContext context) {
    final model = InheritedModel.inheritFrom<AddSessionModel>(
      context,
      aspect: AddSessionAspect.ignoreAttendance,
    );
    return model!.ignoreAttendance;
  }

  static int classIdOf(BuildContext context) {
    final model = context.getInheritedWidgetOfExactType<AddSessionModel>();
    return model!.classId;
  }

  @override
  bool updateShouldNotify(covariant AddSessionModel oldWidget) {
    return updateShouldNotifyDependent(
      oldWidget,
      AddSessionAspect.values.toSet(),
    );
  }

  @override
  bool updateShouldNotifyDependent(
    covariant AddSessionModel oldWidget,
    Set<AddSessionAspect> dependencies,
  ) {
    for (final dep in dependencies) {
      switch (dep) {
        case AddSessionAspect.day:
          if (day != oldWidget.day) return true;
        case AddSessionAspect.startTime:
          if (startTime != oldWidget.startTime) return true;
        case AddSessionAspect.endTime:
          if (endTime != oldWidget.endTime) return true;
        case AddSessionAspect.ignoreAttendance:
          if (ignoreAttendance != oldWidget.ignoreAttendance) return true;
        case AddSessionAspect.courseClass:
          if (classId != oldWidget.classId) return true;
      }
    }

    return false;
  }
}
