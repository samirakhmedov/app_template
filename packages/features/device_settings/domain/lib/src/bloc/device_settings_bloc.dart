import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:device_settings_domain/device_settings_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_settings_event.dart';
part 'device_settings_state.dart';
part 'device_settings_bloc.freezed.dart';

class DeviceSettingsBloc extends Bloc<DeviceSettingsEvent, DeviceSettingsState> {
  final IDeviceSettingsRepository _repository;

  DeviceSettingsBloc({
    required IDeviceSettingsRepository repository,
  }) : _repository = repository,
       super(const DeviceSettingsState()) {
    on<DeviceSettingsInitialize>(_initialize);
    on<DeviceSettingsSetRefreshRate>(_setRefreshRate);
    on<DeviceSettingsSetOrientations>(_setOrientations);
    on<DeviceSettingsSetSystemUiMode>(_setSystemUiMode);
    on<DeviceSettingsSetOverlayStyle>(_setOverlayStyle);
  }

  Future<void> _initialize(
    DeviceSettingsInitialize event,
    Emitter<DeviceSettingsState> emit,
  ) async {
    await _repository.applySettings(state.settings);
    emit(state.copyWith(isInitialized: true));
  }

  Future<void> _setRefreshRate(
    DeviceSettingsSetRefreshRate event,
    Emitter<DeviceSettingsState> emit,
  ) async {
    final newSettings = state.settings.copyWith(refreshRate: event.rate);
    await _repository.setRefreshRate(event.rate);
    emit(state.copyWith(settings: newSettings));
  }

  Future<void> _setOrientations(
    DeviceSettingsSetOrientations event,
    Emitter<DeviceSettingsState> emit,
  ) async {
    final newSettings = state.settings.copyWith(orientations: event.orientations);
    await _repository.setOrientations(event.orientations);
    emit(state.copyWith(settings: newSettings));
  }

  Future<void> _setSystemUiMode(
    DeviceSettingsSetSystemUiMode event,
    Emitter<DeviceSettingsState> emit,
  ) async {
    final newSettings = state.settings.copyWith(systemUiMode: event.mode);
    await _repository.setSystemUiMode(event.mode);
    emit(state.copyWith(settings: newSettings));
  }

  Future<void> _setOverlayStyle(
    DeviceSettingsSetOverlayStyle event,
    Emitter<DeviceSettingsState> emit,
  ) async {
    final newSettings = state.settings.copyWith(overlayStyle: event.style);
    await _repository.setOverlayStyle(event.style);
    emit(state.copyWith(settings: newSettings));
  }
}
