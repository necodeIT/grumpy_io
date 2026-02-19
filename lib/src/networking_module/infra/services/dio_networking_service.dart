import 'dart:async';

import 'package:dio/dio.dart';
import 'package:grumpy_io/grumpy_io.dart';

/// Default implementation of [NetworkService] using the Dio package.
class DioNetworkingService extends NetworkService {
  /// Default implementation of [NetworkService] using the Dio package.
  DioNetworkingService(this.dio) : super.internal();

  /// The Dio instance used to perform HTTP requests.
  final Dio dio;

  @override
  FutureOr<void> free() {
    dio.close(force: true);
  }

  @override
  String get logTag => 'DioNetworkingService';

  @override
  Future<NetworkResponse> sendRequest(
    NetworkRequest request, {
    Duration? timeout,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    var future = dio.request(
      request.url,
      data: request.body,
      queryParameters: request.queryParameters,
      options: Options(
        method: request.method.name.toUpperCase(),
        headers: request.headers,
      ),
      onReceiveProgress: onReceiveProgress,
      onSendProgress: onSendProgress,
    );

    if (timeout != null) {
      future = future.timeout(timeout);
    }

    final response = await future;

    return NetworkResponse(
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      body: response.data,
      request: request,
      headers: response.headers.map,
    );
  }

  @override
  bool get singelton => true;
}
