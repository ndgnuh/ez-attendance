import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';

class SemesterPicker extends ConsumerWidget {
  const SemesterPicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final semestersAsync = ref.watch(allSemesterProviders);
    switch (semestersAsync) {
      case AsyncLoading():
        return LinearProgressIndicator();
      case AsyncError(:final error, :final stackTrace):
        if (kDebugMode) {
          print(stackTrace);
        }
        return Text(error.toString());
      default:
    }

    final semesters = semestersAsync.value!;
    return DropdownMenu(
      expandedInsets: EdgeInsets.zero,
      label: Text("Học kỳ"),
      dropdownMenuEntries: [
        DropdownMenuEntry(label: "Tất cả", value: null),
        for (final semester in semesters)
          DropdownMenuEntry(label: semester.name, value: semester),
      ],
      onSelected: (mSemester) {
        final notifier = ref.read(SemesterNotifier.instance);
        switch (mSemester) {
          case null:
            notifier.clear();
          default:
            notifier.set(mSemester);
        }
      },
    );
  }
}
