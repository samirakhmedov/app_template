import 'package:haptics/src/entities/haptic_feedback.dart';
import 'package:haptics/src/entities/haptic_impact.dart';
import 'package:haptics/src/entities/haptic_notification.dart';

import 'haptics_platform_interface.dart';

/// A class that provides a set of methods to trigger haptic feedback.
class Haptics {
  /// A singleton instance of [Haptics].
  static final Haptics instance = Haptics._();

  /// A private constructor.
  Haptics._();

  /// The platform instance.
  final HapticsPlatform _platform = HapticsPlatform.instance;

  /// Initializes the haptics engine.
  Future<void> init() => _platform.init();

  /// Disposes the haptics engine.
  Future<void> dispose() => _platform.dispose();

  /// Triggers a haptic impact.
  ///
  /// [impact] - the type of impact to trigger.
  ///
  /// For more information, see [HapticImpactType].
  Future<void> impact(HapticImpactType impact) => _platform.impact(impact);

  /// Triggers a haptic notification.
  ///
  /// [notification] - the type of notification to trigger.
  ///
  /// For more information, see [HapticNotificationType].
  Future<void> notification(HapticNotificationType notification) =>
      _platform.notification(notification);

  /// Triggers a haptic feedback.
  ///
  /// [feedback] - the type of feedback to trigger.
  ///
  /// For more information, see [HapticFeedbackType].
  Future<void> feedback(HapticFeedbackType feedback) => _platform.feedback(feedback);

  /// Triggers a haptic selection.
  Future<void> selection() => _platform.selection();
}
