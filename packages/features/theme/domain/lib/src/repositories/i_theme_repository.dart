import 'package:app_domain/app_domain.dart';
import 'package:theme_domain/theme_domain.dart';

abstract interface class IThemeRepository {
  ThemeMode get themeMode;
  RequestOperation<void> setThemeMode(ThemeMode mode);
}
