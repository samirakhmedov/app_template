import 'package:app_template/core/architecture/presentation/component.dart';
import 'package:app_template/features/{{feature.snakeCase()}}/presentation/widgets/{{name.snakeCase()}}_layout.dart';
import 'package:flutter/material.dart';

/// {@template {{name.snakeCase()}}_component}
/// A component for the {{name.snakeCase()}} widget.
/// {@endtemplate}
class {{name.pascalCase()}}Component extends Component<{{name.pascalCase()}}ViewModel, {{name.pascalCase()}}Layout> {
  /// {@macro {{name.snakeCase()}}_component}
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

/// {@template {{name.snakeCase()}}_view_model}
/// A view model for the {{name.snakeCase()}} widget.
/// {@endtemplate}
abstract class {{name.pascalCase()}}ViewModel implements ViewModel {

}
