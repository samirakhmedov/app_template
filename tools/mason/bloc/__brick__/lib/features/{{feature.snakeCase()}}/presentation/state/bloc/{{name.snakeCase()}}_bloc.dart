import 'dart:async';

import 'package:app_template/features/{{feature.snakeCase()}}/domain/repositories/i_{{feature.snakeCase()}}_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '{{name.snakeCase()}}_event.dart';
part '{{name.snakeCase()}}_state.dart';
part '{{name.snakeCase()}}_bloc.freezed.dart';

/// {@template {{name.snakeCase()}}_bloc}
/// A bloc for the {{name.snakeCase()}}.
/// {@endtemplate}
class {{name.pascalCase()}}Bloc extends Bloc<{{name.pascalCase()}}Event, {{name.pascalCase()}}State> {
  final I{{feature.pascalCase()}}Repository _{{feature.camelCase()}}Repository;

  /// {@macro {{name.snakeCase()}}_bloc}
  {{name.pascalCase()}}Bloc({required I{{feature.pascalCase()}}Repository {{feature.camelCase()}}Repository})
    : _{{feature.camelCase()}}Repository = {{feature.camelCase()}}Repository,
      super(const {{name.pascalCase()}}State.initial()) {
    on<{{name.pascalCase()}}Initialize>((event, emit) => _initialize(emit));
  }

  Future<void> _initialize(Emitter<{{name.pascalCase()}}State> emit) async {
    emit(const {{name.pascalCase()}}State.loading());
    await _{{feature.camelCase()}}Repository.initialize();
    emit(const {{name.pascalCase()}}State.loaded());
  }
}
