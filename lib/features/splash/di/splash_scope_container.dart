import 'package:app_template/core/architecture/di/dependencies_registrar.dart';
import 'package:app_template/features/app/di/i_app_scope.dart';
import 'package:app_template/features/splash/data/repositories/splash_repository.dart';
import 'package:app_template/features/splash/di/i_splash_scope.dart';
import 'package:app_template/features/splash/domain/repositories/i_splash_repository.dart';
import 'package:app_template/features/splash/presentation/state/bloc/splash_bloc.dart';
import 'package:yx_scope/yx_scope.dart';

/// {@template splash_scope_container}
/// A container for the splash scope.
/// {@endtemplate}
class SplashScopeContainer extends ChildScopeContainer<IAppScope> implements ISplashScope {
  /// The splash bloc dependency.
  late final splashBlocDep = rawAsyncDep<SplashBloc>(
    _createSplashBloc,
    init: (bloc) async => bloc.add(SplashInitialize()),
    dispose: (bloc) => bloc.close(),
  );

  /// The splash repository dependency.
  late final splashRepositoryDep = dep<ISplashRepository>(_createSplashRepository);

  /// The initialize queue.
  @override
  List<Set<AsyncDepType>> get initializeQueue => [
    {splashBlocDep},
  ];

  @override
  SplashBloc get splashBloc => splashBlocDep.get;

  /// {@macro splash_scope_container}
  SplashScopeContainer({required super.parent});

  SplashBloc _createSplashBloc() {
    return SplashBloc(splashRepository: splashRepositoryDep.get);
  }

  ISplashRepository _createSplashRepository() {
    return SplashRepository(logger: parent.logger);
  }
}

/// {@template splash_scope_holder}
/// A holder for the splash scope.
/// {@endtemplate}
class SplashScopeHolder extends ChildScopeHolder<SplashScopeContainer, IAppScope> {
  /// {@macro splash_scope_holder}
  SplashScopeHolder(super.parent);

  @override
  SplashScopeContainer createContainer(IAppScope parent) => SplashScopeContainer(parent: parent);
}
