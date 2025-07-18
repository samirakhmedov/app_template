part of 'shader_bloc.dart';

/// Shader state for BloC.
@freezed
abstract class ShaderState with _$ShaderState {
  /// {@template shader_state}
  /// State for the shader BLoC.
  /// {@endtemplate}
  const factory ShaderState({
    /// Map of shader types to their loaded fragment shaders.
    @Default({}) Map<ShaderType, ui.FragmentShader?> shaders,
  }) = _ShaderState;
}
