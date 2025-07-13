part of 'theme_bloc.dart';

/// {@template theme_state}
/// A state for the theme.
/// {@endtemplate}
@freezed
abstract class ThemeState with _$ThemeState {
  /// {@macro theme_state}
  const factory ThemeState({
    @Default(ThemeMode.system) ThemeMode themeMode,
  }) = _ThemeState;
}
