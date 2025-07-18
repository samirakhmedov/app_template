/// Enum representing available shader types in the application.
///
/// Each shader type contains its display name.
enum ShaderType {
  /// Shimmer effect shader for creating animated shimmer effects.
  shimmer(
    displayName: ShaderNames.shimmer,
  );

  /// Creates a new [ShaderType] with the specified [displayName].
  const ShaderType({
    required this.displayName,
  });

  /// The human-readable display name for the shader.
  final String displayName;
}

/// Static class containing shader name constants.
abstract final class ShaderNames {
  /// Shimmer effect shader name.
  static const String shimmer = 'shimmer';
}
