import 'dart:async';
import 'dart:typed_data';

import 'package:cronet_http/cronet_http.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

/// A [Dio] [HttpClientAdapter] that uses the Cronet network stack.
class CronetAdapter implements HttpClientAdapter {
  final CronetClient _client;

  /// If [_closeEngine] is `true`, then the underlying [CronetEngine] will be
  /// closed when [close] is called.
  final bool _closeEngine;

  /// {@macro cronet_adapter}
  CronetAdapter(CronetEngine engine, {bool closeEngine = true})
    : _client = CronetClient.fromCronetEngine(engine, closeEngine: closeEngine),
      _closeEngine = closeEngine;

  @override
  void close({bool force = false}) {
    if (_closeEngine) {
      _client.close();
    }
  }

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
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
