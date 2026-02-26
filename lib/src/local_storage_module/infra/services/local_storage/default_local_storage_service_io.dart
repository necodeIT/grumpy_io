import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:grumpy/grumpy.dart';
import 'package:grumpy_io/grumpy_io.dart';
import 'package:crypto/crypto.dart';

/// Default local storage service implementation for desktop platforms.
class DefaultLocalStorageService extends LocalStorageService {
  /// Default local storage service implementation for desktop platforms.
  DefaultLocalStorageService() : super.internal();

  /// The configuration for the local storage service.
  GrumpyIoConfig get config => RootModule.getConfig<GrumpyIoConfig>();

  final LocalStorageValueCodec _codec = LocalStorageValueCodec();

  IoPath? _storagePath;

  /// The folder path where local storage values are stored.
  IoPath get storagePath {
    if (_storagePath != null) {
      return _storagePath!;
    }
    if (Platform.isWindows) {
      final base = Platform.environment['APPDATA'];
      if (base == null) {
        throw StateError('APPDATA not set');
      }
      return _storagePath = IoPath('$base\\${config.localStoragePrefix}');
    }

    if (Platform.isMacOS) {
      final home = Platform.environment['HOME'];
      if (home == null) {
        throw StateError('HOME not set');
      }
      return _storagePath = IoPath(
        '$home/Library/Application Support/${config.localStoragePrefix}',
      );
    }

    // Linux / BSD / others
    final home = Platform.environment['HOME'];
    if (home == null) {
      throw StateError('HOME not set');
    }
    final xdg = Platform.environment['XDG_DATA_HOME'];
    return _storagePath = IoPath(
      '${xdg ?? '$home/.local/share'}/${config.localStoragePrefix}',
    );
  }

  /// Converts a [StorageKey] to a safe file name.
  IoPath pathFromKey(StorageKey key) {
    final digest = sha256.convert(utf8.encode(key.asStorageKey())).bytes;
    final b64 = base64UrlEncode(digest).replaceAll('=', '');
    return storagePath / 'sk_$b64';
  }

  final _fileSystemService = FileSystemService();

  @override
  Future<IoResult<void>> clearNamespace(String namespace) async {
    final files = await list(namespace: namespace);

    if (files case IoErr<List<LocalStorageValue>>(failure: final failure)) {
      return IoErr<int>(failure);
    }

    final List<Future<IoResult<void>>> removals = [];

    for (final file in files.valueOrNull ?? <LocalStorageValue>[]) {
      removals.add(remove(file.key));
    }

    await Future.wait(removals);

    return const IoOk<void>(null);
  }

  @override
  FutureOr<void> destroy() {}

  @override
  Future<IoResult<LocalStorageValue?>> get(StorageKey key) async {
    final path = pathFromKey(key);

    final exists = await _fileSystemService.exists(path);
    if (exists case IoErr<bool>(failure: final failure)) {
      return IoErr<LocalStorageValue?>(failure);
    }
    if (exists case IoOk<bool>(value: false)) {
      return const IoOk<LocalStorageValue?>(null);
    }

    final read = await _fileSystemService.readBytes(path);
    return switch (read) {
      IoErr<Bytes>(failure: final failure) => IoErr<LocalStorageValue?>(
        failure,
      ),
      IoOk<Bytes>(value: final bytes) => IoOk<LocalStorageValue?>(
        _codec.decode(bytes),
      ),
    };
  }

  @override
  Future<IoResult<List<LocalStorageValue>>> list({
    String? namespace,
    String? prefix,
  }) async {
    final files = await _fileSystemService.list(storagePath);

    if (files case IoErr<List<IoPath>>(failure: final failure)) {
      return IoErr<List<LocalStorageValue>>(failure);
    }

    final reads = (files.valueOrNull ?? [])
        .map((f) => _fileSystemService.readBytes(f))
        .toList();

    final results = await Future.wait(reads);

    final List<LocalStorageValue> values = [];

    for (final result in results) {
      if (result case IoErr<Bytes>(failure: final failure)) {
        log('Failed to read a local storage file: $failure');
        continue;
      }

      final value = _codec.decode(result.valueOrNull!);
      if (namespace != null && value.key.namespace != namespace) {
        continue;
      }
      if (prefix != null && !value.key.primaryKey.startsWith(prefix)) {
        continue;
      }
      values.add(value);
    }

    return IoOk<List<LocalStorageValue>>(values);
  }

  @override
  String get logTag => 'DefaultLocalStorageService';

  @override
  Future<IoResult<void>> put(LocalStorageValue value) async {
    return _fileSystemService.writeBytes(
      pathFromKey(value.key),
      _codec.encode(value),
    );
  }

  @override
  Future<IoResult<void>> remove(StorageKey key) async {
    return _fileSystemService.delete(pathFromKey(key));
  }
}
