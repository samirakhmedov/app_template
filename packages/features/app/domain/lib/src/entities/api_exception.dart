import 'package:network/network.dart';

base class ApiException implements Exception {
  final DioException original;
  final StackTrace stackTrace;
  final int? specialCode;
  final String? specialMessage;

  bool get isUserBlocked => specialCode == 101;

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

final class TimeoutException extends ApiException {
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
