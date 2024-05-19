import 'dart:io';
import 'package:flutter/services.dart';

class SystemUtils {
  static isDarkMode(bool isDark) {
    if (Platform.isAndroid || Platform.isIOS) {
      if (isDark == true) {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
      } else {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
      }
    }
  }
}
