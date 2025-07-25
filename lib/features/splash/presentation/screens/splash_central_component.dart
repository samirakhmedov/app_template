import 'dart:async';

import 'package:app_template/core/architecture/presentation/widgets/component.dart';
import 'package:app_template/core/config/constants.dart';
import 'package:app_template/features/app/di/i_app_scope.dart';
import 'package:app_template/features/app/router/app_router.dart';
import 'package:app_template/features/common/presentation/state/shader/shader_bloc.dart';
import 'package:app_template/features/splash/presentation/screens/splash_central_layout.dart';
import 'package:app_template/features/splash/presentation/state/bloc/splash_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template splash_component}
/// A component for the splash screen.
/// {@endtemplate}
@RoutePage()
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

  ShaderBloc get _shaderBloc => context.read<IAppScope>().shaderBloc;

  @override
  void initState() {
    super.initState();
    unawaited(_animationController.forward());
    _shaderBloc.add(ShaderEvent.loadShimmer());
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
    BlocListener<StateStreamable<ShaderState>, ShaderState>(
      listener: (context, state) {
        _checkReadiness();
      },
      bloc: _shaderBloc,
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

    if (_splashBloc.state is! SplashStateLoaded) {
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
