import 'package:app_domain/app_domain.dart';
import 'package:app_presentation/app_presentation.dart';
import 'package:debug_di_interface/src/i_debug_module.dart';
import 'package:debug_domain/debug_domain.dart';

/// No-op stub used by production targets (basic, huawei).
///
/// Satisfies [IDebugModule] without allocating any debug infrastructure.
final class NoOpDebugModule implements IDebugModule {
  const NoOpDebugModule();

  @override
  List<AsyncDepType> get initDeps => const [];

  @override
  IDebugRepository get repository => const _NoOpDebugRepository();

  @override
  String? get rawBaseUri => null;
}

final class _NoOpDebugRepository implements IDebugRepository {
  const _NoOpDebugRepository();

  @override
  RequestOperation<Uri> getBaseUri() => throw UnimplementedError('debug module disabled');

  @override
  RequestOperation<void> setBaseUri(Uri uri) => throw UnimplementedError('debug module disabled');
}
