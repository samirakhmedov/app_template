part of 'device_settings_bloc.dart';

@freezed
sealed class DeviceSettingsEvent with _$DeviceSettingsEvent {
  const factory DeviceSettingsEvent.initialize() = DeviceSettingsInitialize;

  const factory DeviceSettingsEvent.setRefreshRate(int? rate) = DeviceSettingsSetRefreshRate;

  const factory DeviceSettingsEvent.setOrientations(
    List<AppDeviceOrientation> orientations,
  ) = DeviceSettingsSetOrientations;

  const factory DeviceSettingsEvent.setSystemUiMode(AppSystemUiMode mode) = DeviceSettingsSetSystemUiMode;

  const factory DeviceSettingsEvent.setOverlayStyle(AppSystemUiOverlayStyle? style) = DeviceSettingsSetOverlayStyle;
}
