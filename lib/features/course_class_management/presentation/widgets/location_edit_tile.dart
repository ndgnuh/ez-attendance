import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../shared/dialogs.dart';
import '../providers.dart';

/// Providers
final _locationProvider = StreamProvider.family(
  (ref, int courseClassId) async* {
    final repo = await ref.watch(courseClassRepositoryProvider.future);
    yield* repo.watchClassLocation(courseClassId);
  },
);

/// Show and edit the class room (location) of a class
class LocationEditTile extends ConsumerWidget {
  static const title = Text("Phòng học");
  final int courseClassId;

  const LocationEditTile({super.key, required this.courseClassId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = _locationProvider(courseClassId);
    final locationAsync = ref.watch(provider);
    switch (locationAsync) {
      case AsyncLoading():
        return ListTile(
          title: title,
          enabled: false,
          trailing: CircularProgressIndicator(),
        );
      case AsyncError(:final error, :final stackTrace):
        if (kDebugMode) {
          print(stackTrace);
        }
        return ListTile(
          title: title,
          subtitle: Text(error.toString()),
          trailing: Icon(Symbols.error),
          enabled: false,
        );
      case AsyncData(value: final location):
        return ListTile(
          title: title,
          subtitle: Text(location ?? "Chưa có"),
          onTap: () async {
            final newLocation = await showStringEditDialog(
              title: "Phòng học",
              initialValue: location ?? "",
            );
            if (null == newLocation) return;
            final repo = await ref.read(courseClassRepositoryProvider.future);
            await repo.updateClassLocation(
              courseClassId: courseClassId,
              newLocation: newLocation,
            );
          },
        );
    }
  }
}
