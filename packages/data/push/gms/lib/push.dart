import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:push_interface/push.dart';

/// Firebase Push Service.
final class Push implements PushServiceInterface {
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

  /// GMS notification services.
  const Push();

  @override
  Future<void> dispose() => Future.value();

  @override
  Future<String?> getToken() => FirebaseMessaging.instance.getToken();

  @override
  Future<void> initialize() => Future.value();

  @override
  Future<void> subscribeToTopic(String topic) => FirebaseMessaging.instance.subscribeToTopic(topic);

  @override
  Future<void> unsubscribeFromTopic(String topic) =>
      FirebaseMessaging.instance.unsubscribeFromTopic(topic);
}
