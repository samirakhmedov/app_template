import 'dart:ui' as ui;

import 'package:app_template/core/architecture/domain/entity/request_operation.dart';
import 'package:app_template/features/common/domain/entities/shader_type.dart';
import 'package:flutter/foundation.dart';

/// {@template i_shader_repository}
/// Interface for the shader repository that provides clean access to shader operations.
/// {@endtemplate}
abstract interface class IShaderRepository {
  /// Reactive shader access.
  ///
  /// Provides access to the unmodifiable map of loaded shaders.
  /// A null value indicates that the shader is not yet loaded.
  ValueListenable<Map<ShaderType, ui.FragmentShader?>> get shaders;

  /// Loads a specific shader by its type.
  ///
  /// Returns a [RequestOperation] that completes when the shader is loaded
  /// or fails with an error if the loading fails.
  RequestOperation<void> loadShader(ShaderType shaderType);

  /// Preloads all configured shaders.
  ///
  /// Returns a [RequestOperation] that completes when all shaders are loaded
  /// or fails with an error if any shader loading fails.
  RequestOperation<void> preloadAllShaders();

  /// Handles memory pressure by clearing and reloading shaders.
  ///
  /// Returns a [RequestOperation] that completes when memory pressure
  /// handling is finished or fails with an error.
  RequestOperation<void> handleMemoryPressure();
}
