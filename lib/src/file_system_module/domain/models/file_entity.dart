import 'dart:typed_data';

import 'package:grumpy/grumpy.dart';

/// A base class representing a file system entity, which can be either a file or a directory. It contains common properties such as name, path, creation date, and modification date.
abstract class FsEntity implements Model {
  /// The name of the file system entity, which is typically the last segment of the path.
  final String name;

  /// The full path of the file system entity, which includes the directory structure leading to it.
  final String path;

  /// The date and time when the file system entity was created.
  final DateTime createdAt;

  /// The date and time when the file system entity was last modified.
  final DateTime modifiedAt;

  const FsEntity({
    required this.name,
    required this.path,
    required this.createdAt,
    required this.modifiedAt,
  });

  bool get isFile => this is FileFsEntity;
  bool get isDirectory => this is DirectoryFsEntity;

  FileFsEntity asFile() {
    if (this is FileFsEntity) {
      return this as FileFsEntity;
    } else {
      throw Exception('This entity is not a file');
    }
  }

  DirectoryFsEntity asDirectory() {
    if (this is DirectoryFsEntity) {
      return this as DirectoryFsEntity;
    } else {
      throw Exception('This entity is not a directory');
    }
  }
}

class FileFsEntity extends FsEntity {
  final int size;
  final String? mimeType;
  final ByteData? content;

  const FileFsEntity({
    required super.name,
    required super.path,
    required super.createdAt,
    required super.modifiedAt,
    required this.size,
    this.mimeType,
    this.content,
  });
}

class DirectoryFsEntity extends FsEntity {
  final List<FsEntity> children;

  const DirectoryFsEntity({
    required super.name,
    required super.path,
    required super.createdAt,
    required super.modifiedAt,
    this.children = const [],
  });

  bool get isEmpty => children.isEmpty;

  bool get isNotEmpty => children.isNotEmpty;
}

class GhostFsEntity extends FsEntity {
  const GhostFsEntity({required super.name, required super.path})
    : super(
        createdAt: DateTime.,
        modifiedAt: DateTime.fromMillisecondsSinceEpoch(0),
      );

  @override
  DateTime get createdAt =>
      throw UnimplementedError('GhostFsEntity does not have a creation date');

  @override
  DateTime get modifiedAt => throw UnimplementedError(
    'GhostFsEntity does not have a modification date',
  );
}
