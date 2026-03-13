import 'package:grumpy/grumpy.dart';

import 'domain/domain.dart';
import 'infra/infra.dart';

export 'domain/domain.dart';
export 'infra/infra.dart';

/// Provides file system capabilities.
///
/// {@macro additional_permissions_note}
class FileSystemModule<RouteType, Config extends Object>
    extends Module<RouteType, Config> {
  @override
  String get logTag => 'FileSystemModule';

  @override
  List<Route<RouteType, Config>> get routes => <Route<RouteType, Config>>[];

  /// Builder for the [FileSystemService] implementation.
  ///
  /// Defaults to [DefaultFileSystemService] for the current platform.
  ///
  /// {@template platform_support_io}
  /// **Note: Currently only supports target platforms where the `dart:io` library is available. For unsupported platforms, it will return an unsupported error.**
  /// {@endtemplate}
  ///
  /// Override to provide support for additional platforms or to customize the default implementation.
  InjectableFactory<FileSystemService, Config> get fileSystemServiceBuilder =>
      (_, _) => DefaultFileSystemService();

  /// Builder for the [TypedFileSystemDatasource] implementation.
  ///
  /// Defaults to [DefaultTypedFileSystemDatasource]. Can be overridden to provide a custom implementation that uses the [FileSystemService] or to customize the default implementation.
  InjectableFactory<TypedFileSystemDatasource, Config>
  get typedFileSystemDatasourceBuilder =>
      (cfg, get) => DefaultTypedFileSystemDatasource(
        fileSystemService: get<FileSystemService>(),
      );

  @override
  void bindServices(Bind<Service, Config> bind) {
    bind<FileSystemService>(fileSystemServiceBuilder);
  }

  @override
  void bindDatasources(Bind<Datasource, Config> bind) {
    bind<TypedFileSystemDatasource>(typedFileSystemDatasourceBuilder);
  }
}
