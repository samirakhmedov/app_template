import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:theme_domain/theme_domain.dart';

part 'theme_bloc.freezed.dart';
part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final IThemeRepository _themeRepository;

  ThemeBloc({required IThemeRepository themeRepository})
    : _themeRepository = themeRepository,
      super(const ThemeState(themeMode: ThemeMode.system)) {
    on<ThemeInitialize>(_initialize);
    on<ThemeSetMode>(_setMode);
  }

  void _initialize(ThemeInitialize event, Emitter<ThemeState> emit) {
    emit(state.copyWith(themeMode: _themeRepository.themeMode));
  }

  void _setMode(
    ThemeSetMode event,
    Emitter<ThemeState> emit,
  ) {
    unawaited(_themeRepository.setThemeMode(event.mode));
    emit(state.copyWith(themeMode: event.mode));
  }
}
