import 'package:haptics_domain/haptics_domain.dart';
import 'package:yx_scope/yx_scope.dart';

/// {@template i_haptics_scope}
/// An interface for the haptics scope.
/// {@endtemplate}
abstract interface class IHapticsScope implements Scope {
  /// The haptics bloc.
  HapticsBloc get hapticsBloc;
}
