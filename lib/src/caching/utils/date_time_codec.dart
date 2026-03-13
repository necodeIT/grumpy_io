import 'package:grumpy/grumpy.dart';

/// Converts [DateTime] to and from milliseconds since epoch for serialization purposes.
class DateTimeCodec extends SerializationCodec<DateTime, int> {
  /// Converts [DateTime] to and from milliseconds since epoch for serialization purposes.
  const DateTimeCodec();
  @override
  int encode(DateTime value) => value.millisecondsSinceEpoch;

  @override
  DateTime decode(int encoded) => DateTime.fromMillisecondsSinceEpoch(encoded);
}
