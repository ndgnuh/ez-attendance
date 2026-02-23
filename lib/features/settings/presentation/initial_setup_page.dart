import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/preference_service.dart';
import '../domain/database_setup.dart';
import 'widgets/storage_permission_tile.dart';

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
                    StoragePermissionTile(),
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
    bool enabled = true;
    // enabled &= appStoragePathAsync.when(
    //   data: (path) => path != null,
    //   loading: () => false,
    //   error: (e, st) => false,
    // );

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

  void showOptions(BuildContext context, WidgetRef ref) {
    final logic = ref.read(databaseSetupLogicProvider);
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          children: [
            ListTile(
              title: const Text('Chọn cơ sở dữ liệu hiện có'),
              onTap: () {
                Navigator.of(context).pop();
                logic.pickExistingDatabase();
              },
            ),
            ListTile(
              title: const Text('Tạo cơ sở dữ liệu mới'),
              onTap: () {
                Navigator.of(context).pop();
                logic.createNewDatabase();
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
