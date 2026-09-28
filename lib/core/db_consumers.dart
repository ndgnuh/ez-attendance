/// Library that provides consumer widgets for some database types
library;

import 'package:riverpod/misc.dart';

import 'database_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class DatabaseConsumer extends ConsumerWidget {
  final Widget Function(BuildContext, AppDatabase) builder;

  const DatabaseConsumer({super.key, required this.builder});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dbAsync = ref.watch(databaseProvider);
    switch (dbAsync) {
      case AsyncLoading():
        return LinearProgressIndicator();
      case AsyncError(:final error, :final stackTrace):
        return Text("Error $error\n$stackTrace");
      case AsyncData(value: final db):
        return builder(context, db);
    }
  }
}

final sessionByIdProvider = StreamProvider.family((ref, int sessionId) async* {
  final db = await ref.watch(databaseProvider.future);
  final stmt = db.select(db.session);
  stmt.where((r) => r.id.equals(sessionId));
  yield* stmt.watchSingle();
});

final classByIdProvider = StreamProvider.family((ref, int classId) async* {
  final db = await ref.watch(databaseProvider.future);
  final stmt = db.select(db.courseClass);
  stmt.where((r) => r.id.equals(classId));
  yield* stmt.watchSingle();
});

class CourseClassConsumer extends ByIdConsumer<CourseClassData, int> {
  const CourseClassConsumer({
    super.key,
    required super.id,
    required super.builder,
  });

  @override
  get providerFamily => classByIdProvider;
}

abstract class ByIdConsumer<T, Id> extends ConsumerWidget {
  final Id id;
  final Widget Function(BuildContext, T) builder;

  StreamProviderFamily<T, Id> get providerFamily;

  const ByIdConsumer({
    super.key,
    required this.id,
    required this.builder,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dbAsync = ref.watch(providerFamily(id));
    switch (dbAsync) {
      case AsyncLoading():
        return LinearProgressIndicator();
      case AsyncError(:final error, :final stackTrace):
        return Text("Error $error\n$stackTrace");
      case AsyncData(:final value):
        return builder(context, value);
    }
  }
}

class SessionConsumer extends ConsumerWidget {
  final int sessionId;
  final Widget Function(BuildContext, SessionData) builder;

  const SessionConsumer({
    super.key,
    required this.sessionId,
    required this.builder,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dbAsync = ref.watch(sessionByIdProvider(sessionId));
    switch (dbAsync) {
      case AsyncLoading():
        return LinearProgressIndicator();
      case AsyncError(:final error, :final stackTrace):
        return Text("Error $error\n$stackTrace");
      case AsyncData(value: final sesssion):
        return builder(context, sesssion);
    }
  }
}
