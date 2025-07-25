// ignore_for_file: type_annotate_public_apis, avoid-shadowing, avoid-dynamic

import 'package:dio/dio.dart';
import 'package:network/network.dart';

/// {@template revivable_dio_client}
/// AppDio wrapper that can be safely disposed and automatically recreated.
/// {@endtemplate}
class RevivableDioClient implements Dio {
  final IScopedHttpClientFactory _factory;
  final String _scopeId;
  Dio? _internalClient;
  bool _isCompletelyDisposed = false;

  @override
  BaseOptions get options => _getOrCreateClient().options;

  @override
  HttpClientAdapter get httpClientAdapter => _getOrCreateClient().httpClientAdapter;

  @override
  Transformer get transformer => _getOrCreateClient().transformer;

  @override
  Interceptors get interceptors => _getOrCreateClient().interceptors;

  @override
  set options(BaseOptions options) {
    _getOrCreateClient().options = options;
  }

  @override
  set httpClientAdapter(HttpClientAdapter adapter) {
    _getOrCreateClient().httpClientAdapter = adapter;
  }

  @override
  set transformer(Transformer transformer) {
    _getOrCreateClient().transformer = transformer;
  }

  /// {@macro revivable_dio_client}
  RevivableDioClient(this._factory, this._scopeId);

  @override
  void close({bool force = false}) {
    _internalClient?.close(force: true);
    _internalClient = null;
    _isCompletelyDisposed = true;
  }

  /// Handles memory pressure by closing underlying client but keeping it revivable.
  void handleMemoryPressure() {
    if (_internalClient == null || _isCompletelyDisposed) return;

    _internalClient?.close(force: true);
    _internalClient = null;
    // Do NOT set _isCompletelyDisposed = true, keep it revivable
  }

  // Override all Dio methods to delegate to internal client
  @override
  Future<Response<T>> fetch<T>(RequestOptions requestOptions) {
    return _getOrCreateClient().fetch<T>(requestOptions);
  }

  @override
  Future<Response<T>> request<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return _getOrCreateClient().request<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      options: options,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  @override
  Future<Response<T>> get<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) {
    return _getOrCreateClient().get<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
  }

  @override
  Future<Response<T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return _getOrCreateClient().post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  @override
  Future<Response<T>> put<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return _getOrCreateClient().put<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  @override
  Future<Response<T>> patch<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return _getOrCreateClient().patch<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  @override
  Future<Response<T>> delete<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _getOrCreateClient().delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  @override
  Future<Response<T>> head<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _getOrCreateClient().head<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  @override
  Dio clone({
    HttpClientAdapter? httpClientAdapter,
    Interceptors? interceptors,
    BaseOptions? options,
    Transformer? transformer,
  }) {
    return _getOrCreateClient().clone(
      options: options,
      interceptors: interceptors,
      httpClientAdapter: httpClientAdapter,
      transformer: transformer,
    );
  }

  @override
  Future<Response<T>> deleteUri<T>(
    Uri uri, {
    Object? data,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _getOrCreateClient().deleteUri<T>(
      uri,
      data: data,
      options: options,
      cancelToken: cancelToken,
    );
  }

  @override
  Future<Response<dynamic>> download(
    String urlPath,
    savePath, {
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    bool deleteOnError = true,
    FileAccessMode fileAccessMode = FileAccessMode.write,
    String lengthHeader = Headers.contentLengthHeader,
    Object? data,
    Options? options,
  }) {
    return _getOrCreateClient().download(
      urlPath,
      savePath,
      onReceiveProgress: onReceiveProgress,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      deleteOnError: deleteOnError,
      fileAccessMode: fileAccessMode,
      lengthHeader: lengthHeader,
      data: data,
      options: options,
    );
  }

  @override
  Future<Response<dynamic>> downloadUri(
    Uri uri,
    savePath, {
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
    bool deleteOnError = true,
    FileAccessMode fileAccessMode = FileAccessMode.write,
    String lengthHeader = Headers.contentLengthHeader,
    Object? data,
    Options? options,
  }) {
    return _getOrCreateClient().downloadUri(
      uri,
      savePath,
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
      deleteOnError: deleteOnError,
      fileAccessMode: fileAccessMode,
      lengthHeader: lengthHeader,
      data: data,
      options: options,
    );
  }

  @override
  Future<Response<T>> getUri<T>(
    Uri uri, {
    Object? data,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) {
    return _getOrCreateClient().getUri<T>(
      uri,
      data: data,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
  }

  @override
  Future<Response<T>> headUri<T>(
    Uri uri, {
    Object? data,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _getOrCreateClient().headUri<T>(
      uri,
      data: data,
      options: options,
      cancelToken: cancelToken,
    );
  }

  @override
  Future<Response<T>> patchUri<T>(
    Uri uri, {
    Object? data,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return _getOrCreateClient().patchUri<T>(
      uri,
      data: data,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  @override
  Future<Response<T>> postUri<T>(
    Uri uri, {
    Object? data,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return _getOrCreateClient().postUri<T>(
      uri,
      data: data,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  @override
  Future<Response<T>> putUri<T>(
    Uri uri, {
    Object? data,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return _getOrCreateClient().putUri<T>(
      uri,
      data: data,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  @override
  Future<Response<T>> requestUri<T>(
    Uri uri, {
    Object? data,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return _getOrCreateClient().requestUri<T>(
      uri,
      data: data,
      cancelToken: cancelToken,
      options: options,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Dio _getOrCreateClient() {
    if (_isCompletelyDisposed) {
      throw StateError('Client has been completely disposed and cannot be revived');
    }

    return _internalClient ??= _factory.createClientForScope(_scopeId);
  }
}
