import 'dart:developer';
import 'dart:typed_data';

import 'package:app_template/generated/app_localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:surf_widget_test_composer/surf_widget_test_composer.dart' as helper;
import 'package:uikit/uikit.dart';

Future<void> testExecutable(Future<void> Function() testMain) {
  TestWidgetsFlutterBinding.ensureInitialized();

  final themes = [
    helper.TestingTheme(
      data: AppThemeData.lightTheme,
      stringified: 'light',
      type: helper.ThemeType.light,
    ),
    helper.TestingTheme(
      data: AppThemeData.darkTheme,
      stringified: 'dark',
      type: helper.ThemeType.dark,
    ),
  ];

  final devices = [
    helper.TestDevice(
      size: const Size(414, 896),
      name: 'iphone11',
      safeArea: const EdgeInsets.only(top: 44, bottom: 34),
    ),
    helper.TestDevice(size: const Size(393, 851), name: 'pixel 4a'),
    helper.TestDevice(size: const Size(320, 568), name: 'iphone_se_1'),
  ];

  return helper.testExecutable(
    testMain: testMain,
    themes: themes,
    wrapper: (child, mode, theme, localizations, locales) => helper.BaseWidgetTestWrapper(
      childBuilder: child,
      mode: mode,
      themeData: theme,
      dependencies: (widget) => widget,
      localizations: _localizationsDelegates,
      localeOverrides: _localizations,
    ),
    backgroundColor: (theme) => theme.colorScheme.surface,
    devicesForTest: devices,
    customComparator: CustomFileComparator(
      '${(goldenFileComparator as LocalFileComparator).basedir}/goldens',
    ),
  );
}

const _localizations = AppLocalizations.supportedLocales;

const _localizationsDelegates = [
  AppLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];

class CustomFileComparator extends LocalFileComparator {
  static const _tolerance = 0.18;
  static const _logLevel = 1999;
  static const _hundredPrecent = 100;

  CustomFileComparator(String testFile) : super(Uri.parse(testFile));

  @override
  Future<bool> compare(Uint8List imageBytes, Uri golden) async {
    final result = await GoldenFileComparator.compareLists(
      imageBytes,
      await getGoldenBytes(golden),
    );

    if (!result.passed && result.diffPercent >= _tolerance) {
      final error = await generateFailureOutput(result, golden, basedir);
      throw FlutterError(error);
    }
    if (!result.passed) {
      log(
        'A tolerable difference of ${result.diffPercent * _hundredPrecent}% was found when comparing $golden.',
        level: _logLevel,
      );
    }

    return result.passed || result.diffPercent <= _tolerance;
  }
}
