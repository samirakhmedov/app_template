import 'package:debug_data/debug_data.dart';
import 'package:debug_domain/debug_domain.dart';
import 'package:flutter/foundation.dart';

/// {@template debug_repository}
/// A repository for the debug.
/// {@endtemplate}
final class DebugRepository extends BaseRepository implements IDebugRepository {
  final IDebugService _debugService;

  @override
  ValueListenable<Uri?> get baseUri => _debugService.baseUri;

  /// {@macro debug_repository}
  const DebugRepository({
    required IDebugService debugService,
    required super.logger,
  }) : _debugService = debugService;

  @override
  RequestOperation<void> setBaseUri(Uri uri) => makeCall(() async => _debugService.setBaseUri(uri));
}
