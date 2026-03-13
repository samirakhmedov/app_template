part of 'device_settings_bloc.dart';

@freezed
sealed class DeviceSettingsState with _$DeviceSettingsState {
  const factory DeviceSettingsState({
    @Default(DeviceSettings()) DeviceSettings settings,
    @Default(false) bool isInitialized,
  }) = _DeviceSettingsState;
}
