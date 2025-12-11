import 'package:riverpod/riverpod.dart';
import 'database/database.dart';
import 'providers.dart';

final courseClassViewModelProvider = FutureProvider.family(
  (ref, CourseClassId id) async {
    final courseClass = await ref.watch(
      courseClassProvider(id).future,
    );

    final semester = await ref.watch(
      semesterProvider(courseClass.semesterId).future,
    );

    final course = await ref.watch(
      courseProvider(courseClass.courseId).future,
    );
    return CourseClassViewModel(
      course: course,
      semester: semester,
      courseClass: courseClass,
    );
  },
);

class CourseClassViewModel {
  final CourseData course;
  final SemesterData semester;
  final CourseClassData courseClass;
  const CourseClassViewModel({
    required this.course,
    required this.semester,
    required this.courseClass,
  });

  static final byIdProvider = courseClassViewModelProvider;
}
