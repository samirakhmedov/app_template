import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:device_settings_domain/src/entities/app_device_orientation.dart';
import 'package:device_settings_domain/src/entities/app_system_ui_mode.dart';
import 'package:device_settings_domain/src/entities/app_system_ui_overlay_style.dart';

part 'device_settings.freezed.dart';

@freezed
sealed class DeviceSettings with _$DeviceSettings {
  const factory DeviceSettings({
    @Default(null) int? refreshRate,
    @Default([
      AppDeviceOrientation.portraitUp,
      AppDeviceOrientation.portraitDown,
    ])
    List<AppDeviceOrientation> orientations,
    @Default(AppSystemUiMode.edgeToEdge) AppSystemUiMode systemUiMode,
    AppSystemUiOverlayStyle? overlayStyle,
  }) = _DeviceSettings;
}
