import 'package:app_domain/app_domain.dart';
import 'package:yx_scope/yx_scope.dart';

/// {@template i_haptics_parent_scope}
/// Defines the dependencies that the haptics scope container requires from its parent scope.
///
/// Any scope that wants to host a haptics child scope must implement this interface.
/// {@endtemplate}
abstract interface class IHapticsParentScope implements Scope {
  /// The logger strategy.
  LoggerStrategy get logger;
}
