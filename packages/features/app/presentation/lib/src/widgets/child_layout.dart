import 'package:app_presentation/src/widgets/component.dart';
import 'package:app_presentation/src/widgets/empty_view_model.dart';
import 'package:app_presentation/src/widgets/layout.dart';
import 'package:flutter/material.dart';

class ChildLayout extends Layout<EmptyViewModel> {
  const ChildLayout({
    required this.child,
    super.key,
  }) : super(viewModel: const EmptyViewModel());

  final Widget child;

  @override
  Widget layout(ViewModel vm) => child;
}
