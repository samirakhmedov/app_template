import 'dart:async';

import 'package:app_template/features/common/domain/repositories/i_memory_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'memory_event.dart';
part 'memory_state.dart';
part 'memory_bloc.freezed.dart';

/// {@template memory_bloc}
/// A bloc for memory management.
/// {@endtemplate}
class MemoryBloc extends Bloc<MemoryEvent, MemoryState> {
  final IMemoryRepository _memoryRepository;

  /// {@macro memory_bloc}
  MemoryBloc({required IMemoryRepository memoryRepository})
    : _memoryRepository = memoryRepository,
      super(const MemoryState.initial()) {
    on<MemoryInitialize>(_initialize);
    on<MemoryHandleMemoryPressure>(_handleMemoryPressure);
    on<MemoryRevive>(_revive);
  }

  void _initialize(MemoryInitialize event, Emitter<MemoryState> emit) {
    // TODO(samirakhmedov): add initialization if needed.
  }

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
