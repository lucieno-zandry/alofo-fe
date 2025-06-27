int anyOfListIndex<T>(List<T> list, bool Function(T) test) {
  for (int i = 0; i < list.length; i++) {
    if (test(list[i])) {
      return i;
    }
  }
  return -1;
}
