import 'package:api/api.dart';
import 'package:flutter/foundation.dart';
import 'package:network/network.dart';
import 'package:splash_data/splash_data.dart';
import 'package:splash_di/src/i_splash_parent_scope.dart';
import 'package:splash_di/src/i_splash_scope.dart';
import 'package:splash_domain/splash_domain.dart';
import 'package:yx_scope/yx_scope.dart';

/// {@template splash_scope_container}
/// A container for the splash scope.
/// {@endtemplate}
class SplashScopeContainer extends ChildScopeContainer<ISplashParentScope> implements ISplashScope {
  /// The splash Dio dependency.
  late final splashDioDep = rawAsyncDep<Dio>(
    () => parent.httpClientFactory.getClientForScope('splash_scope'),
    init: (_) => SynchronousFuture(null),
    dispose: (_) async => parent.httpClientFactory.disposeScopeClient('splash_scope'),
  );

  /// The splash repository dependency.
  late final splashRepositoryDep = dep<ISplashRepository>(_createSplashRepository);

  /// The splash bloc dependency.
  late final splashBlocDep = rawAsyncDep<SplashBloc>(
    _createSplashBloc,
    init: (bloc) async => bloc.add(SplashInitialize()),
    dispose: (bloc) => bloc.close(),
  );

  @override
  List<Set<AsyncDep<Object>>> get initializeQueue => [
    {splashDioDep},
    {splashBlocDep},
  ];

  @override
  SplashBloc get splashBloc => splashBlocDep.get;

  /// {@macro splash_scope_container}
  SplashScopeContainer({required super.parent});

  SplashBloc _createSplashBloc() {
    return SplashBloc(repository: splashRepositoryDep.get);
  }

  ISplashRepository _createSplashRepository() {
    return SplashRepository(
      api: IpApi(splashDioDep.get),
      logger: parent.logger,
      database: parent.appDatabase,
    );
  }
}
