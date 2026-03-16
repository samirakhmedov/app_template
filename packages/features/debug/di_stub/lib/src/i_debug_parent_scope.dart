import 'package:yx_scope/yx_scope.dart';

/// {@template i_debug_parent_scope}
/// Stub parent scope interface for the debug feature.
///
/// Non-debug app targets implement this interface on their AppScopeContainer
/// without providing any debug-specific dependencies.
/// {@endtemplate}
abstract interface class IDebugParentScope implements Scope {}
