import 'dart:math';

import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';

class CheckUtils {
  static final String _tag = 'CheckUtils';

/*  /// 判断是否为平板
  static Future<bool> isPad() async {
    bool result = false;
    AndroidDeviceInfo? androidInfo = await DeviceInfoPlugin().androidInfo;
    if (androidInfo != null && androidInfo.device.) {
      result = true;
    }
    print('$_tag isPad: $result');
    return result;
  }*/

  /// 判断是否为平板
  static Future<bool> isPad2(BuildContext context) async {
    bool result = false;
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenInches = _calculateScreenSize(mediaQuery.size.width, mediaQuery.size.height, mediaQuery.devicePixelRatio);
    if (screenInches >= 7.9) {
      result = true;
    }
    print('$_tag screenInches: $screenInches');
    print('$_tag isPad: $result');
    return result;
  }

  /// 判断是否为平板
  static bool isTablet(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return mediaQuery.size.shortestSide >= 1500;
  }

  /// 判断屏幕尺寸
  static double screenSize(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return _calculateScreenSize(mediaQuery.size.width, mediaQuery.size.height, mediaQuery.devicePixelRatio);
  }

  static double _calculateScreenSize(double width, double height, double pixelRatio) {
    num x = pow(width / pixelRatio / 25.4, 2);
    num y = pow(height / pixelRatio / 25.4, 2);
    return sqrt(x + y);
  }
}
