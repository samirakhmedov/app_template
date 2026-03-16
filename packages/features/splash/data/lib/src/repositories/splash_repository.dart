// ignore_for_file: avoid-passing-self-as-argument

import 'package:api/api.dart';
import 'package:app_data/app_data.dart';
import 'package:app_domain/app_domain.dart';
import 'package:database/database.dart';
import 'package:splash_domain/splash_domain.dart';

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
