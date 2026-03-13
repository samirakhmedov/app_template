// ignore_for_file: prefer-match-file-name

typedef Closure<R, T> = R Function(T it);

extension LetX<T extends Object> on T {
  R let<R>(Closure<R, T> closure) {
    return closure(this);
  }

  R? run<R>(Closure<R?, T> closure) {
    return closure(this);
  }
}

extension LetNullableX<T extends Object> on T? {
  R? let<R>(Closure<R, T> closure) {
    final object = this;

    return object == null ? null : closure(object);
  }

  R? run<R>(Closure<R?, T> closure) {
    final object = this;

    return object == null ? null : closure(object);
  }
}

extension AlsoX<T extends Object?> on T {
  T also(Closure<void, T> closure) {
    closure(this);

    return this;
  }
}

extension RepeatX<T extends Object?> on T {
  Iterable<T> repeat(int times) {
    return Iterable.generate(times, (_) => this);
  }
}
