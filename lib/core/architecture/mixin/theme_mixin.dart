import 'package:app_template/core/architecture/presentation/component.dart';
import 'package:flutter/material.dart';
import 'package:uikit/uikit.dart';

/// {@template theme_mixin}
/// A mixin that provides access to the theme.
/// {@endtemplate}
mixin ThemeMixin {
  /// The sizes scheme.
  AppSizesScheme get sizes => context.appSizesScheme;

  /// The color scheme.
  AppColorScheme get colors => context.appColorScheme;

  /// The text scheme.
  AppTextScheme get text => context.appTextScheme;

  /// The context.
  BuildContext get context;
}

/// {@template theme_vm}
/// A view model that provides access to the theme.
/// {@endtemplate}
abstract interface class ThemeVM implements ViewModel {
  /// The sizes scheme.
  AppSizesScheme get sizes;

  /// The color scheme.
  AppColorScheme get colors;

  /// The text scheme.
  AppTextScheme get text;
}
