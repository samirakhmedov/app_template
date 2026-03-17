import 'package:app_di/app_di.dart';
import 'package:debug_di/src/i_debug_scope.dart';
import 'package:debug_domain/debug_domain.dart';
import 'package:yx_scope/yx_scope.dart';

/// {@template debug_scope_container}
/// A container for the debug scope.
/// {@endtemplate}
class DebugScopeContainer extends ChildScopeContainer<IAppScope> implements IDebugScope {
  /// The debug bloc dependency.
  late final debugBlocDep = rawAsyncDep<DebugBloc>(
    _createDebugBloc,
    init: (bloc) async => bloc.add(DebugInitialize(environmentUrl: parent.environmentUrl)),
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

  DebugBloc _createDebugBloc() {
    return DebugBloc(debugRepository: parent.debugRepository);
  }
}
