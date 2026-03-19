import 'package:app_di/app_di.dart';
import 'package:{{name.snakeCase()}}_data/{{name.snakeCase()}}_data.dart';
import 'package:{{name.snakeCase()}}_di/src/i_{{name.snakeCase()}}_scope.dart';
import 'package:{{name.snakeCase()}}_domain/{{name.snakeCase()}}_domain.dart';
import 'package:yx_scope/yx_scope.dart';

class {{name.pascalCase()}}ScopeContainer extends ChildScopeContainer<IAppScope> implements I{{name.pascalCase()}}Scope {
  late final {{name.camelCase()}}RepositoryDep = dep<I{{name.pascalCase()}}Repository>(_create{{name.pascalCase()}}Repository);

  late final {{name.camelCase()}}BlocDep = rawAsyncDep<{{name.pascalCase()}}Bloc>(
    _create{{name.pascalCase()}}Bloc,
    init: (bloc) async => bloc.add({{name.pascalCase()}}Initialize()),
    dispose: (bloc) => bloc.close(),
  );

  @override
  List<Set<AsyncDep<Object>>> get initializeQueue => [
    {{{name.camelCase()}}BlocDep},
  ];

  @override
  {{name.pascalCase()}}Bloc get {{name.camelCase()}}Bloc => {{name.camelCase()}}BlocDep.get;

  {{name.pascalCase()}}ScopeContainer({required super.parent});

  {{name.pascalCase()}}Bloc _create{{name.pascalCase()}}Bloc() {
    return {{name.pascalCase()}}Bloc(repository: {{name.camelCase()}}RepositoryDep.get);
  }

  I{{name.pascalCase()}}Repository _create{{name.pascalCase()}}Repository() {
    return {{name.pascalCase()}}Repository(logger: parent.logger);
  }
}
