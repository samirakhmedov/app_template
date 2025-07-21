import 'package:dio/dio.dart';
import 'package:network/src/adapters/http_adapter_native_factory.dart'
    if (dart.library.html) 'package:network/src/core/adapters/http_adapter_web_factory.dart';

/// A drop-in replacement for Dio's default [HttpClientAdapter] that delegates
/// the actual network work to platform-specific [`http`](https://pub.dev/packages/http)
/// based clients coming from
/// `http_native_adapter.dart` (Android / iOS / macOS / Desktop) and
/// `http_web_adapter.dart` (Web).
///
/// The implementation tries to mirror the behaviour of Dio's out-of-the-box
/// adapters with regard to:
///   * connect / send / receive time-outs
///   * request cancellation
///   * progress callbacks (`onSendProgress`, `onReceiveProgress`)
///   * proper mapping between Dart `http` and Dio concepts (headers, redirects…)
///
/// The goal is to keep the observable behaviour indistinguishable from
/// `IOHttpClientAdapter` & `BrowserHttpClientAdapter` while still using the
/// project-specific HTTP clients (Cronet / Cupertino / Fetch).
// ignore: prefer_mixin
class AppDio with DioMixin implements AppDioInterface {
  /// Optional factory function that creates a new instance of [BaseOptions].
  ///
  /// If not provided, a default instance of [BaseOptions] will be used.
  @override
  CreateBaseOptions? baseOptionsFactory;

  /// {@macro http_client_factory}
  AppDio({
    CreateBaseOptions? createBaseOptions,
  }) : baseOptionsFactory = createBaseOptions {
    httpClientAdapter = createHttpClientAdapter();
  }

  @override
  BaseOptions get options => baseOptionsFactory?.call() ?? BaseOptions();
}

/// App dio interface for extension.
abstract interface class AppDioInterface implements Dio {
  /// Optional factory function that creates a new instance of [BaseOptions].
  ///
  /// If not provided, a default instance of [BaseOptions] will be used.
  CreateBaseOptions? baseOptionsFactory;
}

/// A factory function that creates a new instance of [BaseOptions].
typedef CreateBaseOptions = BaseOptions Function();
