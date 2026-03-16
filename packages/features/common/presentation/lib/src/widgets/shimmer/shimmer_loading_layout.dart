import 'dart:ui' as ui;

import 'package:app_presentation/app_presentation.dart';
import 'package:common_presentation/src/widgets/shimmer/shimmer_loading_component.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

    return Builder(
      builder: (context) {
        final shaders = context.watch<Map<String, ui.FragmentShader?>>();
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

            final shader = shaders[vm.shimmerShaderPath];
            final animation = shimmerChanges.value;

            return ShaderMask(
              // ignore: prefer-extracting-callbacks
              shaderCallback: (_) {
                if (shader != null) {
                  return vm.buildFragmentShader(
                    shader,
                    offsetWithinShimmer,
                    shimmerSize,
                    animation,
                  );
                }

                return vm.buildGradientShader(
                  offsetWithinShimmer,
                  shimmerSize,
                  animation,
                );
              },
              blendMode: BlendMode.srcATop,
              child: chld,
            );
          },
          child: vm.child,
        );
      },
    );
  }
}
