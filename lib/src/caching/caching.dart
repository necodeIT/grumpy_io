import 'package:grumpy/grumpy.dart';
import 'package:grumpy_io/grumpy_io.dart';

export 'utils/utils.dart';
import 'infra/infra.dart';

/// Provides caching capabilities using local storage as the underlying mechanism for the file cache layer and an in-memory map for the memory cache layer.
///
/// Usage:
///
/// ```dart
/// class MyModule extends RootModule with GrumpyIoCache {
///   // ...
/// }
/// ```
///
/// It's that easy! By mixing in [GrumpyIoCache], your module will automatically use the provided implementations for both the memory cache layer and the file cache layer, allowing you to leverage caching in your application without any additional setup.
///
/// {@macro additional_permissions_note}
mixin GrumpyIoCache<RouteType, Config extends LocalStorageConfig>
    on RootModule<RouteType, Config> {
  @override
  InjectableFactory<MemoryCacheLayerService, LocalStorageConfig>
  get memoryCacheLayerServiceBuilder =>
      (_, _) => GrumpyIoMemoryCacheLayerService();

  @override
  InjectableFactory<FileCacheLayerService, LocalStorageConfig>?
  get fileCacheLayerServiceBuilder =>
      (_, _) => GrumpyIoFileCacheLayerService();
}
