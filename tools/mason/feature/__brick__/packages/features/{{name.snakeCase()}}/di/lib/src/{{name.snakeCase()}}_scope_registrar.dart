import 'package:app_presentation/app_presentation.dart';
import 'package:{{name.snakeCase()}}_di/src/i_{{name.snakeCase()}}_scope.dart';
import 'package:{{name.snakeCase()}}_di/src/{{name.snakeCase()}}_scope_holder.dart';

class {{name.pascalCase()}}ScopeRegistrar implements DependenciesRegistrar<I{{name.pascalCase()}}Scope> {
  final {{name.pascalCase()}}ScopeHolder holder;

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
