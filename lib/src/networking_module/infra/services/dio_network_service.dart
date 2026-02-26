import 'package:dio/dio.dart';
import 'package:grumpy_io/grumpy_io.dart';

/// Dio-backed native implementation of [NetworkService].
class DioNetworkService extends NetworkService {
  /// Creates a network service.
  DioNetworkService({Dio? dio}) : _dio = dio ?? Dio(), super.internal();

  final Dio _dio;

  @override
  Future<IoResult<NetworkResponse>> send(
    NetworkRequest request, {
    TransferProgressCallback? onUploadProgress,
    TransferProgressCallback? onDownloadProgress,
    NetworkCancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.request<List<int>>(
        request.resolvedUri.toString(),
        data: request.bodyBytes,
        cancelToken: _toCancelToken(cancelToken),
        options: Options(
          method: _method(request.method),
          headers: <String, String>{
            ...request.headers,
            if (request.contentType != null)
              Headers.contentTypeHeader: request.contentType!,
          },
          responseType: ResponseType.bytes,
          sendTimeout: request.sendTimeout,
          receiveTimeout: request.receiveTimeout,
        ),
        onSendProgress: (sent, total) {
          if (total > 0 && onUploadProgress != null) {
            onUploadProgress(
              TransferProgress(transferredBytes: sent, totalBytes: total),
            );
          }
        },
        onReceiveProgress: (received, total) {
          if (total > 0 && onDownloadProgress != null) {
            onDownloadProgress(
              TransferProgress(transferredBytes: received, totalBytes: total),
            );
          }
        },
      );

      final payload = response.data;
      final bytes = payload == null
          ? Bytes(0)
          : Bytes.fromList(List<int>.from(payload));

      return IoOk(
        NetworkResponse(
          statusCode: response.statusCode ?? 0,
          statusMessage: response.statusMessage,
          headers: response.headers.map,
          bodyBytes: bytes,
          request: request,
        ),
      );
    } on DioException catch (error, stackTrace) {
      return IoErr(
        IoFailure(
          code: _mapFailure(error),
          message: error.message ?? 'Network request failed.',
          cause: error,
          stackTrace: stackTrace,
        ),
      );
    } catch (error, stackTrace) {
      return IoErr(
        IoFailure(
          code: IoFailureCode.unknown,
          message: 'Unexpected network failure.',
          cause: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  static String _method(HttpMethod method) => switch (method) {
    HttpMethod.get => 'GET',
    HttpMethod.post => 'POST',
    HttpMethod.put => 'PUT',
    HttpMethod.patch => 'PATCH',
    HttpMethod.delete => 'DELETE',
    HttpMethod.head => 'HEAD',
    HttpMethod.options => 'OPTIONS',
  };

  static CancelToken? _toCancelToken(NetworkCancelToken? token) {
    if (token is DefaultNetworkCancelToken) {
      return token._token;
    }
    return null;
  }

  static IoFailureCode _mapFailure(DioException exception) {
    return switch (exception.type) {
      DioExceptionType.connectionTimeout => IoFailureCode.timeout,
      DioExceptionType.sendTimeout => IoFailureCode.timeout,
      DioExceptionType.receiveTimeout => IoFailureCode.timeout,
      DioExceptionType.cancel => IoFailureCode.cancelled,
      DioExceptionType.badResponse => IoFailureCode.networkError,
      DioExceptionType.connectionError => IoFailureCode.networkError,
      DioExceptionType.badCertificate => IoFailureCode.networkError,
      DioExceptionType.unknown => IoFailureCode.unknown,
    };
  }

  @override
  Future<void> destroy() async {
    _dio.close(force: true);
  }

  @override
  String get logTag => 'DefaultNetworkService';
}

/// Default cancellable token for [DioNetworkService].
class DefaultNetworkCancelToken implements NetworkCancelToken {
  final CancelToken _token = CancelToken();

  @override
  bool get isCancelled => _token.isCancelled;

  @override
  void cancel([String? reason]) {
    _token.cancel(reason);
  }
}

/// Creates the default [NetworkService].
DioNetworkService createDefaultNetworkService({Dio? dio}) {
  return DioNetworkService(dio: dio);
}
