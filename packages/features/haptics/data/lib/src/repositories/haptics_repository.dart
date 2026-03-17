import 'package:app_data/app_data.dart';
import 'package:haptics_data/src/services/i_haptics_service.dart';
import 'package:haptics_domain/haptics_domain.dart';

/// {@template haptics_repository}
/// A repository for the haptics feature.
/// {@endtemplate}
final class HapticsRepository extends BaseRepository implements IHapticsRepository {
  final IHapticsService _service;

  /// {@macro haptics_repository}
  const HapticsRepository({
    required IHapticsService service,
    required super.logger,
  }) : _service = service;

  @override
  Future<void> impact(HapticImpactType type) => makeCall(() => _service.impact(type));

  @override
  Future<void> notification(HapticNotificationType type) => makeCall(() => _service.notification(type));

  @override
  Future<void> feedback(HapticFeedbackType type) => makeCall(() => _service.feedback(type));

  @override
  Future<void> selection() => makeCall(_service.selection);
}
