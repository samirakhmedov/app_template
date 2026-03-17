import 'package:app_presentation/app_presentation.dart';
import 'package:debug_data/debug_data.dart';
import 'package:debug_di_interface/debug_di_interface.dart';
import 'package:debug_domain/debug_domain.dart';
import 'package:storage/storage.dart';
import 'package:yx_scope/yx_scope.dart';

/// {@template app_scope_debug_module}
/// App-scope debug infrastructure module — real implementation.
///
/// Generic over [IDebugModuleContext] so it carries no dep on AppScopeContainer
/// and can be used by any container that provides [IDebugModuleContext.debugStorage]
/// and [IDebugModuleContext.logger].
/// {@endtemplate}
class AppScopeDebugModule<T extends IDebugModuleContext> extends ScopeModule<T> implements IDebugModule {
  late final debugRepositoryDep = dep<IDebugRepository>(
    () => DebugRepository(
      debugService: debugServiceDep.get,
      logger: container.logger,
    ),
  );

  late final debugServiceDep = rawAsyncDep<IDebugService>(
    () => DebugService(
      debugStorage: DebugStorage(storage: container.debugStorage),
    ),
    init: (service) => service.initialize(),
    dispose: (service) => service.dispose(),
  );

  @override
  List<AsyncDepType> get initDeps => [debugServiceDep];

  @override
  IDebugRepository get repository => debugRepositoryDep.get;

  @override
  String? get rawBaseUri => debugServiceDep.get.baseUri?.toString();

  /// {@macro app_scope_debug_module}
  AppScopeDebugModule(super.container);
}
