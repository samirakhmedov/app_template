part of '{{name.snakeCase()}}_bloc.dart';

/// {@template {{name.snakeCase()}}_event}
/// An event for the {{name.snakeCase()}}.
/// {@endtemplate}
@freezed
sealed class {{name.pascalCase()}}Event with _${{name.pascalCase()}}Event {
  /// {@macro {{name.snakeCase()}}_event}
  const factory {{name.pascalCase()}}Event.initialize() = {{name.pascalCase()}}Initialize;
}
