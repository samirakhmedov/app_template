/// Push library.
library;

/// Repository for working with push notifications.
///
/// Allows listening for incoming notifications
/// and provides access to the application's registration token
/// on the device used for push notifications.
// ignore: prefer-match-file-name
abstract interface class PushServiceInterface {
  /// Notification stream.
  ///
  /// Allows listening for notifications arriving on the device
  /// and processing them immediately.
  Stream<Notification> get pushStream;

  /// Release resources.
  Future<void> dispose();

  /// Initializes the notifications repository.
  Future<void> initialize();

  /// Get the device registration token.
  ///
  /// Returns `null` if the token has not been obtained.
  ///
  /// For GMS it returns the FCM token.
  ///
  /// For HMS it returns `null`.
  Future<String?> getToken();

  /// Subscribe to a notification topic.
  Future<void> subscribeToTopic(String topic);

  /// Unsubscribe from a notification topic.
  Future<void> unsubscribeFromTopic(String topic);
}

/// Notification model.
///
/// If necessary, extend this class
/// to add extra data
/// from notifications.
final class Notification {
  /// Notification title.
  final String title;

  /// Notification body.
  final String body;

  /// Constructor.
  const Notification({
    required this.title,
    required this.body,
  });
}
