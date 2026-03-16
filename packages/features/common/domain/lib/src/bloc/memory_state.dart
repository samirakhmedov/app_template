part of 'memory_bloc.dart';

@freezed
abstract class MemoryState with _$MemoryState {
  const factory MemoryState.initial() = MemoryStateInitial;
  const factory MemoryState.handlingPressure() = MemoryStateHandlingPressure;
  const factory MemoryState.revived() = MemoryStateRevived;
}
