import 'package:grumpy/grumpy.dart';

/// Platform-neutral filesystem path wrapper.
class IoPath extends Model {
  /// Creates a path value.
  const IoPath(this.value);

  /// Raw path string.
  final String value;

  /// Converts the path to a URI.
  Uri toUri() => Uri.file(value);

  /// Creates a path from [uri].
  static IoPath fromUri(Uri uri) {
    if (!uri.hasScheme || uri.scheme == 'file') {
      return IoPath(uri.toFilePath());
    }
    return IoPath(uri.toString());
  }

  @override
  String toString() => value;

  /// Combines this path with [other] using simple string concatenation.
  IoPath operator +(Object other) => IoPath(value + other.toString());

  /// Combines this path with [other] using a path separator.
  IoPath operator /(Object other) => IoPath('$value/${other.toString()}');
}
