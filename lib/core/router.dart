import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../features/class_registration/course_class_students/page.dart';
import '../features/course_class_import/import_page.dart';
import '../features/course_class_management/presentation.dart';
import '../features/settings/initial_setup_page.dart';
import '../features/settings/middleware_page.dart';

class AppRouter {
  final BuildContext context;

  const AppRouter(this.context);
  NavigatorState get navigator => Navigator.of(context);

  ProviderContainer get ref => ProviderScope.containerOf(context);

  Widget homePage() {
    // if (kDebugMode) {
    //   return CourseClassImportPage();
    // }
    return MiddlewarePage();
  }

  Future<void> simpleTo(Widget page, {bool replace = false}) {
    final route = MaterialPageRoute(builder: (context) => page);
    if (replace) {
      return navigator.pushReplacement(route);
    } else {
      return navigator.push(route);
    }
  }

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

  Future toRealHomePage() => simpleTo(CourseClassListPage(), replace: true);
}

extension EzRouter on BuildContext {
  AppRouter get router => AppRouter(this);
}
