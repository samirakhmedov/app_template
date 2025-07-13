import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// {@template system_chrome_util.class}
/// Utility class for interacting with [SystemChrome].
/// {@endtemplate}
class SystemChromeUtil {
  /// Default app orientation mode.
  static const appDefaultOrientation = [
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ];

  /// Default app system UI mode.
  static const appDefaultSystemUIMode = SystemUiMode.edgeToEdge;

  /// Lock app in portrait mode.
  static Future<void> lockDeviceRotation() async {
    await SystemChrome.setPreferredOrientations(appDefaultOrientation);
  }

  /// Unlock app landscape mode.
  static Future<void> unlockDeviceRotation() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitDown,
    ]);
  }

  /// Enables [SystemUiMode.immersive] system UI mode.
  static Future<void> enableSeamlessUI() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  /// Enables [appDefaultSystemUIMode].
  static Future<void> disableSeamlessUI() async {
    await SystemChrome.setEnabledSystemUIMode(appDefaultSystemUIMode);
  }

  /// Set default system UI overlay style.
  static void setDefaultSystemUIOverlayStyle() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        statusBarColor: Colors.transparent,
      ),
    );
  }
}
