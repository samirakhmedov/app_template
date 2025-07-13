import 'package:app_template/core/architecture/di/dependencies_registrar.dart';
import 'package:app_template/features/app/di/i_app_scope.dart';
import 'package:app_template/features/{{name.snakeCase()}}/data/repositories/{{name.snakeCase()}}_repository.dart';
import 'package:app_template/features/{{name.snakeCase()}}/di/i_{{name.snakeCase()}}_scope.dart';
import 'package:app_template/features/{{name.snakeCase()}}/domain/repositories/i_{{name.snakeCase()}}_repository.dart';
import 'package:app_template/features/{{name.snakeCase()}}/presentation/state/bloc/{{name.snakeCase()}}_bloc.dart';
import 'package:yx_scope/yx_scope.dart';

/// {@template {{name.snakeCase()}}_scope_container}
/// A container for the {{name.snakeCase()}} scope.
/// {@endtemplate}
class {{name.pascalCase()}}ScopeContainer extends ChildScopeContainer<IAppScope> implements I{{name.pascalCase()}}Scope {
  /// The {{name.snakeCase()}} bloc dependency.
  late final {{name.camelCase()}}BlocDep = rawAsyncDep<{{name.pascalCase()}}Bloc>(
    _create{{name.pascalCase()}}Bloc,
    init: (bloc) async => bloc.add({{name.pascalCase()}}Initialize()),
    dispose: (bloc) => bloc.close(),
  );

  /// The {{name.snakeCase()}} repository dependency.
  late final {{name.camelCase()}}RepositoryDep = dep<I{{name.pascalCase()}}Repository>(_create{{name.pascalCase()}}Repository);

  /// The initialize queue.
  @override
  List<Set<AsyncDepType>> get initializeQueue => [
    {{{name.camelCase()}}BlocDep},
  ];

  @override
  {{name.pascalCase()}}Bloc get {{name.camelCase()}}Bloc => {{name.camelCase()}}BlocDep.get;

  /// {@macro {{name.snakeCase()}}_scope_container}
  {{name.pascalCase()}}ScopeContainer({required super.parent});

  {{name.pascalCase()}}Bloc _create{{name.pascalCase()}}Bloc() {
    return {{name.pascalCase()}}Bloc({{name.camelCase()}}Repository: {{name.camelCase()}}RepositoryDep.get);
  }

  I{{name.pascalCase()}}Repository _create{{name.pascalCase()}}Repository() {
    return {{name.pascalCase()}}Repository(logger: parent.logger);
  }
}

/// {@template {{name.snakeCase()}}_scope_holder}
/// A holder for the {{name.snakeCase()}} scope.
/// {@endtemplate}
class {{name.pascalCase()}}ScopeHolder extends ChildScopeHolder<{{name.pascalCase()}}ScopeContainer, IAppScope> {
  /// {@macro {{name.snakeCase()}}_scope_holder}
  {{name.pascalCase()}}ScopeHolder(super.parent);

  @override
  {{name.pascalCase()}}ScopeContainer createContainer(IAppScope parent) => {{name.pascalCase()}}ScopeContainer(parent: parent);
}
