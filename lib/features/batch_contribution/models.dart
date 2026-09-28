// ─────────────────────────────── States ────────────────────────────
import 'package:flutter/widgets.dart';
import 'package:riverpod/experimental/mutation.dart';

import 'db.dart';

final batchContributionMutation = Mutation<void>();

// Data model fields
enum BatchUpdateAspect { updateValue, updateMode, ids }

class BatchUpdateModel extends InheritedModel<BatchUpdateAspect> {
  final List<String> ids;
  final ContributionUpdateModes updateMode;
  final int updateValue;
  // ignore: library_private_types_in_public_api
  final _BatchUpdateScopeState state;

  const BatchUpdateModel({
    super.key,
    required super.child,
    required this.ids,
    required this.updateMode,
    // ignore: library_private_types_in_public_api
    required this.state,
    this.updateValue = 1,
  });

  @override
  bool updateShouldNotify(covariant BatchUpdateModel oldWidget) {
    return oldWidget.ids != ids ||
        oldWidget.updateMode != updateMode ||
        updateValue != oldWidget.updateValue;
  }

  @override
  bool updateShouldNotifyDependent(
    covariant BatchUpdateModel oldWidget,
    Set<BatchUpdateAspect> dependencies,
  ) {
    if (oldWidget.ids != ids && dependencies.contains(BatchUpdateAspect.ids)) {
      return true;
    }

    if (oldWidget.updateMode != updateMode &&
        dependencies.contains(BatchUpdateAspect.updateMode)) {
      return true;
    }

    if (oldWidget.updateValue != updateValue &&
        dependencies.contains(BatchUpdateAspect.updateValue)) {
      return true;
    }

    return false;
  }

  // ignore: library_private_types_in_public_api
  static _BatchUpdateScopeState actionsOf(BuildContext context) {
    final model = context.getInheritedWidgetOfExactType<BatchUpdateModel>();
    return model!.state;
  }

  static List<String> idsOf(BuildContext context) {
    return InheritedModel.inheritFrom<BatchUpdateModel>(
      context,
      aspect: BatchUpdateAspect.ids,
    )!.ids;
  }

  static ContributionUpdateModes updateModeOf(BuildContext context) {
    return InheritedModel.inheritFrom<BatchUpdateModel>(
      context,
      aspect: BatchUpdateAspect.updateMode,
    )!.updateMode;
  }

  static int updateValueOf(BuildContext context) {
    return InheritedModel.inheritFrom<BatchUpdateModel>(
      context,
      aspect: BatchUpdateAspect.updateValue,
    )!.updateValue;
  }
}

class BatchUpdateScope extends StatefulWidget {
  final Widget child;
  const BatchUpdateScope({super.key, required this.child});

  @override
  State<BatchUpdateScope> createState() => _BatchUpdateScopeState();
}

class _BatchUpdateScopeState extends State<BatchUpdateScope> {
  List<String> ids = [];
  int updateValue = 1;
  ContributionUpdateModes updateMode = ContributionUpdateModes.addToValue;

  @override
  Widget build(BuildContext context) {
    return BatchUpdateModel(
      ids: ids,
      updateMode: updateMode,
      updateValue: updateValue,
      state: this,
      child: widget.child,
    );
  }

  void setIds(List<String> ids) => setState(() {
    this.ids = ids;
  });

  void setUpdateMode(ContributionUpdateModes updateMode) => setState(() {
    this.updateMode = updateMode;
  });

  void setUpdateValue(int updateValue) => setState(() {
    this.updateValue = updateValue;
  });
}
