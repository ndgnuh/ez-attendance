import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/database/database.dart';
import '../../../shared/providers.dart';

class InitialSetupPage extends StatelessWidget {
  const InitialSetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trang cài đặt'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(context.gutterLarge),
          child: Column(
            spacing: context.gutterLarge,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _StoragePermissionTile(),
                    Divider(),
                    _AppStoragePicker(),
                    Divider(),
                    _DatabasePathPicker(),
                    Divider(),
                    _DarkModeSwitch(),
                  ],
                ),
              ),
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

class _DatabasePathPicker extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStoragePathAsync = ref.watch(appStoragePathProvider);

    bool enabled = true;
    enabled &= appStoragePathAsync.when(
      data: (path) => path != null,
      loading: () => false,
      error: (e, st) => false,
    );

    enabled &= ref
        .watch(storagePermissionProvider)
        .when(
          data: (status) => status.isGranted,
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

  Future<void> pickExistingDatabase(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final initialDirectory = await ref.watch(appStoragePathProvider.future);

    final databasePath = await FilesystemPicker.open(
      context: context,
      rootDirectory: Directory(initialDirectory as String),
      pickText: 'Chọn cơ sở dữ liệu',
    );

    if (databasePath != null) {
      ref.read(appDatabasePathProvider.notifier).set(databasePath);
    }
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

    finished &= ref
        .watch(storagePermissionProvider)
        .maybeWhen(
          data: (status) => status.isGranted,
          orElse: () => false,
        );

    callback() {
      if (finished) {
        final navigator = Navigator.of(context);
        navigator.pushReplacementNamed('/');
        return;
      }

      final messenger = ScaffoldMessenger.of(context);
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            'Vui lòng hoàn tất thiết lập trước khi tiếp tục.',
          ),
        ),
      );
    }

    return FilledButton.icon(
      label: const Text('Hoàn tất thiết lập'),
      icon: Icon(Symbols.check_circle),
      onPressed: finished ? callback : null,
    );
  }
}

class _StoragePermissionTile extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storagePermissionAsync = ref.watch(storagePermissionProvider);
    final granted = storagePermissionAsync.when(
      data: (status) => status.isGranted,
      loading: () => false,
      error: (e, st) => false,
    );

    return ListTile(
      title: const Text('Quyền truy cập bộ nhớ'),
      subtitle: Text(granted ? 'Đã cấp quyền' : 'Chưa cấp quyền'),
      trailing: Icon(
        granted ? Symbols.check_circle : Symbols.error,
        color: granted ? Colors.green : Colors.red,
      ),
      onTap: () {
        ref.read(storagePermissionProvider.notifier).request();
      },
    );
  }
}
