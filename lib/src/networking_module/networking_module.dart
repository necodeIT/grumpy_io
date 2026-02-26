import 'package:dio/dio.dart';
import 'package:grumpy/grumpy.dart';

import 'domain/domain.dart';
import 'infra/infra.dart';

export 'domain/domain.dart';
export 'infra/infra.dart';

/// Module responsible for registering default networking services.
class NetworkingModule<RouteType, Config extends Object>
    extends Module<RouteType, Config> {
  @override
  String get logTag => 'NetworkingModule';

  @override
  List<Route<RouteType, Config>> get routes => <Route<RouteType, Config>>[];

  @override
  void bindExternalDeps(Bind<Object, Config> bind) {
    bind<Dio>((_, _) => Dio());
  }

  @override
  void bindServices(Bind<Service, Config> bind) {
    bind<NetworkService>((_, get) {
      return createDefaultNetworkService(dio: get<Dio>());
    });
    bind<FileTransferService>((_, get) {
      return DefaultFileTransferService(networkService: get<NetworkService>());
    });
  }

  @override
  void bindDatasources(Bind<Datasource, Config> bind) {
    bind<TypedNetworkDatasource>((_, get) {
      return DefaultTypedNetworkDatasource(
        networkService: get<NetworkService>(),
      );
    });
  }
}
