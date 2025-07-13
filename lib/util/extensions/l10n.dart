import 'package:app_template/generated/app_localizations.dart';
import 'package:app_template/generated/app_localizations_en.dart';
import 'package:flutter/material.dart';

/// {@template l10n}
/// A extension for the build context to get the l10n.
/// {@endtemplate}
extension L10n on BuildContext {
  /// {@macro l10n}
  AppLocalizations get l10n => AppLocalizations.of(this) ?? AppLocalizationsEn();
}
