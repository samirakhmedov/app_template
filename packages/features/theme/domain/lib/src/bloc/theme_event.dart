part of 'theme_bloc.dart';

@freezed
sealed class ThemeEvent with _$ThemeEvent {
  const factory ThemeEvent.initialize() = ThemeInitialize;
  const factory ThemeEvent.setMode(ThemeMode mode) = ThemeSetMode;
}
