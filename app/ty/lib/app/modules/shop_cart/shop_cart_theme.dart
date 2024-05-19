import 'package:flutter/material.dart';
import 'package:get/get.dart';

extension ThemeDataExtension on ThemeData {
  // 自定义颜色键
  Color get shopcartBackgroundColor =>
      Get.isDarkMode ? const Color(0XFF1E2029) : Colors.white;

  Color get shopcartContentBackgroundColor =>
      Get.isDarkMode ? Colors.white.withOpacity(0.04) : const Color(0xFFF3FAFF);

  Color get shopcartClosedContentBackgroundColor =>
      Get.isDarkMode ? Colors.white.withOpacity(0.04) : const Color(0xFFF2F2F6);

  Color get shopcartKeyboardColor =>
      Get.isDarkMode ? Colors.white.withOpacity(0.04) : Color(0xFFFFFFFF);

  Color get shopcartTextColor =>
      Get.isDarkMode ? Colors.white.withOpacity(0.9) : Color(0xFF303442);

  Color get shopcartTintColor =>
      Get.isDarkMode ? Colors.white.withOpacity(0.2) : Color(0xFFC9CDDB);

  Color get shopcartLabelColor =>
      Get.isDarkMode ? Colors.white.withOpacity(0.5) : Color(0xFF7981A3);

  Color get shopcartItemNumberBackgroundColor =>
      Get.isDarkMode ? Colors.white.withOpacity(0.04) : Color(0XFFD1EBFF);

  Color get shopcartParlayChangeBackgroundColor =>
      Get.isDarkMode ? Colors.white.withOpacity(0.04) : Color(0XFFE8F5FF);

  Color get shopcartButtonDisableBackgroundColor =>
      Get.isDarkMode ? Colors.white.withOpacity(0.2) :Color(0XFFC9CDD8) ;

  Color get shopcartDeleteButtonBackgroundColor =>
      Get.isDarkMode ? Colors.white.withOpacity(0.08) :Color(0xFFE4E6ED) ;

  Color get shopcartTipsBackgroundColor =>
      Get.isDarkMode ? const Color(0xFF1A1A1A) : const Color(0xFFF3FAFF);

  Color get shopcartCloseButtonColor =>
      Get.isDarkMode ? Colors.black.withOpacity(0.6) : Colors.white.withOpacity(0.6);

  Color get shopcartInputBorderFocusColor =>
      Get.isDarkMode ? Color(0XFF179CFF) : Color(0XFF179CFF);

  Color get shopcartInputBorderUnfocusColor =>
      Get.isDarkMode ? Colors.white.withOpacity(0.08) : Color(0xFFD1EBFF);

  Color get shopcartDividerColor =>
      Get.isDarkMode ? Colors.white.withOpacity(0.08): Color(0xFFF2F2F6);
}