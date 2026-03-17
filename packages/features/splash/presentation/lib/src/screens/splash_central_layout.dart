import 'package:app_presentation/app_presentation.dart';
import 'package:flutter/material.dart';
import 'package:splash_presentation/splash_presentation.dart';

/// {@template splash_layout}
/// A layout for the splash.
/// {@endtemplate}
class SplashCentralLayout extends Layout<SplashViewModel> {
  /// {@macro splash_layout}
  const SplashCentralLayout({
    required super.viewModel,
    super.key,
  });

  @override
  Widget layout(SplashViewModel vm) {
    return         Scaffold(
          body: Center(
            child: RepaintBoundary(
              child: FadeTransition(
                opacity: vm.fadeAnimation,
                child: FlutterLogo(
                  size: 200,
                ),
              ),
            ),
          ),
        );
  }
}
