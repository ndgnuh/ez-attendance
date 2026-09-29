import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod/experimental/mutation.dart';

import '../ui_model.dart';

final _mut = Mutation<void>();

class RunButton extends ConsumerWidget {
  const RunButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(_mut);
    final messenger = ScaffoldMessenger.of(context);
    final submitAction = AddSessionModel.getSubmitFunction(context);

    switch (state) {
      case MutationIdle():
        return FilledButton.icon(
          icon: Icon(Symbols.add),
          onPressed:
              () => _mut.run(ref, (txn) {
                return Future.sync(submitAction);
              }),
          label: Text("Tạo buổi học"),
        );
      case MutationPending<void>():
        return FilledButton.icon(
          icon: CircularProgressIndicator(),
          onPressed: null,
          label: Text("Thêm"),
        );
      case MutationError(:final error, :final stackTrace):
        print(stackTrace);
        return FilledButton.icon(
          icon: Icon(Symbols.error),
          onPressed: () => _mut.reset(ref),
          label: Text("Lỗi: $error, click để reset"),
        );
      case MutationSuccess<void>():
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pop(context);
          messenger.showSnackBar(SnackBar(content: Text("Đã thêm buổi học")));
        });

        return FilledButton.icon(
          icon: Icon(Symbols.check_box),
          label: Text("Xong, nhấn để quay lại"),
          onPressed: () => Navigator.pop(context),
        );
    }
  }
}
