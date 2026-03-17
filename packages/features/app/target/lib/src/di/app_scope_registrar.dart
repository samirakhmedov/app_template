import 'package:app_presentation/app_presentation.dart';
import 'package:app_target/src/di/app_scope_container.dart';
import 'package:app_target/src/di/i_app_scope.dart';
import 'package:core/core.dart';
import 'package:debug_di_interface/debug_di_interface.dart';

/// {@template app_scope_registrar}
/// Initializes and disposes the [AppScopeContainer].
/// {@endtemplate}
class AppScopeRegistrar implements DependenciesRegistrar<IAppScope> {
  /// The environment used to build the scope.
  final Environment environment;

  /// Optional factory forwarded to [AppScopeHolder].
  ///
  /// Pass `null` for production targets; pass `AppScopeDebugModule.new` (from
  /// `debug_di`) for the debug target.
  final IDebugModule Function(AppScopeContainer)? debugModuleFactory;

  late final AppScopeHolder _holder;

  /// {@macro app_scope_registrar}
  AppScopeRegistrar({required this.environment, this.debugModuleFactory});

  @override
  Future<IAppScope> initialize() async {
    _holder = AppScopeHolder(debugModuleFactory: debugModuleFactory);

    await _holder.create(environment);

    // ignore: avoid-non-null-assertion
    return _holder.scope!;
  }

  @override
  Future<void> dispose() => _holder.drop();
}
