import 'package:grumpy/grumpy.dart';

import '../../../core/core.dart';
import 'http_method.dart';

/// Canonical network request model.
class NetworkRequest extends Model {
  /// Creates a network request.
  const NetworkRequest({
    required this.method,
    required this.uri,
    this.headers = const <String, String>{},
    this.query = const <String, String>{},
    this.bodyBytes,
    this.contentType,
    this.connectTimeout,
    this.sendTimeout,
    this.receiveTimeout,
  });

  /// Request method.
  final HttpMethod method;

  /// Request target URI.
  final Uri uri;

  /// Request headers.
  final Map<String, String> headers;

  /// Query parameters merged into [uri].
  final Map<String, String> query;

  /// Optional request body bytes.
  final Bytes? bodyBytes;

  /// Optional request body content type.
  final String? contentType;

  /// Optional connection timeout.
  final Duration? connectTimeout;

  /// Optional upload timeout.
  final Duration? sendTimeout;

  /// Optional download timeout.
  final Duration? receiveTimeout;

  /// Returns a URI with [query] merged into existing query parameters.
  Uri get resolvedUri {
    if (query.isEmpty) return uri;
    final merged = <String, String>{...uri.queryParameters, ...query};
    return uri.replace(queryParameters: merged);
  }
}
