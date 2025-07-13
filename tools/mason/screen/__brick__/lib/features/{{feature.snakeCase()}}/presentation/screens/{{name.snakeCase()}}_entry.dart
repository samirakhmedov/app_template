import 'package:app_template/core/architecture/di/dependencies_registrar.dart';
import 'package:app_template/core/architecture/presentation/feature_entry.dart';
import 'package:app_template/features/app/di/i_app_scope.dart';
import 'package:app_template/features/app/presentation/app_startup_layout.dart';
import 'package:app_template/features/{{feature.snakeCase()}}/di/i_{{feature.snakeCase()}}_scope.dart';
import 'package:app_template/features/{{feature.snakeCase()}}/di/{{feature.snakeCase()}}_scope_registrar.dart';
import 'package:app_template/features/{{feature.snakeCase()}}/presentation/screens/{{name.snakeCase()}}_component.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';

/// {@template {{name.snakeCase()}}_entry}
/// A feature entry for the {{name.snakeCase()}} screen.
/// {@endtemplate}
@RoutePage()
class {{name.pascalCase()}}Entry extends FeatureEntry<I{{feature.pascalCase()}}Scope, {{name.pascalCase()}}Component> {
  /// {@macro {{name.snakeCase()}}_entry}
  const {{name.pascalCase()}}Entry({super.key});

  @override
  List<SingleChildWidget> providers(I{{feature.pascalCase()}}Scope scope) {
    return [BlocProvider.value(value: scope.{{feature.camelCase()}}Bloc)];
  }

  @override
  DependenciesRegistrar<I{{feature.pascalCase()}}Scope> scope(BuildContext context) {
    final scope = context.read<IAppScope>();

    // ignore: avoid-undisposed-instances
    return {{feature.pascalCase()}}ScopeRegistrar(scope.{{feature.camelCase()}}Scope);
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
