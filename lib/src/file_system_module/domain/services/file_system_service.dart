import 'dart:typed_data';

import 'package:grumpy/grumpy.dart';
import 'package:grumpy_io/grumpy_io.dart';

/// Service responsible for handling file system operations.
abstract class FileSystemService extends Service {
  @override
  String get group => '${super.group}.FileSystemService';

  /// Internal constructor for subclasses.
  FileSystemService.internal();

  /// Returns the DI-registered implementation of [FileSystemService].
  ///
  /// Shorthand for [Service.get].
  factory FileSystemService() {
    return Service.get<FileSystemService>();
  }

  FsEntity read(String path);

  Future<bool> fileExists(FsEntity file);

  Future<void> writeFile(String path, ByteData content);

  Future<void> deleteFile(FsEntity file);

  Future<void> createDirectory(String path);

  Future<void> deleteDirectory(
    DirectoryFsEntity directory, {
    bool recursive = false,
  });
}
