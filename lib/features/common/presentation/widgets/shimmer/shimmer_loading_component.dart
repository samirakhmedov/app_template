import 'package:app_template/core/architecture/presentation/component.dart';
import 'package:app_template/core/config/environment/test_env_detector.dart';
import 'package:app_template/features/app/di/i_app_scope.dart';
import 'package:app_template/features/common/domain/entities/shader_type.dart';
import 'package:app_template/features/common/presentation/state/shader/shader_bloc.dart';
import 'package:app_template/features/common/presentation/widgets/shimmer/shimmer_component.dart';
import 'package:app_template/features/common/presentation/widgets/shimmer/shimmer_loading_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uikit/uikit.dart';

/// {@template shimmer_loading_component}
/// A component for the shimmer loading effect.
/// {@endtemplate}
class ShimmerLoadingComponent extends Component<ShimmerLoadingViewModel, ShimmerLoadingLayout> {
  /// {@macro shimmer_loading_component}
  const ShimmerLoadingComponent({
    required this.isLoading,
    required this.child,
    super.key,
  });

  /// Whether the shimmer effect is enabled.
  final bool isLoading;

  /// The widget below this widget in the tree.
  final Widget child;

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

  ShaderBloc get _shaderBloc => context.read<IAppScope>().shaderBloc;

  @override
  void initState() {
    super.initState();

    // Trigger shader preloading
    _shaderBloc.add(const ShaderLoadShader(ShaderType.shimmer));
  }

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

  LinearGradient get shimmerGradient => LinearGradient(
    begin: _shimmerGradient.begin,
    end: _shimmerGradient.end,
    colors: _shimmerGradient.colors,
    stops: _shimmerGradient.stops,
    transform: _SlidingGradientTransform(slidePercent: shimmerProvider.shimmerChanges.value),
  );

  IShimmerProvider get shimmerProvider => ShimmerComponent.of(context);

  @override
  Animation<double> get shimmerChanges => shimmerProvider.shimmerChanges;

  @override
  bool get isSized => shimmerProvider.isSized;

  @override
  Size? get size => shimmerProvider.size;

  @override
  Widget get child => widget.child;

  @override
  bool get isLoading => widget.isLoading;

  @override
  Shader buildShader(
    Offset offsetWithinShimmer,
    Size shimmerSize,
  ) {
    // Access current shader state
    final shaderState = _shaderBloc.state;
    final shader = shaderState.shaders[ShaderType.shimmer];

    if (shader == null || TestEnvDetector.isTestEnvironment) {
      // Fallback to existing gradient shader
      return shimmerGradient.createShader(
        Rect.fromLTWH(
          -offsetWithinShimmer.dx,
          -offsetWithinShimmer.dy,
          shimmerSize.width,
          shimmerSize.height,
        ),
      );
    }
    // Configure fragment shader uniforms
    final animationValue = shimmerProvider.shimmerChanges.value;
    final theme = context.appColorScheme;

    shader
      ..setFloat(0, shimmerSize.width) // uSize.x
      ..setFloat(1, shimmerSize.height) // uSize.y
      ..setFloat(2, animationValue * 6.28318) // uSeed (animation value * 2π for smooth wave)
      ..setFloat(3, theme.skeletonTertiary.r) // uLineColor.r
      ..setFloat(4, theme.skeletonTertiary.g) // uLineColor.g
      ..setFloat(5, theme.skeletonTertiary.b) // uLineColor.b
      ..setFloat(6, theme.skeletonTertiary.a) // uLineColor.a
      ..setFloat(7, theme.skeletonSecondary.r) // uBackgroundColor.r
      ..setFloat(8, theme.skeletonSecondary.g) // uBackgroundColor.g
      ..setFloat(9, theme.skeletonSecondary.b) // uBackgroundColor.b
      ..setFloat(10, theme.skeletonSecondary.a) // uBackgroundColor.a
      ..setFloat(11, 0.4); // uStripeWidth

    return shader;
  }

  @override
  ShimmerLoadingLayout view() {
    return ShimmerLoadingLayout(viewModel: this);
  }

  @override
  Offset getDescendantOffset({required RenderBox descendant, Offset offset = Offset.zero}) {
    final shimmerBox = context.findRenderObject() as RenderBox?;

    return descendant.localToGlobal(offset, ancestor: shimmerBox);
  }

  @override
  StateStreamable<ShaderState> get shaderBloc => _shaderBloc;
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

  /// Whether the shimmer is sized.
  bool get isSized;

  /// The size of the shimmer.
  Size? get size;

  /// The shader bloc for accessing shader state.
  StateStreamable<ShaderState> get shaderBloc;

  /// Returns the offset of the descendant in the shimmer's coordinate system.
  Offset getDescendantOffset({
    required RenderBox descendant,
    Offset offset = Offset.zero,
  });

  /// Builds the shader for the shimmer effect.
  Shader buildShader(
    Offset offsetWithinShimmer,
    Size shimmerSize,
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
