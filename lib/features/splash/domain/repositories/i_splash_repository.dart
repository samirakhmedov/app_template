import 'package:app_template/core/architecture/domain/entity/request_operation.dart';

/// {@template i_splash_repository}
/// An interface for the splash repository.
/// {@endtemplate}
abstract interface class ISplashRepository {
  /// Initializes the splash repository.
  RequestOperation<void> initialize();
}
