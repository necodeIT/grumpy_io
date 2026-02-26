import 'dart:async';
import 'dart:typed_data';

/// Canonical byte payload type used across network/storage/filesystem services.
typedef Bytes = Uint8List;

/// Stable, backend-agnostic failure categories used by `grumpy_io`.
enum IoFailureCode {
  /// This operation is not supported by the current platform or configuration.
  unsupported,

  /// The requested resource was not found.
  notFound,

  /// The requested resource already exists.
  alreadyExists,

  /// Insufficient permissions to perform this operation.
  permissionDenied,

  /// The operation took too long to complete.
  timeout,

  /// An error in the underlying network stack (e.g. DNS failure, connection reset, etc.).
  networkError,

  /// The data is malformed or does not conform to expected format/schema.
  invalidData,

  /// The operation was cancelled by the caller before completion.
  cancelled,

  /// An unexpected error occurred (e.g. unhandled exception, etc.).
  unknown,
}

/// A typed IO failure envelope.
class IoFailure {
  /// Creates an IO failure.
  const IoFailure({
    required this.code,
    required this.message,
    this.cause,
    this.details = const <String, Object?>{},
    this.stackTrace,
  });

  /// Failure category.
  final IoFailureCode code;

  /// Human-readable failure summary.
  final String message;

  /// Optional original cause.
  final Object? cause;

  /// Optional structured context for callers/logging.
  final Map<String, Object?> details;

  /// Optional stack trace when failure was captured.
  final StackTrace? stackTrace;

  @override
  String toString() => 'IoFailure(code: $code, message: $message)';
}

/// Functional-style result for IO operations.
sealed class IoResult<T> {
  /// Creates a result value.
  const IoResult();

  /// Returns `true` when this result is [IoOk].
  bool get isOk => this is IoOk<T>;

  /// Returns `true` when this result is [IoErr].
  bool get isErr => this is IoErr<T>;

  /// Returns [IoOk.value] or `null`.
  T? get valueOrNull => switch (this) {
    IoOk<T>(value: final value) => value,
    IoErr<T>() => null,
  };

  /// Returns [IoErr.failure] or `null`.
  IoFailure? get failureOrNull => switch (this) {
    IoOk<T>() => null,
    IoErr<T>(failure: final failure) => failure,
  };
}

/// Successful IO result.
final class IoOk<T> extends IoResult<T> {
  /// Creates a successful result carrying [value].
  const IoOk(this.value);

  /// Successful payload.
  final T value;
}

/// Failed IO result.
final class IoErr<T> extends IoResult<T> {
  /// Creates a failed result carrying [failure].
  const IoErr(this.failure);

  /// Failure payload.
  final IoFailure failure;

  /// Creates a failed result for an unsupported operation.
  const factory IoErr.unsupported([String? operation]) = _UnsupportedIoErr;
}

final class _UnsupportedIoErr<T> extends IoErr<T> {
  final String? operation;

  const _UnsupportedIoErr([this.operation])
    : super(const IoFailure(code: IoFailureCode.unsupported, message: ''));

  @override
  IoFailure get failure => IoFailure(
    code: IoFailureCode.unsupported,
    message: operation == null
        ? 'This operation is not supported by the current platform or configuration.'
        : 'The operation "$operation" is not supported by the current platform or configuration.',
  );
}
