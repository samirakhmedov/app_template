import 'package:app_template/core/architecture/presentation/widgets/layout.dart';
import 'package:app_template/core/config/constants.dart';
import 'package:app_template/features/theme/domain/entities/theme_mode.dart' as app;
import 'package:app_template/features/theme/presentation/state/bloc/theme_bloc.dart';
import 'package:app_template/features/theme/presentation/widgets/theme_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          app.ThemeMode.light => vm.lightTheme,
          app.ThemeMode.dark => vm.darkTheme,
          app.ThemeMode.system => switch (MediaQuery.platformBrightnessOf(context)) {
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
