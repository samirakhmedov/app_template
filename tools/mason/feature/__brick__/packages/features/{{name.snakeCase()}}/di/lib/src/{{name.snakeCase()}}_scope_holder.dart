import 'package:app_di/app_di.dart';
import 'package:{{name.snakeCase()}}_di/src/{{name.snakeCase()}}_scope_container.dart';
import 'package:yx_scope/yx_scope.dart';

class {{name.pascalCase()}}ScopeHolder extends ChildScopeHolder<{{name.pascalCase()}}ScopeContainer, IAppScope> {
  {{name.pascalCase()}}ScopeHolder(super.parent);

  @override
  {{name.pascalCase()}}ScopeContainer createContainer(IAppScope parent) => {{name.pascalCase()}}ScopeContainer(parent: parent);
}
