sealed class Result<TData, TErr extends Object> {
  const Result();

  const factory Result.ok(TData data) = ResultOk;

  const factory Result.failed(TErr failure, StackTrace stackTrace) = ResultFailed;
}

final class ResultOk<TData, TErr extends Object> extends Result<TData, TErr> {
  final TData data;

  const ResultOk(this.data);
}

final class ResultFailed<TData, TErr extends Object> extends Result<TData, TErr> {
  final TErr error;
  final StackTrace stackTrace;

  const ResultFailed(this.error, this.stackTrace);
}
