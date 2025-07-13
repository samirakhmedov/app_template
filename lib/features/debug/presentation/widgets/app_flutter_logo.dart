import 'package:app_template/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:uikit/uikit.dart';

/// {@template app_flutter_logo}
/// A widget for the app flutter logo.
/// {@endtemplate}
class AppFlutterLogo extends StatelessWidget {
  /// {@macro app_flutter_logo}
  const AppFlutterLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return VectorImageWidget(
      asset: Assets.resources.vectors.logo,
      width: context.appSizesScheme.iconsSizeEnormous,
      height: context.appSizesScheme.iconsSizeEnormous,
      fit: BoxFit.contain,
      color: context.appColorScheme.onPrimary,
    );
  }
}
