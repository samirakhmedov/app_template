import 'package:app_data/app_data.dart';
import 'package:app_domain/src/entities/request_operation.dart';
import 'package:app_domain/src/entities/result.dart';
import 'package:common_domain/common_domain.dart';
import 'package:database/database.dart';
import 'package:network/network.dart';

final class MemoryRepository extends BaseRepository implements IMemoryRepository {
  final IScopedHttpClientFactory _client;
  final IRevivableDatabase _database;

  const MemoryRepository({
    required super.logger,
    required IScopedHttpClientFactory clientFactory,
    required IRevivableDatabase database,
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
