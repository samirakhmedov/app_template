part of 'debug_bloc.dart';

/// {@template debug_event}
/// An event for the debug.
/// {@endtemplate}
@freezed
sealed class DebugEvent with _$DebugEvent {
  /// {@macro debug_event}
  const factory DebugEvent.initialize({required Urls environmentUrl}) = DebugInitialize;

  /// {@macro debug_event}
  const factory DebugEvent.setBaseUrl({required Urls baseUrl}) = DebugSetBaseUrl;
}
