import 'package:haptics/src/entities/haptic_feedback.dart';
import 'package:haptics/src/entities/haptic_impact.dart';
import 'package:haptics/src/entities/haptic_notification.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'haptics_method_channel.dart';

abstract class HapticsPlatform extends PlatformInterface {
  /// Constructs a HapticsPlatform.
  HapticsPlatform() : super(token: _token);

  static final Object _token = Object();

  static HapticsPlatform _instance = MethodChannelHaptics();

  /// The default instance of [HapticsPlatform] to use.
  ///
  /// Defaults to [MethodChannelHaptics].
  static HapticsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [HapticsPlatform] when
  /// they register themselves.
  static set instance(HapticsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Initializes the haptics engine.
  Future<void> init() {
    throw UnimplementedError('init() has not been implemented.');
  }

  /// Disposes the haptics engine.
  Future<void> dispose() {
    throw UnimplementedError('dispose() has not been implemented.');
  }

  /// Triggers a haptic impact.
  ///
  /// [impact] - the type of impact to trigger.
  Future<void> impact(HapticImpactType impact) {
    throw UnimplementedError('impact() has not been implemented.');
  }

  /// Triggers a haptic notification.
  ///
  /// [notification] - the type of notification to trigger.
  Future<void> notification(HapticNotificationType notification) {
    throw UnimplementedError('notification() has not been implemented.');
  }

  /// Triggers a haptic feedback.
  ///
  /// [feedback] - the type of feedback to trigger.
  Future<void> feedback(HapticFeedbackType feedback) {
    throw UnimplementedError('feedback() has not been implemented.');
  }

  /// Triggers a haptic selection.
  Future<void> selection() {
    throw UnimplementedError('selection() has not been implemented.');
  }
}
