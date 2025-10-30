// import 'package:drift/drift.dart';
import 'package:riverpod/riverpod.dart';
import '../providers.dart';

// final semestersProvider = AsyncNotifierProvider(SemestersNotifier.new);
// final classIdsProvider = AsyncNotifierProvider(ClassIdsNotifier.new);
// final classByIdProvider = AsyncNotifierProvider.family(ClassByIdNotifier.new);
// final lastSemesterProvider = AsyncNotifierProvider(LatestSemesterNotifier.new);
//
// class LatestSemesterNotifier extends AsyncNotifier<String?> {
//   @override
//   Future<String?> build() async {
//     final semesters = (await ref.watch(semestersProvider.future)).toList();
//     semesters.sort((a, b) => b.compareTo(a));
//     return semesters.isNotEmpty ? semesters.first : null;
//   }
// }
//
// class SemestersNotifier extends AsyncNotifier<Set<String>> {
//   @override
//   Future<Set<String>> build() async {
//     final db = ref.watch(databaseProvider);
//     final query = db.managers.courseClass.map(
//       (courseClass) => courseClass.semester,
//     );
//     final semesters = await query.get();
//     return semesters.toSet();
//   }
// }
//
// class ClassIdsNotifier extends AsyncNotifier<Set<String>> {
//   @override
//   Future<Set<String>> build() async {
//     final db = ref.watch(databaseProvider);
//     final query = db.managers.courseClass.map(
//       (courseClass) => courseClass.id,
//     );
//     final classIds = await query.get();
//     return classIds.toSet();
//   }
// }
//
// class ClassByIdNotifier extends AsyncNotifier<CourseClassData?> {
//   final String classId;
//
//   ClassByIdNotifier(this.classId);
//
//   @override
//   Future<CourseClassData?> build() async {
//     final db = ref.watch(databaseProvider);
//     final query = db.managers.courseClass.filter(
//       (tbl) => tbl.id.equals(classId),
//     );
//     final classData = await query.getSingleOrNull();
//     return classData;
//   }
// }
//
// class ClassesNotifier extends AsyncNotifier<List<CourseClassData>> {
//   @override
//   Future<List<CourseClassData>> build() async {
//     final db = ref.watch(databaseProvider);
//     final query = db.managers.courseClass;
//     final classes = await query.get();
//     return classes;
//   }
// }
