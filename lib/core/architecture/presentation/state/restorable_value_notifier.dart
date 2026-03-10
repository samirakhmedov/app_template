// ignore_for_file: no-object-declaration

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// A [ValueNotifier] that is also a [RestorableProperty].
///
/// This class combines the functionality of a [ValueNotifier] with the state
/// restoration capabilities of Flutter's restoration framework. The [value]
/// held by this notifier will be automatically saved and restored.
///
/// It can be used with a to rebuild parts of the UI
/// when its value changes.
///
/// This property must be registered with a on a
/// object to be properly managed.
abstract class RestorableValueNotifier<T> extends RestorableProperty<T>
    implements ValueListenable<T> {
  /// The default value of the notifier.
  final T defaultValue;

  T _value;

  /// The current value stored in this notifier.
  ///
  /// When the value is changed, listeners are notified and the new value is
  /// marked for restoration.
  @override
  T get value => _value;

  /// Sets the value of the notifier.
  set value(T newValue) {
    if (_value == newValue) {
      return;
    }

    _value = newValue;

    // Notify listeners of the change, like a standard ValueNotifier.
    notifyListeners();
  }

  /// Creates a new with an initial value.
  RestorableValueNotifier(this.defaultValue) : _value = defaultValue;

  @override
  T createDefaultValue() {
    _value = defaultValue;

    return _value;
  }

  @override
  void initWithValue(T val) {
    value = val;
  }
}
