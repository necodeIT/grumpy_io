import 'dart:convert';

import 'package:grumpy/grumpy.dart';
import 'package:grumpy_io/grumpy_io.dart';

/// Persistent cache layer backed by [LocalStorageService].
class GrumpyIoFileCacheLayerService extends FileCacheLayerService {
  /// Creates a file cache layer.
  GrumpyIoFileCacheLayerService({LocalStorageService? storageService})
    : _storageService = storageService,
      super.internal();

  final LocalStorageService? _storageService;

  LocalStorageService get _storage => _storageService ?? LocalStorageService();

  @override
  Future<CacheEntry<T>?> read<T, Serialized extends Object>(
    StorageKey key, {
    SerializationCodec<T, Serialized>? codec,
  }) async {
    final storageResult = await _storage.get(_CacheStorageKey.fromKey(key));
    if (storageResult case IoErr<LocalStorageValue?>()) {
      return null;
    }

    final stored = (storageResult as IoOk<LocalStorageValue?>).value;
    if (stored == null) return null;

    try {
      final map = jsonDecode(utf8.decode(stored.bytes));
      if (map is! Map) return null;
      final data = Map<String, Object?>.from(map);

      if (data['schemaId'] != key.schemaId ||
          data['compatVersion'] != key.compatVersion) {
        await _storage.remove(_CacheStorageKey.fromKey(key));
        return null;
      }

      final payload = data['payload'];
      if (payload is! Map) return null;
      final payloadMap = Map<String, Object?>.from(payload);

      final decodedPayload = _deserializePayload(payloadMap);
      final value = codec == null
          ? decodedPayload as T
          : codec.decode(decodedPayload as Serialized);

      final createdAt = DateTime.parse(data['createdAt'] as String);
      final expiresAtRaw = data['expiresAt'];
      final expiresAt = expiresAtRaw == null
          ? null
          : DateTime.parse(expiresAtRaw as String);

      final entry = CacheEntry<T>(
        value: value,
        createdAt: createdAt,
        expiresAt: expiresAt,
        etag: data['etag'] as String?,
      );

      if (entry.isExpired) {
        await _storage.remove(_CacheStorageKey.fromKey(key));
        return null;
      }

      return entry;
    } catch (_) {
      await _storage.remove(_CacheStorageKey.fromKey(key));
      return null;
    }
  }

  @override
  Future<void> write<T, Serialized extends Object>(
    StorageKey<T> key,
    CacheEntry<T> entry, {
    SerializationCodec<T, Serialized>? codec,
  }) async {
    final payload = codec == null
        ? _serializePayload(entry.value as Object?)
        : _serializePayload(codec.encode(entry.value));

    final envelope = <String, Object?>{
      'schemaId': key.schemaId,
      'compatVersion': key.compatVersion,
      'createdAt': entry.createdAt.toIso8601String(),
      'expiresAt': entry.expiresAt?.toIso8601String(),
      'etag': entry.etag,
      'payload': payload,
    };

    await _storage.put(
      LocalStorageValue(
        key: _CacheStorageKey.fromKey(key),
        bytes: Bytes.fromList(utf8.encode(jsonEncode(envelope))),
        savedAt: DateTime.now(),
        expiresAt: entry.expiresAt,
        contentType: 'application/grumpy-cache+json',
      ),
    );
  }

  @override
  Future<void> invalidate<T>(StorageKey<T> key) {
    return _storage.remove(_CacheStorageKey.fromKey(key)).then((_) {});
  }

  @override
  Future<void> clearNamespace(String namespace) {
    return _storage
        .clearNamespace(_CacheStorageKey.storageNamespace)
        .then((_) {});
  }

  Map<String, Object?> _serializePayload(Object? payload) {
    if (payload is Bytes) {
      return <String, Object?>{'kind': 'bytes', 'value': base64Encode(payload)};
    }
    if (payload is List<int>) {
      return <String, Object?>{'kind': 'bytes', 'value': base64Encode(payload)};
    }
    if (payload is num ||
        payload is String ||
        payload is bool ||
        payload == null) {
      return <String, Object?>{'kind': 'json', 'value': payload};
    }
    if (payload is List || payload is Map) {
      return <String, Object?>{'kind': 'json', 'value': payload};
    }
    throw ArgumentError('Unsupported payload type: ${payload.runtimeType}');
  }

  Object? _deserializePayload(Map<String, Object?> payload) {
    final kind = payload['kind'];
    if (kind == 'bytes') {
      final encoded = payload['value'] as String;
      return Bytes.fromList(base64Decode(encoded));
    }
    return payload['value'];
  }

  @override
  Future<void> destroy() async {}

  @override
  String get logTag => 'GrumpyIoFileCacheLayerService';
}
