import 'package:checkin_tool/core/database/tables.dart';
import 'package:checkin_tool/core/router.dart';
import 'package:checkin_tool/features/attendance/domain/dao.dart';
import 'package:checkin_tool/features/attendance/domain/data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/widgets/error_view.dart';
import '../../domain/models.dart';
import '../providers.dart';

class CourseClassListView extends ConsumerWidget {
  const CourseClassListView({super.key});

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
    /// TOOD: merge
    final modelAsync = ref.watch(
      CourseClassViewModel.provider(id),
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

    /// TODO: move to a CourseClassItemViewModel
    final model = modelAsync.value;
    final courseClass = model.courseClass;
    final course = model.course;
    final semester = model.semester;

    final router = AppRouter(context);

    /// Start and end period
    final periodsAsync = ref.watch(courseClassPeriodsProvider(courseClass.id));
    final (startPeriod, endPeriod) =
        periodsAsync.whenOrNull(
          loading: () => (null, null),
          data: (value) => value ?? (null, null),
          error: (error, stackTrace) {
            print(stackTrace);
            return (null, null);
          },
        ) ??
        (null, null);

    final title = '${course.name} - ${course.id} - ${courseClass.classCode}';
    final time = switch ((
      courseClass.dayOfWeek,
      startPeriod,
      endPeriod,
    )) {
      (DayOfWeek day, PeriodData from, PeriodData to) =>
        "${day.shortName}, ${from.humanizeStartTime} – ${to.humanizeEndTime} (tiết ${from.id} - ${to.id})",
      (DayOfWeek day, PeriodData from, _) =>
        "${day.shortName}, ${from.humanizeStartTime} (tiết ${from.id})",
      (DayOfWeek day, _, _) => day.fullName,
      _ => "Chưa có thông tin",
    };

    final subtitle = [
      'Học kỳ: ${semester.name}',
      'Địa điểm: ${courseClass.location ?? "chưa có"}',
      'Thời gian: $time',
    ].join('\n');
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: () {
        router.toCourseClassDetails(courseClass.id);
      },
    );
  }
}
