/// Type of filesystem entity.
enum FsEntityType {
  /// Regular file entity.
  file,

  /// Directory entity.
  directory,

  /// Symbolic link entity.
  symlink,

  /// Unknown or unsupported entity type.
  unknown,
}
