import 'package:flutter/material.dart';
import 'package:uikit/src/buttons/app_base_button.dart';
import 'package:uikit/src/buttons/app_button_configurations.dart';
import 'package:uikit/src/buttons/app_button_scheme.dart';

/// {@template app_secondary_button}
/// Вторичная кнопка приложения.
/// {@endtemplate}
class AppTransparentButton extends StatelessWidget {
  /// {@macro app_secondary_button}
  const AppTransparentButton({
    required this.child,
    this.onPressed,
    this.state = ButtonState.active,
    this.size = AppButtonSize.large,
    this.style,
    super.key,
  });

  /// Состояние кнопки
  ///
  /// При состоянии, отличном от [ButtonState.active], не работает [onPressed].
  final ButtonState state;

  /// Размер кнопки.
  final AppButtonSize size;

  /// Колбек нажатия на кнопку.
  final VoidCallback? onPressed;

  /// Стиль кнопки.
  final ButtonStyle? style;

  /// Контент кнопки.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final buttonScheme = context.appButtonScheme;
    final buttonStyle =
        style ??
        switch (size) {
          AppButtonSize.small => buttonScheme.transparentSmall,
          AppButtonSize.medium => buttonScheme.transparentMedium,
          AppButtonSize.large => buttonScheme.transparentLarge,
        };

    return AppBaseButton(
      state: state,
      onPressed: onPressed,
      style: buttonStyle,
      child: child,
    );
  }
}
