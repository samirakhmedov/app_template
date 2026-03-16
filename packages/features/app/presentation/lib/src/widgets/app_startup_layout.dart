import 'package:flutter/material.dart';

/// {@template app_startup_layout}
/// A layout for the app startup.
/// {@endtemplate}
class AppStartupLayout extends StatelessWidget {
  /// {@macro app_startup_layout}
  const AppStartupLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(child: const Scaffold());
  }
}
