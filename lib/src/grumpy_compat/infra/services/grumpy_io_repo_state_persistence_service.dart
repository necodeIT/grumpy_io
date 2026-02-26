import 'dart:convert';

import 'package:grumpy/grumpy.dart';

import '../../../core/core.dart';
import '../../../local_storage_module/domain/models/local_storage_value.dart';
import '../../../local_storage_module/domain/services/local_storage_service.dart';

/// Snapshot persistence compatible with Grumpy repo contracts.
class GrumpyIoRepoStatePersistenceService extends RepoStatePersistenceService {
  /// Creates persistence service.
  GrumpyIoRepoStatePersistenceService({LocalStorageService? storageService})
    : _storageService = storageService,
      super.internal();

  final LocalStorageService? _storageService;

  LocalStorageService get _storage => _storageService ?? LocalStorageService();

  @override
  Future<RepoSnapshot<T>?> load<T, Serialized extends Object>(
    RepoSnapshotKey key, {
    required SerializationCodec<T, Serialized> codec,
  }) async {
    final storageResult = await _storage.get(_RepoStorageKey.fromKey(key));
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
        await _storage.remove(_RepoStorageKey.fromKey(key));
        return null;
      }

      final payload = data['payload'];
      if (payload is! Map) return null;
      final payloadMap = Map<String, Object?>.from(payload);
      final decoded = _deserializePayload(payloadMap);

      final savedAt = DateTime.parse(data['savedAt'] as String);
      final expiresAtRaw = data['expiresAt'];
      final lastSyncAtRaw = data['lastSyncAt'];

      return RepoSnapshot<T>(
        data: codec.decode(decoded as Serialized),
        savedAt: savedAt,
        expiresAt: expiresAtRaw == null
            ? null
            : DateTime.parse(expiresAtRaw as String),
        lastSyncAt: lastSyncAtRaw == null
            ? null
            : DateTime.parse(lastSyncAtRaw as String),
        metadata: data['metadata'] is Map
            ? Map<String, Object?>.from(data['metadata'] as Map)
            : const <String, Object?>{},
      );
    } catch (_) {
      await _storage.remove(_RepoStorageKey.fromKey(key));
      return null;
    }
  }

  @override
  Future<void> save<T, Serialized extends Object>(
    RepoSnapshotKey key,
    RepoSnapshot<T> snapshot, {
    required SerializationCodec<T, Serialized> codec,
  }) async {
    final encoded = codec.encode(snapshot.data);
    final envelope = <String, Object?>{
      'schemaId': key.schemaId,
      'compatVersion': key.compatVersion,
      'savedAt': snapshot.savedAt.toIso8601String(),
      'expiresAt': snapshot.expiresAt?.toIso8601String(),
      'lastSyncAt': snapshot.lastSyncAt?.toIso8601String(),
      'metadata': snapshot.metadata,
      'payload': _serializePayload(encoded),
    };

    await _storage.put(
      LocalStorageValue(
        key: _RepoStorageKey.fromKey(key),
        bytes: Bytes.fromList(utf8.encode(jsonEncode(envelope))),
        savedAt: snapshot.savedAt,
        expiresAt: snapshot.expiresAt,
        contentType: 'application/grumpy-snapshot+json',
      ),
    );
  }

  @override
  Future<void> delete(RepoSnapshotKey key) {
    return _storage.remove(_RepoStorageKey.fromKey(key)).then((_) {});
  }

  @override
  Future<void> clearNamespace(String namespace) {
    return _storage
        .clearNamespace(_RepoStorageKey.storageNamespace)
        .then((_) {});
  }

  Map<String, Object?> _serializePayload(Object payload) {
    if (payload is Bytes) {
      return <String, Object?>{'kind': 'bytes', 'value': base64Encode(payload)};
    }
    if (payload is List<int>) {
      return <String, Object?>{'kind': 'bytes', 'value': base64Encode(payload)};
    }
    if (payload is num || payload is String || payload is bool) {
      return <String, Object?>{'kind': 'json', 'value': payload};
    }
    if (payload is List || payload is Map) {
      return <String, Object?>{'kind': 'json', 'value': payload};
    }
    throw ArgumentError('Unsupported snapshot payload: ${payload.runtimeType}');
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
  String get logTag => 'GrumpyIoRepoStatePersistenceService';
}

class _RepoStorageKey implements StorageKey {
  const _RepoStorageKey._(this.primaryKey);

  static const String storageNamespace = 'repo_snapshots';

  final String primaryKey;

  factory _RepoStorageKey.fromKey(RepoSnapshotKey key) {
    return _RepoStorageKey._(key.asStorageKey());
  }

  @override
  int? get compatVersion => null;

  @override
  String get namespace => storageNamespace;

  @override
  String get schemaId => 'grumpy_io_repo_snapshot_v1';

  @override
  String asStorageKey() => '$namespace|$schemaId|$primaryKey';
}
