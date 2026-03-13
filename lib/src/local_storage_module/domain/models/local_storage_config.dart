/// A configuration class for local storage settings.
///
/// Modules importing [LocalStorageModule] must have a config extending this class to provide necessary configuration for local storage operations, such as directory and file naming conventions.
class LocalStorageConfig {
  /// The prefix used for local storage.
  ///
  /// Used for directory and file naming to avoid conflicts with other applications using the same package for local storage.
  final String localStoragePrefix;

  /// Creates a new instance of [LocalStorageConfig].
  LocalStorageConfig({required this.localStoragePrefix});
}
