import 'dart:async';

import 'package:app_template/features/app/router/app_router.dart';
import 'package:app_template/features/haptics/presentation/widgets/haptics_component.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:haptics/haptics.dart';

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
        HapticsComponent.of(context).impact(HapticImpactType.heavy);
        unawaited(context.router.push(const DebugRoute()));
      },
      child: child,
    );
  }
}
