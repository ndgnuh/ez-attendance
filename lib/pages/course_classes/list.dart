import 'dart:typed_data';

import 'package:checkin_tool/database/database.dart';
import 'package:checkin_tool/design.dart';
import 'package:checkin_tool/widgets/error_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

import '../../widgets/bottom_navigation.dart';
import '../pages.dart';

import '../../view_models.dart';
import '../../providers.dart';

class SemesterPicker extends ConsumerWidget {
  const SemesterPicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text("");
  }
}

class CourseClassListPage extends StatelessWidget {
  static const routeName = '/';
  const CourseClassListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        bottomNavigationBar: const MyBottomNavigationBar(),
        appBar: ConstrainedAppBar(
          withTabs: true,
          child: AppBar(
            title: const Text('Danh sách lớp'),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Lớp học'),
                Tab(text: 'Cài đặt'),
              ],
            ),
          ),
        ),
        body: ConstrainedBody(
          child: TabBarView(
            children: [
              _CourseClassListTabView(),
              _SettingsView(),
            ],
          ),
          // CourseClassListView(classes: []),
        ),
      ),
    );
  }
}

class _CourseClassListTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.gutter),
      child: Column(
        spacing: context.gutter,
        children: [
          Expanded(child: _CourseClassListView()),
          DropdownMenu(
            expandedInsets: EdgeInsets.zero,
            label: Text('Học kỳ'),
            dropdownMenuEntries: [],
          ),
        ],
      ),
    );
  }
}

class _SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);

    final buttons = [
      ListTile(
        title: Text('Tạo lớp'),
        onTap: () {
          navigator.pushNamed(RouteNames.courseClassCreate);
        },
      ),
    ];
    return Padding(
      padding: EdgeInsets.all(context.gutter),
      child: ListView.separated(
        itemBuilder: (context, index) => buttons[index],
        itemCount: buttons.length,
        separatorBuilder: (context, index) => Divider(),
      ),
    );
  }
}

class _CourseClassListView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final idsAsync = ref.watch(courseClassIdsProvider);
    switch (idsAsync) {
      case AsyncLoading():
        return Center(child: CircularProgressIndicator());
      case AsyncError(:final error, :final stackTrace):
        return ErrorView(error: error, stackTrace: stackTrace);
      case AsyncData():
        break;
    }

    final ids = idsAsync.value;
    if (ids.isEmpty) {
      return Center(
        child: Text('Chưa có lớp học nào'),
      );
    }

    return ListView.separated(
      itemCount: ids.length,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (context, index) {
        final id = ids[index];
        return _CourseClassListItem(id: id);
      },
    );
  }
}

class _CourseClassListItem extends ConsumerWidget {
  final int id;
  const _CourseClassListItem({required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modelAsync = ref.watch(
      CourseClassViewModel.byIdProvider(id as CourseClassId),
    );
    switch (modelAsync) {
      case AsyncLoading():
        return ListTile(
          title: Text('Đang tải...'),
        );
      case AsyncError(:final error, :final stackTrace):
        return ErrorView(error: error, stackTrace: stackTrace);
      case AsyncData():
        break;
    }

    final model = modelAsync.value;
    final courseClass = model.courseClass;
    final course = model.course;
    final semester = model.semester;

    final title = 'Lớp ${courseClass.classCode}';
    final subtitle = [
      'Mã học phần: ${course.id}',
      'Học kỳ: ${semester.name}',
    ].join('\n');
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: () {
        Navigator.of(context).pushNamed(
          RouteNames.courseClassDetail,
          arguments: courseClass.id,
        );
      },
    );
  }
}
