/// {@template app_shaders}
/// Shader asset path constants for the app.
///
/// Fragment shaders are declared under `flutter: shaders:` in the package
/// pubspec and are not picked up by flutter_gen, so paths are listed here.
/// {@endtemplate}
abstract class AppShaders {
  /// Asset path for the shimmer fragment shader.
  static const shimmerFrag = 'packages/app_assets/assets/shaders/shimmer.frag';
}
