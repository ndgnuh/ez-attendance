import 'package:checkin_tool/core/router.dart';
import 'package:checkin_tool/design.dart';
import 'package:checkin_tool/shared/widgets/error_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../view_models.dart';
// import '../../shared/providers.dart';

import './providers.dart';

class SemesterPicker extends ConsumerWidget {
  const SemesterPicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final semestersAsync = ref.watch(allSemesterProviders);
    switch (semestersAsync) {
      case AsyncLoading():
        return LinearProgressIndicator();
      case AsyncError(:final error, :final stackTrace):
        if (kDebugMode) {
          print(stackTrace);
        }
        return Text(error.toString());
      default:
    }

    final semesters = semestersAsync.value!;
    return DropdownMenu(
      expandedInsets: EdgeInsets.zero,
      label: Text("Học kỳ"),
      dropdownMenuEntries: [
        DropdownMenuEntry(label: "Tất cả", value: null),
        for (final semester in semesters)
          DropdownMenuEntry(label: semester.name, value: semester),
      ],
      onSelected: (mSemester) {
        final notifier = ref.read(SemesterNotifier.instance);
        switch (mSemester) {
          case null:
            notifier.clear();
          default:
            notifier.set(mSemester);
        }
      },
    );
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
        appBar: AppBar(
          title: const Text('Danh sách lớp'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Lớp học'),
              Tab(text: 'Cài đặt'),
            ],
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
          SemesterPicker(),
        ],
      ),
    );
  }
}

class _SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);

    final router = AppRouter(context);
    final buttons = [
      ListTile(
        leading: Icon(Symbols.add_rounded),
        title: Text('Tạo lớp'),
        subtitle: Text('Tạo lớp học mới'),
        onTap: () => router.toCourseClassCreatePage(),
      ),

      ListTile(
        leading: Icon(Symbols.upload_file_rounded),
        title: Text('Nhập lớp từ file'),
        subtitle: Text('Nhập file xlsx'),
        onTap: () => router.toCourseClassImportPage(),
      ),
    ];

    final others = <Widget>[
      // Consumer(
      //   builder: (context, ref, _) {
      //     final darkModeAsync = ref.watch(useDarkModeProvider);
      //     final isDarkMode = darkModeAsync.when(
      //       data: (value) => value ?? false,
      //       loading: () => false,
      //       error: (e, st) => false,
      //     );
      //     return SwitchListTile(
      //       secondary: Icon(
      //         isDarkMode
      //             ? Symbols.dark_mode_rounded
      //             : Symbols.light_mode_rounded,
      //       ),
      //       title: Text('Chế độ tối'),
      //       subtitle: Text(
      //         'Đang sử dụng giao diện ${isDarkMode ? "tối" : "sáng"}',
      //       ),
      //       value: isDarkMode,
      //       onChanged: (value) {
      //         ref.read(useDarkModeProvider.notifier).set(value);
      //       },
      //     );
      //   },
      // ),
    ];

    return Padding(
      padding: EdgeInsets.all(context.gutter),
      child: Column(
        children: [
          CardSection(title: "Danh mục lớp", children: buttons),
          CardSection(title: "Khác", children: others),
        ],
      ),
    );
  }
}

class _CourseClassListView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final idsAsync = ref.watch(courseClassesProvider);
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
        return _CourseClassListItem(id: id.id);
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
      CourseClassViewModel.byIdProvider(id),
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
        context.router.toCourseClassDetails(courseClass.id);
      },
    );
  }
}
