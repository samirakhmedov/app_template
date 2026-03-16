import 'package:yx_scope/yx_scope.dart';

/// {@template i_http_module_context}
/// Context interface required by `AppScopeHttpModule`.
///
/// App scope containers implement this to provide the base URL and
/// an optional debug-override URI to the HTTP module.
/// {@endtemplate}
abstract class IHttpModuleContext extends BaseScopeContainer {
  /// Override base URI supplied by a debug service, or null in production.
  String? get debugBaseUri;

  /// Production base URL for the HTTP client.
  String get baseUrl;
}
