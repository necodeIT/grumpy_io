// Class name must be the same across all platform files
// ignore_for_file: base_class_wrong_file_name

import 'dart:async';

import 'package:grumpy_io/grumpy_io.dart';
import 'package:grumpy/grumpy.dart';

/// Default noop local storage service implementation for unsupported platforms.
class DefaultLocalStorageService extends LocalStorageService {
  /// Default noop local storage service implementation for unsupported platforms.
  const DefaultLocalStorageService() : super.internal();

  @override
  Future<IoResult<void>> clearNamespace(String namespace) async =>
      const IoErr<void>.unsupported('clear namespace in local storage');

  @override
  FutureOr<void> destroy() {}

  @override
  Future<IoResult<LocalStorageValue?>> get(StorageKey key) async =>
      const IoErr<LocalStorageValue?>.unsupported('get from local storage');

  @override
  Future<IoResult<List<LocalStorageValue>>> list({
    String? namespace,
    String? prefix,
  }) async => const IoErr<List<LocalStorageValue>>.unsupported(
    'list from local storage',
  );

  @override
  Future<IoResult<void>> put(LocalStorageValue value) async =>
      const IoErr<void>.unsupported('put to local storage');

  @override
  Future<IoResult<void>> remove(StorageKey key) async =>
      const IoErr<void>.unsupported('remove from local storage');
  @override
  String get logTag => 'DefaultLocalStorageService';
}
