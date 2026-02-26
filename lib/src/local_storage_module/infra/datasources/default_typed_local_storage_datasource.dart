import 'package:grumpy/grumpy.dart';
import 'package:grumpy_io/grumpy_io.dart';

/// Default [TypedLocalStorageDatasource] implementation.
class DefaultTypedLocalStorageDatasource extends TypedLocalStorageDatasource {
  /// Creates a datasource.
  DefaultTypedLocalStorageDatasource({LocalStorageService? localStorageService})
    : _localStorageService = localStorageService,
      super.internal();

  @override
  bool get singelton => true;

  final LocalStorageService? _localStorageService;

  LocalStorageService get _storage =>
      _localStorageService ?? LocalStorageService();

  @override
  Future<IoResult<T?>> get<T>({
    required StorageKey key,
    required SerializationCodec<T, Bytes> codec,
  }) async {
    final stored = await _storage.get(key);
    return switch (stored) {
      IoErr<LocalStorageValue?>(failure: final failure) => IoErr<T?>(failure),
      IoOk<LocalStorageValue?>(value: final value) => _decode<T>(value, codec),
    };
  }

  @override
  Future<IoResult<void>> put<T>({
    required StorageKey key,
    required T value,
    required SerializationCodec<T, Bytes> codec,
    String? contentType,
    Map<String, Object?> metadata = const <String, Object?>{},
  }) async {
    final encoded = _encode(value, codec);
    if (encoded case IoErr<Bytes>(failure: final failure)) {
      return IoErr<void>(failure);
    }

    return _storage.put(
      LocalStorageValue(
        key: key,
        bytes: (encoded as IoOk<Bytes>).value,
        metadata: metadata,
      ),
    );
  }

  @override
  Future<IoResult<void>> remove(StorageKey key) => _storage.remove(key);

  @override
  Future<IoResult<void>> clearNamespace(String namespace) {
    return _storage.clearNamespace(namespace);
  }

  IoResult<T?> _decode<T>(
    LocalStorageValue? value,
    SerializationCodec<T, Bytes> codec,
  ) {
    if (value == null) return IoOk<T?>(null);
    try {
      return IoOk<T?>(codec.decode(value.bytes));
    } catch (error, stackTrace) {
      return IoErr<T?>(
        IoFailure(
          code: IoFailureCode.invalidData,
          message: 'Failed to decode local storage payload.',
          cause: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  IoResult<Bytes> _encode<T>(T value, SerializationCodec<T, Bytes> codec) {
    try {
      return IoOk<Bytes>(codec.encode(value));
    } catch (error, stackTrace) {
      return IoErr<Bytes>(
        IoFailure(
          code: IoFailureCode.invalidData,
          message: 'Failed to encode local storage payload.',
          cause: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  @override
  Future<void> destroy() async {}

  @override
  String get logTag => 'DefaultTypedLocalStorageDatasource';
}
