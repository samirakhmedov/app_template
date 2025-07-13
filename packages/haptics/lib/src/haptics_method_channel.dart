import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:haptics/src/entities/haptic_feedback.dart';
import 'package:haptics/src/entities/haptic_impact.dart';
import 'package:haptics/src/entities/haptic_notification.dart';

import 'haptics_platform_interface.dart';

/// An implementation of [HapticsPlatform] that uses method channels.
class MethodChannelHaptics extends HapticsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel(_HapticsMethodChannelConstants.channelName);

  @override
  Future<void> init() => _invokeMethod(_HapticsMethodChannelConstants.initMethod);

  @override
  Future<void> dispose() => _invokeMethod(_HapticsMethodChannelConstants.disposeMethod);

  @override
  Future<void> impact(HapticImpactType impact) => _invokeMethod(
    _HapticsMethodChannelConstants.impactMethod,
    _HapticsMethodChannelConstants.styleKey,
    impact.name,
  );

  @override
  Future<void> notification(HapticNotificationType notification) => _invokeMethod(
    _HapticsMethodChannelConstants.notificationMethod,
    _HapticsMethodChannelConstants.typeKey,
    notification.name,
  );

  @override
  Future<void> feedback(HapticFeedbackType feedback) => _invokeMethod(
    _HapticsMethodChannelConstants.feedbackMethod,
    _HapticsMethodChannelConstants.typeKey,
    feedback.name,
  );

  @override
  Future<void> selection() => _invokeMethod(_HapticsMethodChannelConstants.selectionMethod);

  Future<void> _invokeMethod(String method, [String? key, String? value]) async {
    try {
      final arguments = <String, dynamic>{};
      if (key != null && value != null) {
        arguments[key] = value;
      }
      await methodChannel.invokeMethod<void>(method, arguments);
    } on PlatformException catch (e) {
      log('Failed to invoke haptic method: ${e.message}');
    } catch (e) {
      log('An unexpected error occurred: $e');
    }
  }
}

abstract class _HapticsMethodChannelConstants {
  static const String channelName = 'com.surf/haptics';

  static const String initMethod = 'init';
  static const String disposeMethod = 'dispose';
  static const String impactMethod = 'impact';
  static const String notificationMethod = 'notification';
  static const String feedbackMethod = 'feedback';
  static const String selectionMethod = 'selection';

  static const String styleKey = 'style';
  static const String typeKey = 'type';
}
