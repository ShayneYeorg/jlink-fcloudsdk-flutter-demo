class TimeMillisUtil {
  static int timMillis = 0; //时间戳
  static int counter = 0; //计数器

  /// 获取计数器
  ///
  /// @return
  static String getCounter() {
    ++counter;
    if (counter < 10) {
      return "000000$counter";
    } else if (counter < 100) {
      return "00000$counter";
    } else if (counter < 1000) {
      return "0000$counter";
    } else if (counter < 10000) {
      return "000$counter";
    } else if (counter < 100000) {
      return "00$counter";
    } else if (counter < 1000000) {
      return "0$counter";
    } else if (counter < 10000000) {
      return '$counter';
    } else {
      counter = 1;
      return "000000$counter";
    }
  }

  /// 获取组合时间戳
  ///
  /// @return
  static String getTimMillis() {
    timMillis = DateTime.now().millisecondsSinceEpoch;
    return '${getCounter()}$timMillis';
  }
}
