import 'package:grumpy/grumpy.dart';

import 'fs_entity_type.dart';
import 'io_path.dart';

/// Filesystem entity metadata.
class FsMetadata extends Model {
  /// Creates metadata.
  const FsMetadata({
    required this.path,
    required this.type,
    required this.exists,
    this.sizeBytes,
    this.createdAt,
    this.modifiedAt,
  });

  /// Entity path.
  final IoPath path;

  /// Entity type.
  final FsEntityType type;

  /// Existence flag.
  final bool exists;

  /// Optional size in bytes.
  final int? sizeBytes;

  /// Optional creation timestamp.
  final DateTime? createdAt;

  /// Optional modification timestamp.
  final DateTime? modifiedAt;
}
