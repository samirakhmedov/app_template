import 'package:debug_di_stub/src/debug_scope_container.dart';
import 'package:debug_di_stub/src/i_debug_parent_scope.dart';
import 'package:yx_scope/yx_scope.dart';

/// {@template debug_scope_holder}
/// Stub holder for the debug scope.
/// {@endtemplate}
class DebugScopeHolder extends ChildScopeHolder<DebugScopeContainer, IDebugParentScope> {
  /// {@macro debug_scope_holder}
  DebugScopeHolder(super.parent);

  @override
  DebugScopeContainer createContainer(IDebugParentScope parent) => DebugScopeContainer(parent: parent);
}
