import '../../../../core/core.dart';
import '../../../domain/models/fs_metadata.dart';
import '../../../domain/models/io_path.dart';
import '../../../domain/services/file_system_service.dart';

/// Web filesystem fallback implementation.
class DefaultFileSystemService extends FileSystemService {
  /// Creates a filesystem fallback.
  DefaultFileSystemService() : super.internal();

  @override
  Future<IoResult<bool>> exists(IoPath path) async =>
      const IoErr.unsupported('file exists');

  @override
  Future<IoResult<FsMetadata>> stat(IoPath path) async =>
      const IoErr.unsupported('file stat');

  @override
  Future<IoResult<Bytes>> readBytes(IoPath file) async =>
      const IoErr.unsupported('read bytes');

  @override
  Future<IoResult<void>> writeBytes(
    IoPath file,
    Bytes bytes, {
    bool overwrite = true,
    bool createParents = true,
  }) async => const IoErr.unsupported('write bytes');

  @override
  Future<IoResult<void>> createDirectory(
    IoPath directory, {
    bool recursive = true,
  }) async => const IoErr.unsupported('create directory');

  @override
  Future<IoResult<void>> delete(IoPath path, {bool recursive = false}) async =>
      const IoErr.unsupported('delete file or directory');

  @override
  Future<IoResult<List<IoPath>>> list(
    IoPath directory, {
    bool recursive = false,
  }) async => const IoErr.unsupported('list directory');

  @override
  Future<IoResult<void>> move(
    IoPath from,
    IoPath to, {
    bool overwrite = false,
  }) async => const IoErr.unsupported('move file or directory');

  @override
  Future<IoResult<void>> copy(
    IoPath from,
    IoPath to, {
    bool overwrite = false,
  }) async => const IoErr.unsupported('copy file or directory');

  @override
  Future<void> destroy() async {}

  @override
  String get logTag => 'DefaultFileSystemService';
}
