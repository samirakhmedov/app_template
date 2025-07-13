part of 'splash_bloc.dart';

/// {@template splash_event}
/// An event for the splash.
/// {@endtemplate}
@freezed
sealed class SplashEvent with _$SplashEvent {
  /// {@macro splash_event}
  const factory SplashEvent.initialize() = SplashInitialize;

  /// {@macro splash_event}
  const factory SplashEvent.loaded() = SplashLoaded;
}
