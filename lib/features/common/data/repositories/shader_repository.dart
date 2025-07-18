import 'dart:ui' as ui;

import 'package:app_template/core/architecture/domain/entity/request_operation.dart';
import 'package:app_template/core/data/repositories/base_repository.dart';
import 'package:app_template/features/common/data/services/i_shader_service.dart';
import 'package:app_template/features/common/domain/entities/shader_type.dart';
import 'package:app_template/features/common/domain/repositories/i_shader_repository.dart';
import 'package:flutter/foundation.dart';

/// {@template shader_repository}
/// A repository for the shader management.
/// {@endtemplate}
final class ShaderRepository extends BaseRepository implements IShaderRepository {
  final IShaderService _shaderService;

  @override
  ValueListenable<Map<ShaderType, ui.FragmentShader?>> get shaders => _shaderService.shaders;

  /// {@macro shader_repository}
  const ShaderRepository({
    required IShaderService shaderService,
    required super.logger,
  }) : _shaderService = shaderService;

  @override
  RequestOperation<void> loadShader(ShaderType shaderType) =>
      makeCall(() async => _shaderService.loadShader(shaderType));

  @override
  RequestOperation<void> preloadAllShaders() =>
      makeCall(() async => _shaderService.preloadAllShaders());

  @override
  RequestOperation<void> handleMemoryPressure() =>
      makeCall(() async => _shaderService.handleMemoryPressure());
}
