import 'package:dio/dio.dart';
import 'package:grumpy/grumpy.dart';

import 'domain/domain.dart';
import 'infra/infra.dart';
export 'domain/domain.dart';

/// A module for handling networking operations, including making HTTP requests and processing responses.
class NetworkingModule<RouteType, Config extends Object>
    extends Module<RouteType, Config> {
  @override
  String get logTag => 'NetworkingModule';

  @override
  List<Route<RouteType, Config>> get routes => [];

  @override
  void bindExternalDeps(Bind<Object, Config> bind) {
    bind<Dio>((_, _) => Dio());
  }

  @override
  void bindServices(Bind<Service, Config> bind) {
    bind<NetworkService>((_, get) => DioNetworkingService(get<Dio>()));
  }
}
