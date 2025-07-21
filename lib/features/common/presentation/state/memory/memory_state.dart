part of 'memory_bloc.dart';

/// {@template memory_state}
/// A state for memory management.
/// {@endtemplate}
@freezed
abstract class MemoryState with _$MemoryState {
  /// {@macro memory_state}
  const factory MemoryState.initial() = MemoryStateInitial;

  /// {@macro memory_state}
  const factory MemoryState.handlingPressure() = MemoryStateHandlingPressure;

  /// {@macro memory_state}
  const factory MemoryState.revived() = MemoryStateRevived;
}
