import 'package:app_template/util/extensions/closures.dart';
import 'package:flutter/material.dart';
import 'package:uikit/uikit.dart';

/// A widget that displays a shimmer block.
///
/// This widget is used to create a placeholder for content that is being loaded.
class ShimmerBlock extends StatelessWidget {
  /// Creates a new [ShimmerBlock] widget.
  const ShimmerBlock({
    required this.width,
    required this.height,
    this.borderRadius,
    super.key,
  });

  /// The width of the block.
  final double width;

  /// The height of the block.
  final double height;

  /// The border radius of the block.
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.appColorScheme.skeletonSecondary,
        borderRadius:
            borderRadius.let(BorderRadius.circular) ?? context.appSizesScheme.borderRadiusGeneral,
      ),
      child: SizedBox(
        width: width,
        height: height,
      ),
    );
  }
}
