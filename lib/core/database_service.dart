import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../shared/providers/local_preferences.dart';
import './database/database.dart';

export './database/database.dart';

final databaseProvider = FutureProvider<AppDatabase>((ref) async {
  final dbPathAsync = await ref.watch(appDatabasePathProvider.future);
  if (dbPathAsync == null) {
    throw Exception('Database path is not set');
  }

  final db = await ref.watch(maybeDatabaseProvider.future);
  assert(db != null, 'Failed to open database at $dbPathAsync');
  return db!;
});

final maybeDatabaseProvider = FutureProvider<AppDatabase?>((ref) async {
  final dbPathAsync = await ref.watch(appDatabasePathProvider.future);
  if (dbPathAsync == null) {
    return null;
  } else {
    try {
      return AppDatabase.openLocalDatabase(dbPathAsync);
    } catch (e) {
      return null;
    }
  }
});

extension DatabaseService on BuildContext {
  Future<AppDatabase> get appDatabase async {
    final ref = ProviderScope.containerOf(this);
    return await ref.read(databaseProvider.future);
  }
}
