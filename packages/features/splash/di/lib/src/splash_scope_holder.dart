import 'package:app_di/app_di.dart';
import 'package:splash_di/src/splash_scope_container.dart';
import 'package:yx_scope/yx_scope.dart';

/// {@template splash_scope_holder}
/// A holder for the splash scope.
/// {@endtemplate}
class SplashScopeHolder extends ChildScopeHolder<SplashScopeContainer, IAppScope> {
  /// {@macro splash_scope_holder}
  SplashScopeHolder(super.parent);

  @override
  SplashScopeContainer createContainer(IAppScope parent) => SplashScopeContainer(parent: parent);
}
