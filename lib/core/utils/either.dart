sealed class Either<L, R> {
  const Either();
  
  T fold<T>(T Function(L left) onLeft, T Function(R right) onRight);
  
  bool get isLeft => this is Left<L, R>;
  bool get isRight => this is Right<L, R>;
  
  L? get left => isLeft ? (this as Left<L, R>).value : null;
  R? get right => isRight ? (this as Right<L, R>).value : null;
}

class Left<L, R> extends Either<L, R> {
  final L value;
  
  const Left(this.value);
  
  @override
  T fold<T>(T Function(L left) onLeft, T Function(R right) onRight) {
    return onLeft(value);
  }
}

class Right<L, R> extends Either<L, R> {
  final R value;
  
  const Right(this.value);
  
  @override
  T fold<T>(T Function(L left) onLeft, T Function(R right) onRight) {
    return onRight(value);
  }
}

extension EitherExtension<L, R> on Either<L, R> {
  Either<L, R2> map<R2>(R2 Function(R right) mapper) {
    return fold(
      (left) => Left<L, R2>(left),
      (right) => Right<L, R2>(mapper(right)),
    );
  }
}

// Топ-уровневые функции для создания Either
Either<L, R> left<L, R>(L value) => Left<L, R>(value);
Either<L, R> right<L, R>(R value) => Right<L, R>(value);


