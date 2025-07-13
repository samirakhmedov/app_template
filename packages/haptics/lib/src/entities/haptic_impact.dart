/// An enumeration of haptic impact styles.
///
/// Simulates physical impacts.
enum HapticImpactType {
  /// A light impact. Good for tab selections, switch toggles.
  /// On Android, requires API 26+.
  light,

  /// A medium impact. Standard for button presses.
  /// On Android, this is mapped to `HapticFeedbackConstants.VIRTUAL_KEY`.
  medium,

  /// A heavy impact. For important actions like deletions or Drag-and-Drop.
  heavy,

  /// A soft, gentle impact.
  /// **iOS 13+ only**. On Android, this is mapped to `HapticFeedbackConstants.KEYBOARD_TAP`.
  soft,

  /// A short, sharp impact.
  /// **iOS 13+ only**. On Android, this is mapped to `HapticFeedbackConstants.LONG_PRESS`.
  rigid,
}
