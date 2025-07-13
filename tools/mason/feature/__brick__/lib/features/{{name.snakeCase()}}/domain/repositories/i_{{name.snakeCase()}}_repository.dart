import 'package:app_template/core/architecture/domain/entity/request_operation.dart';

/// {@template i_{{name.snakeCase()}}_repository}
/// An interface for the {{name.snakeCase()}} repository.
/// {@endtemplate}
abstract interface class I{{name.pascalCase()}}Repository {
  /// Initializes the {{name.snakeCase()}} repository.
  RequestOperation<void> initialize();
}
