import 'dart:async';

import 'package:huawei_push/huawei_push.dart';
import 'package:push_interface/push.dart';

/// Huawei Push Service.
final class PushService implements PushServiceInterface {
  String? _token;

  late final StreamSubscription<String> _tokenSubscription;

  @override
  Future<String?> getToken() async {
    Push.getToken('');

    if (_token != null) {
      return _token;
    }

    final token = await Push.getTokenStream.firstWhere((element) => element.isNotEmpty);

    return token;
  }

  @override
  Stream<Notification> get pushStream => Push.onMessageReceivedStream
      .map(
        (event) => event.notification,
      )
      .where(
        (event) => event != null,
      )
      .map((event) {
        return Notification(
          title: event!.title ?? '',
          body: event.body ?? '',
        );
      });

  @override
  Future<void> subscribeToTopic(String topic) => Push.subscribe(topic);

  @override
  Future<void> unsubscribeFromTopic(String topic) => Push.unsubscribe(topic);

  @override
  Future<void> initialize() {
    _tokenSubscription = Push.getTokenStream.listen(_listenToToken);
    Push.getToken('');
    return Future.wait([
      Push.consentOn(),
      Push.setAutoInitEnabled(true),
      Push.turnOnPush(),
    ]);
  }

  void _listenToToken(String token) {
    _token = token;
  }

  @override
  Future<void> dispose() async {
    await _tokenSubscription.cancel();
  }
}
