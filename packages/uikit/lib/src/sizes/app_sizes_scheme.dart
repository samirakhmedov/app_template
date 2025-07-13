// ignore_for_file: avoid-non-null-assertion, avoid-long-files

import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'app_sizes_scheme.tailor.dart';

/// Naming-dimension table:
/// Microscopic - 1
/// Tiny - 2
/// Small - 4
/// Medium - 8
/// Standard - 12
/// General - 16
/// Big - 20
/// Huge - 24
/// Massive - 32
/// Gigantic - 40
/// Considerable - 56
/// Enormous - 80

/// App text style scheme.
@TailorMixin(themeGetter: ThemeGetter.onBuildContext)
class AppSizesScheme extends ThemeExtension<AppSizesScheme> with _$AppSizesSchemeTailorMixin {
  /// Empty padding / border position for positioned widget.
  ///
  /// Default value is `0.0`.
  @override
  final double empty;

  /// Default height for cursor in text fields.
  ///
  /// Default value is `20.0`.
  @override
  final double cursorHeightGeneral;

  /// Default height for separators.
  ///
  /// Default value is `1.0`.
  @override
  final double separatorMicroscopic;

  /// Height for separators for more distinct separators.
  ///
  /// Default value is `2.0`.
  @override
  final double separatorSmall;

  /// Default value is `1.0`.
  @override
  final double paddingMicroscopic;

  /// Default value is `2.0`.
  @override
  final double paddingTiny;

  /// Default value is `4.0`.
  @override
  final double paddingSmall;

  /// Default value is `8.0`.
  @override
  final double paddingMedium;

  /// Default value is `12.0`.
  @override
  final double paddingStandard;

  /// Default value is `16.0`.
  @override
  final double paddingGeneral;

  /// Default value is `20.0`.
  @override
  final double paddingBig;

  /// Default value is `24.0`.
  @override
  final double paddingHuge;

  /// Default value is `32.0`.
  @override
  final double paddingMassive;

  /// Default value is `40.0`.
  @override
  final double paddingGigantic;

  /// Default value is `56.0`.
  @override
  final double paddingConsiderable;

  /// Default value is `80.0`.
  @override
  final double paddingEnormous;

  /// Small border radius used throughout the app.
  ///
  /// Default value is `BorderRadius.circular(4.0)`.
  @override
  final BorderRadius borderRadiusSmall;

  /// Medium border radius used throughout the app.
  ///
  /// Default value is `BorderRadius.circular(8.0)`.
  @override
  final BorderRadius borderRadiusMedium;

  /// Standart border radius used throughout the app.
  ///
  /// Default value is `BorderRadius.circular(12.0)`.
  @override
  final BorderRadius borderRadiusStandart;

  /// General border radius used throughout the app.
  ///
  /// Default value is `BorderRadius.circular(16.0)`.
  @override
  final BorderRadius borderRadiusGeneral;

  /// Huge border radius used throughout the app.
  ///
  /// Default value is `BorderRadius.circular(24.0)`.
  @override
  final BorderRadius borderRadiusHuge;

  /// Default stroke width of different borders in app.
  ///
  /// Default value is `2.0`.
  @override
  final double strokeGeneral;

  /// Circular progress indicator minimum size.
  ///
  /// Used in PTR to determine loader's size on pull progress.
  ///
  /// Default value is `2.0`.
  @override
  final double loaderSizeMinimum;

  /// Circular progress indicator maximum size.
  ///
  /// Used in PTR to determine loader's size on pull progress.
  ///
  /// Default value is `24.0`.
  @override
  final double loaderSizeMaximum;

  /// Standart size of icons in app.
  ///
  /// Default value is `12.0`.
  @override
  final double iconSizeStandart;

  /// General size of icons in app.
  ///
  /// Default value is `16.0`.
  @override
  final double iconSizeGeneral;

  /// Huge size of icons in app.
  ///
  /// Default value is `24.0`.
  @override
  final double iconSizeHuge;

  /// Massive size of icon buttons in app.
  ///
  /// Default value is `32.0`.
  @override
  final double iconSizeMassive;

  /// Gigantic size of icons.
  ///
  /// Default value is `40.0`.
  @override
  final double iconSizeGigantic;

  /// Enormous size of action buttons/action header icons in app.
  ///
  /// Default value is `80.0`.
  @override
  final double iconsSizeEnormous;

  /// App sizes scheme for app.
  const AppSizesScheme({
    required this.empty,
    required this.cursorHeightGeneral,
    required this.paddingStandard,
    required this.separatorMicroscopic,
    required this.paddingMicroscopic,
    required this.paddingGeneral,
    required this.borderRadiusSmall,
    required this.borderRadiusMedium,
    required this.borderRadiusStandart,
    required this.borderRadiusGeneral,
    required this.borderRadiusHuge,
    required this.paddingMedium,
    required this.paddingSmall,
    required this.strokeGeneral,
    required this.separatorSmall,
    required this.paddingTiny,
    required this.loaderSizeMinimum,
    required this.loaderSizeMaximum,
    required this.paddingBig,
    required this.paddingHuge,
    required this.paddingMassive,
    required this.paddingGigantic,
    required this.paddingConsiderable,
    required this.paddingEnormous,
    required this.iconSizeStandart,
    required this.iconSizeGeneral,
    required this.iconSizeHuge,
    required this.iconSizeMassive,
    required this.iconSizeGigantic,
    required this.iconsSizeEnormous,
  });

  /// Base app text theme.
  AppSizesScheme.base()
    : cursorHeightGeneral = 20,
      separatorMicroscopic = 1,
      empty = 0,
      paddingGeneral = 16,
      borderRadiusSmall = BorderRadius.circular(4),
      borderRadiusMedium = BorderRadius.circular(8),
      borderRadiusStandart = BorderRadius.circular(12),
      borderRadiusGeneral = BorderRadius.circular(16),
      borderRadiusHuge = BorderRadius.circular(24),
      paddingMicroscopic = 1,
      paddingMedium = 8,
      strokeGeneral = 2,
      paddingTiny = 2,
      separatorSmall = 2,
      loaderSizeMaximum = 24,
      loaderSizeMinimum = 2,
      paddingSmall = 4,
      paddingStandard = 12,
      iconSizeStandart = 12,
      iconSizeGeneral = 16,
      iconSizeHuge = 24,
      iconSizeMassive = 32,
      paddingBig = 20,
      paddingHuge = 24,
      paddingMassive = 32,
      paddingGigantic = 40,
      paddingConsiderable = 56,
      paddingEnormous = 80,
      iconSizeGigantic = 40,
      iconsSizeEnormous = 80;

  /// Get [AppSizesScheme] from [BuildContext].
  static AppSizesScheme of(BuildContext context) => Theme.of(context).extension<AppSizesScheme>()!;
}

/// Sizes extension for [BuildContext].
extension SizesExt on BuildContext {
  /// Returns native bottom insets height.
  double get bottomViewInsets => MediaQuery.viewInsetsOf(this).bottom;

  /// Returns [AppSizesScheme] from [BuildContext].
  AppSizesScheme get sizes => AppSizesScheme.of(this);
}
