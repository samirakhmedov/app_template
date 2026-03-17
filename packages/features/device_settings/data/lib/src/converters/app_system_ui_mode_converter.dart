import 'dart:convert';

import 'package:device_settings_domain/device_settings_domain.dart';
import 'package:flutter/services.dart';

final class AppSystemUiModeConverter extends Converter<AppSystemUiMode, SystemUiMode> {
  const AppSystemUiModeConverter();

  @override
  SystemUiMode convert(AppSystemUiMode input) {
    return switch (input) {
      AppSystemUiMode.edgeToEdge => SystemUiMode.edgeToEdge,
      AppSystemUiMode.immersive => SystemUiMode.immersive,
      AppSystemUiMode.immersiveSticky => SystemUiMode.immersiveSticky,
      AppSystemUiMode.leanBack => SystemUiMode.leanBack,
    };
  }
}

final class AppSystemUiOverlayStyleConverter extends Converter<AppSystemUiOverlayStyle, SystemUiOverlayStyle> {
  const AppSystemUiOverlayStyleConverter();

  @override
  SystemUiOverlayStyle convert(AppSystemUiOverlayStyle input) {
    return input.isDark ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light;
  }
}
