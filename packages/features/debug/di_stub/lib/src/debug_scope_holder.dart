import 'package:app_di/app_di.dart';
import 'package:debug_di_stub/src/debug_scope_container.dart';
import 'package:yx_scope/yx_scope.dart';

/// {@template debug_scope_holder}
/// Stub holder for the debug scope.
/// {@endtemplate}
class DebugScopeHolder extends ChildScopeHolder<DebugScopeContainer, IAppScope> {
  /// {@macro debug_scope_holder}
  DebugScopeHolder(super.parent);

  @override
  DebugScopeContainer createContainer(IAppScope parent) => DebugScopeContainer(parent: parent);
}
