/// Provides `*Buidler` widgets that consumes ID
/// of database items and pass it to a builder.
library;

import 'package:checkin_tool/core/database_service.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/riverpod.dart';

Stream<StudentData?> _queryStudent({
  required final Ref ref,
  required final String id,
  required final bool notNull,
}) async* {
  final db = await ref.watch(databaseProvider.future);
  final stmt = db.select(db.student);
  stmt.where((s) => s.id.equals(id));
  if (notNull) {
    yield* stmt.watchSingle();
  } else {
    yield* stmt.watchSingleOrNull();
  }
}

/// StreamProvider that returns [StudentData] by ID, can be [null]
final studentProvider = StreamProvider.family(
  (ref, String id) => _queryStudent(ref: ref, id: id, notNull: false),
);

/// StreamProvider that returns [StudentData] by ID, can not be [null]
/// Will raise error if the student ID does not exist.
final requireStudentProvider = StreamProvider.family(
  (ref, String id) => _queryStudent(ref: ref, id: id, notNull: true),
);

/// A widget tha treceive student ID and a builder function.
/// The builder funciton builds the final widget from actual student data.
class StudentConsumer extends ConsumerWidget {
  /// The unique key corresponding to the targeted student record.
  final String id;
  final Widget Function(BuildContext context, StudentData? data) builder;
  final Widget Function(BuildContext, Object, StackTrace)? errorBuilder;
  final WidgetBuilder? loadingBuilder;

  static Widget _errorBuilder(
    BuildContext context,
    Object error,
    StackTrace stackTrace,
  ) {
    return Text("Lỗi khi tải sinh viên");
  }

  /// Creates a [StudentConsumer] wrapper instance.
  ///
  /// * [id] identifies the targeted student record.
  /// * [builder] builds the content UI once data arrives.
  /// * [loadingBuilder] overrides the default horizontal loader behavior.
  /// * [errorBuilder] overrides the default error text renderer.
  const StudentConsumer({
    super.key,
    required this.builder,
    required this.id,
    this.loadingBuilder,
    this.errorBuilder = _errorBuilder,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncState = ref.watch(studentProvider(id));
    switch (asyncState) {
      case AsyncLoading():
        if (loadingBuilder != null) {
          return loadingBuilder!(context);
        } else {
          return LinearProgressIndicator();
        }
      case AsyncError(:final error, :final stackTrace):
        final requireErrorBuilder = errorBuilder ?? _errorBuilder;
        return requireErrorBuilder(context, error, stackTrace);
      case AsyncData(:final value):
        return builder(context, value);
    }
  }
}
