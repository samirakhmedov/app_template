import 'package:haptics_di/src/haptics_scope_container.dart';
import 'package:haptics_di/src/i_haptics_parent_scope.dart';
import 'package:yx_scope/yx_scope.dart';

/// {@template haptics_scope_holder}
/// A holder for the haptics scope.
/// {@endtemplate}
class HapticsScopeHolder extends ChildScopeHolder<HapticsScopeContainer, IHapticsParentScope> {
  /// {@macro haptics_scope_holder}
  HapticsScopeHolder(super.parent);

  @override
  HapticsScopeContainer createContainer(IHapticsParentScope parent) => HapticsScopeContainer(parent: parent);
}
