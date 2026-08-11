import 'dart:convert';

import 'package:grumpy/grumpy.dart';
import 'package:grumpy_io/grumpy_io.dart';
import 'package:test/test.dart';

void main() {
  group('JsonListUtf8Codec', () {
    const codec = JsonListUtf8Codec<_Item>.from(
      toJson: _itemToJson,
      fromJson: _itemFromJson,
    );

    test('encodes a list as a UTF-8 JSON array', () {
      final encoded = codec.encode(const [_Item(1), _Item(2)]);

      expect(utf8.decode(encoded), '[{"value":1},{"value":2}]');
    });

    test('decodes a UTF-8 JSON array', () {
      final payload = Bytes.fromList(utf8.encode('[{"value":1},{"value":2}]'));

      expect(codec.decode(payload), const [_Item(1), _Item(2)]);
    });

    test('rejects a payload whose root is not an array', () {
      final payload = Bytes.fromList(utf8.encode('{"value":1}'));

      expect(
        () => codec.decode(payload),
        throwsA(
          isA<FormatException>().having(
            (error) => error.message,
            'message',
            'Expected JSON array payload.',
          ),
        ),
      );
    });

    test('rejects array values that are not JSON objects', () {
      final payload = Bytes.fromList(utf8.encode('[{"value":1},2]'));

      expect(
        () => codec.decode(payload),
        throwsA(
          isA<FormatException>().having(
            (error) => error.message,
            'message',
            'Expected JSON object at index 1.',
          ),
        ),
      );
    });
  });
}

class _Item {
  const _Item(this.value);

  final int value;

  @override
  bool operator ==(Object other) => other is _Item && value == other.value;

  @override
  int get hashCode => value.hashCode;
}

JsonMap _itemToJson(_Item item) => {'value': item.value};

_Item _itemFromJson(JsonMap json) => _Item(json['value']! as int);
