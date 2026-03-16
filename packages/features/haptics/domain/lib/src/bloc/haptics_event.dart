part of 'haptics_bloc.dart';

@freezed
sealed class HapticsEvent with _$HapticsEvent {
  const factory HapticsEvent.initialize() = HapticsInitialize;
  const factory HapticsEvent.triggerImpact(HapticImpactType type) = HapticsTriggerImpact;
  const factory HapticsEvent.triggerNotification(HapticNotificationType type) = HapticsTriggerNotification;
  const factory HapticsEvent.triggerFeedback(HapticFeedbackType type) = HapticsTriggerFeedback;
  const factory HapticsEvent.triggerSelection() = HapticsTriggerSelection;
}
