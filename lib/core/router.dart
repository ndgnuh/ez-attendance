import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../features/composite_screens/composite_screens.dart';
import '../features/attendance_session/presentation.dart';
import '../features/class_registration/course_class_students/page.dart';
import '../features/course_class_management/course_class_management.dart';
import '../features/settings/settings.dart';
import 'database/database.dart';

class AppRouter {
  final BuildContext context;

  const AppRouter(this.context);
  NavigatorState get navigator => Navigator.of(context);

  ProviderContainer get ref => ProviderScope.containerOf(context);

  Widget homePage() {
    if (kDebugMode) {
      // return AttendanceSessionCreatePage(courseClassId: 3);
    }
    return MiddlewarePage();
  }

  Future simpleTo<T>(Widget page, {bool replace = false}) {
    final route = MaterialPageRoute<T>(builder: (context) => page);
    if (replace) {
      return navigator.pushReplacement(route);
    } else {
      return navigator.push<T>(route);
    }
  }

  Future<StudentCompanion?> toAddStudentPage({String? studentId}) {
    final route = MaterialPageRoute<StudentCompanion>(
      builder: (context) => AddStudentPage(studentId: studentId),
    );
    return navigator.push<StudentCompanion>(route);
  }

  Future toAttendanceSessionListPage(int courseClassId) => simpleTo(
    AttendanceSessionListPage(courseClassId: courseClassId),
  );

  Future toAttendanceSessionStudentListPage(int sessionId) => simpleTo(
    AttendanceListPage(sessionId: sessionId),
  );

  Future toCourseClassCreatePage() => simpleTo(CourseClassCreatePage());

  Future toCourseClassDetails(int courseClassId) {
    final route = MaterialPageRoute(
      builder: (context) => CourseClassDetailsPage(id: courseClassId),
    );
    return navigator.push(route);
  }

  Future<void> toCourseClassImportPage() => simpleTo(CourseClassImportPage());

  Future toCourseClassStudentList(int courseClassId) => simpleTo(
    CourseClassStudentList(
      courseClassId: courseClassId,
    ),
  );

  Future toInitialSetupPage() => simpleTo(InitialSetupPage(), replace: true);

  Future toRealHomePage() => simpleTo(HomePage(), replace: true);
}

extension EzRouter on BuildContext {
  AppRouter get router => AppRouter(this);
}
