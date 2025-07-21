import 'package:api/api.dart';
import 'package:app_template/core/architecture/domain/entity/request_operation.dart';
import 'package:app_template/core/data/repositories/base_repository.dart';
import 'package:app_template/features/splash/domain/repositories/i_splash_repository.dart';

/// {@template splash_repository}
/// A repository for the splash.
/// {@endtemplate}
final class SplashRepository extends BaseRepository implements ISplashRepository {
  /// Mock API for test.
  final IpApi _ipApi;

  /// {@macro splash_repository}
  const SplashRepository({required IpApi api, required super.logger}) : _ipApi = api;

  @override
  RequestOperation<void> initialize() => makeCall(() async {
    await Future.delayed(const Duration(seconds: 2));

    await _ipApi.getIp();
  });
}
