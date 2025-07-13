/// Extension for [Iterable].
extension IterableX<T> on Iterable<T> {
  /// Separates elements of the list with a separator.
  Iterable<T> separated(T separator) sync* {
    var ind = 0;

    final iterator = this.iterator;

    while (iterator.moveNext()) {
      yield iterator.current;

      if (ind != length - 1) {
        yield separator;
      }

      ind += 1;
    }
  }
}
