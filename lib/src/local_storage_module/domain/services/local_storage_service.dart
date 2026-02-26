import 'package:grumpy/grumpy.dart';
import 'package:grumpy_io/grumpy_io.dart';

/// Storage service for binary values keyed by [StorageKey].
abstract class LocalStorageService extends Service {
  /// Creates a local storage service.
  const LocalStorageService.internal() : super();

  /// Returns the DI-registered implementation.
  factory LocalStorageService() => Service.get<LocalStorageService>();

  /// Returns the value for [key] or `null` on miss.
  Future<IoResult<LocalStorageValue?>> get(StorageKey key);

  /// Stores [value].
  Future<IoResult<void>> put(LocalStorageValue value);

  /// Removes [key].
  Future<IoResult<void>> remove(StorageKey key);

  /// Clears all values under [namespace].
  Future<IoResult<void>> clearNamespace(String namespace);

  /// Lists all values under [namespace] with optional [prefix] filtering.
  ///
  /// If [namespace] is not provided, values from all namespaces will be included in the results.
  /// If [prefix] is provided, only keys starting with [prefix] will be included in the results.
  Future<IoResult<List<LocalStorageValue>>> list({
    String? namespace,
    String? prefix,
  });

  @override
  String get group => '${super.group}.LocalStorageService';

  @override
  bool get singelton => true;
}
