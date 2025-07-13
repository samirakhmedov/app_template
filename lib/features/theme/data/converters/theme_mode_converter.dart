import 'package:app_template/core/architecture/data/converters/converter.dart';
import 'package:app_template/features/theme/domain/entities/theme_mode.dart';

/// {@template theme_mode_converter}
/// A converter for [ThemeMode].
/// {@endtemplate}
final class ThemeModeConverter extends ConverterToAndFrom<String, ThemeMode> {
  @override
  Converter<String, ThemeMode> get converter => const _ThemeModeToStringConverter();

  @override
  Converter<ThemeMode, String> get reverseConverter => const _StringToThemeModeConverter();

  /// {@macro theme_mode_converter}
  const ThemeModeConverter();
}

final class _ThemeModeToStringConverter extends Converter<String, ThemeMode> {
  const _ThemeModeToStringConverter();

  @override
  String convert(ThemeMode input) {
    return input.name;
  }
}

final class _StringToThemeModeConverter extends Converter<ThemeMode, String> {
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
