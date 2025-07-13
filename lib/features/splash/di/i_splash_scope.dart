import 'package:app_template/features/splash/presentation/state/bloc/splash_bloc.dart';
import 'package:yx_scope/yx_scope.dart';

/// {@template i_splash_scope}
/// An interface for the splash scope.
/// {@endtemplate}
abstract interface class ISplashScope implements Scope {
  /// The splash bloc.
  SplashBloc get splashBloc;
}
