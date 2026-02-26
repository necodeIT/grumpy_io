/// Upload/download progress payload.
class TransferProgress {
  /// Creates a progress event.
  const TransferProgress({
    required this.transferredBytes,
    required this.totalBytes,
  });

  /// Number of bytes transferred so far.
  final int transferredBytes;

  /// Total size in bytes.
  final int totalBytes;

  /// Fraction in range `0.0..1.0`.
  double get fraction {
    if (totalBytes <= 0) return 0;
    return transferredBytes / totalBytes;
  }
}

/// Callback used by upload/download operations.
typedef TransferProgressCallback = void Function(TransferProgress progress);
