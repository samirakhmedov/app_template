import 'package:app_template/core/architecture/presentation/layout.dart';
import 'package:app_template/features/debug/presentation/screens/easter_egg/easter_egg_component.dart';
import 'package:app_template/features/debug/presentation/widgets/app_flutter_logo.dart';
import 'package:app_template/features/debug/presentation/widgets/drag/drag_component.dart';
import 'package:app_template/features/debug/presentation/widgets/rotation/rotation_component.dart';
import 'package:app_template/features/debug/presentation/widgets/template_background_widget.dart';
import 'package:flutter/material.dart';

/// {@template easter_egg_layout}
/// A layout for the easter egg.
/// {@endtemplate}
class EasterEggLayout extends Layout<EasterEggViewModel> {
  /// {@macro easter_egg_layout}
  const EasterEggLayout({
    required super.viewModel,
    super.key,
  });

  @override
  Widget layout(EasterEggViewModel vm) {
    return Scaffold(
      body: RotationComponent(
        rotationTargetKey: vm.logoKey,
        child: Stack(
          children: [
            const TemplateBackgroundWidget(),
            SafeArea(
              child: Center(
                child: _InteractiveLogo(vm),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InteractiveLogo extends StatelessWidget {
  const _InteractiveLogo(this.component);

  final EasterEggViewModel component;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: DragComponent(
        child: ValueListenableBuilder(
          valueListenable: RotationComponent.of(context).angleState,
          builder: (ctx, value, child) => Transform.rotate(
            angle: value,
            child: child ?? const SizedBox(),
          ),
          child: SizedBox(
            key: component.logoKey,
            width: 200,
            height: 200,
            child: AppFlutterLogo(),
          ),
        ),
      ),
    );
  }
}
