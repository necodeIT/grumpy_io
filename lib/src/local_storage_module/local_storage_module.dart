import 'package:grumpy/grumpy.dart';
import 'package:grumpy_io/grumpy_io.dart';

import 'infra/infra.dart';

export 'domain/domain.dart';
export 'utils/utils.dart';

/// Provides local storage capabilities using a key-value store abstraction.
///
/// **Note: Default implementations currently rely on the [FileSystemModule]. This module excpects a [FileSystemModule] to be imported in the same or a parent module. (We do not manually import it for you in order to allow overrides of either modules).**
///
/// {@macro additional_permissions_note}
///
class LocalStorageModule<RouteType, Config extends LocalStorageConfig>
    extends Module<RouteType, Config> {
  @override
  String get logTag => 'LocalStorageModule';

  @override
  List<Route<RouteType, Config>> get routes => <Route<RouteType, Config>>[];

  /// Builder for the [LocalStorageService] implementation.
  ///
  /// Defaults to [DefaultLocalStorageService] for the current platform.
  ///
  /// {@template platform_support_web_and_io}
  /// **Note: Currently, the default implementation only supports platforms where the `dart:io` or `dart:js_interop` library is available. For unsupported platforms, it will return an unsupported error.**
  /// {@endtemplate}
  ///
  /// Override to provide support for additional platforms or to customize the default implementation.
  InjectableFactory<LocalStorageService, Config>
  get localStorageServiceBuilder =>
      (cfg, _) => DefaultLocalStorageService(cfg);

  /// Builder for the [TypedLocalStorageDatasource] implementation.
  ///
  /// Defaults to [DefaultTypedLocalStorageDatasource].
  InjectableFactory<TypedLocalStorageDatasource, Config>
  get typedLocalStorageDatasourceBuilder =>
      (cfg, get) => DefaultTypedLocalStorageDatasource(
        localStorageService: get<LocalStorageService>(),
      );

  @override
  void bindServices(Bind<Service, Config> bind) {
    bind<LocalStorageService>(localStorageServiceBuilder);
  }

  @override
  void bindDatasources(Bind<Datasource, Config> bind) {
    bind<TypedLocalStorageDatasource>(typedLocalStorageDatasourceBuilder);
  }
}
