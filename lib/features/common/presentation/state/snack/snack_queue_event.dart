part of 'snack_queue_bloc.dart';

/// {@template snack_queue_event}
/// Events for the [SnackQueueBloc].
/// {@endtemplate}
@freezed
sealed class SnackQueueEvent with _$SnackQueueEvent {
  /// Enqueue a new snack.
  const factory SnackQueueEvent.add(TopSnackBar snack) = SnackQueueAdd;

  /// Clear snacks queued before [closeTime].
  const factory SnackQueueEvent.clear(DateTime closeTime) = SnackQueueClear;

  /// Remove the first snack from the queue (called after it was displayed).
  const factory SnackQueueEvent.removeFirst() = SnackQueueRemoveFirst;
}
