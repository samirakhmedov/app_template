import 'package:app_template/core/architecture/domain/entity/request_operation.dart';
import 'package:app_template/core/data/repositories/base_repository.dart';
import 'package:app_template/features/theme/data/services/i_theme_service.dart';
import 'package:app_template/features/theme/domain/entities/theme_mode.dart';
import 'package:app_template/features/theme/domain/repositories/i_theme_repository.dart';
import 'package:flutter/foundation.dart';

/// {@template theme_repository}
/// A repository for the theme.
/// {@endtemplate}
final class ThemeRepository extends BaseRepository implements IThemeRepository {
  final IThemeService _themeService;

  @override
  ValueListenable<ThemeMode> get themeMode => _themeService.themeMode;

  /// {@macro theme_repository}
  const ThemeRepository({
    required IThemeService themeService,
    required super.logger,
  }) : _themeService = themeService;

  @override
  RequestOperation<void> setThemeMode(ThemeMode mode) {
    return makeCall(
      () => _themeService.setThemeMode(mode),
    );
  }
}
