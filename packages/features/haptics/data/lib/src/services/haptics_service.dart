import 'package:haptics/haptics.dart' as ext;
import 'package:haptics_data/src/services/i_haptics_service.dart';
import 'package:haptics_domain/haptics_domain.dart';

/// {@template haptics_service}
/// A service for the haptics feature.
///
/// Wraps the external [ext.Haptics] package, managing its lifecycle
/// and mapping domain types to platform types.
/// {@endtemplate}
final class HapticsService implements IHapticsService {
  /// {@macro haptics_service}
  const HapticsService();

  @override
  Future<void> initialize() => ext.Haptics.instance.init();

  @override
  Future<void> dispose() => ext.Haptics.instance.dispose();

  @override
  Future<void> impact(HapticImpactType type) {
    return ext.Haptics.instance.impact(
      ext.HapticImpactType.values.byName(type.name),
    );
  }

  @override
  Future<void> notification(HapticNotificationType type) {
    return ext.Haptics.instance.notification(
      ext.HapticNotificationType.values.byName(type.name),
    );
  }

  @override
  Future<void> feedback(HapticFeedbackType type) {
    return ext.Haptics.instance.feedback(
      ext.HapticFeedbackType.values.byName(type.name),
    );
  }

  @override
  Future<void> selection() => ext.Haptics.instance.selection();
}
