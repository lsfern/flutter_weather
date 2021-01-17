import 'package:flutter/material.dart';

class Util {
  /// 当前亮度模式
  static Brightness getAppBrightness(BuildContext context) {
    return MediaQuery.of(context).platformBrightness;
  }
}
