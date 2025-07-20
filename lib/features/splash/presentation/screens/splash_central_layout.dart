import 'package:app_template/core/architecture/presentation/widgets/layout.dart';
import 'package:app_template/features/splash/presentation/screens/splash_central_component.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
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
