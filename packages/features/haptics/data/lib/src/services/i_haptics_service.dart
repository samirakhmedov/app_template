import 'package:app_domain/app_domain.dart';
import 'package:haptics_domain/haptics_domain.dart';

/// {@template i_haptics_service}
/// An interface for the haptics service.
/// {@endtemplate}
abstract interface class IHapticsService implements LifecycleObject {
  /// Triggers impact haptic feedback.
  Future<void> impact(HapticImpactType type);

  /// Triggers notification haptic feedback.
  Future<void> notification(HapticNotificationType type);

  /// Triggers feedback haptic feedback.
  Future<void> feedback(HapticFeedbackType type);

  /// Triggers selection haptic feedback.
  Future<void> selection();
}
