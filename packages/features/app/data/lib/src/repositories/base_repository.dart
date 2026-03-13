import 'dart:io';

import 'package:app_domain/app_domain.dart';
import 'package:flutter/foundation.dart';
import 'package:network/network.dart';

abstract base class BaseRepository {
  final LoggerStrategy logger;

  const BaseRepository({required this.logger});

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

typedef FutureCall<T> = Future<T> Function();
