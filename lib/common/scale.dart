// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'dart:ui';

///全局尺寸适配
class KScale {
  // ignore: deprecated_member_use
  static MediaQueryData mediaQuery = MediaQueryData.fromWindow(window);
  static final double _width = mediaQuery.size.width;
  static final double _height = mediaQuery.size.height;
  static final double _topbarH = mediaQuery.padding.top;
  static final double _botbarH = mediaQuery.padding.bottom;
  static final double _pixelRatio = mediaQuery.devicePixelRatio;
  static var _ratio;

  //这里以375作为适配，当然还有750、
  static init(int number) {
    // ignore: unnecessary_type_check
    int uiwidth = number is int ? number : 375;
    _ratio = _width / uiwidth;
  }

  static double pxToDp(int px) {
    return px / _pixelRatio;
  }

  static px(number) {
    if (!(_ratio is double || _ratio is int)) {
      KScale.init(375);
    }
    return number * _ratio;
  }

  //一个像素
  static onepx() {
    return 1 / _pixelRatio;
  }

  static screenW() {
    return _width;
  }

  static screenH() {
    return _height;
  }

  static padTopH() {
    return _topbarH;
  }

  static padBotH() {
    return _botbarH;
  }
}
