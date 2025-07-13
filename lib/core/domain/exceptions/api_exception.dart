import 'package:network/network.dart';

/// {@template api_exception.class}
/// API exception. Все ошибки, которые могут возникнуть при работе с API.
/// {@endtemplate}
base class ApiException implements Exception {
  /// Оригинальная ошибка.
  final DioException original;

  /// [StackTrace] оригинальной ошибки.
  final StackTrace stackTrace;

  /// Спецаильный код ошибки из тела ответа.
  /// Специальные коды проверяются ниже через геттеры.
  final int? specialCode;

  /// Специальное сообщение об ошибке из тела ответа.
  final String? specialMessage;

  /// UserBlocked - пользователь был заблокирован.
  bool get isUserBlocked => specialCode == 101;

  /// {@macro api_exception.class}
  const ApiException({
    required this.original,
    required this.stackTrace,
    this.specialCode,
    this.specialMessage,
  });

  @override
  String toString() {
    final specialCodeString = specialCode?.toString() ?? 'empty';
    final specialMessageString = specialMessage ?? 'empty';
    final originalString = original.toString();

    return 'ApiException(specialCode: $specialCodeString, specialMessage: $specialMessageString, original: $originalString)';
  }
}

/// {@template timeout_exception.class}
/// TimeoutException.
/// {@endtemplate}
final class TimeoutException extends ApiException {
  /// {@macro timeout_exception.class}
  const TimeoutException({
    required super.original,
    required super.stackTrace,
    super.specialCode,
    super.specialMessage,
  });

  @override
  String toString() {
    final specialCodeString = specialCode?.toString() ?? 'empty';
    final specialMessageString = specialMessage ?? 'empty';
    final originalString = original.toString();

    return 'TimeoutException(specialCode: $specialCodeString, specialMessage: $specialMessageString, original: $originalString)';
  }
}
