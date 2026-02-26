import 'package:grumpy/grumpy.dart';

/// In-memory cache layer compatible with Grumpy cache contracts.
class GrumpyIoMemoryCacheLayerService extends MemoryCacheLayerService {
  /// Creates a memory cache layer.
  GrumpyIoMemoryCacheLayerService() : super.internal();

  final Map<String, CacheEntry<Object?>> _entries =
      <String, CacheEntry<Object?>>{};

  @override
  Future<CacheEntry<T>?> read<T, Serialized extends Object>(
    StorageKey<T> key, {
    SerializationCodec<T, Serialized>? codec,
  }) async {
    final entry = _entries[key.asStorageKey()];
    if (entry == null) return null;
    if (entry.isExpired) {
      _entries.remove(key.asStorageKey());
      return null;
    }
    return entry as CacheEntry<T>;
  }

  @override
  Future<void> write<T, Serialized extends Object>(
    StorageKey<T> key,
    CacheEntry<T> entry, {
    SerializationCodec<T, Serialized>? codec,
  }) async {
    _entries[key.asStorageKey()] = entry as CacheEntry<Object?>;
  }

  @override
  Future<void> invalidate<T>(StorageKey<T> key) async {
    _entries.remove(key.asStorageKey());
  }

  @override
  Future<void> clearNamespace(String namespace) async {
    _entries.removeWhere((key, _) => key.startsWith('$namespace|'));
  }

  @override
  Future<void> destroy() async {
    _entries.clear();
  }

  @override
  String get logTag => 'GrumpyIoMemoryCacheLayerService';
}
