// ignore_for_file: no-object-declaration

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

abstract class RestorableValueNotifier<T> extends RestorableProperty<T> implements ValueListenable<T> {
  final T defaultValue;

  T _value;

  @override
  T get value => _value;

  set value(T newValue) {
    if (_value == newValue) {
      return;
    }

    _value = newValue;

    notifyListeners();
  }

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
