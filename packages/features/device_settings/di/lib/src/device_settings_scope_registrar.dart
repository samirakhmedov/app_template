import 'package:app_presentation/app_presentation.dart';
import 'package:device_settings_di/src/device_settings_scope_holder.dart';
import 'package:device_settings_di/src/i_device_settings_scope.dart';

/// {@template device_settings_scope_registrar}
/// A registrar for the device settings scope.
/// {@endtemplate}
class DeviceSettingsScopeRegistrar implements DependenciesRegistrar<IDeviceSettingsScope> {
  /// The holder for the device settings scope.
  final DeviceSettingsScopeHolder holder;

  /// {@macro device_settings_scope_registrar}
  const DeviceSettingsScopeRegistrar(this.holder);

  @override
  Future<void> dispose() => holder.drop();

  @override
  Future<IDeviceSettingsScope> initialize() async {
    await holder.create();

    // ignore: avoid-non-null-assertion
    return holder.scope!;
  }
}
