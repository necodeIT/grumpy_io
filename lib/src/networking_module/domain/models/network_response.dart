import 'package:grumpy/grumpy.dart';

import '../../../core/core.dart';
import 'network_request.dart';

/// Canonical network response model.
class NetworkResponse extends Model {
  /// Creates a network response.
  const NetworkResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.headers,
    required this.bodyBytes,
    required this.request,
  });

  /// HTTP status code.
  final int statusCode;

  /// Optional HTTP status message.
  final String? statusMessage;

  /// Response headers.
  final Map<String, List<String>> headers;

  /// Response body bytes.
  final Bytes bodyBytes;

  /// Original request.
  final NetworkRequest request;
}
