import 'package:app_data/app_data.dart';
import 'package:app_domain/app_domain.dart';
import 'package:{{name.snakeCase()}}_domain/{{name.snakeCase()}}_domain.dart';

final class {{name.pascalCase()}}Repository extends BaseRepository implements I{{name.pascalCase()}}Repository {
  const {{name.pascalCase()}}Repository({required super.logger});

  @override
  RequestOperation<void> initialize() => makeCall(() async {
    await Future.delayed(const Duration(seconds: 2));
  });
}
