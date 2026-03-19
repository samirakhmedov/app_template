import 'package:app_presentation/app_presentation.dart';
import 'package:{{feature.snakeCase()}}_presentation/src/widgets/{{name.snakeCase()}}_component.dart';
import 'package:flutter/material.dart';

class {{name.pascalCase()}}Layout extends Layout<{{name.pascalCase()}}ViewModel> {
  const {{name.pascalCase()}}Layout({
    required super.viewModel,
    super.key,
  });

  @override
  Widget layout({{name.pascalCase()}}ViewModel vm) {
    return const Center(
      child: Text('{{name.pascalCase()}} widget is working!'),
    );
  }
}
