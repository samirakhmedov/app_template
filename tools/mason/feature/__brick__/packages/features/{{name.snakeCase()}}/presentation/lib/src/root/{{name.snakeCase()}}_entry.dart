import 'package:app_di/app_di.dart';
import 'package:app_presentation/app_presentation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';
import 'package:{{name.snakeCase()}}_di/{{name.snakeCase()}}_di.dart';

class {{name.pascalCase()}}Entry extends FeatureEntry<I{{name.pascalCase()}}Scope> {
  const {{name.pascalCase()}}Entry({super.key});

  @override
  List<SingleChildWidget> providers(I{{name.pascalCase()}}Scope scope) {
    return [BlocProvider.value(value: scope.{{name.camelCase()}}Bloc)];
  }

  @override
  DependenciesRegistrar<I{{name.pascalCase()}}Scope> scope(BuildContext context) {
    final parent = context.read<IAppScope>();

    return {{name.pascalCase()}}ScopeRegistrar({{name.pascalCase()}}ScopeHolder(parent));
  }

  @override
  WidgetBuilder get placeholder =>
      (context) => const AppStartupLayout();
}
