import 'package:app_template/core/architecture/presentation/widgets/layout.dart';
import 'package:app_template/features/common/domain/entities/shader_type.dart';
import 'package:app_template/features/common/presentation/state/shader/shader_bloc.dart';
import 'package:app_template/features/common/presentation/widgets/shimmer/shimmer_loading_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

    return BlocBuilder<StateStreamable<ShaderState>, ShaderState>(
      builder: (context, shaderState) {
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
              // ignore: prefer-extracting-callbacks
              shaderCallback: (_) {
                final shader = shaderState.shaders[ShaderType.shimmer];

                final animation = shimmerChanges.value;

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
      bloc: vm.shaderBloc,
    );
  }
}
