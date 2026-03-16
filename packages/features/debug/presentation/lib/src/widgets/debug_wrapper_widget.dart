import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:debug_presentation/src/root/debug_routes.dart';
import 'package:flutter/material.dart';
import 'package:haptics_presentation/haptics_presentation.dart';

/// {@template debug_wrapper_widget}
/// A widget that wraps the child widget and shows the debug screen when long pressed.
/// {@endtemplate}
class DebugWrapperWidget extends StatelessWidget {
  /// {@macro debug_wrapper_widget}
  const DebugWrapperWidget({
    required this.child,
    super.key,
  });

  /// The child widget.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        HapticsComponent.of(context).impact(.heavy);
        unawaited(context.router.pushPath(debugPath));
      },
      child: child,
    );
  }
}
