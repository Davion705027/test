import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_ty_app/app/core/format/common/module/format-date.dart';
import 'package:flutter_ty_app/app/core/format/common/module/format-score.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_map_operate.dart';
import 'package:flutter_ty_app/app/global/user_controller.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/odds_info_extension.dart';
import 'package:flutter_ty_app/app/services/api/match_detail_api.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../generated/locales.g.dart';
import '../../../db/app_cache.dart';
import '../../../global/data_store_controller.dart';
import '../../../services/api/result_api.dart';
import '../../../services/models/res/get_h5_order_list_entity.dart';
import '../../../services/models/res/get_match_result_entity.dart';
import '../../../services/models/res/playback_video_url_entity.dart';
import '../../../utils/systemchrome.dart';
import '../../../utils/utils.dart';

import '../../bet_detail/analyze_match/analyze_news/amalyze_match_data/analyze_match_data_logic.dart';
import '../../bet_detail/analyze_match/analyze_news/analyze_battle_array/analyze_battle_array_logic.dart';
import '../../bet_detail/analyze_match/analyze_news/analyze_match_history/analyze_match_history_logic.dart';
import '../../bet_detail/analyze_match/analyze_news/analyze_match_information/analyze_match_information_logic.dart';
import '../../bet_detail/analyze_match/analyze_news/analyze_match_odds/analyze_match_odds_logic.dart';
import '../../bet_detail/analyze_match/analyze_news/analyze_match_result/analyze_match_result_logic.dart';
import '../../bet_detail/analyze_match/analyze_news/analyze_news/analyze_news_logic.dart';
import '../../match_detail/controllers/analyze_tab_controller.dart';
import '../../match_detail/controllers/match_detail_controller.dart';
import '../../match_detail/views/match_detail_view.dart';
import '../widgets/HeaderModel.dart';
import 'results_details_logic.dart';
import 'package:intl/intl.dart';

