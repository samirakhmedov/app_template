/// An enumeration for specialized, platform-oriented feedback types.
enum HapticFeedbackType {
  /// Haptic feedback for a context click.
  /// **Android only (API 23+)**. On iOS, a custom pattern is used.
  contextClick,

  /// Haptic feedback for a drag start.
  /// **Android only (API 34+)**. On iOS, a custom pattern is used.
  dragStart,

  /// Haptic feedback for a gesture end.
  /// **Android only (API 30+)**. On iOS, a custom pattern is used.
  gestureEnd,

  /// Haptic feedback for a gesture start.
  /// **Android only (API 30+)**. On iOS, a custom pattern is used.
  gestureStart,

  /// Haptic feedback for a text handle move.
  /// **Android only (API 23+)**. On iOS, a custom pattern is used.
  textHandleMove,

  /// Haptic feedback for a virtual key release.
  /// **Android only (API 29+)**. On iOS, a custom pattern is used.
  virtualKeyRelease,
}
