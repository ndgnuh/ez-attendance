import 'package:checkin_tool/features/course_class_management/presentation/widgets/export_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../core/router.dart';
import '../../../design.dart';
import '../domain/dao.dart';
import '../domain/models.dart';

class CourseClassDeleteButton extends StatelessWidget {
  final Function(BuildContext, VoidCallback) builder;
  final int courseClassId;

  const CourseClassDeleteButton({
    super.key,
    required this.builder,
    required this.courseClassId,
  });

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    callback() async {
      // Last confirmation
      final ok = await showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text("Xóa lớp?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text("Hủy"),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: Text(
                    "Xóa",
                    style: TextStyle(color: Colors.redAccent),
                  ),
                ),
              ],
            ),
      );

      // User does not confirm
      if (ok != true) {
        return;
      }

      final ref = ProviderScope.containerOf(context);
      final service = await ref.read(
        CourseClassManagementService.provider.future,
      );
      await service.deleteCourseClass(courseClassId);
      navigator.pop();
    }

    return builder(context, callback);
  }
}

class CourseClassDetailsPage extends StatelessWidget {
  static final tabs = [
    const Tab(text: 'Thông tin chung'),
    const Tab(text: 'Danh sách lớp'),
    const Tab(text: 'Buổi điểm danh'),
  ];
  final int id;

  const CourseClassDetailsPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin lớp'),
      ),
      body: _GeneralInfoTab(id: id),
      // body: TabBarView(
      //   children: [
      //     _GeneralInfoTab(id: id),
      //     _ClassStudentsTab(id: id),
      //     _GeneralInfoTab(id: id),
      //   ],
      // ),
    );
  }
}

class _ClassStudentsTab extends ConsumerWidget {
  final int id;
  const _ClassStudentsTab({required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.all(context.gutter),
      child: Column(
        children: [],
      ),
    );
  }
}

class _GeneralInfoTab extends ConsumerWidget {
  final int id;
  const _GeneralInfoTab({required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modelAsync = ref.watch(
      CourseClassViewModel.provider(id),
    );
    switch (modelAsync) {
      case AsyncLoading():
        return const Center(child: CircularProgressIndicator());
      case AsyncError(:final error, :final stackTrace):
        return Center(child: ErrorWidget(error));
      default:
    }

    final model = modelAsync.value;
    final course = model?.course;
    final semester = model?.semester;
    final courseClass = model?.courseClass;

    final router = AppRouter(context);

    final generalInfo = [
      ListTile(
        title: Text("Học phần"),
        subtitle: Text('${course?.id} - ${course?.name}'),
      ),
      ListTile(
        title: Text("Học kỳ"),
        subtitle: Text('${semester?.name}'),
      ),
      ListTile(
        title: Text("Danh sách lớp"),
        subtitle: Text("Tới trang danh sách lớp"),
        trailing: Icon(Symbols.chevron_forward),
        onTap: () => router.toCourseClassStudentList(id),
      ),
      ListTile(
        title: Text("Điểm danh"),
        subtitle: Text("Danh sách buổi điểm danh"),
        trailing: Icon(Symbols.chevron_forward),
        onTap: () => router.toAttendanceSessionListPage(id),
      ),
    ];

    final exportZone = [
      ExportClassAttendanceButton(courseClassId: id),
    ];

    final scheduleInfo = [
      ListTile(
        title: Text("Phòng học"),
        subtitle: Text('${courseClass?.location}'),
      ),
      ListTile(
        title: Text("Ngày học"),
        subtitle: Text('${courseClass?.dayOfWeek}'),
      ),
      ListTile(
        title: Text("Tiết bắt đầu"),
        subtitle: Text('${courseClass?.fromPeriod}'),
      ),
      ListTile(
        title: Text("Tiết kết thúc"),
        subtitle: Text('${courseClass?.toPeriod}'),
      ),
    ];

    final dangerZone = [
      CourseClassDeleteButton(
        courseClassId: id,
        builder: (context, onPress) {
          return ListTile(
            title: Text("Xóa lớp", style: TextStyle(color: Colors.red)),
            onTap: onPress,
          );
        },
      ),
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(context.gutter),
      child: Column(
        spacing: context.gutter,
        children: [
          CardSection(
            title: "Thông tin chung",
            children: generalInfo,
          ),
          CardSection(
            title: "Ngoại vi",
            children: exportZone,
          ),
          CardSection(
            title: "Vùng nguy hiểm",
            children: dangerZone,
          ),
        ],
      ),
    );
  }
}
