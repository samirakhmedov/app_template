
import 'package:app_domain/app_domain.dart';

/// {@template i_debug_repository}
/// An interface for the debug repository.
/// {@endtemplate}
abstract interface class IDebugRepository {
  /// The base URI.
  RequestOperation<Uri> getBaseUri();

  /// Sets the base URI.
  RequestOperation<void> setBaseUri(Uri uri);
}
