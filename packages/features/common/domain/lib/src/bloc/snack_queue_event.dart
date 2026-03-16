part of 'snack_queue_bloc.dart';

@freezed
sealed class SnackQueueEvent with _$SnackQueueEvent {
  const factory SnackQueueEvent.add(SnackData snack) = SnackQueueAdd;
  const factory SnackQueueEvent.clear(DateTime closeTime) = SnackQueueClear;
  const factory SnackQueueEvent.removeFirst() = SnackQueueRemoveFirst;
}
