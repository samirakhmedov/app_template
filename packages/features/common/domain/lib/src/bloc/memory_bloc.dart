import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:common_domain/common_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'memory_event.dart';
part 'memory_state.dart';
part 'memory_bloc.freezed.dart';

class MemoryBloc extends Bloc<MemoryEvent, MemoryState> {
  final IMemoryRepository _memoryRepository;

  MemoryBloc({required IMemoryRepository memoryRepository})
    : _memoryRepository = memoryRepository,
      super(const MemoryState.initial()) {
    on<MemoryInitialize>(_initialize);
    on<MemoryHandleMemoryPressure>(_handleMemoryPressure);
    on<MemoryRevive>(_revive);
  }

  void _initialize(MemoryInitialize event, Emitter<MemoryState> emit) {}

  Future<void> _handleMemoryPressure(
    MemoryHandleMemoryPressure event,
    Emitter<MemoryState> emit,
  ) async {
    await _memoryRepository.handleMemoryPressure();
    emit(const MemoryState.handlingPressure());
  }

  Future<void> _revive(MemoryRevive event, Emitter<MemoryState> emit) async {
    await _memoryRepository.revive();
    emit(const MemoryState.revived());
  }
}
