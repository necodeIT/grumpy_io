import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:grumpy/grumpy.dart';
import 'package:grumpy_io/grumpy_io.dart';

import 'package:web/web.dart' as web;

/// Default local storage service implementation for web.
class DefaultLocalStorageService extends LocalStorageService {
  /// Default local storage service implementation for web.
  const DefaultLocalStorageService() : super.internal();

  /// The codec used to encode and decode local storage values.
  final codec = const LocalStorageValueStringCodec();

  /// Converts a [StorageKey] to a safe javascript localStorage key.
  String keyToJs(StorageKey key) {
    final digest = sha256
        .convert(utf8.encode(key.asStorageKey()))
        .bytes; // 32 bytes
    final b64 = base64UrlEncode(digest).replaceAll('=', ''); // 43 chars
    return 'sk_$b64';
  }

  @override
  Future<IoResult<void>> clearNamespace(String namespace) async {
    final files = await list(namespace: namespace);

    if (files case IoErr<List<StorageKey>>(failure: final failure)) {
      return IoErr<void>(failure);
    }

    final removals = <Future<IoResult<void>>>[];
    for (final file in files.valueOrNull!) {
      removals.add(remove(file.key));
    }

    await Future.wait(removals);

    return const IoOk(null);
  }

  @override
  FutureOr<void> destroy() {}

  @override
  Future<IoResult<LocalStorageValue?>> get(StorageKey key) async {
    final result = web.window.localStorage.getItem(keyToJs(key));

    return IoOk(result == null ? null : codec.decode(result));
  }

  @override
  Future<IoResult<List<LocalStorageValue>>> list({
    String? namespace,
    String? prefix,
  }) async {
    int idx = 0;

    final List<LocalStorageValue> values = [];

    while (true) {
      final key = web.window.localStorage.key(idx);
      if (key == null) {
        break;
      }

      final blob = web.window.localStorage.getItem(key);

      if (blob == null) {
        idx++;
        continue;
      }

      final value = codec.decode(blob);

      if (namespace != null && value.key.namespace != namespace) {
        idx++;
        continue;
      }

      if (prefix != null && !value.key.primaryKey.startsWith(prefix)) {
        idx++;
        continue;
      }

      values.add(value);
      idx++;
    }

    return IoOk(values);
  }

  @override
  String get logTag => 'DefaultLocalStorageService';

  @override
  Future<IoResult<void>> put(LocalStorageValue value) async {
    web.window.localStorage.setItem(keyToJs(value.key), codec.encode(value));

    return const IoOk(null);
  }

  @override
  Future<IoResult<void>> remove(StorageKey key) async {
    web.window.localStorage.removeItem(keyToJs(key));

    return const IoOk(null);
  }
}
