import 'package:app_data/app_data.dart';
import 'package:app_domain/app_domain.dart';
import 'package:theme_data/src/services/i_theme_service.dart';
import 'package:theme_domain/theme_domain.dart';

/// {@template theme_repository}
/// A repository for the theme.
/// {@endtemplate}
final class ThemeRepository extends BaseRepository implements IThemeRepository {
  final IThemeService _themeService;

  @override
  ThemeMode get themeMode => _themeService.themeMode.value;

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
