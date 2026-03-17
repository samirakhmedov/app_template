import 'dart:ui' as ui;

import 'package:flutter/painting.dart';

/// A [ShaderWarmUp] that pre-compiles the project's custom fragment shaders
/// before the first frame is rendered, moving GPU shader compilation from
/// animation time to startup time.
///
/// Pass the same [fragmentShaderPaths] that you provide to
/// ShaderProviderComponent so both loading steps target the same assets.
class AllShadersWarmUp extends ShaderWarmUp {
  const AllShadersWarmUp({this.fragmentShaderPaths = const []});

  /// Asset paths of the custom fragment shaders to warm up.
  final List<String> fragmentShaderPaths;

  @override
  Future<void> warmUpOnCanvas(ui.Canvas canvas) async {
    var index = 0;

    for (final path in fragmentShaderPaths) {
      try {
        final program = await ui.FragmentProgram.fromAsset(path);
        final shader = program.fragmentShader();
        canvas.drawRect(
          (ui.Offset(10, 10) * index.toDouble()) & const ui.Size(15, 15),
          ui.Paint()..shader = shader,
        );
        index++;
      } on Object catch (_) {
        // Shader unavailable (web / test env) — skip.
      }
    }
  }
}
