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
