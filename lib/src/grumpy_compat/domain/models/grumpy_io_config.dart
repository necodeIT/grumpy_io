import '../../../file_system_module/domain/services/file_system_service.dart';
import '../../../local_storage_module/domain/services/local_storage_service.dart';
import '../../../networking_module/domain/services/file_transfer_service.dart';
import '../../../networking_module/domain/services/network_service.dart';

/// Optional dependency overrides for `grumpy_io` service wiring.
class GrumpyIoConfig {
  /// Creates configuration.
  const GrumpyIoConfig({
    this.networkServiceFactory,
    this.fileTransferServiceFactory,
    this.fileSystemServiceFactory,
    this.localStorageServiceFactory,
    this.enableCachePersistenceAdapters = true,
    required this.localStoragePrefix,
  });

  /// Optional network service factory override.
  final NetworkService Function()? networkServiceFactory;

  /// Optional transfer service factory override.
  final FileTransferService Function(NetworkService network)?
  fileTransferServiceFactory;

  /// Optional filesystem service factory override.
  final FileSystemService Function()? fileSystemServiceFactory;

  /// Optional local storage service factory override.
  final LocalStorageService Function()? localStorageServiceFactory;

  /// Enables cache/persistence service overrides in root-module mixin.
  final bool enableCachePersistenceAdapters;

  /// Prefix for local storage keys to avoid conflicts with other apps.
  ///
  /// Used as a directory name on file-based implementations and as a key prefix on key-value stores.
  final String localStoragePrefix;
}
