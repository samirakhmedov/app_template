import 'package:app_template/core/architecture/di/dependencies_registrar.dart';
import 'package:app_template/features/{{name.snakeCase()}}/di/i_{{name.snakeCase()}}_scope.dart';
import 'package:app_template/features/{{name.snakeCase()}}/di/{{name.snakeCase()}}_scope_container.dart';

/// {@template {{name.snakeCase()}}_scope_registrar}
/// A registrar for the {{name.snakeCase()}} scope.
/// {@endtemplate}
class {{name.pascalCase()}}ScopeRegistrar implements DependenciesRegistrar<I{{name.pascalCase()}}Scope> {
  /// The holder.
  final {{name.pascalCase()}}ScopeHolder holder;

  /// {@macro {{name.snakeCase()}}_scope_registrar}
  const {{name.pascalCase()}}ScopeRegistrar(this.holder);

  @override
  Future<void> dispose() => holder.drop();
  @override
  Future<I{{name.pascalCase()}}Scope> initialize() async {
    await holder.create();

    // ignore: avoid-non-null-assertion
    return holder.scope!;
  }
}
