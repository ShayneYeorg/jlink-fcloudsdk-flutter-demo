// ignore_for_file: file_names

import 'dart:async';
///计时器
class Countdown {
  int count;
  bool isCounting = false;
  Timer? timer;

  Countdown({required this.count});

  void starCount({required Function() onCount,required Function() onEnd}) {
    if (isCounting == false) {
      isCounting = true;
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (count > 0) {
          count--;
          onCount();
        } else {
          stop();
          onEnd();
        }
      });
    }
  }

  void stop() {
    if (isCounting) {
      timer?.cancel();
      timer = null;
      isCounting = false;
    }
  }
}