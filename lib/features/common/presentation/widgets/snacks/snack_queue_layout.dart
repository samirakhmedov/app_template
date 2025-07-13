import 'package:app_template/core/architecture/presentation/layout.dart';
import 'package:app_template/features/common/presentation/widgets/snacks/snack_queue_component.dart';
import 'package:flutter/material.dart';

/// {@template snack_queue_layout}
/// A "dumb" layout that simply returns the child supplied by its view-model.
/// {@endtemplate}
class SnackQueueLayout extends Layout<SnackQueueViewModel> {
  /// {@macro snack_queue_layout}
  const SnackQueueLayout({required super.viewModel, super.key});

  @override
  Widget layout(SnackQueueViewModel vm) => vm.child;
}
