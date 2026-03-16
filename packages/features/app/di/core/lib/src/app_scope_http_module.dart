import 'package:core/core.dart';
import 'package:di_core/src/i_http_module_context.dart';
import 'package:flutter/foundation.dart';
import 'package:network/network.dart';
import 'package:yx_scope/yx_scope.dart';

/// {@template app_scope_http_module}
/// A module providing HTTP infrastructure: a scoped client factory and
/// the root Dio client.
///
/// Requires the container to implement `IHttpModuleContext` so the module
/// can resolve the effective base URL at runtime (debug override or production).
/// {@endtemplate}
class AppScopeHttpModule<T extends IHttpModuleContext> extends ScopeModule<T> {
  /// The root Dio dependency.
  late final rootDioDep = rawAsyncDep(
    () => httpClientFactoryDep.get.getClientForScope('root_http_client'),
    init: (_) => SynchronousFuture(null),
    dispose: (_) async =>
        httpClientFactoryDep.get.disposeScopeClient('root_http_client'),
  );

  /// The HTTP client factory dependency.
  late final httpClientFactoryDep = rawAsyncDep(
    _createHttpClientFactory,
    init: (factory) => SynchronousFuture(null),
    dispose: (factory) => factory.dispose(),
  );

  /// {@macro app_scope_http_module}
  AppScopeHttpModule(super.container);

  LogInterceptor _createLogInterceptor() {
    return LogInterceptor(
      requestBody: true,
      responseBody: true,
    );
  }

  IScopedHttpClientFactory _createHttpClientFactory() {
    return ScopedHttpClientFactory(
      baseOptionsFactory: () => BaseOptions(
        connectTimeout: kDefaultConnectTimeout,
        receiveTimeout: kDefaultReceiveTimeout,
        sendTimeout: kDefaultSendTimeout,
        baseUrl: container.debugBaseUri ?? container.baseUrl,
      ),
      interceptors: [_createLogInterceptor()],
    );
  }
}
