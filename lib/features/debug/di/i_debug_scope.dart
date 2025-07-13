import 'package:app_template/features/debug/presentation/state/bloc/debug_bloc.dart';
import 'package:yx_scope/yx_scope.dart';

/// {@template i_debug_scope}
/// A scope for the debug feature.
/// {@endtemplate}
abstract interface class IDebugScope implements Scope {
  /// The debug bloc.
  DebugBloc get debugBloc;
}