class ResultsDetailsController extends GetxController
    with GetTickerProviderStateMixin {
  final ResultsDetailslogic logic = ResultsDetailslogic();
  late AnimationController animationController;
  late Animation animation;
  InAppWebViewController? webViewController;
  String mid = '';
  bool headMenu = false;
  bool playVideo = false;
  String playVideoUrl = '';

  bool allExpand = true;

  //赛事
  bool event = false;
  //bet
  bool bet = false;
  //回放
  bool playback = false;




  List<String> videoHead = [
    LocaleKeys.highlights_type_all.tr,
    LocaleKeys.highlights_type_goal.tr,
    LocaleKeys.highlights_type_corner.tr,
    LocaleKeys.highlights_type_penalty.tr,
  ];
  List<PlaybackVideoUrlDataEventList> originEventList = [];

  MatchEntity argumemts = Get.arguments[0]['item'];
  String typePicture = Get.arguments[1]['typePicture'];
  int eventHeadIndex = 0;
  int videoIndex = 0;
  int titleIndex = Get.arguments[2]['titleIndex'];

  List<MatchHps> data = [];
  MatchEntity? detailData;

  late List<MatchEntity> matcheHandpickData = [];
  late List<PlaybackVideoUrlDataEventList> eventList = [];
  List<GetH5OrderListDataRecordxData> miApuestaData = [];
  // 头部渲染 对象
  HeaderModel headerMap = HeaderModel();

  // 头部选择联赛列表
  List<MatchEntity> headMatchList = [];

  // 当前联赛
  late MatchEntity currentMatch;

  // 使用默认详情
  var detailController = Get.find<MatchDetailController>();

  final _refreshSubject = BehaviorSubject<Function>();

  RxBool loading = false.obs;

  /// 记录请求次数
  int requestCount = 0;
  Timer? _timer;
  @override
  void onInit() {
    SystemUtils.isDarkMode(true);
    mid = argumemts.mid;

    initData();


    iconRefresh();

    /// 设置详情mid 用于加载详情列表
    detailController.detailState.mId = mid;
    detailController.detailState.getFewer.value = 1;

    /// 设置dj详情
    detailController.detailState.isDJDetail = (titleIndex == 1);

    initWeb();
    initSubject();

    super.onInit();
  }

  void initData() async{
   await   getResultMatchDetail();

    matcheHandpick();
    getResultGetH5OrderList();
    playbackVideoUrl(0);
  }

  @override
  void onClose() {
    _refreshSubject.close();
    try {
      webViewController?.dispose();
    } catch (e) {}

    super.onClose();
  }

  onEventHeadIndex(int index) {
    eventHeadIndex = index;
    if (eventHeadIndex == 0) {
      detailController.refreshOddsInfoData(refresh: true);
    } else if (eventHeadIndex == 1) {
      // 对应vue match-container-main-template7.vue
      matcheHandpick();
    } else if (eventHeadIndex == 2) {
      getResultGetH5OrderList();
    }else if (eventHeadIndex == 3) {
      playbackVideoUrl(0);
    }
    update();
  }

  Future<void> getMatchResult() async {
    DateTime now = DateTime.now();
    DateTime startOfDay = DateTime(now.year, now.month, now.day);
    String md = startOfDay.millisecondsSinceEpoch.toString();

    final res = await ResultApi.instance().getMatchResult(
      0,
      mid,
      createGcuuid(),
      titleIndex == 0 ? '' : '1',
    );

    // if (res.success && !ObjectUtil.isEmptyList(res.data)) {
    //   // data = res.data!;
    //   update();
    // }
  }

  Future<void> getResultMatchDetail() async {
    loading.value = true;
    try {
      requestCount++;
      final res = await ResultApi.instance().getResultMatchDetail(
        mid,
        1,
        UserController.to.getUid(),
        titleIndex == 0 ? '' : '1',
      );
      if (res.success && ObjectUtil.isNotEmpty(res.data)) {
        detailData = res.data;

        /// 这里需要特殊处理 巨坑啊
        // 61-比赛延迟,80-比赛中断,90-比赛放弃
        if (!(['90', '80', '61'].contains(detailData?.mmp))) {
          detailData?.mmp = '999';
        }
        // TODO js 空字符串是false？
        // if("" && data.mo == 1){
        //   // 61-比赛延迟,80-比赛中断,90-比赛放弃
        //   if(!(['90','80','61'].includes(data.mmp+''))){
        //     data.mmp = '999'
        //   }
        // }

        detailData?.mhs = 0;
        // 更新数据仓库
        setHeaderMap(detailData);
        DataStoreController.to.updateMatch(detailData!);

        update();
      }
      loading.value = false;
    } catch (e) {
      // 请求超过五次，退到上一页面
      if (requestCount >= 5) {
        Get.back();
        return;
      }
      1100.milliseconds.delay(() {
        if (isClosed) return;
        getResultMatchDetail();
      });
    }
  }

  Future<void> getResultGetH5OrderList() async {
    try {
      final res = await ResultApi.instance().resultGetH5OrderList(
        mid,
        2,
       '1',
        3,
      );
      if (res.code=='0000000') {
        if (res != null) {
          if (res.data.record != null) {
            ///倒叙map(回来的数据是反的，最新日期在map最后面一条)
            Map<String, GetH5OrderListDataRecordx?> record = res.data.record ?? {};
            List<MapEntry<String, GetH5OrderListDataRecordx?>> entries =
            record.entries.toList();
            Map<String, GetH5OrderListDataRecordx?> reversedMap =
            Map.fromEntries(entries);

            miApuestaData.clear();
            ///便利map，把数据全部房在一起。
            reversedMap.forEach((key, value) {
              miApuestaData.addAll( value!.data);
            });
            bet = true;
          }
        }

        update();
      }
      loading.value = false;
    } catch (e) {
      // 请求超过五次，退到上一页面
      if (requestCount >= 5) {
        Get.back();
        return;
      }
      1100.milliseconds.delay(() {
        if (isClosed) return;
        getResultGetH5OrderList();
      });
    }
  }

  Future<void> matcheHandpick() async {
    loading.value = true;
    try {
      final res = await ResultApi.instance().matcheHandpick(
        UserController.to.getUid(),
        detailData?.csid ?? "",
      );
      if (res.success && ObjectUtil.isNotEmpty(res.data)) {
        matcheHandpickData = res.data!;
        event = true;
        update();
      }
    } catch (e) {
      Get.log("赛果精选赛事：$e");
    } finally {
      loading.value = false;
    }
  }

  // 设置头部参数
  setHeaderMap(data) {
    // 获取比分
    headerMap.score = TYFormatScore.formatTotalScore(data).text;

    // 获取时间
    String time = TYFormatDate.formatTime(data.mgt, 'mm/dd HH:MM');
    headerMap.time = time;

    String status = '';
    Map detailDataMmpMap = {
      '90': 'mmp.3.90',
      '61': 'mmp.5.61',
      '80': 'mmp.5.80',
      '100': 'mmp.2.100',
      // '999': 'mmp.3.999',
      '999': 'mmp.3.999_app_h5',
    };
    // 只在足球详情页面 显示

    // 赛事中断 单独判断
    if (data.ms == 10) {
      status = 'ms.10';
    } else if (detailDataMmpMap.containsKey(data.mmp)) {
      status = detailDataMmpMap[data.mmp];
    } else {
      status = '';
    }
    headerMap.status = status;
    update();
  }

  Future<void> playbackVideoUrl(int eventCode) async {
    final res = await ResultApi.instance().playbackVideoUrl(
      'H5',
      eventCode.toString(),
      mid,
    );
    if(res.data.eventList.isNotEmpty){
      eventList = res.data.eventList;
      eventList = originEventList = List.from(eventList.reversed);
      playback =true;
      update();
    }

  }

  onIsExpand(GetMatchResultData data) {
    data.isExpand = !data.isExpand;
    update();
  }

  onExpandAll() {
    if(eventHeadIndex==0){
      bool res = !allExpand;

      /// 一键展开折叠
      detailController.changeBtn();
      allExpand = res;
      update();
    }

  }

  onRefresh() {
    animationController.forward();
    getResultMatchDetail();
    // 赔率列表数据拉取
    _refreshSubject
        .add(() => detailController.refreshOddsInfoData(refresh: true));
  }

  void iconRefresh() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reset();
      }
    });
  }

  onHeadMenu() {
    headMenu = !headMenu;
    // 显示
    if (headMenu) {
      // 走接口获取列表
      fetchMatchListData();
    } else {
      update(['ResultDetailHeadMatchList']);
    }
  }

  /// 联赛下拉选择组件展开时的联赛列表获取
  fetchMatchListData() async {
    String tId = argumemts.tid;

    int mgt = int.parse(detailData!.mgt);

    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(mgt);
    String date_ = dateTime.toLocal().toIso8601String().split('T')[0];

    DateTime parsedDate = DateTime.parse(date_);
    int time_ = parsedDate.millisecondsSinceEpoch;
    MatchDetailApi.instance()
        .getMatchDetailByTournamentId(
      tId,
      1,
      time_.toString(),
      titleIndex == 0 ? '' : '1',
    )
        .then((value) {
      if (value.success && ObjectUtil.isNotEmpty(value.data)) {
        headMatchList = value.data!;
        update(['ResultDetailHeadMatchList']);
      }
    });
  }

  formatDateTime(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var formatter = DateFormat('MM/dd HH:mm');
    return formatter.format(date);
  }

  formatDateTimes(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var formatter = DateFormat('HH:mm');
    return formatter.format(date);
  }

  onSelectVideo(int index) {
    videoIndex = index;
    // 全部
    if (index == 0) {
      eventList = originEventList;
    }
    // 进球
    else if (index == 1) {
      eventList = originEventList
          .where((element) => element.eventCode == 'goal')
          .toList();
    }
    // 角球
    else if (index == 2) {
      eventList = originEventList
          .where((element) => element.eventCode == 'corner')
          .toList();
    }
    // 罚牌
    else {
      eventList = originEventList
          .where((element) => element.eventCode.contains('card'))
          .toList();
    }
    update();
  }

  // 点击头部 切换联赛
  onHeadMatch(MatchEntity matchItem) {
    currentMatch = matchItem;
    mid = matchItem.mid;
    eventHeadIndex = 0;
    getResultMatchDetail();
    headMenu = !headMenu;

    if (mid != detailController.detailState.mId) {
      // 赛事变更重置玩法集tab 投注数据
      detailController.detailState.curCategoryTabId = "0";
      detailController.detailState.mId = mid;

      // 投注数据拉取
      detailController.refreshOddsInfoData(refresh: true);
    }
  }

  onGoToDetails(MatchEntity item) {
    DataStoreController.to.injectMatch(item);
    // 跳转不同mid详情 不与当前赛果的默认详情冲突
    Get.to(
      () => MatchDetailView(
        tag: item.mid,
      ),
      arguments: {
        'mid': item.mid,
        'csid': item.csid,
      },
      binding: BindingsBuilder(() {
        Get.put(MatchDetailController(), tag: item.mid);
        Get.put(AnalyzeTabController());
        Get.put(AnalyzeMatchHistoryLogic());
        Get.put(AnalyzeNewsLogic());
        Get.put(AnalyzeMatchResultLogic());
        Get.put(AnalyzeMatchDataLogic());
        Get.put(AnalyzeBattleArrayLogic());
        Get.put(AnalyzeMatchInformationLogic());
        Get.put(AnalyzeMatchOddsLogic());

        Get.find<AnalyzeTabController>().tag = item.mid;
        Get.find<AnalyzeMatchHistoryLogic>().tag = item.mid;
        Get.find<AnalyzeNewsLogic>().tag = item.mid;
        Get.find<AnalyzeMatchResultLogic>().tag = item.mid;
        Get.find<AnalyzeMatchDataLogic>().tag = item.mid;
        Get.find<AnalyzeBattleArrayLogic>().tag = item.mid;
        Get.find<AnalyzeMatchInformationLogic>().tag = item.mid;
        Get.find<AnalyzeMatchOddsLogic>().tag = item.mid;
      }),
    );
  }

  initWeb() {
    // late final PlatformWebViewControllerCreationParams params;
    // if (WebViewPlatform.instance is WebKitWebViewPlatform) {
    //   params = WebKitWebViewControllerCreationParams(
    //     allowsInlineMediaPlayback: true,
    //     mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
    //   );
    // } else {
    //   params = const PlatformWebViewControllerCreationParams();
    // }
    //
    // final WebViewController controller =
    //     WebViewController.fromPlatformCreationParams(params);
    //
    // webViewController = controller
    //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //   ..setBackgroundColor(Colors.black)
    //   ..setNavigationDelegate(
    //     NavigationDelegate(
    //       onProgress: (int progress) {
    //         // Update loading bar.
    //       },
    //       onPageStarted: (String url) {},
    //       onPageFinished: (String url) {},
    //       onWebResourceError: (WebResourceError error) {},
    //     ),
    //   );
    //
    // if (controller.platform is AndroidWebViewController) {
    //   AndroidWebViewController.enableDebugging(true);
    //   (controller.platform as AndroidWebViewController)
    //       .setMediaPlaybackRequiresUserGesture(false);
    // }
  }

  onPlayVideo(PlaybackVideoUrlDataEventList eventItem) {
    DateTime now = DateTime.now();
    DateTime startOfDay = DateTime(now.year, now.month, now.day);
    String t = startOfDay.millisecondsSinceEpoch.toString();
    playVideoUrl =
        '${StringKV.liveUrl.get()}/videoReplay.html?src=${eventItem.fragmentVideo}&lang=&volume=1&t=$t';

    webViewController?.loadUrl(
        urlRequest: URLRequest(url: WebUri(playVideoUrl)));
    playVideo = true;
    update();
  }

  onClosVideo() {
    // webViewController.canGoBack();
    playVideo = false;
    webViewController?.evaluateJavascript(
        source: "that.player.video.setAttribute('muted','muted');");
    webViewController?.evaluateJavascript(source: "that.player.pause();");
    update();
  }

  void initSubject() {
    _refreshSubject
        .debounceTime(const Duration(milliseconds: 1100))
        .listen((callback) {
      // 点击防抖
      callback();
    });
  }


}

class FLagModel {
  // 图标
  late String icon = '';

  // 进球 角球
  late String name = '';
}
