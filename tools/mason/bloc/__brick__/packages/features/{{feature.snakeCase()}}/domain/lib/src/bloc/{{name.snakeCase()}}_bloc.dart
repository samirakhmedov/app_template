import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:{{feature.snakeCase()}}_domain/{{feature.snakeCase()}}_domain.dart';

part '{{name.snakeCase()}}_bloc.freezed.dart';
part '{{name.snakeCase()}}_event.dart';
part '{{name.snakeCase()}}_state.dart';

class {{name.pascalCase()}}Bloc extends Bloc<{{name.pascalCase()}}Event, {{name.pascalCase()}}State> {
  final I{{feature.pascalCase()}}Repository _repository;

  {{name.pascalCase()}}Bloc({required I{{feature.pascalCase()}}Repository repository})
    : _repository = repository,
      super(const {{name.pascalCase()}}State.initial()) {
    on<{{name.pascalCase()}}Initialize>(_initialize);
  }

  Future<void> _initialize({{name.pascalCase()}}Initialize _, Emitter<{{name.pascalCase()}}State> emit) async {
    emit(const {{name.pascalCase()}}State.loading());
    await _repository.initialize();
    emit(const {{name.pascalCase()}}State.loaded());
  }
}
