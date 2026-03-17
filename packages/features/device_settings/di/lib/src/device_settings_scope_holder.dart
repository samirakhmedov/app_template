import 'package:app_di/app_di.dart';
import 'package:device_settings_di/src/device_settings_scope_container.dart';
import 'package:yx_scope/yx_scope.dart';

/// {@template device_settings_scope_holder}
/// A holder for the device settings scope.
/// {@endtemplate}
class DeviceSettingsScopeHolder extends ChildScopeHolder<DeviceSettingsScopeContainer, IAppScope> {
  /// {@macro device_settings_scope_holder}
  DeviceSettingsScopeHolder(super.parent);

  @override
  DeviceSettingsScopeContainer createContainer(IAppScope parent) => DeviceSettingsScopeContainer(parent: parent);
}
