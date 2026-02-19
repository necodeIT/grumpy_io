import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:grumpy/grumpy.dart';
import 'package:grumpy_io/grumpy_io.dart';

part 'network_response.freezed.dart';
part 'network_response.g.dart';

/// A response from a network request, containing the status code, body, headers, and the original request.
@freezed
abstract class NetworkResponse with _$NetworkResponse implements Model {
  /// Creates a new [NetworkResponse] instance.
  const factory NetworkResponse({
    /// The HTTP status code of the response.
    int? statusCode,

    /// The HTTP status message of the response.
    String? statusMessage,

    /// The body of the response. Can be of any type depending on the response content.
    required dynamic body,

    /// The original request that resulted in this response.
    required NetworkRequest request,

    /// The headers of the response. Defaults to an empty map if not provided.
    @Default({}) Map<String, List<String>> headers,
  }) = _NetworkResponse;

  /// Creates a [NetworkResponse] instance from a JSON map.
  factory NetworkResponse.fromJson(Map<String, Object?> json) =>
      _$NetworkResponseFromJson(json);
}
