import 'package:app_domain/app_domain.dart';
import 'package:device_settings_domain/src/entities/app_device_orientation.dart';
import 'package:device_settings_domain/src/entities/app_system_ui_mode.dart';
import 'package:device_settings_domain/src/entities/app_system_ui_overlay_style.dart';
import 'package:device_settings_domain/src/entities/device_settings.dart';

abstract interface class IDeviceSettingsRepository {
  RequestOperation<void> applySettings(DeviceSettings settings);

  RequestOperation<void> setRefreshRate(int? refreshRate);

  RequestOperation<void> setOrientations(List<AppDeviceOrientation> orientations);

  RequestOperation<void> setSystemUiMode(AppSystemUiMode mode);

  RequestOperation<void> setOverlayStyle(AppSystemUiOverlayStyle? style);
}
