import 'package:dio/dio.dart';

/// {@template i_scoped_http_client_factory}
/// Interface for creating and managing HTTP clients per scope.
/// {@endtemplate}
abstract interface class IScopedHttpClientFactory {
  /// Creates basic HTTP client. Do not stores it within factory.
  Dio createClientForScope(String scopeId);

  /// Creates or retrieves an existing HTTP client for the given scope. Stores it within factory and handles
  /// the lifecycle directly.
  Dio getClientForScope(String scopeId);

  /// Disposes client for specific scope completely (when scope pops).
  void disposeScopeClient(String scopeId);

  /// Handles memory pressure by closing underlying clients without removing them.
  void handleMemoryPressure();

  /// Disposes the factory.
  Future<void> dispose();
}
