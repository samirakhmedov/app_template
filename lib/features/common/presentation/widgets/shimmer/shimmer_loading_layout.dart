import 'package:app_template/core/architecture/presentation/layout.dart';
import 'package:app_template/features/common/presentation/widgets/shimmer/shimmer_loading_component.dart';
import 'package:flutter/material.dart';

/// {@template shimmer_loading_layout}
/// A layout for the shimmer loading effect.
/// {@endtemplate}
class ShimmerLoadingLayout extends Layout<ShimmerLoadingViewModel> {
  /// {@macro shimmer_loading_layout}
  const ShimmerLoadingLayout({required super.viewModel, super.key});

  @override
  Widget layout(ShimmerLoadingViewModel vm) {
    if (!vm.isLoading) {
      return vm.child;
    }

    final shimmerChanges = vm.shimmerChanges;

    return AnimatedBuilder(
      animation: shimmerChanges,
      builder: (ctx, chld) {
        if (!vm.isSized) {
          return const SizedBox();
        }

        final shimmerSize = vm.size;

        if (shimmerSize == null) {
          return const SizedBox();
        }

        final descendant = ctx.findRenderObject() as RenderBox?;

        if (descendant == null) {
          return const SizedBox();
        }

        final offsetWithinShimmer = vm.getDescendantOffset(
          descendant: descendant,
        );

        return ShaderMask(
          shaderCallback: (_) => vm.buildShader(offsetWithinShimmer, shimmerSize),
          blendMode: BlendMode.srcATop,
          child: chld,
        );
      },
      child: vm.child,
    );
  }
}
