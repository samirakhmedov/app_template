part of 'splash_bloc.dart';

@freezed
abstract class SplashState with _$SplashState {
  const factory SplashState.initial() = SplashStateInitial;
  const factory SplashState.loading() = SplashStateLoading;
  const factory SplashState.loaded() = SplashStateLoaded;
  const factory SplashState.error(String message) = SplashStateError;
}
