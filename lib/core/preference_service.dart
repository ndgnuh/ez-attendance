import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:riverpod/riverpod.dart';

enum PreferenceKey {
  themeMode,
  defaultAttendanceMode,
  databasePath,
}

/// This service handles app preferences
class PreferenceService {
  // Singleton
  PreferenceService._init();
  static final PreferenceService _instance = PreferenceService._init();

  // Instance getter
  PreferenceService get instance => _instance;
  factory PreferenceService() {
    return _instance;
  }

  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  /// Get database path as nullable
  /// if null then the path needs to be setup
  Future<String?> getDatabasePath() async {
    return (await prefs).getString('app_database_path');
  }

  /// Same as [getDatabasePath], but ensure the path is not null
  /// only use this function in inner screens
  Future<String> requireDatabasePath() async {
    return (await getDatabasePath()) as String;
  }

  Future<bool> getDarkMode() async {
    return (await prefs).getBool('use_dark_mode') ?? false;
  }

  Future<bool> setDarkMode(bool value) async {
    return (await prefs).setBool('use_dark_mode', value);
  }

  Future<void> toggleDarkMode() async {
    final dm = await getDarkMode();
    setDarkMode(!dm);
  }

  Future<bool> getDefaultScanMode() async {
    return (await prefs).getBool('scan_mode_by_default') ?? false;
  }

  Future<bool> setDefaultScanMode(bool value) async {
    return (await prefs).setBool('scan_mode_by_default', value);
  }
}

class StoragePermissionNotifier extends AsyncNotifier<PermissionStatus> {
  @override
  FutureOr<PermissionStatus> build() async {
    if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
      return PermissionStatus.granted;
    }

    /// This is the permission for older android versions
    /// See docs of permission handler package
    final status1 = await Permission.storage.status;
    if (kDebugMode) {
      print(status1);
    }
    if (status1 == PermissionStatus.granted) {
      return status1;
    }

    /// on newer android version, this is the permission to
    /// implement, it has to be defined in the manifest
    final status2 = await Permission.manageExternalStorage.status;
    if (kDebugMode) {
      print(status2);
    }
    return status2;
  }

  Future<void> request() async {
    void onGranted() {
      ref.invalidateSelf();
    }

    await [
      Permission.storage.onGrantedCallback(onGranted),
      Permission.manageExternalStorage.onGrantedCallback(onGranted),
    ].request();
    ref.invalidateSelf();
  }
}

/// Provide if the app is ready
final readyProvider = FutureProvider<bool>((ref) async {
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
