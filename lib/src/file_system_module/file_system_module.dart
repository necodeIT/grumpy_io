import 'package:grumpy/grumpy.dart';

import 'domain/domain.dart';
import 'infra/infra.dart';

export 'domain/domain.dart';
export 'infra/infra.dart';

/// Module responsible for registering default filesystem services.
class FileSystemModule<RouteType, Config extends Object>
    extends Module<RouteType, Config> {
  @override
  String get logTag => 'FileSystemModule';

  @override
  List<Route<RouteType, Config>> get routes => <Route<RouteType, Config>>[];

  @override
  void bindExternalDeps(Bind<Object, Config> bind) {}

  @override
  void bindServices(Bind<Service, Config> bind) {
    bind<FileSystemService>((_, __) => DefaultFileSystemService());
  }

  @override
  void bindDatasources(Bind<Datasource, Config> bind) {
    bind<TypedFileSystemDatasource>((_, get) {
      return DefaultTypedFileSystemDatasource(
        fileSystemService: get<FileSystemService>(),
      );
    });
  }
}
