import 'package:app_template/core/architecture/presentation/layout.dart';
import 'package:app_template/features/common/presentation/widgets/shimmer/shimmer_component.dart';
import 'package:flutter/material.dart';

/// {@template shimmer_layout}
/// A layout for the shimmer effect.
/// {@endtemplate}
class ShimmerLayout extends Layout<ShimmerViewModel> {
  /// {@macro shimmer_layout}
  const ShimmerLayout({required super.viewModel, super.key});

  @override
  Widget layout(ShimmerViewModel vm) {
    return vm.child;
  }
}
