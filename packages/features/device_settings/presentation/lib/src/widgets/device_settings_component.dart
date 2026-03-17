import 'package:app_presentation/app_presentation.dart';
import 'package:device_settings_domain/device_settings_domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class DeviceSettingsComponent extends Component<EmptyViewModel, ChildLayout> {
  final Widget child;

  const DeviceSettingsComponent({
    required this.child,
    super.key,
  });

  @override
  ComponentState<DeviceSettingsComponent, EmptyViewModel, ChildLayout> createState() => _DeviceSettingsComponentState();
}

class _DeviceSettingsComponentState extends ComponentState<DeviceSettingsComponent, EmptyViewModel, ChildLayout> {
  late final DeviceSettingsBloc deviceSettingsBloc;

  @override
  void initState() {
    super.initState();
    deviceSettingsBloc = context.read<DeviceSettingsBloc>();
    deviceSettingsBloc.add(const DeviceSettingsEvent.initialize());
  }

  @override
  ChildLayout view() => ChildLayout(child: widget.child);
}
