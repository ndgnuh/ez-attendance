import 'package:riverpod/riverpod.dart';

import '../database/database.dart';
import '../providers.dart';

final courseByIdProvider = AsyncNotifierProvider.family(
  CourseByIdNotifier.new,
);

class CourseByIdNotifier extends AsyncNotifier<CourseData> {
  String courseId;

  CourseByIdNotifier(this.courseId);

  @override
  Future<CourseData> build() async {
    final db = await ref.watch(databaseProvider.future);
    final stmt = db.searchCourse(id: courseId);
    final course = await stmt.getSingleOrNull();
    assert(course != null, 'Course with id $courseId not found');
    return course!;
  }
}
