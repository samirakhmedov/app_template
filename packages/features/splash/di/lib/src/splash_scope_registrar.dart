import 'package:app_presentation/app_presentation.dart';
import 'package:splash_di/src/i_splash_scope.dart';
import 'package:splash_di/src/splash_scope_holder.dart';

/// {@template splash_scope_registrar}
/// A registrar for the splash scope.
/// {@endtemplate}
class SplashScopeRegistrar implements DependenciesRegistrar<ISplashScope> {
  /// The holder for the splash scope.
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
