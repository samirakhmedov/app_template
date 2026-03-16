import 'package:debug_domain/debug_domain.dart';
import 'package:yx_scope/yx_scope.dart';

/// {@template i_debug_scope}
/// An interface for the debug scope.
/// {@endtemplate}
abstract interface class IDebugScope implements Scope {
  /// The debug bloc.
  DebugBloc get debugBloc;
}
