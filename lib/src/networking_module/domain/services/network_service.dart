import 'package:grumpy/grumpy.dart';

import '../../../core/core.dart';
import '../models/http_method.dart';
import '../models/network_request.dart';
import '../models/network_response.dart';
import '../models/transfer_progress.dart';
import 'network_cancel_token.dart';

/// Service for raw HTTP operations.
abstract class NetworkService extends Service {
  /// Creates a network service.
  NetworkService.internal() : super();

  /// Returns the DI-registered implementation.
  factory NetworkService() => Service.get<NetworkService>();

  /// Sends an HTTP request.
  Future<IoResult<NetworkResponse>> send(
    NetworkRequest request, {
    TransferProgressCallback? onUploadProgress,
    TransferProgressCallback? onDownloadProgress,
    NetworkCancelToken? cancelToken,
  });

  /// Convenience GET request.
  Future<IoResult<NetworkResponse>> get(
    Uri uri, {
    Map<String, String>? headers,
    Map<String, String>? query,
  }) {
    return send(
      NetworkRequest(
        method: HttpMethod.get,
        uri: uri,
        headers: headers ?? const <String, String>{},
        query: query ?? const <String, String>{},
      ),
    );
  }

  /// Convenience POST request.
  Future<IoResult<NetworkResponse>> post(
    Uri uri, {
    Map<String, String>? headers,
    Map<String, String>? query,
    Bytes? bodyBytes,
    String? contentType,
  }) {
    return send(
      NetworkRequest(
        method: HttpMethod.post,
        uri: uri,
        headers: headers ?? const <String, String>{},
        query: query ?? const <String, String>{},
        bodyBytes: bodyBytes,
        contentType: contentType,
      ),
    );
  }

  /// Convenience PUT request.
  Future<IoResult<NetworkResponse>> put(
    Uri uri, {
    Map<String, String>? headers,
    Map<String, String>? query,
    Bytes? bodyBytes,
    String? contentType,
  }) {
    return send(
      NetworkRequest(
        method: HttpMethod.put,
        uri: uri,
        headers: headers ?? const <String, String>{},
        query: query ?? const <String, String>{},
        bodyBytes: bodyBytes,
        contentType: contentType,
      ),
    );
  }

  /// Convenience PATCH request.
  Future<IoResult<NetworkResponse>> patch(
    Uri uri, {
    Map<String, String>? headers,
    Map<String, String>? query,
    Bytes? bodyBytes,
    String? contentType,
  }) {
    return send(
      NetworkRequest(
        method: HttpMethod.patch,
        uri: uri,
        headers: headers ?? const <String, String>{},
        query: query ?? const <String, String>{},
        bodyBytes: bodyBytes,
        contentType: contentType,
      ),
    );
  }

  /// Convenience DELETE request.
  Future<IoResult<NetworkResponse>> delete(
    Uri uri, {
    Map<String, String>? headers,
    Map<String, String>? query,
    Bytes? bodyBytes,
    String? contentType,
  }) {
    return send(
      NetworkRequest(
        method: HttpMethod.delete,
        uri: uri,
        headers: headers ?? const <String, String>{},
        query: query ?? const <String, String>{},
        bodyBytes: bodyBytes,
        contentType: contentType,
      ),
    );
  }

  @override
  String get group => '${super.group}.NetworkService';

  @override
  bool get singelton => true;
}
