import 'dart:async';
import 'dart:typed_data';

import 'package:async/async.dart';
import 'package:cupertino_http/cupertino_http.dart';
import 'package:dio/dio.dart';
import 'package:objective_c/objective_c.dart';

const _nsurlErrorCancelled = -999;

class _TaskTracker {
  final responseCompleter = Completer<HTTPURLResponse>();
  final RequestOptions options;
  final StreamController<Uint8List> responseController;

  /// Whether the response stream subscription has been cancelled.
  bool responseListenerCancelled = false;
  int numRedirects = 0;
  Uri? lastUrl; // The last URL redirected to.

  _TaskTracker(this.options, this.responseController);

  void close() {
    unawaited(responseController.close());
  }
}

/// {@template url_session_adapter}
/// This class is a wrapper around the [URLSession] class.
/// It implements the [HttpClientAdapter] interface.
/// It is used to make HTTP requests using the [URLSession] class.
/// {@endtemplate}
class UrlSessionAdapter implements HttpClientAdapter {
  static final Map<URLSessionTask, _TaskTracker> _tasks = {};
  URLSession? _session;

  /// {@macro url_session_adapter}
  UrlSessionAdapter(URLSessionConfiguration configuration) {
    _session = URLSession.sessionWithConfiguration(
      configuration,
      onRedirect: _onRedirect,
      onResponse: _onResponse,
      onData: _onData,
      onComplete: _onComplete,
    );
  }

  @override
  void close({bool force = false}) {
    _session?.finishTasksAndInvalidate();
    _session = null;
  }

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    final session = _session;
    if (session == null) {
      throw DioException(
        requestOptions: options,
        error: 'UrlSessionAdapter is closed',
      );
    }

    final urlRequest = MutableURLRequest.fromUrl(options.uri)..httpMethod = options.method;

    options.headers.forEach((key, value) {
      urlRequest.setValueForHttpHeaderField(value.toString(), key);
    });

    if (requestStream != null) {
      final stream = requestStream;
      if (options.requestEncoder == null) {
        final queue = StreamQueue(stream);
        while (await queue.hasNext && (await queue.peek).isEmpty) {
          await queue.next;
        }
        if (await queue.hasNext) {
          urlRequest.httpBodyStream = queue.rest.toNSInputStream();
        }
      } else {
        final body = await stream.toList();
        final data = Uint8List.fromList(body.expand((el) => el).toList());
        urlRequest.httpBody = data.toNSData();
      }
    }

    final task = session.dataTaskWithRequest(urlRequest);

    // ignore: close_sinks
    final responseController = StreamController<Uint8List>(
      onCancel: () {
        final taskTracker = _tasks[task];
        if (taskTracker == null) return;
        taskTracker.responseListenerCancelled = true;
        task.cancel();
      },
    );

    final taskTracker = _TaskTracker(options, responseController);
    _tasks[task] = taskTracker;

    unawaited(
      cancelFuture?.whenComplete(() {
        task.cancel();
        taskTracker.responseCompleter.completeError(
          DioException.requestCancelled(
            requestOptions: options,
            reason: 'Request cancelled.',
          ),
        );
      }),
    );

    task.resume();

    final response = await taskTracker.responseCompleter.future;

    final headers = response.allHeaderFields.map(
      (key, value) => MapEntry(key.toLowerCase(), [value]),
    );

    return ResponseBody(
      taskTracker.responseController.stream,
      response.statusCode,
      isRedirect: !options.followRedirects && taskTracker.numRedirects > 0,
      headers: headers,
    );
  }

  static _TaskTracker _tracker(URLSessionTask task) => _tasks[task]!;

  static void _onComplete(
    URLSession session,
    URLSessionTask task,
    NSError? error,
  ) {
    final taskTracker = _tracker(task);
    if (error != null &&
        // ignore: avoid-inverted-boolean-checks
        !(error.domain.toString() == 'NSURLErrorDomain' && error.code == _nsurlErrorCancelled)) {
      final exception = DioException(
        requestOptions: taskTracker.options,
        error: error,
      );
      if (taskTracker.responseCompleter.isCompleted) {
        taskTracker.responseController.addError(exception);
      } else {
        taskTracker.responseCompleter.completeError(exception);
      }
    } else {
      if (!taskTracker.responseCompleter.isCompleted) {
        taskTracker.responseCompleter.completeError(
          StateError('task completed without an error or response'),
        );
      }
    }
    taskTracker.close();
    _tasks.remove(task);
  }

  static void _onData(URLSession session, URLSessionTask task, NSData data) {
    final taskTracker = _tracker(task);
    if (taskTracker.responseListenerCancelled) return;
    taskTracker.responseController.add(data.toList());
  }

  static URLRequest? _onRedirect(
    URLSession session,
    URLSessionTask task,
    HTTPURLResponse response,
    URLRequest request,
  ) {
    final taskTracker = _tracker(task)..numRedirects += 1;
    if (taskTracker.options.followRedirects &&
        taskTracker.numRedirects <= taskTracker.options.maxRedirects) {
      taskTracker.lastUrl = request.url;

      return request;
    }

    return null;
  }

  static NSURLSessionResponseDisposition _onResponse(
    URLSession session,
    URLSessionTask task,
    URLResponse response,
  ) {
    final taskTracker = _tracker(task);
    taskTracker.responseCompleter.complete(response as HTTPURLResponse);

    return NSURLSessionResponseDisposition.NSURLSessionResponseAllow;
  }
}
