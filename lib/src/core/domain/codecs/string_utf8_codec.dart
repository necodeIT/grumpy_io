import 'dart:convert';

import 'package:grumpy/grumpy.dart';

import '../models/io_result.dart';

/// UTF-8 codec for plain text payloads.
class StringUtf8Codec implements SerializationCodec<String, Bytes> {
  /// Creates a string codec.
  const StringUtf8Codec();

  @override
  Bytes encode(String value) => Bytes.fromList(utf8.encode(value));

  @override
  String decode(Bytes payload) => utf8.decode(payload);
}
