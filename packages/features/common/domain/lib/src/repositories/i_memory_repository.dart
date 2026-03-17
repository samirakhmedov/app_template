import 'package:app_domain/app_domain.dart';

abstract interface class IMemoryRepository {
  RequestOperation<void> handleMemoryPressure();
  RequestOperation<void> revive();
}
