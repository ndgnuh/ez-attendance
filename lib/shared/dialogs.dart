import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/database_service.dart';
import 'context.dart';
import 'repository.dart';

/// Show a dialog to confirm user actions
Future<bool> showConfirmationDialog({
  BuildContext? context,
  Widget? title,
  String? titleText,
  String? cancelText,
  String? confirmText,
}) async {
  final result = await showDialog(
    context: context ?? navigationKey.currentContext!,
    builder: (context) {
      return ConfirmationDialog(
        title: title,
        titleText: titleText,
        cancelText: cancelText,
        confirmText: confirmText,
      );
    },
  );
  return result ?? false;
}

/// Show a dialog to select between values
Future<T?> showSelectionDialog<T>({
  required List<T> values,
  required String title,
  required Widget Function(T) optionBuilder,
  BuildContext? context,
}) async {
  return showDialog<T>(
    context: context ?? navigationKey.currentContext!,
    builder: (context) {
      final navigator = Navigator.of(context);
      return SimpleDialog(
        title: Text(title),
        children: [
          for (final value in values)
            SimpleDialogOption(
              onPressed: () => navigator.pop(value),
              child: optionBuilder(value),
            ),
        ],
      );
    },
  );
}

/// Show dialog that allow typing text inside,
Future<String?> showStringEditDialog({
  required String title,
  String initialValue = "",
  String cancelText = "Hủy",
  String confirmText = "Lưu",
  BuildContext? context,
  InputDecoration? decoration,
  List<TextInputFormatter>? inputFormatters,
}) async {
  final controller = TextEditingController(text: initialValue);
  return showDialog(
    context: context ?? navigationKey.currentContext!,
    builder: (context) {
      final navigator = Navigator.of(context);
      return AlertDialog(
        title: Text(title),
        content: TextField(
          inputFormatters: inputFormatters,
          enableSuggestions: true,
          controller: controller,
        ),
        actions: [
          TextButton(onPressed: () => navigator.pop(), child: Text(cancelText)),
          TextButton(
            onPressed: () => navigator.pop(controller.text),
            child: Text(confirmText),
          ),
        ],
      );
    },
  );
}

class ConfirmationDialog extends StatelessWidget {
  final Widget? title;
  final String? titleText;
  final String? cancelText;
  final String? confirmText;

  /// The parameters are required so that the upper API does not miss any
  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.titleText,
    required this.cancelText,
    required this.confirmText,
  });

  @override
  Widget build(BuildContext context) {
    final titleText = this.titleText ?? "Xác nhận";
    final cancelText = this.cancelText ?? "Hủy";
    final confirmText = this.confirmText ?? "xác nhận";
    final title = this.title ?? Text(titleText);

    final navigator = Navigator.of(context);
    return AlertDialog(
      title: title,
      actions: [
        TextButton(
          onPressed: () => navigator.pop(false),
          child: Text(cancelText),
        ),
        TextButton(
          onPressed: () => navigator.pop(true),
          child: Text(confirmText),
        ),
      ],
    );
  }
}

class PeriodSelectionDialog extends ConsumerWidget {
  final String titleText;

  /// Show period selection dialog
  static Future<T?> show<T>({
    required String titleText,
    BuildContext? context,
  }) async {
    return await showDialog<T?>(
      context: context ?? navigationKey.currentContext!,
      builder: (context) => PeriodSelectionDialog(titleText: titleText),
    );
  }

  const PeriodSelectionDialog({super.key, required this.titleText});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final periodsAsync = ref.watch(periodListProvider);

    return SimpleDialog(
      title: Text(titleText),
      children: buildChildren(context, periodsAsync),
    );
  }

  List<Widget> buildChildren(
    BuildContext context,
    AsyncValue<List<PeriodData>> periodsAsync,
  ) {
    final navigator = Navigator.of(context);
    switch (periodsAsync) {
      case AsyncLoading():
        return [CircularProgressIndicator()];

      case AsyncError(:final error, :final stackTrace):
        print(stackTrace);
        return [Text(error.toString())];

      case AsyncData(value: final periods):
        return [
          for (final period in periods)
            ListTile(
              title: Text("Tiết ${period.id}"),
              subtitle: Text(
                "${period.startTime.format(context)} - ${period.endTime.format(context)}",
              ),
              onTap: () => navigator.pop(period),
            ),
        ];
    }
  }
}
