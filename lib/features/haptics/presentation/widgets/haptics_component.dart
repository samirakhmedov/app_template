import 'dart:async';

import 'package:app_template/core/architecture/presentation/component.dart';
import 'package:app_template/features/haptics/presentation/widgets/haptic_layout.dart';
import 'package:flutter/material.dart';
import 'package:haptics/haptics.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

/// {@template haptic_component}
/// Component that provides haptic feedback capabilities.
/// {@endtemplate}
class HapticsComponent extends Component<HapticViewModel, HapticLayout> {
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
  ComponentState<HapticsComponent, HapticViewModel, HapticLayout> createState() =>
      _HapticComponentState();
}

class _HapticComponentState extends ComponentState<HapticsComponent, HapticViewModel, HapticLayout>
    implements HapticViewModel, IHapticProvider {
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
  Widget get child => widget.child;

  @override
  HapticLayout view() {
    return HapticLayout(viewModel: this);
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

/// A dummy ViewModel for the HapticComponent.
abstract interface class HapticViewModel implements ViewModel {
  /// The child widget.
  Widget get child;
}
