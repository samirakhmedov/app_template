import 'package:{{name.snakeCase()}}_domain/{{name.snakeCase()}}_domain.dart';
import 'package:yx_scope/yx_scope.dart';

abstract interface class I{{name.pascalCase()}}Scope implements Scope {
  {{name.pascalCase()}}Bloc get {{name.camelCase()}}Bloc;
}
