import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:grumpy_io/grumpy_io.dart';

/// JSON converter for [Bytes] using Base64 encoding.
class BytesJsonConverter extends JsonConverter<Bytes, String> {
  /// JSON converter for [Bytes] using Base64 encoding.
  const BytesJsonConverter();

  @override
  Bytes fromJson(String json) {
    return Bytes.fromList(base64Decode(json));
  }

  @override
  String toJson(Bytes object) {
    return base64Encode(object);
  }
}
