import 'dart:async';
import 'dart:io';

import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';

final readyProvider = FutureProvider<bool>((ref) async {
  final appStoragePath = await ref.watch(appStoragePathProvider.future);
  if (appStoragePath == null) {
    return false;
  }

  final databasePath = await ref.watch(appDatabasePathProvider.future);
  if (databasePath == null) {
    return false;
  }

  final permissionStatus = await ref.watch(storagePermissionProvider.future);
  if (permissionStatus != PermissionStatus.granted) {
    return false;
  }

  return true;
});

final appStoragePathProvider = AsyncNotifierProvider(
  () => StringPreferenceNotifier('app_storage_path'),
);

final appDatabasePathProvider = AsyncNotifierProvider(
  () => StringPreferenceNotifier('app_database_path'),
);

final useDarkModeProvider = AsyncNotifierProvider(
  () => BoolPreferenceNotifier('use_dark_mode', false),
);

final storagePermissionProvider = AsyncNotifierProvider(
  () => StoragePermissionNotifier(),
);

sealed class PreferenceNotifier<T> extends AsyncNotifier<T?> {
  final String name;
  final T? initialValue;
  PreferenceNotifier(this.name, [this.initialValue]);

  T? getValue(SharedPreferences prefs);
  void setValue(SharedPreferences prefs, T value);

  @override
  FutureOr<T?> build() async {
    final prefs = await SharedPreferences.getInstance();
    return getValue(prefs);
  }

  void set(T value) async {
    final prefs = await SharedPreferences.getInstance();
    setValue(prefs, value);
    state = AsyncData(value);
  }
}

class BoolPreferenceNotifier extends PreferenceNotifier<bool> {
  BoolPreferenceNotifier(super.name, [super.initialValue]);

  @override
  bool? getValue(SharedPreferences prefs) {
    return prefs.getBool(name) ?? initialValue;
  }

  @override
  void setValue(SharedPreferences prefs, bool value) {
    prefs.setBool(name, value);
  }
}

class StringPreferenceNotifier extends PreferenceNotifier<String> {
  StringPreferenceNotifier(super.name, [super.initialValue]);

  @override
  String? getValue(SharedPreferences prefs) {
    return prefs.getString(name) ?? initialValue;
  }

  @override
  void setValue(SharedPreferences prefs, String value) {
    prefs.setString(name, value);
  }
}

class StoragePermissionNotifier extends AsyncNotifier<PermissionStatus> {
  StoragePermissionNotifier();

  @override
  FutureOr<PermissionStatus> build() async {
    if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
      return PermissionStatus.granted;
    }
    final statusStorage = await Permission.storage.status;
    if (statusStorage.isGranted) {
      return statusStorage;
    }
    final status = await Permission.manageExternalStorage.status;
    return status;
  }

  Future<void> request() async {
    final statusStorage = await Permission.storage.request();
    if (statusStorage.isGranted) {
      ref.invalidateSelf();
      return;
    }

    await Permission.manageExternalStorage.request();
    ref.invalidateSelf();
  }
}
