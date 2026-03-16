import 'package:core/core.dart';
import 'package:debug_domain/debug_domain.dart';
import 'package:yx_scope/yx_scope.dart';

/// {@template i_debug_parent_scope}
/// Defines the dependencies that the debug scope container requires from its parent scope.
///
/// Any scope that wants to host a debug child scope must implement this interface.
/// {@endtemplate}
abstract interface class IDebugParentScope implements Scope {
  /// The debug repository.
  IDebugRepository get debugRepository;

  /// The environment URL used to initialize the debug bloc.
  Urls get environmentUrl;
}
