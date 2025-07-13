import 'package:api/src/data/ip/ip_dto.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'ip_api.g.dart';

/// API for ip.
@RestApi()
abstract class IpApi {
  /// API creation factory using [Dio].
  factory IpApi(Dio dio, {String baseUrl}) = _IpApi;

  /// Request to get the current IP address.
  @GET('')
  Future<IpDto> getIp([
    @Query('format') String format = 'json',
    @CancelRequest() CancelToken? cancelToken,
  ]);
}
