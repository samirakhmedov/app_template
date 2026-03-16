import 'package:debug_di_stub/src/i_debug_parent_scope.dart';
import 'package:debug_di_stub/src/i_debug_scope.dart';
import 'package:yx_scope/yx_scope.dart';

/// {@template debug_scope_container}
/// Stub debug scope container — no dependencies, no initialization queue.
/// {@endtemplate}
class DebugScopeContainer extends ChildScopeContainer<IDebugParentScope>
    implements IDebugScope {
  @override
  List<Set<AsyncDep<Object>>> get initializeQueue => const [];

  /// {@macro debug_scope_container}
  DebugScopeContainer({required super.parent});
}
