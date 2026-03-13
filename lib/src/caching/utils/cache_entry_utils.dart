import 'package:grumpy/grumpy.dart';
import 'package:grumpy_io/src/caching/utils/date_time_codec.dart';

/// Extension methods for [CacheEntry] to facilitate conversion between cache entry metadata and JSON-serializable formats, as well as creating cache entries from JSON metadata.
extension CacheEntryUtils<T> on CacheEntry<T> {
  /// Converts the cache entry's metadata to a JSON-serializable map.
  ///
  /// The `createdAt` and `expiresAt` fields are encoded using [DateTimeCodec] to convert them to milliseconds since epoch, making them suitable for JSON serialization. The `etag` is included as-is.
  Map<String, dynamic> metadataJson() {
    final codec = const DateTimeCodec();
    return {
      'createdAt': codec.encode(createdAt),
      'expiresAt': expiresAt != null ? codec.encode(expiresAt!) : null,
      'etag': etag,
    };
  }

  /// Creates a [CacheEntry] from a JSON map containing metadata and a value.
  ///
  /// If the metadata contains `createdAt` and `expiresAt`, they will be decoded using [DateTimeCodec]. If not, `createdAt` will default to the current time and `expiresAt` will be null.
  static CacheEntry<T> fromMetadataJson<T>({
    required T value,
    required Map<String, dynamic> metadata,
  }) {
    final codec = const DateTimeCodec();
    final createdAt = metadata['createdAt'] as int?;
    final expiresAt = metadata['expiresAt'] as int?;
    final etag = metadata['etag'] as String?;

    return CacheEntry<T>(
      value: value,
      createdAt: createdAt != null ? codec.decode(createdAt) : DateTime.now(),
      expiresAt: expiresAt != null ? codec.decode(expiresAt) : null,
      etag: etag,
    );
  }
}
