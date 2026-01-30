extension IntExtension on int {
  String toStringAsPreFixed() {
    if (this < 10) {
      return '0$this';
    }
    return '$this';
  }
}
