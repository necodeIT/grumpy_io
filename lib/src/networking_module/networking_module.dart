import 'package:dio/dio.dart';
import 'package:grumpy/grumpy.dart';

import 'domain/domain.dart';
import 'infra/infra.dart';

export 'domain/domain.dart';

/// Provides networking capabilities.
///
/// {@template additional_permissions_note}
/// **Note: You might have to enable additional permissions on certain platforms (e.g., Android, iOS) for this module to work as expected.**
/// {@endtemplate}
class NetworkingModule<RouteType, Config extends Object>
    extends Module<RouteType, Config> {
  @override
  String get logTag => 'NetworkingModule';

  @override
  List<Route<RouteType, Config>> get routes => <Route<RouteType, Config>>[];

  /// Builder for the [Dio] instance used by the default [DioNetworkService] implementation.
  ///
  /// Defaults to a new [Dio] instance with default options.
  ///
  /// Override to provide a custom configured [Dio] instance for the default implementation.
  InjectableFactory<Dio, Config> get dioBuilder =>
      (_, _) => Dio();

  /// Builder for the [NetworkService] implementation.
  ///
  /// Defaults to a [DioNetworkService] using a default [Dio] instance.
  ///
  /// Override to provide a custom implementation.
  ///
  /// To customize the [Dio] instance used by the default implementation, override [dioBuilder]
  InjectableFactory<NetworkService, Config> get networkServiceBuilder =>
      (_, get) => DioNetworkService(dio: get<Dio>());

  /// Builder for the [TypedNetworkDatasource] implementation.
  ///
  /// Defaults to a [DefaultTypedNetworkDatasource] using the currently registered [NetworkService].
  ///
  /// Override to provide a custom implementation.
  ///
  /// To change the [NetworkService] used by the default implementation, override [networkServiceBuilder].
  InjectableFactory<TypedNetworkDatasource, Config>
  get typedNetworkDatasourceBuilder =>
      (cfg, get) =>
          DefaultTypedNetworkDatasource(networkService: get<NetworkService>());

  /// Builder for the [FileTransferService] implementation.
  ///
  /// Defaults to a [DioFileTransferService] backed by [Dio].
  ///
  /// Override to provide a custom implementation.
  ///
  /// To customize the [Dio] instance used by the default implementation, override [dioBuilder]
  InjectableFactory<FileTransferService, Config>
  get fileTransferServiceBuilder =>
      (cfg, get) =>
          DioFileTransferService(networkService: get<NetworkService>());

  @override
  void bindExternalDeps(Bind<Object, Config> bind) {
    bind<Dio>(dioBuilder);
  }

  @override
  void bindServices(Bind<Service, Config> bind) {
    bind<NetworkService>(networkServiceBuilder);
    bind<FileTransferService>(fileTransferServiceBuilder);
  }

  @override
  void bindDatasources(Bind<Datasource, Config> bind) {
    bind<TypedNetworkDatasource>(typedNetworkDatasourceBuilder);
  }
}
