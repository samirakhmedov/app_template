part of 'memory_bloc.dart';

/// {@template memory_event}
/// An event for memory management.
/// {@endtemplate}
@freezed
sealed class MemoryEvent with _$MemoryEvent {
  /// {@macro memory_event}
  const factory MemoryEvent.initialize() = MemoryInitialize;

  /// {@macro memory_event}
  const factory MemoryEvent.handleMemoryPressure() = MemoryHandleMemoryPressure;

  /// {@macro memory_event}
  const factory MemoryEvent.revive() = MemoryRevive;
}
