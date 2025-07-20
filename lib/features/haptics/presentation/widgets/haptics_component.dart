import 'dart:async';

import 'package:app_template/core/architecture/presentation/core/child_layout.dart';
import 'package:app_template/core/architecture/presentation/core/empty_view_model.dart';
import 'package:app_template/core/architecture/presentation/widgets/component.dart';
import 'package:flutter/material.dart';
import 'package:haptics/haptics.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

/// {@template haptic_component}
/// Component that provides haptic feedback capabilities.
/// {@endtemplate}
class HapticsComponent extends Component<EmptyViewModel, ChildLayout> {
  /// {@macro haptic_component}
  const HapticsComponent({
    required this.child,
    super.key,
  });

  /// The child widget.
  final Widget child;

  /// Returns the [IHapticProvider] from the context.
  static IHapticProvider of(BuildContext context) {
    return context.read<IHapticProvider>();
  }

  @override
  ComponentState<HapticsComponent, EmptyViewModel, ChildLayout> createState() =>
      _HapticComponentState();
}

class _HapticComponentState extends ComponentState<HapticsComponent, EmptyViewModel, ChildLayout>
    implements EmptyViewModel, IHapticProvider {
  @override
  void initState() {
    super.initState();

    unawaited(Haptics.instance.init());
  }

  @override
  void dispose() {
    unawaited(Haptics.instance.dispose());

    super.dispose();
  }

  @override
  List<SingleChildWidget> providers() {
    return [
      Provider<IHapticProvider>.value(value: this),
    ];
  }

  @override
  void impact(HapticImpactType impact) => unawaited(Haptics.instance.impact(impact));

  @override
  void notification(HapticNotificationType notification) =>
      unawaited(Haptics.instance.notification(notification));

  @override
  void feedback(HapticFeedbackType feedback) => unawaited(Haptics.instance.feedback(feedback));

  @override
  void selection() => unawaited(Haptics.instance.selection());

  @override
  ChildLayout view() => ChildLayout(child: widget.child);
}

/// Haptic provider interface.
abstract interface class IHapticProvider {
  /// Triggers impact haptic feedback.
  void impact(HapticImpactType impact);

  /// Triggers notification haptic feedback.
  void notification(HapticNotificationType notification);

  /// Triggers feedback haptic feedback.
  void feedback(HapticFeedbackType feedback);

  /// Triggers selection haptic feedback.
  void selection();
}
