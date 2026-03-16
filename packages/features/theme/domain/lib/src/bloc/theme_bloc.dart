import 'dart:async';

import 'package:app_domain/src/entities/request_operation.dart';
import 'package:theme_domain/src/entities/theme_mode.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme_event.dart';
part 'theme_state.dart';
part 'theme_bloc.freezed.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final IThemeRepository _themeRepository;

  ThemeBloc({required IThemeRepository themeRepository})
    : _themeRepository = themeRepository,
      super(const ThemeState()) {
    on<ThemeInitialize>(_initialize);
    on<ThemeSetMode>(_setMode);
  }
}
