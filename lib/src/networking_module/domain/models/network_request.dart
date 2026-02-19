import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:grumpy/grumpy.dart';

part 'network_request.freezed.dart';
part 'network_request.g.dart';

/// A network request for making HTTP calls.
@freezed
abstract class NetworkRequest with _$NetworkRequest implements Model {
  /// Creates a new [NetworkRequest] instance.
  const factory NetworkRequest({
    required String url,
    required HttpMethod method,
    @Default({}) Map<String, String> headers,
    @Default(null) dynamic body,
    @Default({}) Map<String, String>? queryParameters,
  }) = _NetworkRequest;

  /// Creates a [NetworkRequest] instance from a JSON map.
  factory NetworkRequest.fromJson(Map<String, Object?> json) =>
      _$NetworkRequestFromJson(json);
}

/// An enumeration of HTTP methods.
enum HttpMethod { get, post, put, delete, patch, head, options }
