import 'package:app_template/core/architecture/domain/entity/request_operation.dart';
import 'package:app_template/features/theme/domain/entities/theme_mode.dart';
import 'package:flutter/foundation.dart';

/// {@template i_theme_repository}
/// An interface for the theme repository.
/// {@endtemplate}
abstract interface class IThemeRepository {
  /// The theme mode.
  ValueListenable<ThemeMode> get themeMode;

  /// Sets the theme mode.
  RequestOperation<void> setThemeMode(ThemeMode mode);
}
