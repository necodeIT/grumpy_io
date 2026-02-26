/// Cancellation token used by network and transfer services.
abstract class NetworkCancelToken {
  /// `true` when cancellation has been requested.
  bool get isCancelled;

  /// Requests cancellation.
  void cancel([String? reason]);
}
