import 'package:app_template/core/architecture/domain/entity/request_operation.dart';
import 'package:app_template/core/architecture/domain/entity/result.dart';
import 'package:app_template/core/data/repositories/base_repository.dart';
import 'package:app_template/features/common/domain/repositories/i_memory_repository.dart';
import 'package:database/database.dart';
import 'package:network/network.dart';

/// {@template memory_repository}
/// A repository for memory management operations.
/// {@endtemplate}
final class MemoryRepository extends BaseRepository implements IMemoryRepository {
  final IScopedHttpClientFactory _client;
  final IRevivableDatabase _database;

  /// {@macro memory_repository}
  const MemoryRepository({
    required IScopedHttpClientFactory clientFactory,
    required IRevivableDatabase database,
    required super.logger,
  }) : _client = clientFactory,
       _database = database;

  @override
  RequestOperation<void> handleMemoryPressure() => makeCall(() async {
    _client.handleMemoryPressure();
    _database.handleMemoryPressure();
  });

  @override
  RequestOperation<void> revive() async => Result.ok(null);
}
