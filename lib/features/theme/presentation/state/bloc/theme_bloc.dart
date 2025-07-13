import 'dart:async';

import 'package:app_template/features/theme/domain/entities/theme_mode.dart';
import 'package:app_template/features/theme/domain/repositories/i_theme_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme_event.dart';
part 'theme_state.dart';
part 'theme_bloc.freezed.dart';

/// {@template theme_bloc}
/// A bloc for the theme.
/// {@endtemplate}
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final IThemeRepository _themeRepository;

  /// {@macro theme_bloc}
  ThemeBloc({required IThemeRepository themeRepository})
    : _themeRepository = themeRepository,
      super(const ThemeState()) {
    on<ThemeInitialize>(_initialize);
    on<ThemeSetMode>(_setMode);
  }

  void _initialize(ThemeInitialize event, Emitter<ThemeState> emit) {
    emit(state.copyWith(themeMode: _themeRepository.themeMode.value));
  }

  void _setMode(
    ThemeSetMode event,
    Emitter<ThemeState> emit,
  ) {
    unawaited(_themeRepository.setThemeMode(event.mode));
    emit(state.copyWith(themeMode: event.mode));
  }
}
