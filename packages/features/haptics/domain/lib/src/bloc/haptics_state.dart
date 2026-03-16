part of 'haptics_bloc.dart';

@freezed
abstract class HapticsState with _$HapticsState {
  const factory HapticsState.initial() = HapticsStateInitial;
  const factory HapticsState.ready() = HapticsStateReady;
}
