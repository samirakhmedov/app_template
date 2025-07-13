// ignore_for_file: avoid-returning-widgets

import 'package:app_template/core/architecture/presentation/component.dart';
import 'package:flutter/material.dart';

/// {@template layout}
/// Base class for all layouts.
/// {@endtemplate}
abstract class Layout<V extends ViewModel> extends StatelessWidget {
  /// {@macro layout}
  const Layout({required this.viewModel, super.key});

  /// The view model to display.
  final V viewModel;

  /// The layout to display.
  Widget layout(V vm);

  @override
  Widget build(BuildContext _) {
    return layout(viewModel);
  }
}
