// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:checkin_tool/shared/context.dart';
import 'package:checkin_tool/shared/dialogs.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;
import 'package:file_picker/file_picker.dart';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as pp;

import '../../../core/database_service.dart';
import '../../../core/preference_service.dart';
import 'package:riverpod/riverpod.dart';

final databaseSetupLogicProvider = Provider(DatabaseSetupLogic.new);

const platform = MethodChannel('com.ndgnuh.attendance_tool/storage');

Future<String> getSdcardPathAndroid() async {
  return await platform.invokeMethod('getStorageRoot');
}

Future<Directory> guessSdcardDirectory() async {
  /// Something like `/storage/emulated/0/Android/data/com.example.checkin_tool/files/down`
  Directory? sdcard =
      (await pp.getDownloadsDirectory()) ??
      (await pp.getExternalStorageDirectory());

  assert(sdcard != null, "Cannot find sdcard");

  while (path.basename(sdcard!.path) != "Android") {
    if (sdcard.parent == sdcard) {
      return sdcard;
    }

    sdcard = sdcard.parent;
  }

  return sdcard.parent;
}

class DatabaseSetupLogic {
  final Ref ref;

  const DatabaseSetupLogic(this.ref);

  Future<void> pickExistingDatabase() async {
    final Directory? rootDirectory;
    if (Platform.isAndroid) {
      rootDirectory = Directory(await getSdcardPathAndroid());
    } else {
      final rootDirectoryPath = await FilePicker.platform.getDirectoryPath(
        dialogTitle: "Chọn thư mục lưu CSDL",
      );
      if (rootDirectoryPath == null) return;
      rootDirectory = Directory(rootDirectoryPath);
    }

    final databasePath = await FilesystemPicker.openDialog(
      context: navigationKey.currentContext!,
      title: "Chọn CSDL",
      pickText: 'Chọn cơ sở dữ liệu',
      fsType: FilesystemType.file,
      rootDirectory: rootDirectory,
      fileTileSelectMode: FileTileSelectMode.wholeTile,
    );

    if (databasePath != null) {
      ref.read(appDatabasePathProvider.notifier).set(databasePath);
    }
  }

  Future<void> createNewDatabase() async {
    /// Get output file
    final directory = await FilePicker.platform.getDirectoryPath(
      dialogTitle: "Chọn thư mục lưu",
    );
    if (directory == null) return;
    final outputPath = path.join(directory, "attendance_db.sqlite");
    final outputFile = File(outputPath);

    /// Check if file exists and prompt for overwrite
    final bool ok;
    if (await outputFile.exists()) {
      ok = await showConfirmationDialog(
        titleText: "File tồn tại, ghi đè?",
      );
    } else {
      ok = true;
    }

    if (ok) {
      /// Save the output db
      final dbBytes = await AppDatabase.createTemporaryDatabase();
      await outputFile.writeAsBytes(dbBytes);

      /// Save the database path preference
      ref.read(appDatabasePathProvider.notifier).set(outputPath);
    }
  }
}
