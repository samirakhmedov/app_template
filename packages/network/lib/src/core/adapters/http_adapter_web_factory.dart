import 'package:dio/dio.dart';
import 'package:fetch_client/fetch_client.dart';
import 'package:network/src/core/adapters/web/fetch_adapter.dart';

/// {@template http_adapter_web_factory}
/// This function creates a [HttpClientAdapter] for the web platform.
/// {@endtemplate}
HttpClientAdapter createHttpClientAdapter() => FetchAdapter(FetchClient(mode: RequestMode.cors));
