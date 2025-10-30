import 'package:riverpod/riverpod.dart';

import '../database.dart';

final databaseProvider = NotifierProvider(DatabaseNotifier.new);

class DatabaseNotifier extends Notifier<AppDatabase> {
  @override
  AppDatabase build() {
    return AppDatabase();
  }
}
