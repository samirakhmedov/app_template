part of 'theme_bloc.dart';

/// {@template theme_event}
/// An event for the theme.
/// {@endtemplate}
@freezed
sealed class ThemeEvent with _$ThemeEvent {
  /// {@macro theme_event}
  const factory ThemeEvent.initialize() = ThemeInitialize;

  /// {@macro theme_event}
  const factory ThemeEvent.setMode(ThemeMode mode) = ThemeSetMode;
}
