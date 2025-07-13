import 'package:app_template/core/architecture/domain/entity/request_operation.dart';
import 'package:app_template/core/data/repositories/base_repository.dart';
import 'package:app_template/features/{{name.snakeCase()}}/domain/repositories/i_{{name.snakeCase()}}_repository.dart';

/// {@template {{name.snakeCase()}}_repository}
/// A repository for the {{name.snakeCase()}}.
/// {@endtemplate}
final class {{name.pascalCase()}}Repository extends BaseRepository implements I{{name.pascalCase()}}Repository {
  /// {@macro {{name.snakeCase()}}_repository}
  const {{name.pascalCase()}}Repository({required super.logger});

  @override
  RequestOperation<void> initialize() => makeCall(() async {
    await Future.delayed(const Duration(seconds: 2));
  });
}
