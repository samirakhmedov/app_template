import 'package:app_data/app_data.dart';
import 'package:app_domain/app_domain.dart';
import 'package:debug_data/debug_data.dart';
import 'package:debug_domain/debug_domain.dart';

/// {@template debug_repository}
/// A repository for the debug.
/// {@endtemplate}
final class DebugRepository extends BaseRepository implements IDebugRepository {
  final IDebugService _debugService;

  /// {@macro debug_repository}
  const DebugRepository({
    required IDebugService debugService,
    required super.logger,
  }) : _debugService = debugService;

  @override
  RequestOperation<void> setBaseUri(Uri uri) => makeCall(() async => _debugService.setBaseUri(uri));
  
  @override
  RequestOperation<Uri> getBaseUri() => makeCall(() async {
    if (_debugService.baseUri case final uri?) {
      return uri;
    }

    throw Exception('No URI found.');
  });
}
