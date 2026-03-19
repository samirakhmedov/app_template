import 'package:app_presentation/app_presentation.dart';
import 'package:{{name.snakeCase()}}_presentation/src/screens/{{name.snakeCase()}}_component.dart';
import 'package:flutter/material.dart';

class {{name.pascalCase()}}Layout extends Layout<{{name.pascalCase()}}ViewModel> {
  const {{name.pascalCase()}}Layout({
    required super.viewModel,
    super.key,
  });

  @override
  Widget layout({{name.pascalCase()}}ViewModel vm) {
    return const Scaffold(
      body: Center(
        child: Text('{{name.pascalCase()}} feature is working!'),
      ),
    );
  }
}
