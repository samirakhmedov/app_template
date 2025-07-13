import 'package:flutter/material.dart';

/// {@template color_opacity.class}
/// A widget that applies a color filter to its child with the specified opacity.
/// {@endtemplate}
class ColorOpacity extends StatelessWidget {
  /// {@macro color_opacity.class}
  const ColorOpacity({
    required this.opacity,
    required this.child,
    super.key,
  });

  /// The opacity of the color.
  final double opacity;

  /// The child widget.
  final Widget child;

  ColorFilter _opacity(double opacity) => ColorFilter.matrix([
    1, 0, 0, 0, 0, // Red channel remains unchanged
    0, 1, 0, 0, 0, // Green channel remains unchanged
    0, 0, 1, 0, 0, // Blue channel remains unchanged
    0, 0, 0, opacity, 0, // Multiply the alpha channel by [opacity]
  ]);

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: _opacity(opacity),
      child: child,
    );
  }
}
