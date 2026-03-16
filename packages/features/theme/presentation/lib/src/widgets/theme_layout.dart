import 'package:app_presentation/app_presentation.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart' hide ThemeMode;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme_domain/theme_domain.dart';
import 'package:theme_presentation/src/widgets/theme_component.dart';

/// {@template theme_layout}
/// A layout for the theme screen.
/// {@endtemplate}
class ThemeLayout extends Layout<ThemeViewModel> {
  /// {@macro theme_layout}
  const ThemeLayout({required super.viewModel, super.key});

  @override
  Widget layout(ThemeViewModel vm) {
    return BlocBuilder<StateStreamable<ThemeState>, ThemeState>(
      builder: (context, state) {
        final theme = switch (state.themeMode) {
          ThemeMode.light => vm.lightTheme,
          ThemeMode.dark => vm.darkTheme,
          ThemeMode.system => switch (MediaQuery.platformBrightnessOf(context)) {
            Brightness.light => vm.lightTheme,
            Brightness.dark => vm.darkTheme,
          },
        };

        return AnimatedTheme(
          data: theme,
          duration: kDefaultAnimationDuration,
          child: vm.child,
        );
      },
      bloc: vm.themeBloc,
    );
  }
}
