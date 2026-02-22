import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/database_service.dart';
import '../../../../core/enums.dart';
import '../providers.dart';

class AttendanceCheckList extends ConsumerWidget {
  final int sessionId;

  const AttendanceCheckList({
    super.key,
    required this.sessionId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final attendanceListAsync = ref.watch(
      attendanceListProvider(sessionId),
    );

    // Handle loading and errors
    switch (attendanceListAsync) {
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
      default:
    }

    // Empty case
    final attendanceList = attendanceListAsync.value!;
    if (attendanceList.isEmpty) {
      return Center(
        child: Text("Không có bản ghi nào"),
      );
    }

    return ListView.separated(
      itemCount: attendanceList.length,
      separatorBuilder: (context, _) => Divider(),
      itemBuilder: (context, idx) {
        final (student, attendance) = attendanceList[idx];
        final title = "${student.id} - ${student.name}";
        final attendanceStatusLabel = attendance.attendanceStatus.label;
        final subtitle =
            "$attendanceStatusLabel. Đóng góp: ${attendance.numContributions}";
        return ListTile(
          title: Text(title),
          subtitle: Text(subtitle),
          trailing: Icon(Symbols.chevron_forward),
          onTap: () {
            showDialog(
              builder: (context) {
                return _Action(
                  student: student,
                  attendance: attendance,
                );
              },
              context: context,
            );
          },
        );
      },
    );
  }
}

class _Action extends StatelessWidget {
  final StudentData student;
  final AttendanceData attendance;

  const _Action({required this.student, required this.attendance});

  @override
  Widget build(BuildContext context) {
    final ref = ProviderScope.containerOf(context);
    final logic = ref.read(AttandanceUpdateLogic.provider(attendance));
    void pop(_) => Navigator.pop(context);
    return SimpleDialog(
      children: [
        ListTile(
          leading: Icon(Symbols.check_box),
          title: Text("Điểm danh"),
          onTap: () => logic.updateStatus(AttendanceStatus.present).then(pop),
        ),
        ListTile(
          leading: Icon(null),
          title: Text("Điểm danh (muộn)"),
          onTap: () => logic.updateStatus(AttendanceStatus.late).then(pop),
        ),
        ListTile(
          leading: Icon(Symbols.clear),
          title: Text("Vắng"),
          onTap: () => logic.updateStatus(AttendanceStatus.absent).then(pop),
        ),
        ListTile(
          leading: Icon(null),
          title: Text("Xin nghỉ"),
          onTap: () => logic.updateStatus(AttendanceStatus.excused).then(pop),
        ),
        Divider(),
        ListTile(
          leading: Icon(Symbols.plus_one),
          title: Text("Cộng điểm"),
          onTap: () => logic.changeScore(1).then(pop),
        ),
        ListTile(
          leading: Icon(null),
          title: Text("Trừ điểm"),
          onTap: () => logic.changeScore(-1).then(pop),
        ),
      ],
    );
  }
}
