import 'package:app_domain/app_domain.dart';
import 'package:core/core.dart';
import 'package:database/database.dart';
import 'package:debug_domain/debug_domain.dart';
import 'package:network/network.dart';
import 'package:yx_scope/yx_scope.dart';

/// {@template i_app_scope}
/// The parent scope contract that all feature DI containers depend on.
///
/// Feature [ChildScopeContainer] subclasses are parameterised on [IAppScope],
/// replacing the previous per-feature parent-scope interfaces
/// (`ISplashParentScope`, `IDebugParentScope`).
/// {@endtemplate}
abstract interface class IAppScope implements Scope {
  /// The scoped HTTP client factory.
  IScopedHttpClientFactory get httpClientFactory;

  /// The logger strategy.
  LoggerStrategy get logger;

  /// The revivable app database.
  IRevivableDatabase get appDatabase;

  /// The debug repository.
  IDebugRepository get debugRepository;

  /// The environment URL used to initialise the debug bloc.
  Urls get environmentUrl;
}
