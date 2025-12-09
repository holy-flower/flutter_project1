// Helper class for Either pattern (used for error handling)
class Either<L, R> {
  final L? _left;
  final R? _right;
  final bool isLeft;

  Either._(this._left, this._right, this.isLeft);

  factory Either.left(L value) => Either._(value, null, true);
  factory Either.right(R value) => Either._(null, value, false);

  T fold<T>(T Function(L) left, T Function(R) right) {
    if (isLeft) {
      return left(_left as L);
    } else {
      return right(_right as R);
    }
  }

  bool get isRight => !isLeft;

  L get left => _left as L;
  R get right => _right as R;
}


