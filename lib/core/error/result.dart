import 'failures.dart';

class Result<S, F extends Failure> {
  final S? _success;
  final F? _failure;

  const Result.success(S success)
      : _success = success,
        _failure = null;

  const Result.failure(F failure)
      : _success = null,
        _failure = failure;

  bool get isSuccess => _success != null;
  bool get isFailure => _failure != null;

  S get success => _success!;
  F get failure => _failure!;

  // Fold mapper supporting both states
  R fold<R>(R Function(S success) onSuccess, R Function(F failure) onFailure) {
    if (isSuccess) {
      return onSuccess(_success as S);
    } else {
      return onFailure(_failure as F);
    }
  }
}
