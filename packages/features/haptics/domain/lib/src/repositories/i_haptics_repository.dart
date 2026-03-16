import 'package:haptics_domain/src/entities/haptic_feedback_type.dart';
import 'package:haptics_domain/src/entities/haptic_impact_type.dart';
import 'package:haptics_domain/src/entities/haptic_notification_type.dart';

/// {@template i_haptics_repository}
/// An interface for the haptics repository.
/// {@endtemplate}
abstract interface class IHapticsRepository {
  /// Triggers impact haptic feedback.
  Future<void> impact(HapticImpactType type);

  /// Triggers notification haptic feedback.
  Future<void> notification(HapticNotificationType type);

  /// Triggers feedback haptic feedback.
  Future<void> feedback(HapticFeedbackType type);

  /// Triggers selection haptic feedback.
  Future<void> selection();
}
