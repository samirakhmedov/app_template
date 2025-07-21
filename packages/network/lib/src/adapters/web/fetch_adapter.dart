import 'dart:async';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:fetch_client/fetch_client.dart';
import 'package:http/http.dart';

/// {@template fetch_adapter}
/// This class is a wrapper around the [FetchClient] class.
/// It implements the [HttpClientAdapter] interface.
/// It is used to make HTTP requests using the [FetchClient] class.
/// {@endtemplate}
class FetchAdapter implements HttpClientAdapter {
  final FetchClient _client;

  /// {@macro fetch_adapter}
  const FetchAdapter(this._client);

  @override
  void close({bool force = false}) {
    _client.close();
  }

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    final request = Request(options.method, options.uri);

    options.headers.forEach((key, value) {
      request.headers[key] = value.toString();
    });

    if (requestStream != null) {
      final body = await requestStream.toList();
      request.bodyBytes = Uint8List.fromList(body.expand((el) => el).toList());
    }

    final completer = Completer<ResponseBody>();

    final responseFuture = _client.send(request);

    unawaited(
      cancelFuture?.whenComplete(() {
        completer.completeError(
          DioException.requestCancelled(
            requestOptions: options,
            reason: 'Request cancelled.',
          ),
        );
      }),
    );

    unawaited(
      responseFuture
          .then((response) {
            completer.complete(
              ResponseBody(
                response.stream.map(Uint8List.fromList),
                response.statusCode,
                statusMessage: response.reasonPhrase,
                isRedirect: response.isRedirect,
                headers: response.headers.map((key, value) => MapEntry(key, [value])),
              ),
            );
          })
          .catchError((error) {
            completer.completeError(
              DioException(
                requestOptions: options,
                error: error,
              ),
            );
          }),
    );

    return completer.future;
  }
}
