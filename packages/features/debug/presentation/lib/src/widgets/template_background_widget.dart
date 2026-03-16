import 'package:flutter/material.dart';
import 'package:uikit/uikit.dart';

/// {@template template_background_widget}
/// A widget that displays a gradient background.
/// {@endtemplate}
class TemplateBackgroundWidget extends StatelessWidget {
  /// {@macro template_background_widget}
  const TemplateBackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _GradientBackground(
          alignment: AlignmentGeometry.xy(0, 0),
          color: context.appColorScheme.primary,
        ),
        _GradientBackground(
          alignment: AlignmentGeometry.xy(-0.8, 0.7),
          color: context.appColorScheme.secondary,
        ),
        _GradientBackground(
          alignment: AlignmentGeometry.xy(-0.7, -0.9),
          color: context.appColorScheme.danger,
        ),
      ],
    );
  }
}

class _GradientBackground extends StatelessWidget {
  const _GradientBackground({
    required this.alignment,
    required this.color,
  });

  final AlignmentGeometry alignment;

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: alignment,
            radius: 2,
            colors: [
              color,
              Colors.white.withAlpha(0),
            ],
            focalRadius: 1,
          ),
        ),
      ),
    );
  }
}
