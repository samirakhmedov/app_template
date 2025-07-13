import 'package:app_template/core/architecture/presentation/layout.dart';
import 'package:app_template/features/haptics/presentation/widgets/haptics_component.dart';
import 'package:flutter/material.dart';

/// A dummy Layout for the HapticComponent.
class HapticLayout extends Layout<HapticViewModel> {
  /// {@macro haptic_layout}
  const HapticLayout({required super.viewModel, super.key});

  @override
  Widget layout(HapticViewModel vm) {
    return vm.child;
  }
}
