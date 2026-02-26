import 'package:dio/dio.dart';
import 'package:grumpy/grumpy.dart';

import '../file_system_module/domain/services/file_system_service.dart';
import '../file_system_module/infra/services/file_system/default_file_system_service.dart';
import '../grumpy_compat/domain/models/grumpy_io_config.dart';
import '../local_storage_module/domain/services/local_storage_service.dart';
import '../local_storage_module/domain/datasources/typed_local_storage_datasource.dart';
import '../local_storage_module/infra/datasources/default_typed_local_storage_datasource.dart';
import '../local_storage_module/infra/services/local_storage/default_local_storage_service.dart';
import '../networking_module/domain/services/file_transfer_service.dart';
import '../networking_module/domain/services/network_service.dart';
import '../networking_module/domain/datasources/typed_network_datasource.dart';
import '../networking_module/infra/datasources/default_typed_network_datasource.dart';
import '../networking_module/infra/services/dio_file_transfer_service.dart';
import '../networking_module/infra/services/dio_network_service.dart';
import '../file_system_module/domain/datasources/typed_file_system_datasource.dart';
import '../file_system_module/infra/datasources/default_typed_file_system_datasource.dart';

/// Module wiring raw and typed IO services.
class GrumpyIoModule<RouteType, Config extends GrumpyIoConfig>
    extends Module<RouteType, Config> {
  @override
  String get logTag => 'GrumpyIoModule';

  @override
  List<Route<RouteType, Config>> get routes => <Route<RouteType, Config>>[];

  @override
  void bindExternalDeps(Bind<Object, Config> bind) {
    bind<Dio>((_, _) => Dio());
  }

  @override
  void bindServices(Bind<Service, Config> bind) {
    bind<NetworkService>((cfg, get) {
      return cfg.networkServiceFactory?.call() ??
          createDefaultNetworkService(dio: get<Dio>());
    });

    bind<FileTransferService>((cfg, get) {
      final network = get<NetworkService>();
      return cfg.fileTransferServiceFactory?.call(network) ??
          DefaultFileTransferService(networkService: network);
    });

    bind<FileSystemService>((cfg, _) {
      return cfg.fileSystemServiceFactory?.call() ?? DefaultFileSystemService();
    });

    bind<LocalStorageService>((cfg, _) {
      return cfg.localStorageServiceFactory?.call() ??
          DefaultLocalStorageService();
    });
  }

  @override
  void bindDatasources(Bind<Datasource, Config> bind) {
    bind<TypedNetworkDatasource>((cfg, get) {
      return DefaultTypedNetworkDatasource(
        networkService: get<NetworkService>(),
      );
    });
    bind<TypedFileSystemDatasource>((cfg, get) {
      return DefaultTypedFileSystemDatasource(
        fileSystemService: get<FileSystemService>(),
      );
    });
    bind<TypedLocalStorageDatasource>((cfg, get) {
      return DefaultTypedLocalStorageDatasource(
        localStorageService: get<LocalStorageService>(),
      );
    });
  }
}
