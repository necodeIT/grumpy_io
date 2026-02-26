import 'package:grumpy_io/grumpy_io.dart';

/// Native file transfer implementation.
class DefaultFileTransferService extends FileTransferService {
  /// Creates a file transfer service.
  DefaultFileTransferService({
    NetworkService? networkService,
    FileSystemService? fileSystemService,
  }) : _networkService = networkService ?? NetworkService(),
       _fileSystemService = fileSystemService ?? FileSystemService(),
       super.internal();

  final NetworkService _networkService;
  final FileSystemService _fileSystemService;

  @override
  Future<IoResult<void>> download(
    Uri uri,
    IoPath destination, {
    Map<String, String>? headers,
    Map<String, String>? query,
    TransferProgressCallback? onProgress,
    NetworkCancelToken? cancelToken,
  }) async {
    final inMemory = await downloadToMemory(
      uri,
      headers: headers,
      query: query,
      onProgress: onProgress,
      cancelToken: cancelToken,
    );

    if (inMemory case IoErr<Bytes>(failure: final failure)) {
      return IoErr<void>(failure);
    }

    try {
      final result = await _fileSystemService.writeBytes(
        destination,
        inMemory.valueOrNull!,
      );

      if (result case IoErr<void>(failure: final failure)) {
        return IoErr<void>(failure);
      }

      return const IoOk<void>(null);
    } catch (error, stackTrace) {
      return IoErr<void>(
        IoFailure(
          code: IoFailureCode.unknown,
          message: 'Failed writing downloaded file.',
          cause: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  @override
  Future<IoResult<Bytes>> downloadToMemory(
    Uri uri, {
    Map<String, String>? headers,
    Map<String, String>? query,
    TransferProgressCallback? onProgress,
    NetworkCancelToken? cancelToken,
  }) async {
    final result = await _networkService.send(
      NetworkRequest(
        method: HttpMethod.get,
        uri: uri,
        headers: headers ?? const <String, String>{},
        query: query ?? const <String, String>{},
      ),
      onDownloadProgress: onProgress,
      cancelToken: cancelToken,
    );

    return switch (result) {
      IoOk<NetworkResponse>(value: final response) => IoOk<Bytes>(
        response.bodyBytes,
      ),
      IoErr<NetworkResponse>(failure: final failure) => IoErr<Bytes>(failure),
    };
  }

  @override
  Future<IoResult<void>> uploadFromMemory(
    Uri uri,
    Bytes bytes, {
    Map<String, String>? headers,
    Map<String, String>? query,
    String? contentType,
    TransferProgressCallback? onProgress,
    NetworkCancelToken? cancelToken,
  }) async {
    final result = await _networkService.send(
      NetworkRequest(
        method: HttpMethod.post,
        uri: uri,
        headers: headers ?? const <String, String>{},
        query: query ?? const <String, String>{},
        bodyBytes: bytes,
        contentType: contentType,
      ),
      onUploadProgress: onProgress,
      cancelToken: cancelToken,
    );

    return switch (result) {
      IoOk<NetworkResponse>() => const IoOk<void>(null),
      IoErr<NetworkResponse>(failure: final failure) => IoErr<void>(failure),
    };
  }

  @override
  Future<IoResult<void>> upload(
    IoPath path,
    Uri uri, {
    Map<String, String>? headers,
    Map<String, String>? query,
    String? contentType,
    TransferProgressCallback? onProgress,
    NetworkCancelToken? cancelToken,
  }) async {
    try {
      final bytes = await _fileSystemService.readBytes(path);
      if (bytes case IoErr<Bytes>(failure: final failure)) {
        return IoErr<void>(failure);
      }
      return uploadFromMemory(
        uri,
        bytes.valueOrNull!,
        headers: headers,
        query: query,
        contentType: contentType,
        onProgress: onProgress,
        cancelToken: cancelToken,
      );
    } catch (error, stackTrace) {
      return IoErr<void>(
        IoFailure(
          code: IoFailureCode.notFound,
          message: 'Unable to read upload source file.',
          cause: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  @override
  Future<void> destroy() async {}

  @override
  String get logTag => 'DefaultFileTransferService';
}

/// Creates the default [FileTransferService].
DefaultFileTransferService createDefaultFileTransferService({
  NetworkService? networkService,
}) {
  return DefaultFileTransferService(networkService: networkService);
}
