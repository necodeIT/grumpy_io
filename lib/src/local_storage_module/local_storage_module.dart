import 'package:grumpy/grumpy.dart';

import 'domain/domain.dart';
import 'infra/infra.dart';

export 'domain/domain.dart';
export 'infra/infra.dart';
export 'utils/utils.dart';

/// Module responsible for registering default local-storage services.
class LocalStorageModule<RouteType, Config extends Object>
    extends Module<RouteType, Config> {
  @override
  String get logTag => 'LocalStorageModule';

  @override
  List<Route<RouteType, Config>> get routes => <Route<RouteType, Config>>[];

  @override
  void bindExternalDeps(Bind<Object, Config> bind) {}

  @override
  void bindServices(Bind<Service, Config> bind) {
    bind<LocalStorageService>((_, _) => LocalStorageService());
  }

  @override
  void bindDatasources(Bind<Datasource, Config> bind) {
    bind<TypedLocalStorageDatasource>((_, get) {
      return DefaultTypedLocalStorageDatasource(
        localStorageService: get<LocalStorageService>(),
      );
    });
  }
}
