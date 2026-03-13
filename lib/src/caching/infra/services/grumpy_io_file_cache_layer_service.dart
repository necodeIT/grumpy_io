import 'dart:async';

import 'dart:typed_data';

import 'package:grumpy/grumpy.dart';
import 'package:grumpy_io/grumpy_io.dart';

/// File cache layer service implementation using local storage as the underlying mechanism.
class GrumpyIoFileCacheLayerService extends FileCacheLayerService {
  /// File cache layer service implementation using local storage as the underlying mechanism.
  GrumpyIoFileCacheLayerService() : super.internal();

  @override
  bool get singelton => true;

  final _localStorage = LocalStorageService();

  @override
  Future<void> clearNamespace(String namespace) async {
    final result = await _localStorage.clearNamespace(namespace);

    if (result.isErr) {
      final err = result.failureOrNull!;
      // Log error but don't throw, as cache clearing should be best-effort
      log(
        'Failed clearing file cache namespace "$namespace"',
        err,
        err.stackTrace,
      );
    }

    log('Cleared file cache namespace "$namespace"');
  }

  @override
  FutureOr<void> destroy() {}

  @override
  Future<void> invalidate<T>(StorageKey key) async {
    await _localStorage.remove(key);
  }

  @override
  String get logTag => 'GrumpyIoFileCacheLayerService';

  @override
  Future<CacheEntry<T>?> read<T>(
    StorageKey key, {
    required SerializationCodec<T, Uint8List> codec,
  }) async {
    final result = await _localStorage.get(key);
    if (result.isErr) {
      log(
        'Failed reading from file cache for key "$key"',
        result.failureOrNull!,
        result.failureOrNull!.stackTrace,
      );
      return null;
    }

    try {
      final localStorageValue = result.valueOrNull;
      if (localStorageValue == null) {
        return null;
      }
      return CacheEntryUtils.fromMetadataJson(
        value: codec.decode(localStorageValue.bytes),
        metadata: localStorageValue.metadata,
      );
    } catch (error, stackTrace) {
      log('Failed decoding file cache entry for key "$key"', error, stackTrace);
      return null;
    }
  }

  @override
  Future<void> write<T>(
    StorageKey key,
    CacheEntry<T> entry, {
    required SerializationCodec<T, Uint8List> codec,
  }) async {
    final encodedValue = codec.encode(entry.value);
    final storageValue = LocalStorageValue(
      key: key,
      bytes: encodedValue,
      metadata: entry.metadataJson(),
    );

    final result = await _localStorage.put(storageValue);

    if (result.isErr) {
      final err = result.failureOrNull!;
      log('Failed writing to file cache for key "$key"', err, err.stackTrace);

      return;
    }

    log('Wrote file cache entry for key "$key"');
  }
}
