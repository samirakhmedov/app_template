import 'package:dio/dio.dart';
import 'package:network/src/client/app_dio.dart';
import 'package:network/src/client/revivable_dio_client.dart';
import 'package:network/src/scope/i_scoped_http_client_factory.dart';

/// {@template scoped_http_client_factory}
/// Central factory for creating and managing HTTP clients per scope.
/// {@endtemplate}
class ScopedHttpClientFactory implements IScopedHttpClientFactory {
  final Map<String, RevivableDioClient> _clients = {};
  final CreateBaseOptions? _baseOptionsFactory;
  final List<Interceptor> _interceptors;

  /// {@macro scoped_http_client_factory}
  ScopedHttpClientFactory({
    CreateBaseOptions? baseOptionsFactory,
    List<Interceptor> interceptors = const [],
  }) : _baseOptionsFactory = baseOptionsFactory,
       _interceptors = interceptors;

  @override
  Future<void> dispose() async {
    // Dispose all clients completely
    for (final client in _clients.values) {
      client.close();
    }

    _clients.clear();
  }

  @override
  RevivableDioClient getClientForScope(String scopeId) {
    return _clients.putIfAbsent(
      scopeId,
      () => RevivableDioClient(this, scopeId),
    );
  }

  @override
  void disposeScopeClient(String scopeId) {
    final client = _clients.remove(scopeId);
    client?.close(force: true);
  }

  @override
  void handleMemoryPressure() {
    for (final client in _clients.values) {
      client.handleMemoryPressure();
    }
  }

  @override
  Dio createClientForScope(String scopeId) {
    final dio = AppDio(createBaseOptions: _baseOptionsFactory);

    // Add interceptors
    dio.interceptors.addAll(_interceptors);

    return dio;
  }
}
