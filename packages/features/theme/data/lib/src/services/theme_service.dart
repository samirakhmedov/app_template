import 'package:flutter/foundation.dart';
import 'package:storage/storage.dart';
import 'package:theme_data/src/converters/theme_mode_converter.dart';
import 'package:theme_data/src/services/i_theme_service.dart';
import 'package:theme_domain/theme_domain.dart';

/// {@template theme_service}
/// A service for the theme.
/// {@endtemplate}
class ThemeService implements IThemeService {
  final IThemeStorage _themeStorage;
  final ThemeModeConverter _themeModeConverter;

  late final ValueNotifier<ThemeMode> _themeModeNotifier;

  @override
  ValueListenable<ThemeMode> get themeMode => _themeModeNotifier;

  /// {@macro theme_service}
  ThemeService({
    required IThemeStorage themeStorage,
    required ThemeModeConverter themeModeConverter,
  }) : _themeStorage = themeStorage,
       _themeModeConverter = themeModeConverter;

  @override
  Future<void> dispose() async {
    _themeModeNotifier.dispose();
  }

  @override
  Future<void> initialize() async {
    final savedMode = await _themeStorage.getThemeMode();

    final converted = _themeModeConverter.decode(savedMode ?? '');

    _themeModeNotifier = ValueNotifier(converted);
  }

  @override
  Future<void> setThemeMode(ThemeMode mode) async {
    if (_themeModeNotifier.value == mode) return;

    final converted = _themeModeConverter.encode(mode);

    await _themeStorage.setThemeMode(converted);

    _themeModeNotifier.value = mode;
  }
}
