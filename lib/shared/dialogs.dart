import 'package:checkin_tool/shared/context.dart';
import 'package:flutter/material.dart';

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
