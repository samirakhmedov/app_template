import 'package:app_presentation/app_presentation.dart';
import 'package:{{name.snakeCase()}}_presentation/src/screens/{{name.snakeCase()}}_layout.dart';
import 'package:flutter/material.dart';

class {{name.pascalCase()}}Component extends Component<{{name.pascalCase()}}ViewModel, {{name.pascalCase()}}Layout> {
  const {{name.pascalCase()}}Component({super.key});

  @override
  ComponentState<{{name.pascalCase()}}Component, {{name.pascalCase()}}ViewModel, {{name.pascalCase()}}Layout> createState() =>
      _{{name.pascalCase()}}ComponentState();
}

class _{{name.pascalCase()}}ComponentState extends ComponentState<{{name.pascalCase()}}Component, {{name.pascalCase()}}ViewModel, {{name.pascalCase()}}Layout>
    implements {{name.pascalCase()}}ViewModel {

  @override
  {{name.pascalCase()}}Layout view() => {{name.pascalCase()}}Layout(viewModel: this);
}

abstract class {{name.pascalCase()}}ViewModel implements ViewModel {

}
