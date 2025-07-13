import 'dart:async';

import 'package:app_template/features/splash/domain/repositories/i_splash_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_event.dart';
part 'splash_state.dart';
part 'splash_bloc.freezed.dart';

/// {@template splash_bloc}
/// A bloc for the splash.
/// {@endtemplate}
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final ISplashRepository _splashRepository;

  /// {@macro splash_bloc}
  SplashBloc({required ISplashRepository splashRepository})
    : _splashRepository = splashRepository,
      super(const SplashState.initial()) {
    on<SplashInitialize>((event, emit) => _initialize(emit));
  }

  Future<void> _initialize(Emitter<SplashState> emit) async {
    emit(const SplashState.loading());
    await _splashRepository.initialize();
    emit(const SplashState.loaded());
  }
}
