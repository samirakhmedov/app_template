import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:push_interface/push.dart';

/// Firebase Push Service.
final class PushService implements PushServiceInterface {
  @override
  Future<String?> getToken() => FirebaseMessaging.instance.getToken();

  @override
  Stream<Notification> get pushStream => FirebaseMessaging.onMessage
      .map(
        (event) => event.notification,
      )
      .where(
        (event) => event != null,
      )
      .map(
        (event) => Notification(
          title: event?.title ?? '',
          body: event?.body ?? '',
        ),
      );

  @override
  Future<void> initialize() => Future.value();

  @override
  Future<void> subscribeToTopic(String topic) => FirebaseMessaging.instance.subscribeToTopic(topic);

  @override
  Future<void> unsubscribeFromTopic(String topic) =>
      FirebaseMessaging.instance.unsubscribeFromTopic(topic);

  @override
  Future<void> dispose() => Future.value();
}
