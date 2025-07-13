/// {@template result.class}
/// Result of a function execution.
///
/// [Result.ok] - named constructor for a successful Result - [Result].
///
/// [Result.failed] - named constructor for Result with error - [ResultFailed].
/// {@endtemplate}
sealed class Result<TData, TErr extends Object> {
  /// {@macro result.class}
  const Result();

  /// {@macro result.class}
  const factory Result.ok(TData data) = ResultOk;

  /// {@macro result.class}
  const factory Result.failed(TErr failure, StackTrace stackTrace) = ResultFailed;
}

/// {@macro result.class}
final class ResultOk<TData, TErr extends Object> extends Result<TData, TErr> {
  /// Successful Result data.
  final TData data;

  /// {@macro result.class}
  const ResultOk(this.data);
}

/// {@macro result.class}
final class ResultFailed<TData, TErr extends Object> extends Result<TData, TErr> {
  /// Error.
  final TErr error;

  /// Stack Trace.
  final StackTrace stackTrace;

  /// {@macro result.class}
  const ResultFailed(this.error, this.stackTrace);
}
