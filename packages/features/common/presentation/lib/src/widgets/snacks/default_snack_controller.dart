import 'package:common_domain/common_domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easy_dialogs/flutter_easy_dialogs.dart';
import 'package:uikit/uikit.dart';

const _snackId = 'snack';

const _defaultDialogDecoration = EasyDialogDecoration.combine([
  EasyDialogAnimation.expansion(),
]);
const _defaultAnimationConfiguration = EasyDialogAnimationConfiguration.bounded();

/// Default controller for displaying messages.
class DefaultSnackController {
  /// Create an instance [DefaultSnackController].
  const DefaultSnackController();

  /// Show the message.
  Future<void> showSnack({
    required SnackMessageType messageType,
    required String message,
    Duration? autoHideDuration,
  }) {
    return FlutterEasyDialogs.show(
      EasyDialog.positioned(
        content: _MobileSnack(message: message, messageType: messageType),
        id: _snackId,
        animationConfiguration: _defaultAnimationConfiguration,
        decoration: _defaultDialogDecoration,
        autoHideDuration: autoHideDuration,
      ).swipe(direction: DismissDirection.up, willDismiss: () => true),
    );
  }

  /// Hide Snack.
  Future<void> hideSnack() {
    return FlutterEasyDialogs.hide(id: _snackId, instantly: true);
  }
}

class _MobileSnack extends StatelessWidget {
  const _MobileSnack({required this.message, required this.messageType});

  final String message;
  final SnackMessageType messageType;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.appColorScheme;
    final textScheme = context.appTextScheme;
    final topPadding = MediaQuery.viewPaddingOf(context).top;

    final generalPadding = context.appSizesScheme.paddingGeneral;

    return SizedBox(
      width: double.infinity,
      child: ColoredBox(
        color: switch (messageType) {
          SnackMessageType.success => colorScheme.positive,
          _ => colorScheme.danger,
        },
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            generalPadding,
            topPadding + context.appSizesScheme.paddingMedium,
            generalPadding,
            generalPadding,
          ),
          child: Text(
            message,
            style: textScheme.label.copyWith(
              color: switch (messageType) {
                SnackMessageType.error || SnackMessageType.warning => colorScheme.onDanger,
                SnackMessageType.success => colorScheme.onPositive,
              },
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
