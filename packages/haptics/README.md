# haptics

A Flutter plugin for providing haptic feedback on iOS and Android.

## API

The `haptics` plugin provides a simple API for triggering haptic feedback. You can use the `HapticsPlatform.instance` to access the following methods:

- `impact(HapticImpactType impact)`: Triggers a haptic impact of the given type.
- `notification(HapticNotificationType notification)`: Triggers a haptic notification of the given type.
- `selection()`: Triggers a haptic selection feedback.
- `feedback(HapticFeedbackType feedback)`: Triggers a haptic feedback of the given type.

## Supported Platforms

- **iOS**: Supports all haptic feedback types.
- **Android**: Supports all haptic feedback types, with fallbacks for `medium`, `soft`, and `rigid` impacts.
