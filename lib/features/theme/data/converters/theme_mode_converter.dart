import 'dart:convert';

import 'package:app_template/features/theme/domain/entities/theme_mode.dart';

/// {@template theme_mode_converter}
/// A converter for [ThemeMode].
/// {@endtemplate}
final class ThemeModeConverter extends Codec<ThemeMode, String> {
  @override
  Converter<String, ThemeMode> get decoder => const _StringToThemeModeConverter();

  @override
  Converter<ThemeMode, String> get encoder => const _ThemeModeToStringConverter();

  /// {@macro theme_mode_converter}
  const ThemeModeConverter();
}

final class _ThemeModeToStringConverter extends Converter<ThemeMode, String> {
  const _ThemeModeToStringConverter();

  @override
  String convert(ThemeMode input) {
    return input.name;
  }
}

final class _StringToThemeModeConverter extends Converter<String, ThemeMode> {
  const _StringToThemeModeConverter();

  @override
  ThemeMode convert(String? input) {
    if (input == null || input.isEmpty) return ThemeMode.system;

    try {
      return ThemeMode.values.byName(input);
    } on Object catch (_) {
      return ThemeMode.system;
    }
  }
}
