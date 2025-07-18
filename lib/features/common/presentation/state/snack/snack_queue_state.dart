part of 'snack_queue_bloc.dart';

/// {@template snack_queue_state}
/// State for the [SnackQueueBloc].
/// {@endtemplate}
@freezed
abstract class SnackQueueState with _$SnackQueueState {
  /// {@macro snack_queue_state}
  const factory SnackQueueState({
    required Queue<TopSnackBar> queue,
  }) = _SnackQueueState;
}
