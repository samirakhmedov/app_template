import 'package:app_domain/src/entities/request_operation.dart';
import 'package:flutter/foundation.dart';

abstract interface class IThemeRepository {
  ValueListenable<ThemeMode> get themeMode;
  RequestOperation<void> setThemeMode(ThemeMode mode);
}
