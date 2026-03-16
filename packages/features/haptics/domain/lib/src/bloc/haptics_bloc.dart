import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:haptics_domain/src/entities/haptic_feedback_type.dart';
import 'package:haptics_domain/src/entities/haptic_impact_type.dart';
import 'package:haptics_domain/src/entities/haptic_notification_type.dart';
import 'package:haptics_domain/src/repositories/i_haptics_repository.dart';

part 'haptics_bloc.freezed.dart';
part 'haptics_event.dart';
part 'haptics_state.dart';

/// {@template haptics_bloc}
/// A bloc for the haptics feature.
/// {@endtemplate}
class HapticsBloc extends Bloc<HapticsEvent, HapticsState> {
  final IHapticsRepository _repository;

  /// {@macro haptics_bloc}
  HapticsBloc({required IHapticsRepository repository})
      : _repository = repository,
        super(const HapticsState.initial()) {
    on<HapticsInitialize>(_initialize);
    on<HapticsTriggerImpact>(_triggerImpact);
    on<HapticsTriggerNotification>(_triggerNotification);
    on<HapticsTriggerFeedback>(_triggerFeedback);
    on<HapticsTriggerSelection>(_triggerSelection);
  }

  void _initialize(HapticsInitialize event, Emitter<HapticsState> emit) {
    emit(const HapticsState.ready());
  }

  void _triggerImpact(HapticsTriggerImpact event, Emitter<HapticsState> emit) {
    unawaited(_repository.impact(event.type));
  }

  void _triggerNotification(HapticsTriggerNotification event, Emitter<HapticsState> emit) {
    unawaited(_repository.notification(event.type));
  }

  void _triggerFeedback(HapticsTriggerFeedback event, Emitter<HapticsState> emit) {
    unawaited(_repository.feedback(event.type));
  }

  void _triggerSelection(HapticsTriggerSelection event, Emitter<HapticsState> emit) {
    unawaited(_repository.selection());
  }
}
