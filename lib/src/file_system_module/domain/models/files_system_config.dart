import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:grumpy/grumpy.dart';

part 'files_system_config.freezed.dart';
part 'files_system_config.g.dart';

/// Configuration for the file system module, containing the platform information to determine the appropriate file system implementation.
@freezed
abstract class FilesSystemConfig with _$FilesSystemConfig implements Model {
  /// Configuration for the file system module, containing the platform information to determine the appropriate file system implementation.
  const factory FilesSystemConfig({
    /// The platform the system is running on. This is required to determine the appropriate file system implementation.
    required StoragePlatform platform,
  }) = _FilesSystemConfig;

  /// Creates a [FilesSystemConfig] instance from a JSON map.
  factory FilesSystemConfig.fromJson(Map<String, Object?> json) =>
      _$FilesSystemConfigFromJson(json);
}

/// An enumeration of supported platforms for the file system module.
enum StoragePlatform {
  /// The Android platform.
  android,

  /// The iOS platform.
  ios,

  /// Any Linux distribution.
  linux,

  /// The macOS platform.
  macos,

  /// The Windows platform.
  windows,

  /// The Web platform.
  web,
}
