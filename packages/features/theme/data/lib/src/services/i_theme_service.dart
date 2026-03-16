import 'package:app_domain/app_domain.dart';
import 'package:flutter/foundation.dart';
import 'package:theme_domain/theme_domain.dart';

/// {@template i_theme_service}
/// An interface for the theme service.
/// {@endtemplate}
abstract interface class IThemeService implements LifecycleObject {
  /// The theme mode.
  ValueListenable<ThemeMode> get themeMode;

  /// Sets the theme mode.
  Future<void> setThemeMode(ThemeMode mode);
}
