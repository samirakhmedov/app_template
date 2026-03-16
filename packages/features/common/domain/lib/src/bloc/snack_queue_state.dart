part of 'snack_queue_bloc.dart';

@freezed
abstract class SnackQueueState with _$SnackQueueState {
  const factory SnackQueueState({
    required Queue<SnackData> queue,
  }) = _SnackQueueState;
}
