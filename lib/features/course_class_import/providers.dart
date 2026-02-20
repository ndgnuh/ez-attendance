import 'package:riverpod/riverpod.dart';

import '../../core/database_service.dart';
import './data_model.dart';

class ImportDataNotifier extends Notifier<ImportData?> {
  @override
  ImportData? build() => null;
  void set(ImportData data) => state = data;
  void clear() => state = null;

  static final provider = NotifierProvider(ImportDataNotifier.new);
  static final instance = provider.notifier;
}

class SemesterNotifier extends Notifier<SemesterData?> {
  @override
  build() => null;
  void set(SemesterData data) => state = data;
  void clear() => state = null;

  static final provider = NotifierProvider(SemesterNotifier.new);
  static final instance = provider.notifier;
}
