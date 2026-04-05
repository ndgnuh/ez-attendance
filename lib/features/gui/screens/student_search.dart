import 'package:checkin_tool/core/router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../student_search/student_search.dart';

class StudentSearchScreen extends StatelessWidget {
  const StudentSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tìm sinh viên"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsetsGeometry.all(context.gutter),
          child: Column(
            spacing: context.gutter,
            children: [
              _StudentSearchBar(),
              Expanded(
                child: _StudentSearchResult(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StudentSearchResult extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(searchResultsProvider);
    switch (asyncData) {
      case AsyncLoading():
        return Center(
          child: LinearProgressIndicator(),
        );
      case AsyncError(:final error, :final stackTrace):
        if (kDebugMode) {
          print(stackTrace);
        }
        return Center(
          child: Text(error.toString()),
        );
      case AsyncData(value: final resultList):
        if (resultList == null) {
          return Center(
            child: Text("Nhập từ khóa để tìm kiếm"),
          );
        }

        if (resultList.isEmpty) {
          return Center(
            child: Text("Không có sinh viên nào"),
          );
        }

        return ListView.separated(
          itemBuilder: (context, i) {
            final result = resultList[i];
            final student = result.studentData;
            final courseClass = result.courseClassData;
            final semester = result.semesterData;

            final title = "${student.id} - ${student.name}";
            final subtitle =
                "Lớp ${courseClass.classCode} - Học kỳ ${semester.name}";

            final router = AppRouter(context);
            return ListTile(
              title: Text(title),
              subtitle: Text(subtitle),
              trailing: Icon(Symbols.chevron_forward),
              onTap: () => router.toCourseClassDetails(courseClass.id),
            );
          },
          separatorBuilder: (context, i) => Divider(),
          itemCount: resultList.length,
        );
    }
  }
}

class _StudentSearchBar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Tìm sinh viên",
      ),
      initialValue: ref.read(searchTextProvider),
      onFieldSubmitted: (value) {
        final notifier = ref.read(searchTextProvider.notifier);
        if (value.isEmpty) {
          notifier.clearState();
        } else {
          notifier.setState(value);
        }
      },
    );
  }
}
