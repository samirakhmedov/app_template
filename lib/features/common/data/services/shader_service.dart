import 'dart:ui' as ui;

import 'package:app_template/features/common/data/services/i_shader_service.dart';
import 'package:app_template/features/common/domain/entities/shader_type.dart';
import 'package:flutter/foundation.dart';

abstract interface class _Shaders {
  static const shimmer = 'assets/shaders/shimmer.frag';
}

/// Extension methods for [ShaderType] to provide flutter_gen asset access.
extension _ShaderTypeExtension on ShaderType {
  /// Gets the asset path using flutter_gen.
  String get assetPath {
    switch (this) {
      case ShaderType.shimmer:
        return _Shaders.shimmer;
    }
  }
}

/// {@template shader_service}
/// Implementation of the shader service that manages fragment shaders lifecycle.
/// {@endtemplate}
final class ShaderService implements IShaderService {
  /// The notifier for the shaders map.
  late final ValueNotifier<Map<ShaderType, ui.FragmentShader?>> _shadersNotifier;

  @override
  ValueListenable<Map<ShaderType, ui.FragmentShader?>> get shaders => _shadersNotifier;

  @override
  Future<void> dispose() async {
    // Dispose individual FragmentShader instances
    for (final shader in _shadersNotifier.value.values) {
      shader?.dispose();
    }

    _shadersNotifier.value = {};

    // Dispose ValueNotifier
    _shadersNotifier.dispose();
  }

  @override
  Future<void> initialize() async {
    // Initialize shaders map with null values for all ShaderType values
    final initialShaders = <ShaderType, ui.FragmentShader?>{};

    // Set up ValueNotifier with unmodifiable map
    _shadersNotifier = ValueNotifier(Map.unmodifiable(initialShaders));
  }

  @override
  Future<void> loadShader(ShaderType shaderType) async {
    if (_shadersNotifier.value.containsKey(shaderType)) return;

    // Load FragmentProgram using flutter_gen asset path
    final program = await ui.FragmentProgram.fromAsset(shaderType.assetPath);

    // Create FragmentShader instance
    final shader = program.fragmentShader();

    // Update map and notify listeners with unmodifiable map
    final updatedShaders = Map<ShaderType, ui.FragmentShader?>.from(_shadersNotifier.value);
    updatedShaders[shaderType] = shader;
    _shadersNotifier.value = Map.unmodifiable(updatedShaders);
  }

  @override
  Future<void> preloadAllShaders() async {
    // Load all shader types in parallel using Future.wait
    await Future.wait([
      for (final shaderType in ShaderType.values) loadShader(shaderType),
    ]);
  }

  @override
  Future<void> handleMemoryPressure() async {
    // Dispose individual FragmentShader instances
    for (final shader in _shadersNotifier.value.values) {
      shader?.dispose();
    }

    // Reset map to null values
    final clearedShaders = <ShaderType, ui.FragmentShader?>{};

    // Notify listeners with unmodifiable map
    _shadersNotifier.value = Map.unmodifiable(clearedShaders);
  }
}
