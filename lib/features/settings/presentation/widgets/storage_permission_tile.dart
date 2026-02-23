import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/preference_service.dart';

class StoragePermissionTile extends ConsumerWidget {
  const StoragePermissionTile({super.key});

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
