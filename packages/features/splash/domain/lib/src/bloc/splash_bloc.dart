import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:splash_domain/src/repositories/i_splash_repository.dart';

part 'splash_bloc.freezed.dart';
part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final ISplashRepository _repository;

  SplashBloc({required ISplashRepository repository})
    : _repository = repository,
      super(const SplashState.initial()) {
    on<SplashInitialize>(_initialize);
  }

   Future<void> _initialize(SplashInitialize _, Emitter<SplashState> emit) async {
    emit(const SplashState.loading());
    await _repository.initialize();
    emit(const SplashState.loaded());
  }
}
