import 'package:grumpy/grumpy.dart';

import '../../../core/core.dart';
import '../../domain/datasources/typed_file_system_datasource.dart';
import '../../domain/models/io_path.dart';
import '../../domain/services/file_system_service.dart';

/// Default [TypedFileSystemDatasource] implementation.
class DefaultTypedFileSystemDatasource extends TypedFileSystemDatasource {
  /// Creates a datasource.
  DefaultTypedFileSystemDatasource({FileSystemService? fileSystemService})
    : _fileSystemService = fileSystemService,
      super.internal();

  final FileSystemService? _fileSystemService;

  FileSystemService get _fileSystem =>
      _fileSystemService ?? FileSystemService();

  @override
  Future<IoResult<T>> read<T>({
    required IoPath file,
    required SerializationCodec<T, Bytes> codec,
  }) async {
    final bytesResult = await _fileSystem.readBytes(file);
    return switch (bytesResult) {
      IoErr<Bytes>(failure: final failure) => IoErr<T>(failure),
      IoOk<Bytes>(value: final bytes) => _decode<T>(bytes, codec),
    };
  }

  @override
  Future<IoResult<void>> write<T>({
    required IoPath file,
    required T value,
    required SerializationCodec<T, Bytes> codec,
    bool overwrite = true,
    bool createParents = true,
  }) async {
    final encoded = _encode<T>(value, codec);
    if (encoded case IoErr<Bytes>(failure: final failure)) {
      return IoErr<void>(failure);
    }
    return _fileSystem.writeBytes(
      file,
      (encoded as IoOk<Bytes>).value,
      overwrite: overwrite,
      createParents: createParents,
    );
  }

  @override
  Future<IoResult<void>> delete(IoPath path, {bool recursive = false}) {
    return _fileSystem.delete(path, recursive: recursive);
  }

  @override
  Future<IoResult<bool>> exists(IoPath path) {
    return _fileSystem.exists(path);
  }

  IoResult<T> _decode<T>(Bytes bytes, SerializationCodec<T, Bytes> codec) {
    try {
      return IoOk<T>(codec.decode(bytes));
    } catch (error, stackTrace) {
      return IoErr<T>(
        IoFailure(
          code: IoFailureCode.invalidData,
          message: 'Failed to decode filesystem payload.',
          cause: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  IoResult<Bytes> _encode<T>(T value, SerializationCodec<T, Bytes> codec) {
    try {
      return IoOk<Bytes>(codec.encode(value));
    } catch (error, stackTrace) {
      return IoErr<Bytes>(
        IoFailure(
          code: IoFailureCode.invalidData,
          message: 'Failed to encode filesystem payload.',
          cause: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  @override
  Future<void> destroy() async {}

  @override
  String get logTag => 'DefaultTypedFileSystemDatasource';
}
