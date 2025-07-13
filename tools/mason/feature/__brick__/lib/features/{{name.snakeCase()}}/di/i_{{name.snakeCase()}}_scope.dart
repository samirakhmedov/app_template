import 'package:app_template/features/{{name.snakeCase()}}/presentation/state/bloc/{{name.snakeCase()}}_bloc.dart';
import 'package:yx_scope/yx_scope.dart';

/// {@template i_{{name.snakeCase()}}_scope}
/// An interface for the {{name.snakeCase()}} scope.
/// {@endtemplate}
abstract interface class I{{name.pascalCase()}}Scope implements Scope {
  /// The {{name.snakeCase()}} bloc.
  {{name.pascalCase()}}Bloc get {{name.camelCase()}}Bloc;
}
