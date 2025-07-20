import 'package:app_template/core/architecture/mixin/lifecycle_observer_mixin.dart';
import 'package:app_template/core/architecture/presentation/core/child_layout.dart';
import 'package:app_template/core/architecture/presentation/core/empty_view_model.dart';
import 'package:app_template/core/architecture/presentation/widgets/component.dart';
import 'package:app_template/core/config/environment/test_env_detector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

/// {@template shimmer_component}
/// A component for the shimmer effect.
/// {@endtemplate}
class ShimmerComponent extends Component<EmptyViewModel, ChildLayout> {
  /// {@macro shimmer_component}
  const ShimmerComponent({
    required this.child,
    super.key,
  });

  /// The child widget.
  final Widget child;

  /// Returns the [IShimmerProvider] from the context.
  static IShimmerProvider of(BuildContext context) {
    return context.read<IShimmerProvider>();
  }

  @override
  ComponentState<ShimmerComponent, EmptyViewModel, ChildLayout> createState() =>
      _ShimmerComponentState();
}

class _ShimmerComponentState extends ComponentState<ShimmerComponent, EmptyViewModel, ChildLayout>
    with SingleTickerProviderStateMixin, LifecycleObserverMixin
    implements IShimmerProvider {
  static const _shimmerDuration = Duration(seconds: 2);

  static const _shimmerMin = -0.5;
  static const _shimmerMax = 1.5;

  late final AnimationController _shimmerController = AnimationController.unbounded(vsync: this);

  @override
  void initState() {
    super.initState();

    _runAnimation();
  }

  @override
  void dispose() {
    _shimmerController.dispose();

    super.dispose();
  }

  @override
  void onPaused() {
    _shimmerController.stop();
  }

  @override
  void onResumed() {
    _runAnimation();
  }

  @override
  List<SingleChildWidget> providers() {
    return [
      Provider<IShimmerProvider>.value(value: this),
    ];
  }

  @override
  Offset getDescendantOffset({
    required RenderBox descendant,
    Offset offset = Offset.zero,
  }) {
    final shimmerBox = context.findRenderObject() as RenderBox?;

    return descendant.localToGlobal(offset, ancestor: shimmerBox);
  }

  @override
  ChildLayout view() => ChildLayout(child: widget.child);

  void _runAnimation() {
    if (TestEnvDetector.isTestEnvironment) return;

    _shimmerController.repeat(min: _shimmerMin, max: _shimmerMax, period: _shimmerDuration);
  }

  @override
  Animation<double> get shimmerChanges => _shimmerController;

  @override
  bool get isSized => (context.findRenderObject() as RenderBox?)?.hasSize ?? false;

  @override
  Size? get size => (context.findRenderObject() as RenderBox?)?.size;
}

/// {@template i_shimmer_provider}
/// A provider for the shimmer effect.
/// {@endtemplate}
abstract interface class IShimmerProvider {
  /// The animation controller for the shimmer effect.
  Animation<double> get shimmerChanges;

  /// Whether the shimmer is sized.
  bool get isSized;

  /// The size of the shimmer.
  Size? get size;

  /// Returns the offset of the descendant in the shimmer's coordinate system.
  Offset getDescendantOffset({
    required RenderBox descendant,
    Offset offset = Offset.zero,
  });
}
