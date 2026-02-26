import 'package:grumpy/grumpy.dart';

import '../../../core/core.dart';
import '../../domain/datasources/typed_network_datasource.dart';
import '../../domain/models/network_request.dart';
import '../../domain/models/network_response.dart';
import '../../domain/models/transfer_progress.dart';
import '../../domain/services/network_cancel_token.dart';
import '../../domain/services/network_service.dart';

/// Default [TypedNetworkDatasource] implementation.
class DefaultTypedNetworkDatasource extends TypedNetworkDatasource {
  /// Creates a datasource.
  DefaultTypedNetworkDatasource({NetworkService? networkService})
    : _networkService = networkService,
      super.internal();

  final NetworkService? _networkService;

  NetworkService get _network => _networkService ?? NetworkService();

  @override
  Future<IoResult<T>> send<T>({
    required NetworkRequest request,
    required SerializationCodec<T, Bytes> codec,
    TransferProgressCallback? onUploadProgress,
    TransferProgressCallback? onDownloadProgress,
    NetworkCancelToken? cancelToken,
  }) async {
    final response = await _network.send(
      request,
      onUploadProgress: onUploadProgress,
      onDownloadProgress: onDownloadProgress,
      cancelToken: cancelToken,
    );

    return switch (response) {
      IoErr<NetworkResponse>(failure: final failure) => IoErr<T>(failure),
      IoOk<NetworkResponse>(value: final ok) => _decode(ok.bodyBytes, codec),
    };
  }

  IoResult<T> _decode<T>(Bytes bytes, SerializationCodec<T, Bytes> codec) {
    try {
      return IoOk<T>(codec.decode(bytes));
    } catch (error, stackTrace) {
      return IoErr<T>(
        IoFailure(
          code: IoFailureCode.invalidData,
          message: 'Failed to decode network payload.',
          cause: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  @override
  Future<void> destroy() async {}

  @override
  String get logTag => 'DefaultTypedNetworkDatasource';
}
