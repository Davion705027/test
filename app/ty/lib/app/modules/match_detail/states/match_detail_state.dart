import 'dart:async';
// import 'package:animated_scroll_view/animated_scroll_view.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gif/gif.dart';
import 'package:rxdart/subjects.dart';
import '../../../../generated/locales.g.dart';
import '../../../services/models/res/category_list_entity.dart';
import '../../../services/models/res/match_entity.dart';
import '../../../services/models/res/vr_hot_entity.dart';
import '../constant/detail_constant.dart';
import '../models/header_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/request_status.dart';

class MatchDetailState {
  MatchEntity? match; // Rx<MatchEntity?>(null);

  /// 下拉联赛赛事数据
  List<MatchEntity> matchListData = [];

  /// ExtendedNestedScrollView 滚动controller
  ScrollController scrollController = ScrollController();

  /// appbar悬停标识
  RxBool appbarPinned = false.obs;

  /// 赛事选择下拉标识
  RxBool isMatchSelectExpand = false.obs;

  /// 视频说明打开标识
  RxBool isOpenVideoInfo = false.obs;

  /// 头部状态 通用、视频、动画
  Rx<HeaderType> headerType = HeaderType.normal.obs;

  /// 当前一级标签页
  RxInt curMainTab = 0.obs;

  String mId = "";
  String csid = "";

  bool isDJDetail = false;

  /// 全屏标识
  RxBool fullscreen = false.obs;

  /// 详情loading
  bool detailLoading = true;

  /// 控制视频动画遮盖文字显示
  RxBool videoTopShow = false.obs;

  /// 遮盖文字持久化
  bool topShowPermanent = false;

  /// 视频动画loading
  RxBool liveLoading = true.obs;

  /// 视频直播url
  String videoUrl = "";

  /// 动画直播url
  String animationUrl = "";

  /// 直播回放url
  String replayUrl = "";

  /// 选择的清晰度 0 标清 1高清
  RxInt selectLine = 0.obs;

  /// 视频直播声音
  RxBool liveMuted = false.obs;

  /// 投注原始数据
  List<MatchHps> oddsInfoList = [];

  // 筛选的列表
  List<dynamic> filterOddsInfoList = [];

  bool hasHotName = false;

  /// vr热门投注
  VrHotEntity? vrHotEntity;

  // vr体育锁盘状态
  bool vrLockStatus = false;

  /// 投注请求状态RequestStatus
  RequestStatus oddsInfoRequestStatus = RequestStatus.loading;

  int oddsInfoRequestCount = 0;

  /// 当前选中玩法集 0所有投注
  String curCategoryTabId = "0";

  /// 玩法集
  List<CategoryListData> categoryList = [
    CategoryListData.fromJson(
        {"id": "0", "marketName": "所有投注", "orderNo": -2147483648})
  ];

  /// 一键收起状态：1、全展开 2、全收起 3、部分展开  1和3箭头向下
  RxInt getFewer = 3.obs;

  /// 折叠动画控制
  bool toggleAnimate = false;

  /// 电竞Chpid
  Map<String, String> chpids = {};

  /// 节流
  late StreamSubscription<void> throttleOddsList; // 玩法集
  // late StreamSubscription<void> throttleOddsInfo; // 投注数据
  late StreamSubscription<void> throttleRCMD303; // ws303
  // late StreamSubscription<void> throttleEventSwitch; // 赛事变更
  final throttleOddsListSubject = PublishSubject<void>();
  final throttleRCMD303Subject = PublishSubject<void>();

  // final throttleEventSwitchSubject = PublishSubject<void>();

  InAppWebViewController? webViewController;

  /// 置顶控制
  // final eventController = DefaultEventController<dynamic>();

  /// 非全屏时动画高度
  RxDouble animateHeaderHeight = 0.0.obs;

  // 玩法集无数据
  bool oddsInfoIsNoData = true;

  // 变更的赛事 用于返回列表时提供给列表刷新
  List<String> mIds = [];

  // 保存展开收起状态
  Map<String, String> hShowMap = {};

  // 保存置顶状态
  Map<String, dynamic> hHtonMap = {};

  bool endScroll = true;

  GifController? gifController;

  // gif默认关闭
  RxBool gifAnimatedStatus = true.obs;

  /// 视频清晰度
  List<String> playTypeList = [
    LocaleKeys.video_flv.tr,
    LocaleKeys.video_m3u8.tr
  ];

  MatchDetailState() {
    // 动画竖屏高度 宽度全屏 比例按照980 / 556
    animateHeaderHeight.value =
        1.sw / (animateRatio) + Get.mediaQuery.padding.top;
  }
}
