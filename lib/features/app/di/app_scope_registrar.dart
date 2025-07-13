import 'package:app_template/core/architecture/di/dependencies_registrar.dart';
import 'package:app_template/core/config/environment/environment.dart';
import 'package:app_template/features/app/di/app_scope_container.dart';
import 'package:app_template/features/app/di/i_app_scope.dart';

/// {@template app_scope_registrar}
/// A registrar for the app scope.
/// {@endtemplate}
class AppScopeRegistrar implements DependenciesRegistrar<IAppScope> {
  /// The environment.
  final Environment environment;

  /// The holder.
  late final AppScopeHolder holder;

  /// {@macro app_scope_registrar}
  AppScopeRegistrar({required this.environment});

  @override
  Future<void> dispose() => holder.drop();

  @override
  Future<IAppScope> initialize() async {
    holder = AppScopeHolder();

    await holder.create(environment);

    // ignore: avoid-non-null-assertion
    return holder.scope!;
  }
}
