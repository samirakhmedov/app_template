import 'package:app_domain/app_domain.dart';
import 'package:storage/storage.dart';
import 'package:yx_scope/yx_scope.dart';

/// Context interface required by AppScopeDebugModule.
///
/// Mirrors IHttpModuleContext in `di_core` — decouples the debug module
/// from AppScopeContainer so `debug_di` carries no dep on `app_target`.
abstract class IDebugModuleContext extends BaseScopeContainer {
  /// The shared-preferences storage used to persist the debug base URI.
  Storage get debugStorage;

  /// The logger strategy.
  LoggerStrategy get logger;
}
