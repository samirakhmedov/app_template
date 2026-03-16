import 'dart:async';

import 'package:huawei_push/huawei_push.dart' as huawei;
import 'package:push_interface/push.dart';

/// Huawei Push Service.
final class Push implements PushServiceInterface {
  String? _token;

  late final StreamSubscription<String> _tokenSubscription;

  @override
  Stream<Notification> get pushStream => huawei.Push.onMessageReceivedStream
      .map(
        (event) => event.notification,
      )
      .where(
        (event) => event != null,
      ).cast<huawei.RemoteMessageNotification>()
      .map((event) {
        return Notification(
          title: event.title ?? '',
          body: event.body ?? '',
        );
      });

  @override
  Future<void> dispose() async {
    await _tokenSubscription.cancel();
  }

  @override
  Future<String?> getToken() async {
    huawei.Push.getToken('');

    if (_token != null) {
      return _token;
    }

    return huawei.Push.getTokenStream.firstWhere((element) => element.isNotEmpty);
  }

  @override
  Future<void> subscribeToTopic(String topic) => huawei.Push.subscribe(topic);

  @override
  Future<void> unsubscribeFromTopic(String topic) => huawei.Push.unsubscribe(topic);

  @override
  Future<void> initialize() {
    _tokenSubscription = huawei.Push.getTokenStream.listen(_listenToToken);
    huawei.Push.getToken('');
    
    return Future.wait([
      huawei.Push.consentOn(),
      huawei.Push.setAutoInitEnabled(true),
      huawei.Push.turnOnPush(),
    ]);
  }

  void _listenToToken(String token) {
    _token = token;
  }
}
