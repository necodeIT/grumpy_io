import 'dart:convert';

import 'package:grumpy/grumpy.dart';

import '../models/io_result.dart';

/// Convenience base for JSON-object codecs serialized as UTF-8 bytes.
abstract class JsonUtf8Codec<T> implements SerializationCodec<T, Bytes> {
  /// Creates a JSON codec.
  const JsonUtf8Codec();

  /// Converts [value] into a JSON object.
  JsonMap toJson(T value);

  /// Converts a JSON object into the target type.
  T fromJson(JsonMap json);

  @override
  Bytes encode(T value) {
    return Bytes.fromList(utf8.encode(jsonEncode(toJson(value))));
  }

  @override
  T decode(Bytes payload) {
    final dynamic decoded = jsonDecode(utf8.decode(payload));
    if (decoded is! Map) {
      throw const FormatException('Expected JSON object payload.');
    }
    return fromJson(Map<String, Object?>.from(decoded));
  }

  /// Creates a JSON codec from [toJson] and [fromJson] functions.
  const factory JsonUtf8Codec.from({
    required JsonMap Function(T value) toJson,
    required T Function(JsonMap json) fromJson,
  }) = _JsonUtf8CodecImpl;
}

class _JsonUtf8CodecImpl<T> extends JsonUtf8Codec<T> {
  const _JsonUtf8CodecImpl({
    required JsonMap Function(T value) toJson,
    required T Function(JsonMap json) fromJson,
  }) : _toJson = toJson,
       _fromJson = fromJson;

  final JsonMap Function(T value) _toJson;

  final T Function(JsonMap json) _fromJson;

  @override
  T fromJson(JsonMap json) => _fromJson(json);

  @override
  JsonMap toJson(T value) => _toJson(value);
}

/// Convenience base for lists of JSON objects serialized as UTF-8 bytes.
abstract class JsonListUtf8Codec<T>
    implements SerializationCodec<List<T>, Bytes> {
  /// Creates a JSON list codec.
  const JsonListUtf8Codec();

  /// Converts [value] into a JSON object.
  JsonMap toJson(T value);

  /// Converts a JSON object into the target type.
  T fromJson(JsonMap json);

  @override
  Bytes encode(List<T> value) {
    final json = value.map(toJson).toList(growable: false);
    return Bytes.fromList(utf8.encode(jsonEncode(json)));
  }

  @override
  List<T> decode(Bytes payload) {
    final dynamic decoded = jsonDecode(utf8.decode(payload));
    if (decoded is! List) {
      throw const FormatException('Expected JSON array payload.');
    }

    return decoded.indexed
        .map((entry) {
          final (index, value) = entry;
          if (value is! Map) {
            throw FormatException('Expected JSON object at index $index.');
          }
          return fromJson(Map<String, Object?>.from(value));
        })
        .toList(growable: false);
  }

  /// Creates a JSON list codec from [toJson] and [fromJson] functions.
  const factory JsonListUtf8Codec.from({
    required JsonMap Function(T value) toJson,
    required T Function(JsonMap json) fromJson,
  }) = _JsonListUtf8CodecImpl;
}

class _JsonListUtf8CodecImpl<T> extends JsonListUtf8Codec<T> {
  const _JsonListUtf8CodecImpl({
    required JsonMap Function(T value) toJson,
    required T Function(JsonMap json) fromJson,
  }) : _toJson = toJson,
       _fromJson = fromJson;

  final JsonMap Function(T value) _toJson;

  final T Function(JsonMap json) _fromJson;

  @override
  T fromJson(JsonMap json) => _fromJson(json);

  @override
  JsonMap toJson(T value) => _toJson(value);
}
