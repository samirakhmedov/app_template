import 'dart:async';
import 'dart:ui' as ui;

import 'package:app_template/features/common/domain/entities/shader_type.dart';
import 'package:app_template/features/common/domain/repositories/i_shader_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'shader_bloc.freezed.dart';
part 'shader_event.dart';
part 'shader_state.dart';

/// {@template shader_bloc}
/// A bloc for shader management.
/// {@endtemplate}
class ShaderBloc extends Bloc<ShaderEvent, ShaderState> {
  final IShaderRepository _shaderRepository;

  /// {@macro shader_bloc}
  ShaderBloc({required IShaderRepository shaderRepository})
    : _shaderRepository = shaderRepository,
      super(const ShaderState()) {
    on<ShaderInitialize>(_initialize);
    on<ShaderLoadShader>(_loadShader);
    on<ShaderHandleMemoryPressure>(_handleMemoryPressure);
    on<_ShaderUpdateState>(_updateState);
  }

  @override
  Future<void> close() {
    _shaderRepository.shaders.removeListener(_shaderListener);

    return super.close();
  }

  void _initialize(ShaderInitialize event, Emitter<ShaderState> emit) {
    _shaderRepository.shaders.addListener(_shaderListener);

    emit(state.copyWith(shaders: _shaderRepository.shaders.value));
  }

  void _shaderListener() {
    add(ShaderEvent._updateState(_shaderRepository.shaders.value));
  }

  Future<void> _loadShader(ShaderLoadShader event, Emitter<ShaderState> emit) async {
    await _shaderRepository.loadShader(event.shaderType);
  }

  Future<void> _handleMemoryPressure(
    ShaderHandleMemoryPressure event,
    Emitter<ShaderState> emit,
  ) async {
    await _shaderRepository.handleMemoryPressure();
  }

  void _updateState(_ShaderUpdateState event, Emitter<ShaderState> emit) {
    emit(state.copyWith(shaders: event.shaders));
  }
}
