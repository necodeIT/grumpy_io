import 'package:grumpy/grumpy.dart';
import 'package:grumpy_io/grumpy_io.dart';

/// Codec for encoding/decoding LocalStorageValue to/from bytes.
class LocalStorageValueCodec extends JsonUtf8Codec<LocalStorageValue> {
  @override
  LocalStorageValue fromJson(JsonMap json) {
    return LocalStorageValue.fromJson(json);
  }

  @override
  JsonMap toJson(LocalStorageValue value) {
    return value.toJson();
  }
}
