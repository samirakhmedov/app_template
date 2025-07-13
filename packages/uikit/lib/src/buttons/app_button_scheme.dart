import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';
import 'package:uikit/src/buttons/app_button_configurations.dart';
import 'package:uikit/src/buttons/app_button_style.dart';
import 'package:uikit/src/colors/app_color_scheme.dart';
import 'package:uikit/src/text/app_text_scheme.dart';

part 'app_button_scheme.tailor.dart';

/// App button styles.
///
/// This extension is in sync with base [ThemeData] and [AppButtonScheme].
///
/// Use case:
///
/// ```dart
/// final buttonScheme = AppButtonScheme.of(context);
///
/// return
/// ```
@immutable
@TailorMixin(themeGetter: ThemeGetter.onBuildContext)
class AppButtonScheme extends ThemeExtension<AppButtonScheme> with _$AppButtonSchemeTailorMixin {
  @override
  final ButtonStyle primaryLarge;

  @override
  final ButtonStyle primaryMedium;

  @override
  final ButtonStyle primarySmall;

  @override
  final ButtonStyle transparentLarge;

  @override
  final ButtonStyle transparentMedium;

  @override
  final ButtonStyle transparentSmall;

  @override
  final ButtonStyle primaryIcon;

  /// @nodoc.
  const AppButtonScheme({
    required this.primaryLarge,
    required this.primaryMedium,
    required this.primarySmall,
    required this.transparentLarge,
    required this.transparentMedium,
    required this.transparentSmall,
    required this.primaryIcon,
  });

  /// @nodoc.
  factory AppButtonScheme.base({
    required AppColorScheme colorScheme,
    required AppTextScheme textScheme,
  }) {
    return AppButtonScheme(
      primaryLarge: AppButtonStyle.primary(
        colorScheme: colorScheme,
        textScheme: textScheme,
        size: AppButtonSize.large,
      ),
      primaryMedium: AppButtonStyle.primary(
        colorScheme: colorScheme,
        textScheme: textScheme,
        size: AppButtonSize.medium,
      ),
      primarySmall: AppButtonStyle.primary(
        colorScheme: colorScheme,
        textScheme: textScheme,
        size: AppButtonSize.small,
      ),
      transparentLarge: AppButtonStyle.transparent(
        colorScheme: colorScheme,
        textScheme: textScheme,
        size: AppButtonSize.large,
      ),
      transparentMedium: AppButtonStyle.transparent(
        colorScheme: colorScheme,
        textScheme: textScheme,
        size: AppButtonSize.medium,
      ),
      transparentSmall: AppButtonStyle.transparent(
        colorScheme: colorScheme,
        textScheme: textScheme,
        size: AppButtonSize.small,
      ),
      primaryIcon: AppButtonStyle.primaryIcon(colorScheme: colorScheme),
    );
  }

  /// @nodoc.
  static AppButtonScheme of(BuildContext context) => context.appButtonScheme;

  @override
  AppButtonScheme lerp(
    covariant ThemeExtension<AppButtonScheme>? other,
    double t,
  ) {
    if (other is! AppButtonScheme) return this;

    return AppButtonScheme(
      primaryLarge: ButtonStyle.lerp(primaryLarge, other.primaryLarge, t) ?? primaryLarge,
      primaryMedium: ButtonStyle.lerp(primaryMedium, other.primaryMedium, t) ?? primaryMedium,
      primarySmall: ButtonStyle.lerp(primarySmall, other.primarySmall, t) ?? primarySmall,
      transparentLarge:
          ButtonStyle.lerp(transparentLarge, other.transparentLarge, t) ?? transparentLarge,
      transparentMedium:
          ButtonStyle.lerp(transparentMedium, other.transparentMedium, t) ?? transparentMedium,
      transparentSmall:
          ButtonStyle.lerp(transparentSmall, other.transparentSmall, t) ?? transparentSmall,
      primaryIcon: ButtonStyle.lerp(primaryIcon, other.primaryIcon, t) ?? primaryIcon,
    );
  }
}
