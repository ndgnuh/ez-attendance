import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database_service.dart';

final _studentListProvider = StreamProvider.family(
  (ref, int courseClassId) async* {
    final db = await ref.watch(databaseProvider.future);
    final stmt = db.getClassStudentList(id: courseClassId);
    await for (final studentList in stmt.watch()) {
      yield studentList;
    }
  },
);

class CourseClassStudentList extends StatelessWidget {
  static const routeName = "/course-class/students/";
  final int courseClassId;

  const CourseClassStudentList({super.key, required this.courseClassId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Danh sách lớp"),
      ),
      body: Padding(
        padding: EdgeInsets.all(context.gutter),
        child: _StudentList(courseClassId: courseClassId),
      ),
    );
  }
}

class _StudentList extends ConsumerWidget {
  final int courseClassId;

  const _StudentList({required this.courseClassId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentListAsync = ref.watch(_studentListProvider(courseClassId));
    switch (studentListAsync) {
      case AsyncLoading():
        return LinearProgressIndicator();
      case AsyncError(:final error, :final stackTrace):
        if (kDebugMode) {
          print(stackTrace);
        }
        return Text(error.toString());
      default:
    }

    final studentList = studentListAsync.value!;
    return Column(
      spacing: context.gutter,
      children: [
        Text("Tổng số sinh viên: ${studentList.length}"),
        Expanded(
          child: ListView.builder(
            itemCount: studentList.length,
            itemBuilder: (context, idx) {
              final student = studentList[idx];
              return ListTile(
                title: Text(student.name),
                subtitle: Text(student.id),
              );
            },
          ),
        ),
      ],
    );
  }
}
