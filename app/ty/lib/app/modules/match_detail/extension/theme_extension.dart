import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

/// 详情主题适配
extension ThemeExtension on ThemeData {
  // 背景
  Color get detailBackgroundColor =>
      Get.isDarkMode ? Colors.transparent : const Color.fromRGBO(248, 249, 250, 1);

  // 面板
  Color get tabPanelBackgroundColor =>
      Get.isDarkMode ? Colors.white.withOpacity(0.04) : Colors.white;

  // 面板阴影
  Color get tabPanelBoxShadowColor =>
      Get.isDarkMode ? Colors.black : Colors.black54;

  // 主tab选中
  Color get tabPanelSelectedColor =>
      Get.isDarkMode ? Colors.white.withOpacity(0.9) : const Color(0xFF303442);

  // 主tab未选中
  Color get tabPanelUnSelectedColor =>
      Get.isDarkMode ? Colors.white.withOpacity(0.9) : const Color(0xFF303442);

  // 指示器
  Color get tabIndicatorColor => Get.isDarkMode
      ? const Color.fromRGBO(18, 125, 204, 1)
      : const Color.fromRGBO(23, 156, 255, 1);

  // 次级面板
  Color get secondTabPanelBackgroundColor => Get.isDarkMode
      ? Colors.white.withOpacity(0.04)
      : Get.currentRoute == Routes.matchDetail ? Colors.white : Colors.white.withOpacity(0.7);

  // 次tab选中
  Color get secondTabPanelSelectedColor =>
      Get.isDarkMode ? Colors.white.withOpacity(0.04) : const Color(0xFFE8F5FF);

// 次tab选中字体
  Color get secondTabPanelSelectedFontColor => Get.isDarkMode
      ? const Color.fromRGBO(18, 125, 204, 1)
      : const Color(0xFF179CFF);
// 次tab选中字体
  Color get analyzeSecondTabPanelSelectedFontColor => Get.isDarkMode
      ? const Color(0xFF179CFF)
      : const Color(0xFF303442) ;
// 次tab选中字体
  Color get analyzeSecondTabPanelUnSelectedFontColor => Get.isDarkMode
      ?const Color(0xFFFFFFFF).withOpacity(0.3)
      :const Color(0xFF7981A4) ;



  // 次tab未选中字体
  Color get secondTabPanelUnSelectedFontColor =>
      Get.isDarkMode ? Colors.white.withOpacity(0.3) : const Color(0xFFAFB3C8);

  // 一键折叠按钮
  Color get foldColor => Get.isDarkMode
      ? Colors.white.withOpacity(0.03999999910593033)
      : const Color(0xFFF2F2F6);

  // 投注面板面板
  Color get betPanelBackGroundColor =>
      Get.isDarkMode ? Colors.white.withOpacity(0.04) : Colors.white;

  // 投注面板黑色字体
  Color get betPanelFontColor =>
      Get.isDarkMode ? Colors.white.withOpacity(0.9) : const Color.fromRGBO(48, 52, 66, 1);
  // 一条横线
  Color get betPanelUnderlineColor =>
      Get.isDarkMode ? Colors.white.withOpacity(0.08) : const Color(0xFFF2F2F6);

  /// 投注按钮
  // 背景
  Color get oddsButtonBackgroundColor =>
      Get.isDarkMode ? Colors.white.withOpacity(0.08) : const Color(0xffFFFFFF);

  //选中背景
  Color get oddsButtonSelectedBackgroundColor =>
      Get.isDarkMode ? Colors.white.withOpacity(0.2) : const Color(0xFFD1EBFF);

  // 选中字体颜色
  Color get oddsButtonSelectFontColor =>
      Get.isDarkMode ? Colors.white.withOpacity(0.9) : const Color(0xFF127DCC);

  // 阴影
  Color get oddsButtonShadowColor =>
      Get.isDarkMode ? Colors.transparent : const Color.fromRGBO(0, 0, 0, 0.08);

  // 名称
  Color get oddsButtonNameFontColor =>
      Get.isDarkMode ? Colors.white.withOpacity(0.5) : const Color(0xFF7981A3);

  // 赔率
  Color get oddsButtonValueFontColor =>
      Get.isDarkMode ? Colors.white.withOpacity(0.9) : const Color(0xFF303442);
  // 文章二级标题
  Color get secondFontColor =>
      Get.isDarkMode ? Colors.white.withOpacity(0.5) : const Color(0xFF7981A4);

  /// 详细比分条
  // 比分
  Color get scoreDetailColor => Get.isDarkMode
      ? const Color.fromRGBO(23, 156, 255, 1)
      : const Color(0xFFFEBE55);

  /// 下拉联赛
  Color get matchSelectBackgroundColor =>
      Get.isDarkMode ? const Color(0xFF1E2029) : Colors.white;

  // title
  Color get matchSelectTitleColor =>
      Get.isDarkMode ? Colors.white : const Color(0xFF303442);

  Color get subSelectTitleColor =>
      Get.isDarkMode ? Colors.white : const Color(0xFF7981A4);

  // 选中
  Color get matchSelectedBgColor => Get.isDarkMode
      ? Colors.white.withOpacity(0.04)
      : const Color.fromRGBO(243, 250, 255, 1);

  // 选中
  Color get resultTextColor => Get.isDarkMode
      ? Colors.white.withOpacity(0.7)
      : const Color(0xFF616783);

  // 选中
  Color get resultSecondTextColor => Get.isDarkMode
      ? Colors.white.withOpacity(0.4)
      : const Color(0xFF303442);

  // 选中
  Color get resultContainerBgColor => Get.isDarkMode
      ? Colors.white.withOpacity(0.04)
      : const Color(0x33AFAFAF);

  Color get dataContainerTextColor => Get.isDarkMode
      ? Colors.white.withOpacity(0.4)
      : const Color(0xFF949AB6);



  // 负
  Color get winResultColor => Get.isDarkMode
      ? const Color.fromRGBO(113, 200, 102, 1)
      : const Color.fromRGBO(113, 200, 102, 1);

  // 胜
  Color get loseResultColor => Get.isDarkMode
      ? const Color.fromRGBO(255, 115, 115, 1)
      : const Color.fromRGBO(255, 115, 115, 1);

  // 平
  Color get equalResultColor => Get.isDarkMode
      ? const Color.fromRGBO(90, 182, 247, 1)
      : const Color.fromRGBO(90, 182, 247, 1);



  // 展开
  Color get analsColorExpand => Get.isDarkMode
      ? const Color.fromRGBO(255, 255, 255, 0.9)
      : const Color.fromRGBO(48, 52, 66, 1);






  // 阵容tabBar文字选中颜色
  Color get analsTextTabSelectColor => Get.isDarkMode
      ? const Color.fromRGBO(255, 255, 255, 1)
      :  const Color.fromRGBO(48, 52, 66, 1);

  // 阵容tabBar文字颜色
  Color get analsTextTabUnSelectColor => Get.isDarkMode
      ? const Color.fromRGBO(255, 255, 255, 0.5)
      :  const Color.fromRGBO(121, 129, 164, 1);

  // 阵容tabBar背景色
  Color get analsTextTabBgColor => Get.isDarkMode
      ? const Color.fromRGBO(255, 255, 255, 0.08)
      :  const Color(0xFFF2F2F6);



}
