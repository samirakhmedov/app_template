import 'package:app_template/core/architecture/presentation/core/empty_view_model.dart';
import 'package:app_template/core/architecture/presentation/widgets/component.dart';
import 'package:app_template/core/architecture/presentation/widgets/layout.dart';
import 'package:flutter/material.dart';

/// Placeholder layout for widgets with logic only.
class ChildLayout extends Layout<EmptyViewModel> {
  /// Child layout constructor.
  ChildLayout({
    required this.child,
    super.key,
  }) : super(viewModel: EmptyViewModel());

  /// Child widget hierarchy.
  final Widget child;

  @override
  Widget layout(ViewModel vm) => child;
}
