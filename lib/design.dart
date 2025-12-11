import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'dart:math';

class ConstrainedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget child;
  final double maxWidth;
  final bool withTabs;

  const ConstrainedAppBar({
    super.key,
    required this.child,
    this.maxWidth = 960,
    this.withTabs = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth,
        ),
        child: child,
      ),
    );
  }

  @override
  Size get preferredSize => switch (withTabs) {
    false => Size.fromHeight(kToolbarHeight),
    true => Size.fromHeight(kToolbarHeight + kTextTabBarHeight),
  };
}

class ConstrainedBody extends StatelessWidget {
  final Widget child;
  final double maxWidth;

  const ConstrainedBody({
    super.key,
    required this.child,
    this.maxWidth = 960,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth,
        ),
        child: child,
      ),
    );
  }
}
