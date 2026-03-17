import 'dart:async';

import 'package:app_presentation/app_presentation.dart';
import 'package:flutter/widgets.dart';
import 'package:splash_presentation/splash_presentation.dart';
import 'package:uikit/uikit.dart';

/// {@template splash_component}
/// A component for the splash screen.
/// {@endtemplate}
class SplashCentralComponent extends Component<SplashViewModel, SplashCentralLayout> {
  /// {@macro splash_component}
  const SplashCentralComponent({super.key});

  @override
  ComponentState<SplashCentralComponent, SplashViewModel, SplashCentralLayout> createState() => _SplashComponentState();
}

class _SplashComponentState extends ComponentState<SplashCentralComponent, SplashViewModel, SplashCentralLayout>
    with SingleTickerProviderStateMixin
    implements SplashViewModel {
  late final _animationController = AnimationController(
    duration: kDefaultAnimationDuration,
    vsync: this,
  );

  @override
  void initState() {
    super.initState();
    unawaited(_animationController.forward());
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  SplashCentralLayout view() => SplashCentralLayout(viewModel: this);

  @override
  Animation<double> get fadeAnimation => _animationController;
}

/// {@template splash_view_model}
/// A view model for the splash screen.
/// {@endtemplate}
abstract class SplashViewModel implements ViewModel {
  /// The fade animation.
  Animation<double> get fadeAnimation;
}
