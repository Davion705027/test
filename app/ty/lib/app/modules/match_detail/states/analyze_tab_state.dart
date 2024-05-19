import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../services/models/res/analyze_back_video_info_entity_entity_entity_entity.dart';

class AnalyzeTabState {
  /// ExtendedNestedScrollView 滚动controller
  ScrollController scrollController = ScrollController();

  /// appbar悬停标识
  RxBool appbarPinned = false.obs;
  bool isLeagueExpand = false; // 联赛选择下拉显示

  /// 头部高度 状态栏 + 置顶悬浮条 + 内容区域
  double headerHeight = 264.h;

  /// 一键收起状态：1、全展开 2、全收起 3、部分展开 1和3箭头向上
  RxInt getFewer = 1.obs;
  /// 当前一级标签页
  RxInt curMainTab = 0.obs;

  RxList<AnalyzeBackVideoInfoEntityEntityEntityEventList> analyzeList =
      <AnalyzeBackVideoInfoEntityEntityEntityEventList>[].obs;

  AnalyzeTabState() {

  }
}
