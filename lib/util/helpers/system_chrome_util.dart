import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// {@template system_chrome_util.class}
/// Utility class for interacting with [SystemChrome].
///
/// @Deprecated('Use DeviceSettingsBloc instead. See migration guide below.')
///
/// ## Migration Guide
///
/// Instead of calling `SystemChromeUtil` methods directly, inject and use
/// `DeviceSettingsBloc` from `package:app_domain/app_domain.dart`.
///
/// ### Before:
/// ```dart
/// await SystemChromeUtil.lockDeviceRotation();
/// await SystemChromeUtil.enableSeamlessUI();
/// SystemChromeUtil.setDefaultSystemUIOverlayStyle();
/// ```
///
/// ### After:
/// ```dart
/// // In your DI container:
/// final deviceSettingsBloc = DeviceSettingsBloc(
///   repository: deviceSettingsRepository,
/// );
///
/// // On app startup:
/// deviceSettingsBloc.add(DeviceSettingsEvent.initialize());
///
/// // To change settings:
/// deviceSettingsBloc.add(DeviceSettingsEvent.setSystemUiMode(
///   AppSystemUiMode.immersive,
/// ));
/// ```
/// {@endtemplate}
@Deprecated('Use DeviceSettingsBloc from package:app_domain instead')
class SystemChromeUtil {
  /// Default app orientation mode.
  @Deprecated('Use DeviceSettings with AppDeviceOrientation instead')
  static const appDefaultOrientation = [
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ];

  /// Default app system UI mode.
  @Deprecated('Use DeviceSettings with AppSystemUiMode instead')
  static const appDefaultSystemUIMode = SystemUiMode.edgeToEdge;

  /// Lock app in portrait mode.
  @Deprecated('Use DeviceSettingsBloc.add(DeviceSettingsEvent.setOrientations(...)) instead')
  static Future<void> lockDeviceRotation() async {
    await SystemChrome.setPreferredOrientations(appDefaultOrientation);
  }

  /// Unlock app landscape mode.
  @Deprecated('Use DeviceSettingsBloc.add(DeviceSettingsEvent.setOrientations(...)) instead')
  static Future<void> unlockDeviceRotation() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitDown,
    ]);
  }

  /// Enables [SystemUiMode.immersive] system UI mode.
  @Deprecated(
    'Use DeviceSettingsBloc.add(DeviceSettingsEvent.setSystemUiMode(AppSystemUiMode.immersive)) instead',
  )
  static Future<void> enableSeamlessUI() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  /// Enables [appDefaultSystemUIMode].
  @Deprecated(
    'Use DeviceSettingsBloc.add(DeviceSettingsEvent.setSystemUiMode(AppSystemUiMode.edgeToEdge)) instead',
  )
  static Future<void> disableSeamlessUI() async {
    await SystemChrome.setEnabledSystemUIMode(appDefaultSystemUIMode);
  }

  /// Set default system UI overlay style.
  @Deprecated('Use DeviceSettingsBloc.add(DeviceSettingsEvent.setOverlayStyle(...)) instead')
  static void setDefaultSystemUIOverlayStyle() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        statusBarColor: Colors.transparent,
      ),
    );
  }
}
