import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:common_domain/common_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'snack_queue_event.dart';
part 'snack_queue_state.dart';
part 'snack_queue_bloc.freezed.dart';

class SnackQueueBloc extends Bloc<SnackQueueEvent, SnackQueueState> {
  SnackQueueBloc() : super(SnackQueueState(queue: Queue())) {
    on<SnackQueueAdd>(_onAdd);
    on<SnackQueueClear>(_onClear);
    on<SnackQueueRemoveFirst>(_onRemoveFirst);
  }

  void _onAdd(SnackQueueAdd event, Emitter<SnackQueueState> emit) {
    final updatedQueue = Queue<SnackData>.from(state.queue)..add(event.snack);
    emit(state.copyWith(queue: updatedQueue));
  }

  void _onClear(SnackQueueClear event, Emitter<SnackQueueState> emit) {
    final updatedQueue = Queue<SnackData>.from(
      state.queue.where(
        (snack) => snack.showTime.isAfter(
          event.closeTime.subtract(const Duration(seconds: 1)),
        ),
      ),
    );
    emit(state.copyWith(queue: updatedQueue));
  }

  void _onRemoveFirst(SnackQueueRemoveFirst event, Emitter<SnackQueueState> emit) {
    if (state.queue.isEmpty) return;
    final updatedQueue = Queue<SnackData>.from(state.queue)..removeFirst();
    emit(state.copyWith(queue: updatedQueue));
  }
}
