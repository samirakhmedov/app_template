import 'dart:async';

import 'package:app_domain/app_domain.dart';

/// {@template i_debug_service}
/// An interface for the debug service.
/// {@endtemplate}
abstract interface class IDebugService implements LifecycleObject {
  /// The base URI.
  Uri? get baseUri;

  /// Sets the base URI.
  Future<void> setBaseUri(Uri uri);
}
