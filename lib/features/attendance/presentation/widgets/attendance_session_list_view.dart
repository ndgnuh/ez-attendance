/// ListView of the attendance sessions of a given course class.
/// Export [AttendanceSessionListView] widget.
library;

import 'package:checkin_tool/core/database_service.dart';
import 'package:drift/drift.dart' show Value;
import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/router.dart';
import '../../domain/dao.dart';
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
        final scheme = ColorScheme.of(context);

        final iconData = switch (session.ignoreAttendance) {
          true => Symbols.person_off,
          false => Symbols.person_check,
        };
        final iconColor = switch (session.ignoreAttendance) {
          true => scheme.error,
          false => scheme.primary,
        };
        final leading = Icon(iconData, color: iconColor);

        final prefix = session.isHomework ? "BTVN" : "Buổi học";
        final title = "$prefix ${_dateFormat.format(session.startTime)}";
        final startTime = session.startTime;
        final endTime = session.endTime;

        final timeFormat = DateFormat("HH:mm");
        final subtitle =
            "Thời gian ${timeFormat.format(startTime)} - ${timeFormat.format(endTime)}";

        return ListTile(
          leading: leading,
          title: Text(title),
          subtitle: Text(subtitle),
          trailing: Icon(Symbols.chevron_forward),
          onTap: () => router.toAttendanceSessionStudentListPage(session.id),
          onLongPress: () => showModalBottomSheet(
            context: context,
            builder: (_) => _SessionOptionsSheet(
              courseClassId: courseClassId,
              sessionId: session.id,
            ),
          ),
        );
      },
    );
  }
}

/// Modal to edit the attendance and type of a session.
/// Watches the session list so the switches follow the database.
class _SessionOptionsSheet extends ConsumerWidget {
  final int courseClassId;
  final int sessionId;

  const _SessionOptionsSheet({
    required this.courseClassId,
    required this.sessionId,
  });

  Future<void> _update(WidgetRef ref, SessionCompanion companion) async {
    final db = await ref.read(databaseProvider.future);
    await db.updateSession(sessionId, companion);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionList = ref
        .watch(attendanceSessionListProvider(courseClassId))
        .value;
    final session = sessionList?.where((s) => s.id == sessionId).firstOrNull;
    if (session == null) return SizedBox.shrink();

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SwitchListTile(
            secondary: Icon(Symbols.person_check),
            title: Text("Điểm danh"),
            value: !session.ignoreAttendance && !session.isHomework,
            onChanged: session.isHomework
                ? null
                : (value) =>
                    _update(ref, SessionCompanion(ignoreAttendance: Value(!value))),
          ),
          SwitchListTile(
            secondary: Icon(Symbols.assignment),
            title: Text("Bài tập về nhà (BTVN)"),
            value: session.isHomework,
            onChanged: (value) =>
                _update(ref, SessionCompanion(isHomework: Value(value))),
          ),
        ],
      ),
    );
  }
}
