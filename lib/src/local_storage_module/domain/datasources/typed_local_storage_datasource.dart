import 'package:grumpy/grumpy.dart';
import 'package:grumpy_io/grumpy_io.dart';

/// Typed local-storage datasource abstraction.
abstract class TypedLocalStorageDatasource extends TypedDatasource {
  /// Creates a datasource.
  const TypedLocalStorageDatasource.internal() : super.internal();

  /// Returns the DI-registered implementation.
  factory TypedLocalStorageDatasource() =>
      Datasource.get<TypedLocalStorageDatasource>();

  /// Loads and decodes [key].
  Future<IoResult<T?>> get<T>({
    required StorageKey key,
    required SerializationCodec<T, Bytes> codec,
  });

  /// Encodes and stores [value] at [key].
  Future<IoResult<void>> put<T>({
    required StorageKey key,
    required T value,
    required SerializationCodec<T, Bytes> codec,
    Map<String, Object?> metadata,
  });

  /// Removes [key].
  Future<IoResult<void>> remove(StorageKey key);

  /// Clears [namespace].
  Future<IoResult<void>> clearNamespace(String namespace);
  @override
  String get group => '${super.group}.TypedLocalStorageDatasource';

  @override
  bool get singelton => true;
}
