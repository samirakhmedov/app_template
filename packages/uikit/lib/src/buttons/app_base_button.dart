import 'package:flutter/material.dart';
import 'package:uikit/src/buttons/app_button_configurations.dart';
import 'package:uikit/src/sizes/app_sizes_scheme.dart';

/// {@template app_base_button}
/// Базовый виджет для кнопки приложения.
/// {@endtemplate}
class AppBaseButton extends StatefulWidget {
  /// {@macro app_base_button}
  const AppBaseButton({
    required this.state,
    required this.onPressed,
    required this.child,
    required this.style,
    super.key,
  });

  /// Состояние кнопки
  ///
  /// При состоянии, отличном от [ButtonState.active], не работает [onPressed].
  final ButtonState state;

  /// Колбек нажатия на кнопку.
  final VoidCallback? onPressed;

  /// Контент кнопки.
  final Widget child;

  /// Стиль кнопки.
  final ButtonStyle style;

  @override
  State<AppBaseButton> createState() => _AppBaseButtonState();
}

class _AppBaseButtonState extends State<AppBaseButton> {
  late final WidgetStatesController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WidgetStatesController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = widget.state == ButtonState.loading;
    final isInactive = widget.state == ButtonState.disabled;

    return SelectionContainer.disabled(
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          TextButton(
            onPressed: switch ((isInactive, isLoading)) {
              (false, false) => widget.onPressed,
              // ignore: no-empty-block
              (false, true) => () {},
              _ => null,
            },
            style: widget.style,
            statesController: _controller,
            child: DefaultTextStyle.merge(
              softWrap: false,
              maxLines: 1,
              child: Offstage(offstage: isLoading, child: widget.child),
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: isLoading
                  ? Center(
                      child: ValueListenableBuilder<Set<WidgetState>>(
                        valueListenable: _controller,
                        builder: (__, states, _) {
                          return RepaintBoundary(
                            child: SizedBox(
                              width: context.appSizesScheme.loaderSizeMaximum,
                              height: context.appSizesScheme.loaderSizeMaximum,
                              child: CircularProgressIndicator(
                                color: widget.style.foregroundColor?.resolve(
                                  states,
                                ),
                                strokeWidth: context.appSizesScheme.strokeGeneral,
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}
