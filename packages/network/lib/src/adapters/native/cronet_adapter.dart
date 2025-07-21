import 'dart:async';
import 'dart:typed_data';

import 'package:cronet_http/cronet_http.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

/// A [Dio] [HttpClientAdapter] that uses the Cronet network stack.
///
/// All instances of [CronetAdapter] share a single underlying [CronetEngine]
/// and [CronetClient] for optimal resource usage. The shared client is created
/// when the first adapter instance is constructed and disposed when the last
/// instance is closed.
class CronetAdapter implements HttpClientAdapter {
  static CronetClient? _sharedClient;
  static int _instanceCount = 0;

  final CronetClient _client;

  /// Creates a new [CronetAdapter] instance.
  ///
  /// Uses a shared [CronetClient] that is reference-counted across all instances.
  CronetAdapter() : _client = _getOrCreateSharedClient() {
    _instanceCount++;
  }

  static CronetClient _getOrCreateSharedClient() {
    if (_sharedClient == null) {
      final engine = CronetEngine.build(
        cacheMode: CacheMode.disabled,
        enableBrotli: true,
        enableHttp2: true,
        enableQuic: true,
      );

      _sharedClient = CronetClient.fromCronetEngine(engine, closeEngine: true);
    }

    return _sharedClient!;
  }

  bool _isClosed = false;

  @override
  void close({bool force = false}) {
    if (_isClosed) return;

    _instanceCount--;

    if (_instanceCount == 0) {
      _sharedClient?.close();
      _sharedClient = null;
    }

    _isClosed = true;
  }

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    if (_isClosed || _sharedClient == null) {
      throw DioException(
        requestOptions: options,
        error: 'CronetAdapter is closed or disposed',
      );
    }

    final request = _convertRequest(options, requestStream);
    final responseFuture = _client.send(request);

    final completer = Completer<http.StreamedResponse>();

    // CronetClient doesn't support cancellation. We race the response future
    // with the cancel future. If the cancel future completes first, we
    // throw a cancellation error. The underlying HTTP request will likely
    // continue to completion.
    if (cancelFuture != null) {
      unawaited(
        cancelFuture.whenComplete(() {
          if (!completer.isCompleted) {
            completer.completeError(
              DioException.requestCancelled(
                requestOptions: options,
                reason: 'Request cancelled.',
              ),
            );
          }
        }),
      );
    }

    unawaited(
      responseFuture
          .then((response) {
            if (!completer.isCompleted) {
              completer.complete(response);
            }
          })
          .catchError((error) {
            if (completer.isCompleted) return;

            final dioError = DioException(
              requestOptions: options,
              error: error,
            );

            completer.completeError(dioError);
          }),
    );

    final http.StreamedResponse httpResponse;
    try {
      httpResponse = await completer.future;
    } on DioException {
      rethrow;
    } catch (e) {
      Error.throwWithStackTrace(
        DioException(
          requestOptions: options,
          error: e,
        ),
        StackTrace.current,
      );
    }

    final headers = httpResponse.headers.map((key, value) => MapEntry(key, value.split(',')));

    return ResponseBody(
      httpResponse.stream.map(Uint8List.fromList),
      httpResponse.statusCode,
      statusMessage: httpResponse.reasonPhrase,
      isRedirect: httpResponse.isRedirect,
      headers: headers,
    );
  }

  http.BaseRequest _convertRequest(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
  ) {
    final http.BaseRequest request;
    if (requestStream == null) {
      final basicRequest = http.Request(options.method, options.uri);
      // Dio processes `options.data` into `requestStream` before calling `fetch`.
      // If `requestStream` is null, there is no body.
      request = basicRequest;
    } else {
      final streamedRequest = http.StreamedRequest(options.method, options.uri);
      requestStream.listen(
        streamedRequest.sink.add,
        onError: streamedRequest.sink.addError,
        onDone: () => unawaited(streamedRequest.sink.close()),
        cancelOnError: true,
      );
      request = streamedRequest;
    }

    request.headers.clear();
    options.headers.forEach((key, value) {
      if (value is List) {
        request.headers[key] = value.join(',');
      } else if (value != null) {
        request.headers[key] = value.toString();
      }
    });

    request
      ..followRedirects = options.followRedirects
      ..maxRedirects = options.maxRedirects;

    return request;
  }
}
