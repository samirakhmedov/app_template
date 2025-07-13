import 'package:flutter/material.dart';
import 'package:vector_graphics/vector_graphics.dart';

/// {@template asset_image_widget.class}
/// Возвращает виджет который зависит от источника изображения.
/// {@endtemplate}
class VectorImageWidget extends StatelessWidget {
  /// {@macro asset_image_widget.class.class}
  const VectorImageWidget({
    required this.asset,
    this.borderRadius = BorderRadius.zero,
    super.key,
    this.width,
    this.height,
    this.fit,
    this.color,
  });

  /// Цвет изображения.
  final Color? color;

  /// Путь до локального изображения.
  final String asset;

  /// Ширина изображения.
  final double? width;

  /// Высота изображения.
  final double? height;

  /// Радиус закругления углов изображения.
  final BorderRadius borderRadius;

  /// [BoxFit] для изображения.
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    final color = this.color;

    Widget widget = VectorGraphic(
      loader: AssetBytesLoader(asset),
      width: width,
      height: height,
      fit: fit ?? BoxFit.cover,
      colorFilter: color == null ? null : ColorFilter.mode(color, BlendMode.srcIn),
    );

    if (borderRadius != BorderRadius.zero) {
      widget = ClipRRect(borderRadius: borderRadius, child: widget);
    }

    return widget;
  }
}
