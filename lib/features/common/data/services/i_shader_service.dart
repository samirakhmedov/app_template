import 'dart:ui' as ui;

import 'package:app_template/core/architecture/di/disposable.dart';
import 'package:app_template/features/common/domain/entities/shader_type.dart';
import 'package:flutter/foundation.dart';

/// {@template i_shader_service}
/// Interface for the shader service that manages fragment shaders lifecycle.
/// {@endtemplate}
abstract interface class IShaderService implements LifecycleObject {
  /// Reactive unmodifiable map of loaded shaders.
  ///
  /// The map contains all shader types as keys and their corresponding
  /// [ui.FragmentShader] instances as values. A null value indicates
  /// that the shader is not yet loaded.
  ValueListenable<Map<ShaderType, ui.FragmentShader?>> get shaders;

  /// Loads a specific shader by its type.
  ///
  /// The shader will be loaded from the asset path corresponding to the
  /// [shaderType] and made available through the [shaders] map.
  Future<void> loadShader(ShaderType shaderType);

  /// Preloads all configured shaders.
  ///
  /// This method loads all available shader types for improved performance.
  Future<void> preloadAllShaders();

  /// Handles memory pressure by clearing and optionally reloading shaders.
  ///
  /// This method clears all loaded shaders and their programs from memory.
  /// It can optionally reload shaders after clearing for memory management.
  Future<void> handleMemoryPressure();
}
