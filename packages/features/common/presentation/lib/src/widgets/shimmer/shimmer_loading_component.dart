import 'dart:math';
import 'dart:ui';

import 'package:app_presentation/app_presentation.dart';
import 'package:common_presentation/src/widgets/shimmer/shimmer_component.dart';
import 'package:common_presentation/src/widgets/shimmer/shimmer_loading_layout.dart';
import 'package:flutter/material.dart';
import 'package:uikit/uikit.dart';

/// {@template shimmer_loading_component}
/// A component for the shimmer loading effect.
/// {@endtemplate}
class ShimmerLoadingComponent extends Component<ShimmerLoadingViewModel, ShimmerLoadingLayout> {
  /// {@macro shimmer_loading_component}
  const ShimmerLoadingComponent({
    required this.isLoading,
    required this.child,
    this.shimmerShaderPath,
    super.key,
  });

  /// Whether the shimmer effect is enabled.
  final bool isLoading;

  /// The widget below this widget in the tree.
  final Widget child;

  /// Asset path of the shimmer fragment shader (use auto-generated flutter_gen constant).
  ///
  /// If omitted, falls back to [IShimmerProvider.shimmerShaderPath] from the
  /// nearest [ShimmerComponent] ancestor.
  final String? shimmerShaderPath;

  @override
  ComponentState<ShimmerLoadingComponent, ShimmerLoadingViewModel, ShimmerLoadingLayout>
  createState() => _ShimmerLoadingComponentState();
}

class _ShimmerLoadingComponentState
    extends ComponentState<ShimmerLoadingComponent, ShimmerLoadingViewModel, ShimmerLoadingLayout>
    implements ShimmerLoadingViewModel {
  static const _shimmerGradientBegin = Alignment(-1, -0.3);
  static const _shimmerGradientEnd = Alignment(1, 0.3);

  static const _shimmerGradientStops = [0.1, 0.3, 0.4];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final theme = context.appColorScheme;

    final secondary = theme.skeletonSecondary;
    final tertiary = theme.skeletonTertiary;

    _shimmerGradient = LinearGradient(
      begin: _shimmerGradientBegin,
      end: _shimmerGradientEnd,
      // ignore: avoid-duplicate-collection-elements
      colors: [secondary, tertiary, secondary],
      stops: _shimmerGradientStops,
    );
  }

  late LinearGradient _shimmerGradient;

  IShimmerProvider get shimmerProvider => ShimmerComponent.of(context);

  @override
  Animation<double> get shimmerChanges => shimmerProvider.shimmerChanges;

  @override
  Widget get child => widget.child;

  @override
  bool get isLoading => widget.isLoading;

  @override
  Shader buildGradientShader(
    Offset offsetWithinShimmer,
    Size shimmerSize,
    double animation,
  ) {
    final gradient = LinearGradient(
      begin: _shimmerGradient.begin,
      end: _shimmerGradient.end,
      colors: _shimmerGradient.colors,
      stops: _shimmerGradient.stops,
      transform: _SlidingGradientTransform(slidePercent: animation),
    );

    return gradient.createShader(
      Rect.fromLTWH(
        -offsetWithinShimmer.dx,
        -offsetWithinShimmer.dy,
        shimmerSize.width,
        shimmerSize.height,
      ),
    );
  }

  @override
  Shader buildFragmentShader(
    FragmentShader shader,
    Offset offsetWithinShimmer,
    Size shimmerSize,
    double animation,
  ) {
    final theme = context.appColorScheme;

    shader
      ..setFloat(0, shimmerSize.width) // uSize.x
      ..setFloat(1, shimmerSize.height) // uSize.y
      ..setFloat(2, animation * pi * 2) // uSeed (animation value * 2π for smooth wave)
      ..setFloat(3, theme.skeletonTertiary.r) // uLineColor.r
      ..setFloat(4, theme.skeletonTertiary.g) // uLineColor.g
      ..setFloat(5, theme.skeletonTertiary.b) // uLineColor.b
      ..setFloat(6, theme.skeletonTertiary.a) // uLineColor.a
      ..setFloat(7, theme.skeletonSecondary.r) // uBackgroundColor.r
      ..setFloat(8, theme.skeletonSecondary.g) // uBackgroundColor.g
      ..setFloat(9, theme.skeletonSecondary.b) // uBackgroundColor.b
      ..setFloat(10, theme.skeletonSecondary.a) // uBackgroundColor.a
      ..setFloat(11, 0.2); // uStripeWidth

    return shader;
  }

  @override
  ShimmerLoadingLayout view() {
    return ShimmerLoadingLayout(viewModel: this);
  }

  @override
  String get shimmerShaderPath =>
      widget.shimmerShaderPath ??
      ShimmerComponent.of(context).shimmerShaderPath ??
      '';

  @override
  Offset getDescendantOffset({required RenderBox descendant, Offset offset = Offset.zero}) =>
      shimmerProvider.getDescendantOffset(
        descendant: descendant,
        offset: offset,
      );

  @override
  bool get isSized => shimmerProvider.isSized;

  @override
  Size? get size => shimmerProvider.size;
}

/// {@template shimmer_loading_view_model}
/// A view model for the shimmer loading effect.
/// {@endtemplate}
abstract interface class ShimmerLoadingViewModel implements ViewModel {
  /// Whether the shimmer effect is enabled.
  bool get isLoading;

  /// The widget below this widget in the tree.
  Widget get child;

  /// The animation controller for the shimmer effect.
  Animation<double> get shimmerChanges;

  /// Asset path of the shimmer fragment shader.
  String get shimmerShaderPath;

  /// Whether the shimmer is sized.
  bool get isSized;

  /// The size of the shimmer.
  Size? get size;

  /// Returns the offset of the descendant in the shimmer's coordinate system.
  Offset getDescendantOffset({
    required RenderBox descendant,
    Offset offset = Offset.zero,
  });

  /// Builds the shader for the shimmer effect.
  Shader buildFragmentShader(
    FragmentShader shader,
    Offset offsetWithinShimmer,
    Size shimmerSize,
    double animation,
  );

  /// Builds the shader for the shimmer effect.
  Shader buildGradientShader(
    Offset offsetWithinShimmer,
    Size shimmerSize,
    double animation,
  );
}

class _SlidingGradientTransform extends GradientTransform {
  final double slidePercent;

  const _SlidingGradientTransform({
    required this.slidePercent,
  });

  @override
  Matrix4 transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0, 0);
  }
}
