import 'package:app_di/app_di.dart';
import 'package:app_presentation/app_presentation.dart';
import 'package:device_settings_di/device_settings_di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeviceSettingsComponent extends StatefulWidget {
  final Widget child;

  const DeviceSettingsComponent({
    required this.child,
    super.key,
  });

  @override
  State<DeviceSettingsComponent> createState() => _DeviceSettingsComponentState();
}

class _DeviceSettingsComponentState extends State<DeviceSettingsComponent> {
  @override
  Widget build(BuildContext context) {
    return DiScope<IDeviceSettingsScope>(
      scopeBuilder: (ctx) => DeviceSettingsScopeRegistrar(
        DeviceSettingsScopeHolder(ctx.read<IAppScope>()),
      ),
      scopeWidgetBuilder: (ctx, scope) => BlocProvider.value(
        value: scope.deviceSettingsBloc,
        child: widget.child,
      ),
      placeholder: widget.child,
    );
  }
}
