import 'package:app_presentation/app_presentation.dart';
import 'package:debug_domain/debug_domain.dart';

/// Contract for the app-scope debug infrastructure module.
///
/// Implemented by AppScopeDebugModule (real) and NoOpDebugModule (stub).
abstract interface class IDebugModule {
  /// Async deps to include in the app scope's level-1 init queue.
  List<AsyncDepType> get initDeps;

  /// The debug repository (base-URI read/write).
  IDebugRepository get repository;

  /// Override base URI from the debug service, or `null` when disabled.
  String? get rawBaseUri;
}
