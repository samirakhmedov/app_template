// ignore_for_file: avoid-long-records, move-records-to-typedefs

import 'package:flutter/material.dart';
import 'package:uikit/src/buttons/app_button_configurations.dart';
import 'package:uikit/src/colors/app_color_scheme.dart';
import 'package:uikit/src/text/app_text_scheme.dart';

/// {@template app_button_style}
/// Стиль кнопки.
/// {@endtemplate}
class AppButtonStyle extends ButtonStyle {
  /// Цвет кнопки в обычном состоянии.
  final Color buttonColor;

  /// Цвет кнопки при наведении.
  final Color buttonHoverColor;

  /// Цвет кнопки при нажатии.
  final Color buttonPressedColor;

  /// Цвет кнопки в отключенном состоянии.
  final Color buttonDisabledColor;

  /// Цвет кнопки при фокусе.
  final Color buttonFocusColor;

  /// Цвет текста в обычном состоянии.
  final Color textColor;

  /// Цвет текста в отключенном состоянии.
  final Color textDisabledColor;

  /// Цвет текста при фокусе.
  final Color textFocusColor;

  @override
  WidgetStateColor get backgroundColor => WidgetStateColor.resolveWith((state) {
    if (state.contains(WidgetState.disabled)) {
      return buttonDisabledColor;
    }

    return buttonColor;
  });

  @override
  WidgetStateColor get overlayColor => WidgetStateColor.resolveWith((state) {
    if (state.contains(WidgetState.pressed)) {
      return buttonPressedColor;
    } else if (state.contains(WidgetState.focused)) {
      return buttonFocusColor;
    } else if (state.contains(WidgetState.hovered)) {
      return buttonHoverColor;
    }

    return Colors.transparent;
  });

  @override
  WidgetStateColor get foregroundColor => WidgetStateColor.resolveWith((state) {
    if (state.contains(WidgetState.disabled)) {
      return textDisabledColor;
    } else if (state.contains(WidgetState.hovered)) {
      return textColor;
    } else if (state.contains(WidgetState.focused)) {
      return textFocusColor;
    }

    return textColor;
  });

  @override
  WidgetStateColor get iconColor => foregroundColor;

  /// {@macro app_button_style}
  AppButtonStyle({
    required this.buttonColor,
    required this.buttonHoverColor,
    required this.buttonPressedColor,
    required this.buttonDisabledColor,
    required this.buttonFocusColor,
    required this.textColor,
    required this.textDisabledColor,
    required this.textFocusColor,
    required super.minimumSize,
    TextStyle? textStyle,
    EdgeInsetsGeometry? padding,
    super.fixedSize,
    WidgetStateProperty<OutlinedBorder?>? shape,
    super.iconSize,
  }) : super(
         animationDuration: kThemeChangeDuration,
         enableFeedback: true,
         alignment: Alignment.center,
         splashFactory: NoSplash.splashFactory,
         elevation: WidgetStateProperty.all(0),
         shadowColor: WidgetStateProperty.all(Colors.transparent),
         textStyle: WidgetStateProperty.all(textStyle),
         padding: WidgetStateProperty.all(padding),
         shape:
             shape ??
             WidgetStateProperty.all(
               RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(16),
               ),
             ),
       );

  /// Создать стиль для первичной кнопки.
  factory AppButtonStyle.primary({
    required AppColorScheme colorScheme,
    required AppTextScheme textScheme,
    required AppButtonSize size,
  }) {
    final (:padding, :textStyle, :buttonSize) = _configureSize(
      textScheme: textScheme,
      size: size,
    );

    return AppButtonStyle(
      buttonColor: colorScheme.primary,
      buttonHoverColor: colorScheme.primary.withValues(alpha: 0.8),
      buttonPressedColor: colorScheme.primary,
      buttonDisabledColor: colorScheme.primary.withValues(alpha: 0.5),
      buttonFocusColor: colorScheme.primary,
      textColor: colorScheme.onPrimary,
      textDisabledColor: colorScheme.onPrimary,
      textFocusColor: colorScheme.onPrimary,
      minimumSize: WidgetStateProperty.all(buttonSize),
      textStyle: textStyle,
      padding: padding,
    );
  }

  /// Создать стиль для первичной кнопки.
  factory AppButtonStyle.primaryIcon({required AppColorScheme colorScheme}) {
    final (:buttonSize, :iconSize, :circularRadius) = _configureIconSize(
      size: AppButtonSize.large,
    );

    return AppButtonStyle(
      buttonColor: colorScheme.primary,
      buttonHoverColor: colorScheme.primary.withValues(alpha: 0.8),
      buttonPressedColor: colorScheme.primary,
      buttonDisabledColor: Colors.transparent,
      buttonFocusColor: colorScheme.primary,
      textColor: colorScheme.onPrimary,
      textDisabledColor: colorScheme.onPrimary,
      textFocusColor: colorScheme.onPrimary,
      minimumSize: WidgetStateProperty.all(buttonSize),
      padding: EdgeInsets.zero,
      fixedSize: WidgetStateProperty.all(buttonSize),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(circularRadius)),
        ),
      ),
      iconSize: WidgetStateProperty.all(iconSize),
    );
  }

  /// Создать стиль для прозрачной кнопки.
  factory AppButtonStyle.transparent({
    required AppColorScheme colorScheme,
    required AppTextScheme textScheme,
    required AppButtonSize size,
  }) {
    final (:padding, :textStyle, :buttonSize) = _configureSize(
      textScheme: textScheme,
      size: size,
    );

    return AppButtonStyle(
      buttonColor: Colors.transparent,
      buttonHoverColor: Colors.transparent,
      buttonPressedColor: colorScheme.primary.withValues(alpha: 0.8),
      buttonDisabledColor: Colors.transparent,
      buttonFocusColor: Colors.transparent,
      textColor: colorScheme.primary,
      textDisabledColor: colorScheme.onPrimary,
      textFocusColor: colorScheme.onPrimary,
      minimumSize: WidgetStateProperty.all(buttonSize),
      textStyle: textStyle,
      padding: padding,
    );
  }

  static ({EdgeInsetsGeometry padding, TextStyle textStyle, Size buttonSize}) _configureSize({
    required AppTextScheme textScheme,
    required AppButtonSize size,
  }) {
    return (
      padding: switch (size) {
        AppButtonSize.small => const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 16,
        ),
        AppButtonSize.medium || AppButtonSize.large => const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 32,
        ),
      },
      textStyle: switch (size) {
        AppButtonSize.large || AppButtonSize.medium => textScheme.display,
        AppButtonSize.small => textScheme.label,
      }.copyWith(height: 1),
      buttonSize: switch (size) {
        AppButtonSize.small => const Size(0, 40),
        AppButtonSize.medium => const Size(0, 48),
        AppButtonSize.large => const Size(0, 56),
      },
    );
  }

  static ({Size buttonSize, double iconSize, double circularRadius}) _configureIconSize({
    required AppButtonSize size,
  }) {
    return (
      buttonSize: switch (size) {
        AppButtonSize.small => const Size.square(32),
        AppButtonSize.medium || AppButtonSize.large => const Size.square(40),
      },
      iconSize: switch (size) {
        AppButtonSize.small => 16,
        AppButtonSize.medium || AppButtonSize.large => 40,
      },
      circularRadius: switch (size) {
        AppButtonSize.small => 16,
        AppButtonSize.medium || AppButtonSize.large => 24,
      },
    );
  }
}
