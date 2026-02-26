import 'package:grumpy/grumpy.dart';

import '../../../core/core.dart';
import '../../../file_system_module/domain/models/io_path.dart';
import '../models/transfer_progress.dart';
import 'network_cancel_token.dart';

/// Service for large binary uploads/downloads.
abstract class FileTransferService extends Service {
  /// Creates a transfer service.
  FileTransferService.internal() : super();

  /// Returns the DI-registered implementation.
  factory FileTransferService() => Service.get<FileTransferService>();

  /// Downloads [uri] to [destination].
  Future<IoResult<void>> download(
    Uri uri,
    IoPath destination, {
    Map<String, String>? headers,
    Map<String, String>? query,
    TransferProgressCallback? onProgress,
    NetworkCancelToken? cancelToken,
  });

  /// Downloads [uri] into memory.
  Future<IoResult<Bytes>> downloadToMemory(
    Uri uri, {
    Map<String, String>? headers,
    Map<String, String>? query,
    TransferProgressCallback? onProgress,
    NetworkCancelToken? cancelToken,
  });

  /// Uploads [bytes] to [uri].
  Future<IoResult<void>> uploadFromMemory(
    Uri uri,
    Bytes bytes, {
    Map<String, String>? headers,
    Map<String, String>? query,
    String? contentType,
    TransferProgressCallback? onProgress,
    NetworkCancelToken? cancelToken,
  });

  /// Uploads file [path] to [uri].
  Future<IoResult<void>> upload(
    IoPath path,
    Uri uri, {
    Map<String, String>? headers,
    Map<String, String>? query,
    String? contentType,
    TransferProgressCallback? onProgress,
    NetworkCancelToken? cancelToken,
  });

  @override
  String get group => '${super.group}.FileTransferService';

  @override
  bool get singelton => true;
}
