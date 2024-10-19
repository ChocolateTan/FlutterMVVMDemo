extension NotNull<T extends Object> on T? {
  void ifNotNull(Function(T) action) {
    if (this != null) {
      action(this!);
    }
  }
}
