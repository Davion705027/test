import 'dart:io';

import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_map_operate.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/detail_bus_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/detail_throttle_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/odds_info_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/webview_extension.dart';
import 'package:flutter_ty_app/app/utils/utils.dart';
import 'package:get/get.dart';
import 'package:gif/gif.dart';

import '../../../db/app_cache.dart';
import '../../../global/config_controller.dart';
import '../../../global/data_store_controller.dart';
import '../../../global/user_controller.dart';
import '../../../routes/app_pages.dart';
import '../../../services/api/match_detail_api.dart';
import '../../../services/models/res/api_res.dart';
import '../../../services/models/res/category_list_entity.dart';
import '../../../services/models/res/match_entity.dart';
import '../../../services/models/res/video_animation_url_entity.dart';
import '../../../services/network/app_dio.dart';
import '../../../utils/bus/bus.dart';
import '../../../utils/bus/event_enum.dart';
import '../../../utils/format_score_util.dart';
import '../../../utils/systemchrome.dart';
import '../../../utils/video_util.dart';
import '../../home/controllers/home_controller.dart';
import '../constant/detail_constant.dart';
import '../models/header_type_enum.dart';
import '../models/request_status.dart';
import '../states/match_detail_state.dart';
import 'analyze_tab_controller.dart';

