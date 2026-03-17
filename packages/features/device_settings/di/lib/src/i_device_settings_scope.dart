import 'package:device_settings_domain/device_settings_domain.dart';
import 'package:yx_scope/yx_scope.dart';

/// {@template i_device_settings_scope}
/// An interface for the device settings scope.
/// {@endtemplate}
abstract interface class IDeviceSettingsScope implements Scope {
  /// The device settings bloc.
  DeviceSettingsBloc get deviceSettingsBloc;
}
