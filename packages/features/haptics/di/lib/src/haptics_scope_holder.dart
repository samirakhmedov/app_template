import 'package:app_di/app_di.dart';
import 'package:haptics_di/src/haptics_scope_container.dart';
import 'package:yx_scope/yx_scope.dart';

/// {@template haptics_scope_holder}
/// A holder for the haptics scope.
/// {@endtemplate}
class HapticsScopeHolder extends ChildScopeHolder<HapticsScopeContainer, IAppScope> {
  /// {@macro haptics_scope_holder}
  HapticsScopeHolder(super.parent);

  @override
  HapticsScopeContainer createContainer(IAppScope parent) => HapticsScopeContainer(parent: parent);
}
