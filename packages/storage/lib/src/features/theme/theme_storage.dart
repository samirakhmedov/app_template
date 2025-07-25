import 'package:storage/src/core/storage/storage.dart';
import 'package:storage/src/features/theme/i_theme_storage.dart';

/// {@template theme_storage}
/// A storage for the theme.
/// {@endtemplate}
class ThemeStorage implements IThemeStorage {
  final Storage _storage;

  /// {@macro theme_storage}
  const ThemeStorage({required Storage storage}) : _storage = storage;

  @override
  Future<String?> getThemeMode() {
    return _storage.getString(_ThemeStorageKeys.theme.key);
  }

  @override
  Future<void> setThemeMode(String mode) async {
    await _storage.setString(_ThemeStorageKeys.theme.key, mode);
  }
}

enum _ThemeStorageKeys {
  theme('theme');

  final String key;

  const _ThemeStorageKeys(this.key);
}
