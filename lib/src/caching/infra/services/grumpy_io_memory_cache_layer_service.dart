import 'dart:async';

import 'dart:typed_data';

import 'package:grumpy/grumpy.dart';

/// Memory cache layer service implementation using in-memory map.
class GrumpyIoMemoryCacheLayerService extends MemoryCacheLayerService {
  /// Memory cache layer service implementation using in-memory map.
  GrumpyIoMemoryCacheLayerService() : super.internal();

  final _cache = <StorageKey, CacheEntry>{};

  @override
  bool get singelton => true;

  @override
  Future<void> clearNamespace(String namespace) async {
    _cache.removeWhere((key, _) => key.namespace == namespace);
  }

  @override
  FutureOr<void> destroy() {
    _cache.clear();
  }

  @override
  Future<void> invalidate<T>(StorageKey key) async {
    _cache.remove(key);
  }

  @override
  String get logTag => 'GrumpyIoMemoryCacheLayerService';

  @override
  Future<CacheEntry<T>?> read<T>(
    StorageKey key, {
    SerializationCodec<T, Uint8List>? codec,
  }) async {
    final entry = _cache[key] as CacheEntry<T>?;

    if (entry != null && entry.isExpired) {
      _cache.remove(key);
      return null;
    }

    return entry;
  }

  @override
  Future<void> write<T>(
    StorageKey key,
    CacheEntry<T> entry, {
    SerializationCodec<T, Uint8List>? codec,
  }) async {
    _cache[key] = entry;
  }
}
