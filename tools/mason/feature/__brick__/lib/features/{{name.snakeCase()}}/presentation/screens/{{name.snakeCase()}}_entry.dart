import 'package:app_template/core/architecture/di/dependencies_registrar.dart';
import 'package:app_template/core/architecture/presentation/feature_entry.dart';
import 'package:app_template/features/app/di/i_app_scope.dart';
import 'package:app_template/features/app/presentation/app_startup_layout.dart';
import 'package:app_template/features/{{name.snakeCase()}}/di/i_{{name.snakeCase()}}_scope.dart';
import 'package:app_template/features/{{name.snakeCase()}}/di/{{name.snakeCase()}}_scope_registrar.dart';
import 'package:app_template/features/{{name.snakeCase()}}/presentation/screens/{{name.snakeCase()}}_component.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';

/// {@template {{name.snakeCase()}}_entry}
/// A feature entry for the {{name.snakeCase()}} screen.
/// {@endtemplate}
@RoutePage()
class {{name.pascalCase()}}Entry extends FeatureEntry<I{{name.pascalCase()}}Scope, {{name.pascalCase()}}Component> {
  /// {@macro {{name.snakeCase()}}_entry}
  const {{name.pascalCase()}}Entry({super.key});

  @override
  List<SingleChildWidget> providers(I{{name.pascalCase()}}Scope scope) {
    return [BlocProvider.value(value: scope.{{name.camelCase()}}Bloc)];
  }

  @override
  DependenciesRegistrar<I{{name.pascalCase()}}Scope> scope(BuildContext context) {
    final scope = context.read<IAppScope>();

    // ignore: avoid-undisposed-instances
    return {{name.pascalCase()}}ScopeRegistrar(scope.{{name.camelCase()}}Scope);
  }

  @override
  {{name.pascalCase()}}Component component() {
    return const {{name.pascalCase()}}Component();
  }

  @override
  Widget placeholder(BuildContext context) {
    return const AppStartupLayout();
  }
}
