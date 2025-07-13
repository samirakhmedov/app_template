import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// The message displayed when the user has not entered the required number of symbols.
  ///
  /// In en, this message translates to:
  /// **'At least {symbols} symbols'**
  String commonAtLeastSymbols(int symbols);

  /// The message displayed when the user has entered an invalid email.
  ///
  /// In en, this message translates to:
  /// **'Invalid email'**
  String get commonInvalidEmail;

  /// The message displayed when the user has not entered a required field.
  ///
  /// In en, this message translates to:
  /// **'Required field'**
  String get commonRequiredField;

  /// The message displayed when the user has entered an invalid link.
  ///
  /// In en, this message translates to:
  /// **'Invalid link'**
  String get commonInvalidLink;

  /// The message displayed when the user has entered an invalid name.
  ///
  /// In en, this message translates to:
  /// **'Invalid name'**
  String get commonInvalidName;

  /// Subtitle for the server switch section of the debug screen.
  ///
  /// In en, this message translates to:
  /// **'Server'**
  String get debugScreenServerSubtitle;

  /// Subtitle for the proxy configuration section of the debug screen.
  ///
  /// In en, this message translates to:
  /// **'Proxy settings'**
  String get debugScreenProxySubtitle;

  /// Supporting information that explains why the proxy URL is needed.
  ///
  /// In en, this message translates to:
  /// **'Enter a proxy URL to intercept network traffic for debugging purposes.'**
  String get debugScreenProxyInfo;

  /// Label for the text field where the user enters the proxy URL.
  ///
  /// In en, this message translates to:
  /// **'Proxy URL'**
  String get debugScreenProxyEditTextLabel;

  /// Text for the button that submits the proxy URL and attempts to connect.
  ///
  /// In en, this message translates to:
  /// **'Connect'**
  String get debugScreenProxyConnectButton;

  /// Title for the shimmer effect demonstration section.
  ///
  /// In en, this message translates to:
  /// **'Shimmer Effect'**
  String get debugScreenShimmerTitle;

  /// Title for the haptic feedback testing section.
  ///
  /// In en, this message translates to:
  /// **'Haptic Feedback'**
  String get debugScreenHapticFeedbackTitle;

  /// Button text for triggering a light haptic impact.
  ///
  /// In en, this message translates to:
  /// **'Light Impact'**
  String get debugScreenHapticLightImpactButton;

  /// Button text for triggering a medium haptic impact.
  ///
  /// In en, this message translates to:
  /// **'Medium Impact'**
  String get debugScreenHapticMediumImpactButton;

  /// Button text for triggering a heavy haptic impact.
  ///
  /// In en, this message translates to:
  /// **'Heavy Impact'**
  String get debugScreenHapticHeavyImpactButton;

  /// Button text for triggering a soft haptic impact.
  ///
  /// In en, this message translates to:
  /// **'Soft Impact'**
  String get debugScreenHapticSoftImpactButton;

  /// Button text for triggering a rigid haptic impact.
  ///
  /// In en, this message translates to:
  /// **'Rigid Impact'**
  String get debugScreenHapticRigidImpactButton;

  /// Button text for triggering a confirm feedback haptic effect.
  ///
  /// In en, this message translates to:
  /// **'Confirm Feedback'**
  String get debugScreenHapticConfirmFeedbackButton;

  /// Button text for triggering a reject feedback haptic effect.
  ///
  /// In en, this message translates to:
  /// **'Reject Feedback'**
  String get debugScreenHapticRejectFeedbackButton;

  /// Button text for triggering a success notification haptic effect.
  ///
  /// In en, this message translates to:
  /// **'Success Notification'**
  String get debugScreenHapticSuccessNotificationButton;

  /// Button text for triggering an error notification haptic effect.
  ///
  /// In en, this message translates to:
  /// **'Error Notification'**
  String get debugScreenHapticErrorNotificationButton;

  /// Button text for triggering a warning notification haptic effect.
  ///
  /// In en, this message translates to:
  /// **'Warning Notification'**
  String get debugScreenHapticWarningNotificationButton;

  /// Button text for triggering a selection haptic effect.
  ///
  /// In en, this message translates to:
  /// **'Selection Haptic'**
  String get debugScreenHapticSelectionHapticButton;

  /// Button text for triggering a context click feedback haptic effect.
  ///
  /// In en, this message translates to:
  /// **'Context Click Feedback'**
  String get debugScreenHapticContextClickFeedbackButton;

  /// Button text for triggering a drag start feedback haptic effect.
  ///
  /// In en, this message translates to:
  /// **'Drag Start Feedback'**
  String get debugScreenHapticDragStartFeedbackButton;

  /// Button text for triggering a gesture end feedback haptic effect.
  ///
  /// In en, this message translates to:
  /// **'Gesture End Feedback'**
  String get debugScreenHapticGestureEndFeedbackButton;

  /// Button text for triggering a gesture start feedback haptic effect.
  ///
  /// In en, this message translates to:
  /// **'Gesture Start Feedback'**
  String get debugScreenHapticGestureStartFeedbackButton;

  /// Button text for triggering a text handle move feedback haptic effect.
  ///
  /// In en, this message translates to:
  /// **'Text Handle Move Feedback'**
  String get debugScreenHapticTextHandleMoveFeedbackButton;

  /// Button text for triggering a virtual key release feedback haptic effect.
  ///
  /// In en, this message translates to:
  /// **'Virtual Key Release Feedback'**
  String get debugScreenHapticVirtualKeyReleaseFeedbackButton;

  /// Button text for triggering the easter egg feature.
  ///
  /// In en, this message translates to:
  /// **'Easter Egg'**
  String get debugScreenEasterEggButton;

  /// Button text for a button that adds a test snack to the queue.
  ///
  /// In en, this message translates to:
  /// **'Snack Queue Test'**
  String get debugScreenSnackQueueTestButton;

  /// Snack message text for testing the snack queue.
  ///
  /// In en, this message translates to:
  /// **'Test'**
  String get debugScreenSnackTestMessage;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
