export 'domain/domain.dart';
import 'package:grumpy/grumpy.dart';

import 'domain/domain.dart';
import 'infra/infra.dart';

/// Module responsible for handling file system operations.
class FileSystemModule<RouteType, Config extends FilesSystemConfig>
    extends Module<RouteType, Config> {
  @override
  String get logTag => 'FileSystemModule';

  @override
  List<Route<RouteType, Config>> get routes => [];

  @override
  void bindExternalDeps(Bind<Object, Config> bind) {}

  @override
  void bindServices(Bind<Service, Config> bind) {}
}
