import 'dart:io';

import 'package:app_template/core/architecture/domain/entity/request_operation.dart';
import 'package:app_template/core/architecture/domain/entity/result.dart';
import 'package:app_template/core/domain/exceptions/api_exception.dart';
import 'package:app_template/core/domain/logger/logger_strategy.dart';
import 'package:flutter/foundation.dart';
import 'package:network/network.dart';

/// {@template base_repository.class}
/// Базовый класс для всех репозиториев в приложении.
/// {@endtemplate}
abstract base class BaseRepository {
  /// Логгер.
  final LoggerStrategy logger;

  /// {@macro base_repository.class}
  const BaseRepository({required this.logger});

  /// Все вызовы к репозиториям должны быть обернуты в этот метод.
  @protected
  RequestOperation<T> makeCall<T>(FutureCall<T> call) async {
    try {
      final data = await call();

      return Result.ok(data);
    } on Object catch (e, s) {
      logger.exception(e, s);

      if (e is DioException) {
        return Result.failed(mapApiException(e, trace: s), s);
      }

      return Result.failed(e, s);
    }
  }

  /// Маппинг ошибки API.
  @protected
  ApiException mapApiException(DioException exception, {required StackTrace trace}) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.connectionError:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.unknown when exception.error is SocketException:
        return TimeoutException(original: exception, stackTrace: trace);
      default:
        break;
    }

    return ApiException(original: exception, stackTrace: trace);
  }
}

/// {@template future_call}
/// A function that returns a future.
/// {@endtemplate}
typedef FutureCall<T> = Future<T> Function();
