import 'package:app_template/core/architecture/presentation/layout.dart';
import 'package:app_template/features/{{feature.snakeCase()}}/presentation/screens/{{name.snakeCase()}}_component.dart';
import 'package:flutter/material.dart';

/// {@template {{name.snakeCase()}}_layout}
/// A layout for the {{name.snakeCase()}}.
/// {@endtemplate}
class {{name.pascalCase()}}Layout extends Layout<{{name.pascalCase()}}ViewModel> {
  /// {@macro {{name.snakeCase()}}_layout}
  const {{name.pascalCase()}}Layout({
    required super.viewModel,
    super.key,
  });

  @override
  Widget layout({{name.pascalCase()}}ViewModel vm) {
    return const Scaffold(
      body: Center(
        child: Text('{{name.pascalCase()}} screen is working!'),
      ),
    );
  }
}
