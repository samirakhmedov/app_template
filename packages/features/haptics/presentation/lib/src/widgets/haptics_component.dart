import 'package:app_presentation/app_presentation.dart';
import 'package:flutter/material.dart';
import 'package:haptics_domain/haptics_domain.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

/// {@template haptics_component}
/// Component that provides haptic feedback capabilities to its subtree.
///
/// Reads [HapticsBloc] from the widget tree (provided by the haptics DI scope)
/// and exposes [IHapticProvider] for children to consume via [HapticsComponent.of].
/// {@endtemplate}
class HapticsComponent extends Component<EmptyViewModel, ChildLayout> {
  /// {@macro haptics_component}
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
      _HapticsComponentState();
}

class _HapticsComponentState
    extends ComponentState<HapticsComponent, EmptyViewModel, ChildLayout>
    implements EmptyViewModel, IHapticProvider {
  late final HapticsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<HapticsBloc>();
  }

  @override
  List<SingleChildWidget> providers() {
    return [
      Provider<IHapticProvider>.value(value: this),
    ];
  }

  @override
  void impact(HapticImpactType impact) =>
      _bloc.add(HapticsEvent.triggerImpact(impact));

  @override
  void notification(HapticNotificationType notification) =>
      _bloc.add(HapticsEvent.triggerNotification(notification));

  @override
  void feedback(HapticFeedbackType feedback) =>
      _bloc.add(HapticsEvent.triggerFeedback(feedback));

  @override
  void selection() => _bloc.add(const HapticsEvent.triggerSelection());

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
