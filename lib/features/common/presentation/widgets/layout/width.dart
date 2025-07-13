import 'package:flutter/material.dart';

/// {@template width}
/// A widget that separates elements.
/// {@endtemplate}
class Width extends StatelessWidget {
  /// {@macro width}
  const Width(this.width, {super.key});

  /// The width of the widget.
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 0,
    );
  }
}
