import 'package:app_template/features/app/di/app_scope_container.dart';
import 'package:app_template/features/app/di/i_app_scope.dart';
import 'package:app_template/features/debug/di/i_debug_scope.dart';
import 'package:app_template/features/debug/presentation/state/bloc/debug_bloc.dart';
import 'package:yx_scope/yx_scope.dart';

/// {@template debug_scope_container}
/// A container for the debug scope.
/// {@endtemplate}
class DebugScopeContainer extends ChildScopeContainer<IAppScope> implements IDebugScope {
  /// The debug bloc dependency.
  late final debugBlocDep = rawAsyncDep<DebugBloc>(
    _createDebugBloc,
    init: (bloc) async => bloc.add(DebugInitialize(environmentUrl: parent.environment.url)),
    dispose: (bloc) => bloc.close(),
  );

  @override
  List<Set<AsyncDep<Object>>> get initializeQueue => [
    {debugBlocDep},
  ];

  @override
  DebugBloc get debugBloc => debugBlocDep.get;

  /// {@macro debug_scope_container}
  DebugScopeContainer({required super.parent});

  /// Creates a new debug bloc.
  DebugBloc _createDebugBloc() {
    return DebugBloc(debugRepository: parent.debugRepository);
  }
}

/// {@template debug_scope_holder}
/// A holder for the debug scope.
/// {@endtemplate}
class DebugScopeHolder extends ChildScopeHolder<DebugScopeContainer, IAppScope> {
  /// {@macro debug_scope_holder}
  DebugScopeHolder(super.parent);

  @override
  DebugScopeContainer createContainer(IAppScope parent) => DebugScopeContainer(parent: parent);
}
