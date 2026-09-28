import 'package:material_ui/material_ui.dart';

enum AddSessionAspect {
  courseClass,
  day,
  startTime,
  endTime,
  ignoreAttendance,
}

class AddSessionScope extends StatefulWidget {
  final Widget child;
  final int classId;
  const AddSessionScope({
    super.key,
    required this.child,
    required this.classId,
  });

  @override
  State<AddSessionScope> createState() => _AddSessionScopeState();
}

class _AddSessionScopeState extends State<AddSessionScope> {
  DateTime day = DateTime.now();
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  bool ignoreAttendance = false;

  void updateFunction({
    DateTime? day,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    bool? ignoreAttendance,
  }) => setState(() {
    this.day = day ?? this.day;
    this.startTime = startTime;
    this.endTime = endTime;
    this.ignoreAttendance = ignoreAttendance ?? this.ignoreAttendance;
  });

  @override
  Widget build(BuildContext context) {
    return AddSessionModel(
      classId: widget.classId,
      startTime: startTime,
      endTime: endTime,
      ignoreAttendance: ignoreAttendance,
      updateFunction: updateFunction,
      day: day,
      child: widget.child,
    );
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
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final bool ignoreAttendance;
  final UpdateFunction updateFunction;

  const AddSessionModel({
    super.key,
    required super.child,
    required this.classId,
    required this.startTime,
    required this.endTime,
    required this.ignoreAttendance,
    required this.updateFunction,
    required this.day,
  });

  static UpdateFunction getUpdater(BuildContext context) {
    final model = context.getInheritedWidgetOfExactType<AddSessionModel>();
    return model!.updateFunction;
  }

  static DateTime dayOf(BuildContext context) {
    final model = context.dependOnInheritedWidgetOfExactType<AddSessionModel>(
      aspect: AddSessionAspect.startTime,
    );
    return model!.day;
  }

  static TimeOfDay? startTimeOf(BuildContext context) {
    final model = context.dependOnInheritedWidgetOfExactType<AddSessionModel>(
      aspect: AddSessionAspect.startTime,
    );
    return model!.startTime;
  }

  static TimeOfDay? endTimeOf(BuildContext context) {
    final model = context.dependOnInheritedWidgetOfExactType<AddSessionModel>(
      aspect: AddSessionAspect.endTime,
    );
    return model!.endTime;
  }

  static bool ignoreAttendanceOf(BuildContext context) {
    final model = context.dependOnInheritedWidgetOfExactType<AddSessionModel>();
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
        case AddSessionAspect.courseClass:
          return false;
        case AddSessionAspect.endTime:
          if (endTime != oldWidget.endTime) return true;
        case AddSessionAspect.ignoreAttendance:
          if (ignoreAttendance != oldWidget.ignoreAttendance) return true;
      }
    }

    return false;
  }
}
