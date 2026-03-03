/// ListView of the attendance sessions of a given course class.
/// Export [AttendanceSessionListView] widget.
library;

import 'package:checkin_tool/core/database_service.dart';
import 'package:drift/drift.dart' show Value;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/router.dart';
import '../providers.dart';

final _dateFormat = DateFormat("dd/MM/yyyy");

class AttendanceSessionListView extends ConsumerWidget {
  final int courseClassId;

  const AttendanceSessionListView({
    super.key,
    required this.courseClassId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionListAsync = ref.watch(
      attendanceSessionListProvider(courseClassId),
    );
    switch (sessionListAsync) {
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

    final sessionList = sessionListAsync.value!;
    if (sessionList.isEmpty) {
      return Center(
        child: Text("không có buổi điểm danh nào"),
      );
    }
    return ListView.separated(
      separatorBuilder: (context, _) => Divider(),
      itemCount: sessionList.length,
      itemBuilder: (context, idx) {
        final router = AppRouter(context);
        final session = sessionList[idx];
        if (session.ignoreAttendance) {}
        final titleAst = session.ignoreAttendance ? " [*]" : "";
        final title =
            "Buổi học ${_dateFormat.format(session.startTime)} $titleAst";
        final startTime = session.startTime;
        final endTime = session.endTime;

        final timeFormat = DateFormat("HH:mm");
        final subtitle =
            "Thời gian ${timeFormat.format(startTime)} - ${timeFormat.format(endTime)}";

        return ListTile(
          title: Text(title),
          subtitle: Text(subtitle),
          trailing: Icon(Symbols.chevron_forward),
          onTap: () => router.toAttendanceSessionStudentListPage(session.id),
          onLongPress: () async {
            // TODO: move to DAO layer.
            final db = await ref.watch(databaseProvider.future);
            final stmt = db.update(db.session);
            stmt.where((r) => r.id.equals(session.id));
            stmt.write(
              SessionCompanion(
                ignoreAttendance: Value(!session.ignoreAttendance),
              ),
            );
          },
        );
      },
    );
  }
}
