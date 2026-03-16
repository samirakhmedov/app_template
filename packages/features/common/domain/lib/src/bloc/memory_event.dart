part of 'memory_bloc.dart';

@freezed
sealed class MemoryEvent with _$MemoryEvent {
  const factory MemoryEvent.initialize() = MemoryInitialize;
  const factory MemoryEvent.handleMemoryPressure() = MemoryHandleMemoryPressure;
  const factory MemoryEvent.revive() = MemoryRevive;
}
