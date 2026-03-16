/// {@template i_theme_storage}
/// An interface for the theme storage.
/// {@endtemplate}
abstract interface class IThemeStorage {
  /// Gets the theme mode.
  ///
  /// Returns either 'system', 'dark', 'light' or null.
  Future<String?> getThemeMode();

  /// Sets the theme mode.
  Future<void> setThemeMode(String mode);
}
