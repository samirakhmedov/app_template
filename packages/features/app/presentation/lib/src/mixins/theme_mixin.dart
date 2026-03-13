import 'package:app_presentation/src/widgets/component.dart';
import 'package:flutter/material.dart';
import 'package:uikit/uikit.dart';

mixin ThemeMixin {
  AppSizesScheme get sizes => context.appSizesScheme;

  AppColorScheme get colors => context.appColorScheme;

  AppTextScheme get text => context.appTextScheme;

  BuildContext get context;
}

abstract interface class ThemeVM implements ViewModel {
  AppSizesScheme get sizes;

  AppColorScheme get colors;

  AppTextScheme get text;
}
