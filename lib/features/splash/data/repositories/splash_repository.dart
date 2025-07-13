import 'package:app_template/core/architecture/domain/entity/request_operation.dart';
import 'package:app_template/core/data/repositories/base_repository.dart';
import 'package:app_template/features/splash/domain/repositories/i_splash_repository.dart';

/// {@template splash_repository}
/// A repository for the splash.
/// {@endtemplate}
final class SplashRepository extends BaseRepository implements ISplashRepository {
  /// {@macro splash_repository}
  const SplashRepository({required super.logger});

  @override
  RequestOperation<void> initialize() => makeCall(() async {
    await Future.delayed(const Duration(seconds: 2));
  });
}
