import 'package:app_template/core/architecture/presentation/layout.dart';
import 'package:app_template/features/debug/presentation/widgets/rotation/rotation_component.dart';
import 'package:flutter/material.dart';

/// {@template rotation_layout}
/// A layout for the rotation.
/// {@endtemplate}
class RotationLayout extends Layout<RotationViewModel> {
  /// {@macro rotation_layout}
  const RotationLayout({
    required super.viewModel,
    super.key,
  });

  @override
  Widget layout(RotationViewModel vm) {
    return GestureDetector(
      onPanStart: vm.onPanStart,
      onPanUpdate: vm.onPanUpdate,
      onPanEnd: vm.onPanEnd,
      child: vm.child,
    );
  }
}
