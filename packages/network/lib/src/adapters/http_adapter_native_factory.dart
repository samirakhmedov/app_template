import 'dart:io';

import 'package:cronet_http/cronet_http.dart';
import 'package:cupertino_http/cupertino_http.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:network/src/adapters/native/cronet_adapter.dart';
import 'package:network/src/adapters/native/url_session_adapter.dart';

/// {@template http_adapter_native_factory}
/// This function creates a [HttpClientAdapter] for the native platform.
/// {@endtemplate}
HttpClientAdapter createHttpClientAdapter({String? userAgent}) {
  if (Platform.isAndroid) {
    final engine = CronetEngine.build(
      cacheMode: CacheMode.disabled,
      enableBrotli: true,
      enableHttp2: true,
      enableQuic: true,
      userAgent: userAgent,
    );

    return CronetAdapter(engine);
  }
  if (Platform.isIOS || Platform.isMacOS) {
    final config = URLSessionConfiguration.ephemeralSessionConfiguration()
      ..httpAdditionalHeaders = {'User-Agent': userAgent ?? 'Dart'}
      ..httpShouldSetCookies = false
      ..allowsCellularAccess = true
      ..allowsExpensiveNetworkAccess = false
      ..allowsConstrainedNetworkAccess = true;

    return UrlSessionAdapter(config);
  }

  return IOHttpClientAdapter();
}
