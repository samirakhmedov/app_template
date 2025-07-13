import 'package:flutter/material.dart';

/// {@template height}
/// A widget that separates elements.
/// {@endtemplate}
class Height extends StatelessWidget {
  /// {@macro height}
  const Height(this.height, {super.key});

  /// The height of the widget.
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 0,
      height: height,
    );
  }
}
