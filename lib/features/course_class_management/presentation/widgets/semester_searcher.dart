import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/database_service.dart';
import '../providers.dart';

class SemesterSearcher extends ConsumerWidget {
  const SemesterSearcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(SemesterNotifier.instanceForImportPage);

    return SearchAnchor(
      viewHintText: "Tìm kiếm học kỳ",
      suggestionsBuilder: (context, controller) async {
        // Don't do anything on empty search
        final searchText = controller.text;
        if (searchText.isEmpty) {
          return [];
        }

        // Search for semester
        final ref = ProviderScope.containerOf(context);
        final db = await ref.read(databaseProvider.future);
        final semesters = await db.searchSemester(searchText: searchText).get();

        // Build options
        final options = <ListTile>[];
        for (final semester in semesters) {
          final option = ListTile(
            title: Text(semester.name),
            subtitle: Text("Học kỳ ${semester.name} [#${semester.id}]."),
            onTap: () {
              notifier.set(semester);
              controller.closeView(null);
            },
          );
          options.add(option);
        }

        // Null option (create new one)
        if (options.isEmpty) {
          options.add(
            ListTile(
              leading: Icon(Symbols.add),
              title: Text("Tạo mới"),
              subtitle: Text("Tạo học kỳ với tên '$searchText'"),
              onTap: () async {
                final semester = await db.createSemester(
                  semesterName: searchText,
                );
                notifier.set(semester);
                controller.closeView(null);
              },
            ),
          );
        }

        return options;
      },
      builder: (context, controller) => _SearchField(controller: controller),
    );
  }
}

class _SearchField extends ConsumerWidget {
  final SearchController controller;

  const _SearchField({required this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(SemesterNotifier.instanceForImportPage);
    final semester = ref.watch(SemesterNotifier.providerForImportPage);
    final clearButton = IconButton(
      onPressed: () => notifier.clear(),
      icon: Icon(Symbols.clear),
    );

    return TextFormField(
      readOnly: true,
      decoration: InputDecoration(
        labelText: "Chọn học kỳ",
        hintText: "Chưa chọn học kỳ",
        suffixIcon: switch (semester) {
          null => null,
          _ => clearButton,
        },
      ),
      controller: TextEditingController(text: semester?.name ?? ""),
      onTap: () {
        controller.clear();
        controller.openView();
      },
    );
  }
}
