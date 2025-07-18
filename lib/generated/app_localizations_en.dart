// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String commonAtLeastSymbols(int symbols) {
    return 'At least $symbols symbols';
  }

  @override
  String get commonInvalidEmail => 'Invalid email';

  @override
  String get commonRequiredField => 'Required field';

  @override
  String get commonInvalidLink => 'Invalid link';

  @override
  String get commonInvalidName => 'Invalid name';

  @override
  String get debugScreenServerSubtitle => 'Server';

  @override
  String get debugScreenProxySubtitle => 'Proxy settings';

  @override
  String get debugScreenProxyInfo =>
      'Enter a proxy URL to intercept network traffic for debugging purposes.';

  @override
  String get debugScreenProxyEditTextLabel => 'Proxy URL';

  @override
  String get debugScreenProxyConnectButton => 'Connect';

  @override
  String get debugScreenShimmerTitle => 'Shimmer Effect';

  @override
  String get debugScreenHapticFeedbackTitle => 'Haptic Feedback';

  @override
  String get debugScreenHapticLightImpactButton => 'Light Impact';

  @override
  String get debugScreenHapticMediumImpactButton => 'Medium Impact';

  @override
  String get debugScreenHapticHeavyImpactButton => 'Heavy Impact';

  @override
  String get debugScreenHapticSoftImpactButton => 'Soft Impact';

  @override
  String get debugScreenHapticRigidImpactButton => 'Rigid Impact';

  @override
  String get debugScreenHapticConfirmFeedbackButton => 'Confirm Feedback';

  @override
  String get debugScreenHapticRejectFeedbackButton => 'Reject Feedback';

  @override
  String get debugScreenHapticSuccessNotificationButton => 'Success Notification';

  @override
  String get debugScreenHapticErrorNotificationButton => 'Error Notification';

  @override
  String get debugScreenHapticWarningNotificationButton => 'Warning Notification';

  @override
  String get debugScreenHapticSelectionHapticButton => 'Selection Haptic';

  @override
  String get debugScreenHapticContextClickFeedbackButton => 'Context Click Feedback';

  @override
  String get debugScreenHapticDragStartFeedbackButton => 'Drag Start Feedback';

  @override
  String get debugScreenHapticGestureEndFeedbackButton => 'Gesture End Feedback';

  @override
  String get debugScreenHapticGestureStartFeedbackButton => 'Gesture Start Feedback';

  @override
  String get debugScreenHapticTextHandleMoveFeedbackButton => 'Text Handle Move Feedback';

  @override
  String get debugScreenHapticVirtualKeyReleaseFeedbackButton => 'Virtual Key Release Feedback';

  @override
  String get debugScreenEasterEggButton => 'Easter Egg';

  @override
  String get debugScreenSnackQueueTestButton => 'Snack Queue Test';

  @override
  String get debugScreenSnackTestMessage => 'Test';
}
