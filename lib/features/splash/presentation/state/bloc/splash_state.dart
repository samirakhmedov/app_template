part of 'splash_bloc.dart';

/// {@template splash_state}
/// A state for the splash.
/// {@endtemplate}
@freezed
abstract class SplashState with _$SplashState {
  /// {@macro splash_state}
  const factory SplashState.initial() = SplashStateInitial;

  /// {@macro splash_state}
  const factory SplashState.loading() = SplashStateLoading;

  /// {@macro splash_state}
  const factory SplashState.loaded() = SplashStateLoaded;
}
