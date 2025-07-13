import 'package:app_template/core/architecture/di/dependencies_registrar.dart';
import 'package:app_template/features/debug/di/debug_scope_container.dart';
import 'package:app_template/features/debug/di/i_debug_scope.dart';

/// {@template debug_scope_registrar}
/// A registrar for the debug scope.
/// {@endtemplate}
class DebugScopeRegistrar implements DependenciesRegistrar<IDebugScope> {
  /// The holder for the debug scope.
  final DebugScopeHolder holder;

  /// {@macro debug_scope_registrar}
  const DebugScopeRegistrar(this.holder);

  @override
  Future<void> dispose() => holder.drop();

  @override
  Future<IDebugScope> initialize() async {
    await holder.create();

    // ignore: avoid-non-null-assertion
    return holder.scope!;
  }
}
