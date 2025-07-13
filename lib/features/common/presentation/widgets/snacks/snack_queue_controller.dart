import 'package:app_template/features/common/presentation/widgets/snacks/snack_message_type.dart';
import 'package:flutter_easy_dialogs/flutter_easy_dialogs.dart';

/// The controller for displaying snacks.
/// Will be available to descendants.
abstract interface class SnackQueueController {
  /// Add Snack to Queue.
  void addSnack(
    String message, {
    required SnackMessageType messageType,
    EasyDialogDecoration? dialogDecoration,
    EasyDialogAnimationConfiguration? animationConfiguration,
  });

  /// Clears the snack queue from potential displays that were queued before [closeTime].
  void clearSnackQueue(DateTime closeTime);
}
