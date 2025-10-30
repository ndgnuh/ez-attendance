import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../database/database.dart';
import '../providers/local_preferences.dart';

class InitialSetupPage extends StatelessWidget {
  const InitialSetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Initial Setup'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(context.gutterLarge),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _AppStoragePicker(),
              Divider(),
              _DatabasePathPicker(),
              Divider(),
              _DarkModeSwitch(),
              Divider(),
              _FinishSetupButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppStoragePicker extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStoragePathAsync = ref.watch(appStoragePathProvider);
    final value = appStoragePathAsync.when(
      data: (path) => path,
      loading: () => null,
      error: (e, st) => null,
    );
    return ListTile(
      title: const Text('Thư mục lưu trữ dữ liệu'),
      subtitle: Text(value ?? 'Chưa chọn'),
      trailing: Icon(Symbols.folder_open),
      onTap: () async {
        final directory = await FilePicker.platform.getDirectoryPath(
          dialogTitle: 'Chọn thư mục lưu trữ dữ liệu',
        );
        if (directory != null) {
          ref.read(appStoragePathProvider.notifier).set(directory);
        }
      },
    );
  }
}

class _DatabasePathPicker extends ConsumerWidget {
  Future<void> pickExistingDatabase(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final initialDirectory = await ref.watch(appStoragePathProvider.future);

    final colorScheme = ColorScheme.of(context);

    final databasePath = await FilesystemPicker.open(
      context: context,
      rootDirectory: Directory(initialDirectory as String),
      pickText: 'Chọn cơ sở dữ liệu',
    );

    if (databasePath != null) {
      ref.read(appDatabasePathProvider.notifier).set(databasePath);
    }
  }

  Future<void> createNewDatabase(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final dbBytes = await AppDatabase.createTemporaryDatabase();
    final initialDirectory = await ref.watch(appStoragePathProvider.future);
    final savedPath = await FilePicker.platform.saveFile(
      dialogTitle: 'Lưu cơ sở dữ liệu mới',
      fileName: 'attendance_database.sqlite',
      initialDirectory: initialDirectory as String,
      bytes: dbBytes,
    );
    switch (savedPath) {
      case String path:
        ref.read(appDatabasePathProvider.notifier).set(path);
      case null:
      // User cancelled the save dialog
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStoragePathAsync = ref.watch(appStoragePathProvider);
    final enabled = appStoragePathAsync.when(
      data: (path) => path != null,
      loading: () => false,
      error: (e, st) => false,
    );

    final value = ref
        .watch(appDatabasePathProvider)
        .when(
          data: (path) => path,
          loading: () => null,
          error: (e, st) => null,
        );

    return ListTile(
      title: const Text('Cơ sở dữ liệu'),
      subtitle: Text(value ?? 'Chọn hoặc tạo mới'),
      trailing: Icon(Symbols.file_open),
      enabled: enabled,
      onTap: () => showOptions(context, ref),
    );
  }

  void showOptions(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          children: [
            ListTile(
              title: const Text('Chọn cơ sở dữ liệu hiện có'),
              onTap: () {
                Navigator.of(context).pop();
                pickExistingDatabase(context, ref);
              },
            ),
            ListTile(
              title: const Text('Tạo cơ sở dữ liệu mới'),
              onTap: () {
                Navigator.of(context).pop();
                createNewDatabase(context, ref);
              },
            ),
          ],
        );
      },
    );
  }
}

class _DarkModeSwitch extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useDarkModeAsync = ref.watch(useDarkModeProvider);
    final useDarkMode = useDarkModeAsync.when(
      data: (useDarkMode) => useDarkMode ?? false,
      loading: () => false,
      error: (e, st) => false,
    );

    return SwitchListTile(
      title: const Text('Sử dụng giao diện tối'),
      value: useDarkMode,
      onChanged: (value) => ref.read(useDarkModeProvider.notifier).set(value),
    );
  }
}

class _FinishSetupButton extends ConsumerWidget {
  const _FinishSetupButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var finished = true;

    finished &= ref
        .watch(appStoragePathProvider)
        .maybeWhen(
          data: (path) => path != null,
          orElse: () => false,
        );

    finished &= ref
        .watch(appDatabasePathProvider)
        .maybeWhen(
          data: (path) => path != null,
          orElse: () => false,
        );

    return ListTile(
      title: const Text('Hoàn tất thiết lập'),
      trailing: Icon(
        Symbols.check_circle,
        color: finished ? Colors.green : Colors.grey,
      ),
      enabled: finished,
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              finished
                  ? 'Thiết lập hoàn tất! Chuyển đến trang chủ...'
                  : 'Vui lòng hoàn tất thiết lập trước khi tiếp tục.',
            ),
          ),
        );
      },
    );
  }
}
