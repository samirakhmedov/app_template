import 'package:flutter/material.dart';
import 'package:uikit/src/others/color_opacity.dart';

/// {@template inactive_wrapper.class}
/// A wrapper for displaying inactive elements.
/// {@endtemplate}
class InactiveWrapper extends StatelessWidget {
  /// {@macro inactive_wrapper.class}
  const InactiveWrapper({required this.child, required this.inactive, super.key});

  /// @nodoc.
  final Widget child;

  /// Whether the widget is inactive.
  final bool inactive;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: inactive,
      child: ColorOpacity(
        opacity: inactive ? 0.5 : 1,
        child: child,
      ),
    );
  }
}
