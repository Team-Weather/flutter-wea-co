extension ListUtil<T> on List<T> {
  bool equals(List<T> other) {
    for (int i = 0; i < other.length; i++) {
      if (this[i] != other[i]) return false;
    }
    return true;
  }
}
