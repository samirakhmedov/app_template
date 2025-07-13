part of '{{name.snakeCase()}}_bloc.dart';

/// {@template {{name.snakeCase()}}_state}
/// A state for the {{name.snakeCase()}} screen.
/// {@endtemplate}
@freezed
abstract class {{name.pascalCase()}}State with _${{name.pascalCase()}}State {
  /// {@macro {{name.snakeCase()}}_state}
  const factory {{name.pascalCase()}}State.initial() = {{name.pascalCase()}}StateInitial;

  /// {@macro {{name.snakeCase()}}_state}
  const factory {{name.pascalCase()}}State.loading() = {{name.pascalCase()}}StateLoading;

  /// {@macro {{name.snakeCase()}}_state}
  const factory {{name.pascalCase()}}State.loaded() = {{name.pascalCase()}}StateLoaded;
}
