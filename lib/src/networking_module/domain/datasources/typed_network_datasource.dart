import 'package:grumpy/grumpy.dart';
import 'package:grumpy_io/grumpy_io.dart';

/// Typed network datasource abstraction.
abstract class TypedNetworkDatasource extends TypedDatasource {
  /// Creates a datasource.
  const TypedNetworkDatasource.internal() : super.internal();

  /// Returns the DI-registered implementation.
  factory TypedNetworkDatasource() => Datasource.get<TypedNetworkDatasource>();

  /// Sends [request] and decodes bytes into `T` via [codec].
  Future<IoResult<T>> send<T>({
    required NetworkRequest request,
    required SerializationCodec<T, Bytes> codec,
    TransferProgressCallback? onUploadProgress,
    TransferProgressCallback? onDownloadProgress,
    NetworkCancelToken? cancelToken,
  });
  @override
  String get group => '${super.group}.TypedNetworkDatasource';

  @override
  bool get singelton => true;
}
