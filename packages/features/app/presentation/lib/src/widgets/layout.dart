// ignore_for_file: avoid-returning-widgets

import 'package:app_presentation/src/widgets/component.dart';
import 'package:flutter/material.dart';

abstract class Layout<V extends ViewModel> extends StatelessWidget {
  const Layout({required this.viewModel, super.key});

  final V viewModel;

  Widget layout(V vm);

  @override
  Widget build(BuildContext _) {
    return layout(viewModel);
  }
}
