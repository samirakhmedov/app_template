import 'package:app_template/core/architecture/domain/entity/request_operation.dart';
import 'package:app_template/core/data/repositories/base_repository.dart';
import 'package:app_template/features/debug/data/services/i_debug_service.dart';
import 'package:app_template/features/debug/domain/repositories/i_debug_repository.dart';
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
