import 'package:app_template/core/architecture/domain/entity/request_operation.dart';

/// {@template i_memory_repository}
/// Interface for the memory repository that handles memory pressure operations.
/// {@endtemplate}
abstract interface class IMemoryRepository {
  /// Handles memory pressure by calling appropriate services.
  ///
  /// Returns a [RequestOperation] that completes when memory pressure
  /// handling is finished or fails with an error.
  RequestOperation<void> handleMemoryPressure();

  /// Handles revival operations after memory pressure.
  ///
  /// Returns a [RequestOperation] that completes when revival
  /// operations are finished or fails with an error.
  RequestOperation<void> revive();
}
