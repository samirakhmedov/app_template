part of 'debug_bloc.dart';

/// {@template debug_state}
/// A state for the debug screen.
/// {@endtemplate}
@freezed
abstract class DebugState with _$DebugState {
  /// {@macro debug_state}
  const factory DebugState({
    Urls? baseUrl,
  }) = _DebugState;
}
