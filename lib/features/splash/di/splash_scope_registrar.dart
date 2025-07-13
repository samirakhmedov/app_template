import 'package:app_template/core/architecture/di/dependencies_registrar.dart';
import 'package:app_template/features/splash/di/i_splash_scope.dart';
import 'package:app_template/features/splash/di/splash_scope_container.dart';

/// {@template splash_scope_registrar}
/// A registrar for the splash scope.
/// {@endtemplate}
class SplashScopeRegistrar implements DependenciesRegistrar<ISplashScope> {
  /// The holder.
  final SplashScopeHolder holder;

  /// {@macro splash_scope_registrar}
  const SplashScopeRegistrar(this.holder);

  @override
  Future<void> dispose() => holder.drop();

  @override
  Future<ISplashScope> initialize() async {
    await holder.create();

    // ignore: avoid-non-null-assertion
    return holder.scope!;
  }
}
