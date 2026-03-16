import 'package:app_domain/src/entities/request_operation.dart';

abstract interface class IMemoryRepository {
  RequestOperation<void> handleMemoryPressure();
  RequestOperation<void> revive();
}
