import 'package:app_template/core/architecture/presentation/widgets/layout.dart';
import 'package:app_template/features/debug/presentation/widgets/drag/drag_component.dart';
import 'package:flutter/material.dart';
import 'package:uikit/uikit.dart';

/// {@template drag_layout}
/// A layout for the drag.
/// {@endtemplate}
class DragLayout extends Layout<DragViewModel> {
  /// {@macro drag_layout}
  const DragLayout({
    required super.viewModel,
    super.key,
  });

  @override
  Widget layout(DragViewModel vm) {
    return GestureDetector(
      onPanStart: vm.onPanStart,
      onPanUpdate: vm.onPanUpdate,
      onPanEnd: vm.onPanEnd,
      child: ValueListenableBuilder(
        valueListenable: vm.offsetAnimation,
        builder: (context, value, child) {
          return Transform(
            transform: Matrix4.identity()..translate(value.dx, value.dy),
            alignment: Alignment.center,
            child: child,
          );
        },
        child: ValueListenableBuilder(
          valueListenable: vm.isDragging,
          builder: (ctx, value, child) => AnimatedPressScale(
            isPressed: value,
            scale: 1.2,
            duration: const Duration(milliseconds: 100),
            child: child ?? const SizedBox(),
          ),
          child: vm.child,
        ),
      ),
    );
  }
}
