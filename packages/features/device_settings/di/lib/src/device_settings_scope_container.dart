import 'package:app_di/app_di.dart';
import 'package:app_presentation/app_presentation.dart';
import 'package:device_settings_data/device_settings_data.dart';
import 'package:device_settings_di/src/i_device_settings_scope.dart';
import 'package:device_settings_domain/device_settings_domain.dart';
import 'package:yx_scope/yx_scope.dart';

/// {@template device_settings_scope_container}
/// A container for the device settings scope.
/// {@endtemplate}
class DeviceSettingsScopeContainer extends ChildScopeContainer<IAppScope> implements IDeviceSettingsScope {
  /// The device settings repository dependency.
  late final _deviceSettingsRepositoryDep = dep<IDeviceSettingsRepository>(
    () => DeviceSettingsRepository(logger: parent.logger),
  );

  /// The device settings bloc dependency.
  late final deviceSettingsBlocDep = rawAsyncDep<DeviceSettingsBloc>(
    () => DeviceSettingsBloc(repository: _deviceSettingsRepositoryDep.get),
    init: (bloc) async => bloc.add(const DeviceSettingsEvent.initialize()),
    dispose: (bloc) => bloc.close(),
  );

  @override
  List<Set<AsyncDepType>> get initializeQueue => [
    {deviceSettingsBlocDep},
  ];

  @override
  DeviceSettingsBloc get deviceSettingsBloc => deviceSettingsBlocDep.get;

  /// {@macro device_settings_scope_container}
  DeviceSettingsScopeContainer({required super.parent});
}
