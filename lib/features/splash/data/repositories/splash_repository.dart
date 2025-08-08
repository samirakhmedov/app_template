// ignore_for_file: avoid-passing-self-as-argument

import 'package:api/api.dart';
import 'package:app_template/core/architecture/domain/entity/request_operation.dart';
import 'package:app_template/core/data/repositories/base_repository.dart';
import 'package:app_template/features/splash/domain/repositories/i_splash_repository.dart';
import 'package:database/database.dart';

/// {@template splash_repository}
/// A repository for the splash.
/// {@endtemplate}
final class SplashRepository extends BaseRepository implements ISplashRepository {
  /// Mock API for test.
  final IpApi _ipApi;

  final IRevivableDatabase _database;

  /// Database instance.
  AppDatabase get db => _database.database;

  /// {@macro splash_repository}
  const SplashRepository({
    required IpApi api,
    required super.logger,
    required IRevivableDatabase database,
  }) : _ipApi = api,
       _database = database;

  @override
  RequestOperation<void> initialize() => makeCall(() async {
    await Future.wait([
      _ipApi.getIp(),
      db.select(db.todoTable).get(),
    ]);
  });
}