/// 普通赛事以及电竞详情
class MatchDetailController extends GetxController
    with GetTickerProviderStateMixin {
  final MatchDetailState detailState = MatchDetailState();
  late TabController tabController;
  bool isDarkMode = Get.isDarkMode;

  @override
  void onInit() {
    DataStoreController.to.isEnterDatail = true;
    // 列表进入
    if (Get.arguments is Map) {
      Map<String, dynamic>? arguments = Get.arguments;
      String mid = arguments?['mid'] ?? ''; // 赛事ID
      String csid = arguments?['csid'] ?? ''; // 联赛ID
      bool isESports = arguments?['isESports'] ?? false; // 电竞进入
      detailState.mId = mid;
      detailState.csid = csid;
      detailState.isDJDetail = isESports;
      pushMid(mid);

      ///  从数据仓库获取基本数据 先展示数据
      detailState.match = DataStoreController.to.getMatchById(mid);
      if (detailState.match != null) {
        detailState.detailLoading = false;
      }
    } else {
      // 赛果、vr体育
    }

    setTabController();

    detailState.gifController = GifController(vsync: this);

    /// ws 监听初始化
    initBus();
    initWebView();

    /// 节流
    initThrottle();

    Map? store = MapKV.matchHpsHtons.get();
    if (store != null) {
      // 获取置顶状态
      detailState.hHtonMap = store as Map<String, dynamic>;
    }

    super.onInit();
  }

  @override
  void onReady() {
    // 适配赛果、虚拟体育
    if (![Routes.matchResultsDetails, Routes.vrSportDetail]
            .contains(Get.currentRoute) &&
        ObjectUtil.isNotEmpty(detailState.mId)) {
      bool initCategoryList = false;
      // 进入参数没有csid 则请求完详情数据再请求玩法集
      if (detailState.csid == "") {
        initCategoryList = true;
      }
      // 详情数据
      fetchMatchDetailData(initCategoryList: initCategoryList);
      // 玩法集tab
      if (!initCategoryList) {
        fetchCategoryList(csid: detailState.csid, mid: detailState.mId);
      }

      // 投注数据拉取
      refreshOddsInfoData(refresh: true);
    }
    // 12秒loading还存在 去除loading
    12.seconds.delay(() {
      if (isClosed) {
        return;
      }
      // 投注数据
      if (detailState.oddsInfoRequestStatus == RequestStatus.loading &&
          detailState.oddsInfoList.isEmpty) {
        detailState.oddsInfoRequestStatus = RequestStatus.noNetwork;
        update([matchOddsInfoGetBuildId, matchBetModeTabGetBuildId]);
        fetchCategoryList();
        refreshOddsInfoData(refresh: true, noLoading: true);
      }

      // 详情
      if (detailState.detailLoading == true) {
        detailState.detailLoading = false;
        update();
      }
    });
    super.onReady();
  }

  @override
  void onClose() {
    DataStoreController.to.isEnterDatail = false;
    disposeBus();
    tabController.dispose();
    detailState.scrollController.dispose();
    detailState.gifController?.dispose();
    // detailState.throttleOddsList.cancel();
    // detailState.throttleOddsListSubject.close();
    // detailState.throttleOddsInfo.cancel();
    // detailState.throttleRCMD303.cancel();
    // detailState.throttleRCMD303Subject.close();
    // detailState.throttleEventSwitch.cancel();
    // detailState.throttleEventSwitchSubject.close();

    // webview
    try {
      sendMessage({"cmd": 'destroy_video'});
      InAppWebViewController.clearAllCache();
      InAppWebViewController.disableWebView();
      detailState.webViewController?.dispose();
    } catch (e) {}

    /// 退出详情页面恢复竖屏 防止横屏时左滑
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // 进详情状态栏颜色改变，退出时恢复
    SystemUtils.isDarkMode(isDarkMode);
    super.onClose();
    Future(() {
      // 退出详情保存置顶状态
      MapKV.matchHpsHtons.save(detailState.hHtonMap);
      appStorage.save();
    });
  }

  ////////////////        api接口       //////////////////
  /// 获取详情数据 传入更新的mId
  fetchMatchDetailData(
      {String? mId, bool initCategoryList = false, bool changeSelect = false}) {
    try {
      // 切换赛事 或者 下拉选择新赛事，先从数据仓库取
      if (mId != null) {
        pushMid(mId);
        MatchEntity? storeMatch = DataStoreController.to.getMatchById(mId);
        if (storeMatch != null) {
          detailState.match = storeMatch;
          resetMatch(mId);
          // 数据仓库已经有该赛事  直接切换赛事  mId = null 往下请求逻辑不再切换
          mId = null;
          update();
        }
      }

      if (detailState.isDJDetail) {
        // 电竞
        MatchDetailApi.instance()
            .getESMatchDetail(
                mId ?? detailState.mId, UserController.to.getUid(), "init")
            .then((value) {
          _detailDataHandler(value,
              mId: mId,
              initCategoryList: initCategoryList,
              changeSelect: changeSelect);
        });
      } else {
        // 详情数据
        MatchDetailApi.instance()
            .getMatchDetail(
                mId ?? detailState.mId, UserController.to.getUid(), "init")
            .then((value) {
          _detailDataHandler(value,
              mId: mId,
              initCategoryList: initCategoryList,
              changeSelect: changeSelect);
        });
      }
    } catch (e) {
      Get.log("fetchMatchDetailData:$e");
      detailState.detailLoading = false;
      update();
    }
  }

  /// 联赛下拉选择组件展开时的联赛列表获取
  fetchMatchListData() {
    if (detailState.match != null && !isClosed) {
      try {
        MatchDetailApi.instance()
            .getMatchDetailByTournamentId(detailState.match!.tid, null, null,
                detailState.isDJDetail ? "1" : null)
            .then((value) {
          if (value.success && !ObjectUtil.isEmptyList(value.data)) {
            detailState.matchListData = value.data!;
          } else {
            detailState.matchListData = [
              DataStoreController.to.getMatchById(detailState.mId) ??
                  detailState.match!
            ];
          }
          update([matchSelectGetBuildId]);
        });
      } catch (e) {
        // 网络错误 延迟2秒请求一次
        // 2.seconds.delay(() => fetchMatchListData());
      }
    }
  }

  /// 获取玩法集
  fetchCategoryList({String? csid, String? mid}) {
    try {
      if ((detailState.match != null && detailState.match?.csid != null) ||
          (csid != null && mid != null)) {
        String sportId = "";
        String mId = "";
        if (csid != null && mid != null) {
          sportId = csid;
          mId = mid;
        } else {
          sportId = detailState.match?.csid ?? "0";
          mId = detailState.mId;
        }

        MatchDetailApi.instance().getCategoryList(sportId, mId).then((value) {
          if (value.success && !ObjectUtil.isEmptyList(value.data)) {
            detailState.categoryList = value.data!;
            // 更新完玩法集，需要判断当前激活项是否存在玩法集中 不存在则重置为第一项
            bool existIdFlag = false;
            for (CategoryListData data in detailState.categoryList) {
              if (data.id == detailState.curCategoryTabId) {
                existIdFlag = true;
              }
            }
            if (!existIdFlag) {
              // 玩法集删除 重置为所有列表
              detailState.curCategoryTabId =
                  detailState.categoryList.safeFirst?.id ?? "0";
              // 刷新一下投注列表
              update([matchOddsInfoGetBuildId]);
            }
            update([matchBetModeTabGetBuildId]);
          }
        });
      }
    } catch (e) {
      // 网络错误 延迟2秒请求一次
      // 2.seconds.delay(() => fetchOddsListData());
    }
  }

  _detailDataHandler(ApiRes<Map<String, dynamic>> value,
      {String? mId, bool initCategoryList = false, bool changeSelect = false}) {
    if (value.success && ObjectUtil.isNotEmpty(value.data)) {
      // 从数据库取原始数据 有原始数据不能直接覆盖
      MatchEntity? originMatch =
          DataStoreController.to.getMatchById(mId ?? detailState.mId);

      if (originMatch != null) {
        Map<String, dynamic> originMatchMap = originMatch.toJson();
        // 合并赛事
        originMatchMap.addAll(value.data!);
        detailState.match = MatchEntity.fromJson(originMatchMap);
      } else {
        detailState.match = MatchEntity.fromJson(value.data!);
      }

      DataStoreController.to.updateMatch(detailState.match!);
      detailState.csid = detailState.match?.csid ?? "";
      // 赛事变更 更新mid
      if (mId != null && mId != detailState.mId) {
        resetMatch(mId);
      }
      // 插入数据仓库可视化赛事
      DataStoreController.to.injecthowMatchIdByMatchEntity(detailState.mId);

      if (initCategoryList) {
        fetchCategoryList();
      }

      // 下拉联赛延迟两秒进行数据持久化
      2000.milliseconds.delay(() {
        fetchMatchListData();
      });
    } else {
      backHome();
    }
    detailState.detailLoading = false;
    setTabController();
    if (changeSelect) {
      AnalyzeTabController.to.isRefresh.value =
          !AnalyzeTabController.to.isRefresh.value;
    }
    update();
  }

  ////////////////////////////////////////////////////////////
  pushMid(String mId) {
    if (!detailState.mIds.contains(mId)) {
      detailState.mIds.add(mId);
    }
  }

  setTabController() {
    int length = 2;
    int initialIndex = 0;
    if (!showMatchAnalysisTab()) {
      length = 1;
    } else {
      initialIndex = detailState.curMainTab.value;
    }

    tabController = TabController(
        initialIndex: initialIndex, length: length, vsync: this)
      ..addListener(() {
        if (tabController.index.toDouble() == tabController.animation?.value) {
          detailState.curMainTab.value = tabController.index;
        }
      });
  }

  /// 刷新
  refreshData() {
    fetchMatchDetailData();
    fetchCategoryList();
    refreshOddsInfoData(refresh: true);
  }

  // 联赛选择修改赛事
  selectChangeMatch(String newMId) {
    // 不同赛事才更新数据
    if (newMId != detailState.mId) {
      fetchMatchDetailData(mId: newMId, changeSelect: true);
      backHome();
    }
  }

  /// 赛事变更重置
  resetMatch(String mId) {
    // 赛事变更重置玩法集tab 投注数据 视频链接
    detailState.mId = mId;

    // 赛事变更 关闭视频
    detailState.videoUrl = "";
    detailState.animationUrl = "";
    try {
      InAppWebViewController.clearAllCache();
    } catch (e) {
      Get.log("InAppWebViewController = $e");
    }
    detailState.liveLoading.value = true;
    detailState.headerType.value = HeaderType.normal;
    sendMessage({"cmd": 'destroy_video'});
    detailState.isOpenVideoInfo.value = false;
    fullscreen(false);

    // 投注数据重置
    detailState.curCategoryTabId = "0";
    detailState.categoryList = [
      CategoryListData.fromJson(
          {"id": "0", "marketName": "所有投注", "orderNo": -2147483648})
    ];
    detailState.oddsInfoList.clear();
    detailState.oddsInfoIsNoData = true;
    // 玩法tab更新
    fetchCategoryList();
    // 投注数据拉取
    refreshOddsInfoData(refresh: true);

    100.milliseconds.delay(() {
      // 触发详情页页面初始化
      Bus.getInstance().emit(EventType.matchTimeInit, null);
      // 详情页更新 正/倒 计时时间
      // useMittEmit(MITT_TYPES.EMIT_UPDATE_GAME_TIME)
    });
  }

  /// 返回逻辑 打开动画和视频时返回详情，详情时退出页面
  back() {
    if (detailState.headerType.value == HeaderType.normal) {
      backHome();
    } else {
      HeaderType headerType = detailState.headerType.value;
      sendMessage({"cmd": 'destroy_video'});

      detailState.headerType.value = HeaderType.normal;
      detailState.isOpenVideoInfo.value = false;
      fullscreen(false);

      if (headerType == HeaderType.animate) {
        // 退出动画 调整header高度
        update();
      }
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
  }

  /// 退回列表
  backHome() {
    Get.back(result: detailState.mIds);
  }

  ///@description 详情页赛事结束自动切换赛事
  ///@return {Object} 返回赛事各项id(球类id:csid/赛事id:mid/联赛id:tid)
  eventSwitch() {
    // 查找参数 1:赛事列表(非滚球:今日 早盘...) 2:赛事详情(滚球) 3:赛事筛选 4:赛事搜索(int) 如果不传默认 1:赛事列表
    String sm = "2";
    // 菜单ID 多个用逗号分割(字符串)
    String euid = HomeController.to.homeState.matchListReq.euid;
    // 早盘日期的参数 早盘 和 串关都要加 (字符串)
    // md: state_data.get_md != -1 ? state_data.get_md : "",
    // 赛事种类id
    String csid = detailState.match?.csid ?? "0";
    // 联赛id
    String tid = detailState.match?.tid ?? "0";
    // 排序 int 类型 1按热门排序 2按时间排序(整型)
    String sort = "1";
    // 搜索关键词 赛事搜索(字符串)
    String keyword = '';
    // 用户id或者uuid
    String cuid = UserController.to.getUid();
    String mid = detailState.mId;
    MatchDetailApi.instance()
        .getDetailVideo(sm, euid, csid, tid, sort, keyword, cuid, mid)
        .then((value) {
      if (value.success) {
        Get.log("赛事切换");
        if (ObjectUtil.isNotEmpty(value.data?.mid) &&
            ObjectUtil.isNotEmpty(value.data?.csid)) {
          Get.log("正常赛事切换${value.data?.mid}");
          // 普通赛事跳电竞赛事，或者电竞赛事跳普通赛事，就需要重置菜单类型
          bool flag1 = [100, 101, 103].contains(int.parse(value.data!.csid));
          bool flag2 = [100, 101, 103].contains(int.parse(csid));
          if (flag1 != flag2) {
            if (flag1) {
              detailState.isDJDetail = true;
            } else {
              detailState.isDJDetail = false;
            }
          }

          // 重新调用 赛事详情页面接口 已包含所有接口请求
          fetchMatchDetailData(mId: value.data?.mid);
          fetchCategoryList(csid: value.data?.csid, mid: value.data?.mid);
          // useMittEmit(MITT_TYPES.EMIT_REF_API);
        } else {
          // 没有返回赛事数据就跳转到列表页
          Get.log("赛事切换->没有返回赛事数据->退回列表页");
          backHome();
        }
      }
    });
  }

  /// 获取队伍名称 1主队 2客队
  String getTeamName({int type = 1, required MatchEntity match}) {
    if (type == 1) {
      String mhn = match.mhn;
      if (mhn.contains("/")) {
        List<String> mhnList = mhn.split(" / ");
        return "${mhnList[0]}/${mhnList[1]}";
      } else {
        return mhn;
      }
    } else {
      String man = match.man;
      if (man.contains("/")) {
        List<String> manList = man.split(" / ");
        return "${manList[0]}/${manList[1]}";
      } else {
        return man;
      }
    }
  }

  /// 是否展示投注/赛事分析 切换tab
  showMatchAnalysisTab() {
    // 足球篮球赛种后台开关开了才显示
    return !['B03', 'C01', 'O01'].contains(detailState.match?.cds) &&
        ["1", "2"].contains(detailState.match?.csid) &&
        ConfigController.to.accessConfig.value.statisticsSwitch;
  }

  /// 置顶悬浮条是否展示比分
  bool isTopShowScore(MatchEntity match) {
    int ms = match.ms;

    if ([1, 2, 3, 4].contains(ms) ||
        // 或者电竞详情时
        ((detailState.isDJDetail) && ms > 0)) {
      return true;
    } else {
      return false;
    }
  }

  /// 是否是电竞比分
  bool eSportsScoring(MatchEntity match) {
    bool scoring = false;
    // 如果是电竞，则进行比分判定处理
    if (detailState.isDJDetail) {
      int mmp = int.tryParse(match.mmp) ?? 1;
      int home = FormatScore.formatTotalScore(match, 0);
      int away = FormatScore.formatTotalScore(match, 1);
      if (mmp != (home + away + 1)) {
        scoring = true;
      }
    }
    return scoring;
  }

  // 比分 vs
  String getMsc(List<String> msc) {
    String result = "";
    for (var item in msc) {
      if (item.contains('S1|')) {
        result = item.split('|')[1].split(':').join(' v ');
        continue;
      }
    }
    return result;
  }

  /// 更新默认比分
  setNativeDetailData(String str) {
    MatchEntity? matchEntity =
        DataStoreController.to.getMatchById(detailState.mId);

    // 判断是否有相应赛事
    List<String> arrMsc = [];
    List<String> msc = matchEntity?.msc ?? [];
    for (String item in msc) {
      arrMsc.add(item.split("|")[0]);
    }
    if (!arrMsc.contains(str.split("|")[0]) && matchEntity != null) {
      matchEntity.msc.add(str);

      /// 更新比分 数据仓库
      // print("更新默认比分");
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        DataStoreController.to.updateMatch(matchEntity);
      });
    }
  }

  // 关盘
  closeOrder() {
    detailState.oddsInfoIsNoData = true;
    update([matchOddsInfoGetBuildId, matchBetModeTabGetBuildId]);
  }

  /////////////////////////////// 视频动画相关  /////////////////////////////

  /// 加载视频
  loadVideo(MatchEntity matchEntity) async {
    bool check = matchEntity.mms >= 2 || matchEntity.mvs > -1;
    if (!check) {
      return;
    }
    detailState.liveLoading.value = true;
    detailState.headerType.value = HeaderType.live;
    try {
      // 判断登录
      await AppDio.getInstance()
          .dio
          .post('${StringKV.baseUrl.get()!}/yewu11/v1/w/isLogin')
          .then((value) async {
        Map data = value.data;
        if (data['code'] == "0000000" && data['data']['isLogin']) {
          // playVideoUrl =
          // '${StringKV.liveUrl.get()}/videoReplay.html?src=${eventItem.fragmentVideo}&lang=&volume=1&t=$t';

          // 电竞只有视频
          if (["100", "101", "102", "103"].contains(detailState.match?.csid)) {
            String? mediaSrc =
                detailState.match?.vurl ?? detailState.match?.varl;
            checkUrl(mediaSrc);
          } else {
            String referUrl = StringKV.liveUrl.get() ?? "";
            String mediaSrc = '';
            if (referUrl != '') {
              mediaSrc = VideoUtil.getVideoUrlH5(referUrl, detailState.mId,
                  liveType: 1, muted: detailState.liveMuted.value);
              checkUrl(mediaSrc);
            } else {
              /// 本地referUrl没有 走这里
              String sendGcuuid = createGcuuid();
              Map<String, dynamic> param = {
                'gcuuid': sendGcuuid,
                'device': 'H5'
              };
              //[GETX] {"code":"0000000","data":{"referUrl":"https://sandboxliveh5.sportxxx13ky.com","aniUrl":"https://d2theorj75dyet.cloudfront.net/sc/index.jsp?"},"msg":"成功","ts":1710687162751}
              await AppDio.getInstance()
                  .dio
                  .post(
                      '${StringKV.baseUrl.get()!}/yewu11/v1/w/videoReferUrl?device=H5',
                      data: param)
                  .then((value) {
                mediaSrc = VideoUtil.getVideoUrlH5(
                    value.data['data']['referUrl'], detailState.mId,
                    liveType: 1, muted: detailState.liveMuted.value);
                checkUrl(mediaSrc);
              });
            }
          }
        } else {
          if (data['code'] == "0401038") {
            return;
          }
          detailState.liveLoading.value = false;
        }
      });
      update();
    } catch (e) {
      detailState.liveLoading.value = false;
      Get.log("loadVideo:$e");
    }
  }

  /// 加载动画
  loadAnimation(MatchEntity matchEntity) async {
    bool check = matchEntity.mms >= 2 || matchEntity.mvs > -1;
    if (!check) {
      return;
    }
    detailState.liveLoading.value = true;
    detailState.headerType.value = HeaderType.animate;
    // https://api-c.sportxxx1zx.com/yewu11/v1/w/videoAnimationUrl
    // https://information-api.dbsportxxx3pk.com/video/report/insert
    try {
      await MatchDetailApi.instance()
          .getVideoAnimationUrl("Animation", detailState.mId)
          .then((value) {
        if (value.success && ObjectUtil.isNotEmpty(value.data)) {
          VideoAnimationUrlEntity videoAnimationUrlEntity = value.data!;
          String animationUrl = "";
          //足篮棒网使用3.0动画  其他使用2.0
          if (["1", "2", "3", "5"].contains(detailState.match?.csid)) {
            List<VideoAnimationUrlAnimation3Url> animation3Urls =
                videoAnimationUrlEntity.animation3Url;
            animation3Urls.forEach((item) {
              if (item.styleName.contains("day")) {
                animationUrl = item.path;
              }
            });
          }
          animationUrl = animationUrl == ""
              ? videoAnimationUrlEntity.animationUrl
              : animationUrl;
          // InAppWebViewController.clearAllCache();
          // print(animationUrl);
          detailState.webViewController
              ?.loadUrl(urlRequest: URLRequest(url: WebUri(animationUrl)));
          detailState.animationUrl = animationUrl;
          showVideoTop();
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.landscapeRight,
          ]);
        }
        detailState.liveLoading.value = false;
      });
      update();
    } catch (e) {
      detailState.liveLoading.value = false;
      Get.log("loadVideo:$e");
    }
  }

  /// 检测视频
  checkUrl(url) async {
    // print(url);
    // InAppWebViewController.clearAllCache();
    // detailState.webViewController.clearCache();
    // detailState.webViewController.clearLocalStorage();

    var httpClient = HttpClient();

    try {
      // 发起 GET 请求
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();

      // 检查响应状态码
      if (response.statusCode == HttpStatus.ok) {
        detailState.webViewController
            ?.loadUrl(urlRequest: URLRequest(url: WebUri(url)));
        detailState.videoUrl = url;
        // 处理请求结果
        Get.log('Received data: $response');
        showVideoTop();
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);
      } else {
        detailState.videoUrl = "";
        Get.log('Request failed with status: ${response.statusCode}');
      }
      detailState.liveLoading.value = false;
      detailState.headerType.value = HeaderType.live;
    } catch (e) {
      detailState.videoUrl = "";
      detailState.headerType.value = HeaderType.live;
      Get.log('Exception caught: $e');
    } finally {
      // 关闭 HttpClient
      httpClient.close();
    }
  }

  showVideoTop() {
    detailState.videoTopShow.value = true;
    // 进入先显示遮盖信息
    5.seconds.delay(() {
      if (isClosed) {
        return;
      }
      detailState.videoTopShow.value = false;
    });
  }

  fullscreen(bool fullscreen) {
    if (fullscreen) {
      // 横屏

      showVideoTop();

      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
      // 全屏状态栏不显示
      // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
      // detailState.fullscreen.value = true;
      // 2.seconds.delay(() {
      //   // 刷新 防止出现没有全屏的情况
      //   detailState.webViewController?.reload();
      // });
    } else {
      // 视频动画未打开时 禁止横竖屏切换
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);
      detailState.fullscreen.value = false;
    }
    // 动画恢复竖屏刷一下
    if (detailState.headerType.value == HeaderType.animate) {
      1500.milliseconds.delay(() {
        detailState.webViewController?.loadUrl(
            urlRequest: URLRequest(url: WebUri(detailState.animationUrl)));
      });
    }
    setRotation();
  }

  setRotation() {
    2.seconds.delay(() {
      if (detailState.headerType.value == HeaderType.normal) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
      } else {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);
      }
    });
  }

  /// 视频上方组件展示
  changeVideoTopShow(bool videoTopShow) {
    if (!detailState.topShowPermanent) {
      detailState.videoTopShow.value = videoTopShow;
    }
  }
}
