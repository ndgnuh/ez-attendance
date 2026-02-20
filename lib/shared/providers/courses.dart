import 'package:riverpod/riverpod.dart';

import '../../core/database/database.dart';
import '../../core/database_service.dart';

final courseByIdProvider = AsyncNotifierProvider.family(
  CourseByIdNotifier.new,
);

class CourseByIdNotifier extends AsyncNotifier<CourseData> {
  String courseId;

  CourseByIdNotifier(this.courseId);

  @override
  Future<CourseData> build() async {
    ref.watch(databaseProvider.future);
    final db = await ref.watch(databaseProvider.future);
    final stmt = db.searchCourse(id: courseId);
    final course = await stmt.getSingleOrNull();
    assert(course != null, 'Course with id $courseId not found');
    return course!;
  }
}
