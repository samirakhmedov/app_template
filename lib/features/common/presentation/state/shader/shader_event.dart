part of 'shader_bloc.dart';

/// Shader events for BloC.
@freezed
sealed class ShaderEvent with _$ShaderEvent {
  /// Initialize shader system.
  const factory ShaderEvent.initialize() = ShaderInitialize;

  /// Load a specific shader.
  const factory ShaderEvent.loadShader(ShaderType shaderType) = ShaderLoadShader;

  /// Handle memory pressure.
  const factory ShaderEvent.handleMemoryPressure() = ShaderHandleMemoryPressure;

  /// Private event for updating state from repository.
  const factory ShaderEvent._updateState(Map<ShaderType, ui.FragmentShader?> shaders) =
      _ShaderUpdateState;
}
