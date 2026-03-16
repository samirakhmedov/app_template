import 'package:app_assets/generated/app_localizations.dart';
import 'package:app_assets/generated/app_localizations_en.dart';
import 'package:flutter/widgets.dart';

/// {@template l10n_extension}
/// Provides convenient access to [AppLocalizations] from [BuildContext].
/// {@endtemplate}
extension L10n on BuildContext {
  /// Returns the [AppLocalizations] for the current locale,
  /// falling back to English if the locale is unavailable.
  AppLocalizations get l10n => AppLocalizations.of(this) ?? AppLocalizationsEn();
}
