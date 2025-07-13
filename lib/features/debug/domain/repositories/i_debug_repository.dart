import 'package:app_template/core/architecture/domain/entity/request_operation.dart';
import 'package:flutter/foundation.dart';

/// {@template i_debug_repository}
/// An interface for the debug repository.
/// {@endtemplate}
abstract interface class IDebugRepository {
  /// The base URI.
  ValueListenable<Uri?> get baseUri;

  /// Sets the base URI.
  RequestOperation<void> setBaseUri(Uri uri);
}
