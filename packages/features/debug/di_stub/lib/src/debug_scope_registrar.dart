import 'package:app_presentation/app_presentation.dart';
import 'package:debug_di_stub/src/debug_scope_holder.dart';
import 'package:debug_di_stub/src/i_debug_scope.dart';

/// {@template debug_scope_registrar}
/// Stub registrar for the debug scope.
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
