import 'package:grumpy/grumpy.dart';
import 'package:grumpy_io/grumpy_io.dart';

/// A service for performing network requests and handling responses.
abstract class NetworkService extends Service {
  @override
  String get group => '${super.group}.NetworkingService';

  /// Internal constructor for subclasses.
  NetworkService.internal();

  /// Returns the DI-registered implementation of [NetworkService].
  ///
  /// Shorthand for [Service.get].
  factory NetworkService() {
    return Service.get<NetworkService>();
  }

  /// Sends a [NetworkRequest] and returns a [NetworkResponse].
  Future<NetworkResponse> sendRequest(
    NetworkRequest request, {
    Duration? timeout,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  });

  /// A convenience method for making a GET request to the specified [url] with optional [headers] and [queryParameters].
  Future<NetworkResponse> get(
    String url, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  }) {
    return sendRequest(
      NetworkRequest(
        url: url,
        method: .get,
        headers: headers ?? {},
        queryParameters: queryParameters ?? {},
      ),
    );
  }

  /// A convenience method for making a POST request to the specified [url] with optional [headers], [body], and [queryParameters].
  Future<NetworkResponse> post(
    String url, {
    Map<String, String>? headers,
    dynamic body,
    Map<String, String>? queryParameters,
  }) {
    return sendRequest(
      NetworkRequest(
        url: url,
        method: .post,
        headers: headers ?? {},
        body: body,
        queryParameters: queryParameters ?? {},
      ),
    );
  }

  /// A convenience method for making a PUT request to the specified [url] with optional [headers], [body], and [queryParameters].
  Future<NetworkResponse> put(
    String url, {
    Map<String, String>? headers,
    dynamic body,
    Map<String, String>? queryParameters,
  }) {
    return sendRequest(
      NetworkRequest(
        url: url,
        method: .put,
        headers: headers ?? {},
        body: body,
        queryParameters: queryParameters ?? {},
      ),
    );
  }

  /// A convenience method for making a DELETE request to the specified [url] with optional [headers], [body], and [queryParameters].
  Future<NetworkResponse> delete(
    String url, {
    Map<String, String>? headers,
    dynamic body,
    Map<String, String>? queryParameters,
  }) {
    return sendRequest(
      NetworkRequest(
        url: url,
        method: .delete,
        headers: headers ?? {},
        body: body,
        queryParameters: queryParameters ?? {},
      ),
    );
  }

  /// A convenience method for making a PATCH request to the specified [url] with optional [headers], [body], and [queryParameters].
  Future<NetworkResponse> patch(
    String url, {
    Map<String, String>? headers,
    dynamic body,
    Map<String, String>? queryParameters,
  }) {
    return sendRequest(
      NetworkRequest(
        url: url,
        method: .patch,
        headers: headers ?? {},
        body: body,
        queryParameters: queryParameters ?? {},
      ),
    );
  }

  /// A convenience method for making a HEAD request to the specified [url] with optional [headers] and [queryParameters].
  Future<NetworkResponse> head(
    String url, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  }) {
    return sendRequest(
      NetworkRequest(
        url: url,
        method: .head,
        headers: headers ?? {},
        queryParameters: queryParameters ?? {},
      ),
    );
  }

  /// A convenience method for making an OPTIONS request to the specified [url] with optional [headers] and [queryParameters].
  Future<NetworkResponse> options(
    String url, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  }) {
    return sendRequest(
      NetworkRequest(
        url: url,
        method: .options,
        headers: headers ?? {},
        queryParameters: queryParameters ?? {},
      ),
    );
  }
}
