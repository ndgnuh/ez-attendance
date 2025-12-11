import 'package:riverpod/riverpod.dart';

import '../database/database.dart';
import './local_preferences.dart';

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

final databaseProvider = FutureProvider<AppDatabase>((ref) async {
  final dbPathAsync = await ref.watch(appDatabasePathProvider.future);
  if (dbPathAsync == null) {
    throw Exception('Database path is not set');
  }

  final db = await ref.watch(maybeDatabaseProvider.future);
  assert(db != null, 'Failed to open database at $dbPathAsync');
  return db!;
});
