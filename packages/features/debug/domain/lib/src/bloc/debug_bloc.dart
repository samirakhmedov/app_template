import 'dart:async';

import 'package:app_domain/app_domain.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:core/core.dart';
import 'package:debug_domain/debug_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'debug_event.dart';
part 'debug_state.dart';
part 'debug_bloc.freezed.dart';

/// {@template debug_bloc}
/// A bloc for the debug.
/// {@endtemplate}
class DebugBloc extends Bloc<DebugEvent, DebugState> {
  final IDebugRepository _debugRepository;

  /// {@macro debug_bloc}
  DebugBloc({required IDebugRepository debugRepository})
    : _debugRepository = debugRepository,
      super(const DebugState()) {
    /// Initializes the bloc.
    on<DebugInitialize>(_initialize);
    on<DebugSetBaseUrl>((event, emit) => _setBaseUrl(event.baseUrl, emit));
  }

  Future<void> _initialize(DebugInitialize event, Emitter<DebugState> emit) async {
    final baseUriRes = await _debugRepository.getBaseUri();

    final baseUri = switch (baseUriRes) {
      ResultOk<Uri, Object>(:final data) => data,
      ResultFailed<Uri, Object>() => null,
    };

    final baseUrl =
        Urls.values.firstWhereOrNull(
          (el) => el.value == baseUri?.toString(),
        ) ??
        event.environmentUrl;

    emit(state.copyWith(baseUrl: baseUrl));
  }

  void _setBaseUrl(Urls baseUrl, Emitter<DebugState> emit) {
    final baseUri = Uri.tryParse(baseUrl.value);

    if (baseUri == null) {
      return;
    }

    unawaited(_debugRepository.setBaseUri(baseUri));

    emit(state.copyWith(baseUrl: baseUrl));
  }
}
