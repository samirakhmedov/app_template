import 'package:app_template/core/architecture/di/disposable.dart';
import 'package:app_template/features/theme/domain/entities/theme_mode.dart';
import 'package:flutter/foundation.dart';

/// {@template i_theme_service}
/// An interface for the theme service.
/// {@endtemplate}
abstract interface class IThemeService implements LifecycleObject {
  /// The theme mode.
  ValueListenable<ThemeMode> get themeMode;

  /// Sets the theme mode.
  Future<void> setThemeMode(ThemeMode mode);
}
