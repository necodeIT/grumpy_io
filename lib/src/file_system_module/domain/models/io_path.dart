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

  /// Equality operator that allows comparing [IoPath] instances with each other and with strings.
  /// If [other] is a string, it compares it with the [value] of this [IoPath]. If [other] is an [IoPath], it compares their [value]s.
  ///
  /// Otherwise returns false.
  ///
  /// Example:
  /// ```dart
  /// final path = IoPath('test');
  /// print(path == 'test'); // true
  /// print(path == IoPath('test')); // true
  /// print(path == 'other'); // false
  /// print(path == IoPath('other')); // false
  /// print(path == 123); // false
  /// ```
  @override
  bool operator ==(Object other) {
    if (other is String) {
      return value == other;
    }

    return identical(this, other) ||
        other is IoPath &&
            runtimeType == other.runtimeType &&
            value == other.value;
  }

  @override
  int get hashCode => value.hashCode;
}
