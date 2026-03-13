import 'dart:convert';

import 'package:device_settings_domain/device_settings_domain.dart';
import 'package:flutter/services.dart';

final class AppDeviceOrientationConverter 
    extends Converter<AppDeviceOrientation, DeviceOrientation> {
  const AppDeviceOrientationConverter();

  @override
  DeviceOrientation convert(AppDeviceOrientation input) {
    return switch (input) {
      AppDeviceOrientation.portraitUp => DeviceOrientation.portraitUp,
      AppDeviceOrientation.portraitDown => DeviceOrientation.portraitDown,
      AppDeviceOrientation.landscapeLeft => DeviceOrientation.landscapeLeft,
      AppDeviceOrientation.landscapeRight => DeviceOrientation.landscapeRight,
    };
  }
}
