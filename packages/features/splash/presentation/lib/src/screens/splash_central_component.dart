import 'dart:async';


import 'package:app_presentation/app_presentation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splash_domain/splash_domain.dart';
import 'package:splash_presentation/splash_presentation.dart';
import 'package:uikit/uikit.dart';

/// {@template splash_component}
/// A component for the splash screen.
/// {@endtemplate}
class SplashCentralComponent extends Component<SplashViewModel, SplashCentralLayout> {
  /// {@macro splash_component}
  const SplashCentralComponent({super.key});

  @override
  ComponentState<SplashCentralComponent, SplashViewModel, SplashCentralLayout> createState() =>
      _SplashComponentState();
}

class _SplashComponentState
    extends ComponentState<SplashCentralComponent, SplashViewModel, SplashCentralLayout>
    with SingleTickerProviderStateMixin
    implements SplashViewModel {
  static const _splashTimeout = Duration(milliseconds: 500);

  late final _animationController = AnimationController(
    duration: kDefaultAnimationDuration,
    vsync: this,
  );

  @override
  void initState() {
    super.initState();
    unawaited(_animationController.forward());
    _startTimeout();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  bool _timeoutReached = false;

  @override
  List<BlocListenerBase<StateStreamable<Object?>, Object?>> listeners() => [
    BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        _checkReadiness();
      },
      listenWhen: (previous, current) => current is SplashStateLoaded,
    ),
  ];

  @override
  SplashCentralLayout view() => SplashCentralLayout(viewModel: this);

  void _startTimeout() {
    Future.delayed(_splashTimeout, () {
      _timeoutReached = true;
      _checkReadiness();
    });
  }

  void _checkReadiness() {
    if (!_timeoutReached) {
      return;
    }

    _ready();
  }

  void _ready() {
    unawaited(context.router.replaceAll([const DebugRoute()]));
  }

  SplashBloc get _splashBloc => context.read<SplashBloc>();

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
