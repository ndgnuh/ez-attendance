import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import './database/database.dart';
import './preference_service.dart';

export './database/database.dart';

final databaseProvider = FutureProvider<AppDatabase>((ref) async {
  final dbPath = await ref.watch(appDatabasePathProvider.future);
  print("Database path: $dbPath");
  if (dbPath == null) {
    throw Exception('Database path is not set');
  }

  final perm = await ref.watch(storagePermissionProvider.future);
  if (!perm.isGranted) {
    throw Exception("Không đọc được CSDL");
  }

  final db = AppDatabase.openLocalDatabase(dbPath);
  return db;
});

extension DatabaseService on BuildContext {
  Future<AppDatabase> get appDatabase async {
    final ref = ProviderScope.containerOf(this);
    return await ref.read(databaseProvider.future);
  }
}
