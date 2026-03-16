import 'package:app_domain/src/entities/request_operation.dart';

abstract interface class ISplashRepository {
  RequestOperation<void> initialize();
}
