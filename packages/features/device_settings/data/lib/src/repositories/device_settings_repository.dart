import 'dart:async';

import 'package:app_data/app_data.dart';
import 'package:app_domain/app_domain.dart';
import 'package:device_settings_data/src/converters/app_device_orientation_converter.dart';
import 'package:device_settings_data/src/converters/app_system_ui_mode_converter.dart';
import 'package:device_settings_domain/device_settings_domain.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';

final class DeviceSettingsRepository extends BaseRepository implements IDeviceSettingsRepository {
  final AppDeviceOrientationConverter _orientationConverter;
  final AppSystemUiModeConverter _systemUiModeConverter;
  final AppSystemUiOverlayStyleConverter _overlayStyleConverter;

  const DeviceSettingsRepository({
    required super.logger,
    AppDeviceOrientationConverter orientationConverter = const AppDeviceOrientationConverter(),
    AppSystemUiModeConverter systemUiModeConverter = const AppSystemUiModeConverter(),
    AppSystemUiOverlayStyleConverter overlayStyleConverter = const AppSystemUiOverlayStyleConverter(),
  }) : _orientationConverter = orientationConverter,
       _systemUiModeConverter = systemUiModeConverter,
       _overlayStyleConverter = overlayStyleConverter;

  @override
  RequestOperation<void> applySettings(DeviceSettings settings) {
    return makeCall(
      () => Future.wait([
        setRefreshRate(settings.refreshRate),
        setOrientations(settings.orientations),
        setOverlayStyle(settings.overlayStyle),
        setSystemUiMode(settings.systemUiMode),
      ]),
    );
  }

  @override
  RequestOperation<void> setRefreshRate(int? refreshRate) {
    return makeCall(() {
      if (refreshRate == null) return SynchronousFuture(null);

      return FlutterDisplayMode.setHighRefreshRate();
    });
  }

  @override
  RequestOperation<void> setOrientations(List<AppDeviceOrientation> orientations) {
    return makeCall(
      () => SystemChrome.setPreferredOrientations(
        orientations.map(_orientationConverter.convert).toList(),
      ),
    );
  }

  @override
  RequestOperation<void> setSystemUiMode(AppSystemUiMode mode) {
    return makeCall(
      () => SystemChrome.setEnabledSystemUIMode(_systemUiModeConverter.convert(mode)),
    );
  }

  @override
  RequestOperation<void> setOverlayStyle(AppSystemUiOverlayStyle? style) {
    return makeCall(
      () {
        if (style == null) return SynchronousFuture(null);

        SystemChrome.setSystemUIOverlayStyle(_overlayStyleConverter.convert(style));

        return Future.value();
      },
    );
  }
}
