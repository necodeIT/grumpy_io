import 'dart:convert';

import 'package:grumpy/grumpy.dart';
import 'package:grumpy_io/grumpy_io.dart';

/// A codec for encoding/decoding [LocalStorageValue] to/from a string using base64 encoding.
///
/// Used for web local storage, which only supports string values.
class LocalStorageValueStringCodec
    extends SerializationCodec<LocalStorageValue, String> {
  /// A codec for encoding/decoding [LocalStorageValue] to/from a string using base64 encoding.
  ///
  /// Used for web local storage, which only supports string values.
  const LocalStorageValueStringCodec();
  @override
  LocalStorageValue decode(String payload) {
    final bytes = base64Decode(payload);
    final jsonString = utf8.decode(bytes);
    final json = jsonDecode(jsonString) as JsonMap;

    return LocalStorageValue.fromJson(json);
  }

  @override
  String encode(LocalStorageValue value) {
    final json = value.toJson();

    final jsonString = jsonEncode(json);

    final bytes = utf8.encode(jsonString);
    return base64Encode(bytes);
  }
}
