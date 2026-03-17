import 'package:meta/meta.dart';

enum SnackMessageType {
  success,
  error,
  warning,
}

@immutable
class SnackData {
  final String message;
  final SnackMessageType messageType;
  final DateTime showTime;

  const SnackData({
    required this.message,
    required this.messageType,
    required this.showTime,
  });

  @override
  String toString() => 'SnackData{messageType: $messageType, message: $message}';
}
