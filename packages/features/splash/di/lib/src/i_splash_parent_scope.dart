import 'package:app_domain/app_domain.dart';
import 'package:database/database.dart';
import 'package:network/network.dart';
import 'package:yx_scope/yx_scope.dart';

/// {@template i_splash_parent_scope}
/// Defines the dependencies that the splash scope container requires from its parent scope.
///
/// Any scope that wants to host a splash child scope must implement this interface.
/// {@endtemplate}
abstract interface class ISplashParentScope implements Scope {
  /// The scoped HTTP client factory used to create a Dio client for splash requests.
  IScopedHttpClientFactory get httpClientFactory;

  /// The logger strategy.
  LoggerStrategy get logger;

  /// The revivable database.
  IRevivableDatabase get appDatabase;
}
