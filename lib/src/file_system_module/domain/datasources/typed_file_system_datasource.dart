import 'package:grumpy/grumpy.dart';
import 'package:grumpy_io/grumpy_io.dart';

/// Typed filesystem datasource abstraction.
abstract class TypedFileSystemDatasource extends TypedDatasource {
  /// Creates a datasource.
  const TypedFileSystemDatasource.internal() : super.internal();

  /// Returns the DI-registered implementation.
  factory TypedFileSystemDatasource() =>
      Datasource.get<TypedFileSystemDatasource>();

  /// Reads file and decodes bytes into `T`.
  Future<IoResult<T>> read<T>({
    required IoPath file,
    required SerializationCodec<T, Bytes> codec,
  });

  /// Encodes and writes `T` to [file].
  Future<IoResult<void>> write<T>({
    required IoPath file,
    required T value,
    required SerializationCodec<T, Bytes> codec,
    bool overwrite = true,
    bool createParents = true,
  });

  /// Deletes [path].
  Future<IoResult<void>> delete(IoPath path, {bool recursive = false});

  /// Returns whether [path] exists.
  Future<IoResult<bool>> exists(IoPath path);
  @override
  String get group => '${super.group}.TypedFileSystemDatasource';

  @override
  bool get singelton => true;
}
