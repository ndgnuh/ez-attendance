import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final Object error;
  final StackTrace stackTrace;
  const ErrorView({
    super.key,
    required this.error,
    required this.stackTrace,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Đã xảy ra lỗi:',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            SizedBox(height: 8),
            Text(error.toString(), style: TextStyle(color: Colors.red)),
            stackTrace.toString().isNotEmpty
                ? Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: SingleChildScrollView(
                    child: Text(
                      stackTrace.toString(),
                      style: TextStyle(fontFamily: 'monospace'),
                    ),
                  ),
                )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
