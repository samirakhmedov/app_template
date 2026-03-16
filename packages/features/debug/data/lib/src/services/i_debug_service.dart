import 'dart:async';

import 'package:app_template/core/architecture/di/disposable.dart';
import 'package:flutter/foundation.dart';

/// {@template i_debug_service}
/// An interface for the debug service.
/// {@endtemplate}
abstract interface class IDebugService implements LifecycleObject {
  /// The base URI.
  ValueListenable<Uri?> get baseUri;

  /// Sets the base URI.
  Future<void> setBaseUri(Uri uri);
}
