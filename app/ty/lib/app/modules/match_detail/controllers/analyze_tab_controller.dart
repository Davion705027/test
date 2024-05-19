import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/analyze_tab_state.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../services/api/analyze_detail_api.dart';
import '../../bet_detail/analyze_match/analyze_news/amalyze_match_data/analyze_match_data_component.dart';
import '../../bet_detail/analyze_match/analyze_news/amalyze_match_data/analyze_match_data_logic.dart';
import '../../bet_detail/analyze_match/analyze_news/analyze_battle_array/analyze_battle_array_component.dart';
import '../../bet_detail/analyze_match/analyze_news/analyze_battle_array/analyze_battle_array_logic.dart';
import '../../bet_detail/analyze_match/analyze_news/analyze_match_history/analyze_match_history_component.dart';
import '../../bet_detail/analyze_match/analyze_news/analyze_match_history/analyze_match_history_logic.dart';
import '../../bet_detail/analyze_match/analyze_news/analyze_match_information/analyze_match_information_component.dart';
import '../../bet_detail/analyze_match/analyze_news/analyze_match_information/analyze_match_information_logic.dart';
import '../../bet_detail/analyze_match/analyze_news/analyze_match_odds/analyze_match_odds_component.dart';
import '../../bet_detail/analyze_match/analyze_news/analyze_match_odds/analyze_match_odds_logic.dart';
import '../../bet_detail/analyze_match/analyze_news/analyze_match_result/analyze_match_result_component.dart';
import '../../bet_detail/analyze_match/analyze_news/analyze_match_result/analyze_match_result_logic.dart';
import '../../bet_detail/analyze_match/analyze_news/analyze_news/analyze_news_component.dart';
import '../../bet_detail/analyze_match/analyze_news/analyze_news/analyze_news_logic.dart';
import 'match_detail_controller.dart';

class AnalyzeTabController extends GetxController
    with GetTickerProviderStateMixin {
  static AnalyzeTabController get to => Get.find();
  late TabController tabController;
  AnalyzeTabState analyzeTabState = AnalyzeTabState();
  bool isFirstPlayBackShow = true;
  bool isShowNews = true;
  bool showBasketBall = false;
  List<Widget> result = [];
  List<String> categoryList = [];

  Rx<bool> isRefresh=false.obs;

  //精彩回放
  AnalyzeMatchHistoryComponent analyzeMatchHistoryComponent =
      AnalyzeMatchHistoryComponent();

  //资讯
  AnalyzeNewsComponent analyzeNewsComponent = AnalyzeNewsComponent();

//  赛况
  AnalyzeMatchResultComponent analyzeMatchResultComponent =
      AnalyzeMatchResultComponent();

  //数据  战绩
  AnalyzeMatchDataComponent analyzeMatchDataComponent =
      AnalyzeMatchDataComponent();

  //阵容
  AnalyzeBattleArrayComponent analyzeBattleArrayComponent =
      AnalyzeBattleArrayComponent();

  //情报
  AnalyzeMatchInformationComponent analyzeMatchInformationComponent =
      AnalyzeMatchInformationComponent();

  // 赔率
  AnalyzeMatchOddsComponent analyzeMatchOddsComponent =
      AnalyzeMatchOddsComponent();

  /// 详情tag，赛果进来需要传递
  String? tag;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print("=======》本地预研  ${Get.locale?.languageCode}");
    if(Get.locale?.languageCode==null||Get.locale?.languageCode=="zh") {
      isShowNews=true;
    }else{
      isShowNews=false;
    }

  }
  @override
  void onReady() {
    super.onReady();
    initMidData();
    requestData();

    getBodyWidget();
    setTabController();
    isRefresh.stream.listen((event) {
        print("=========>收到数据流  ${tabController.index}");
        int page=tabController.index;
        setTabController();
        try{

          refreshData(page);
        }catch(e){
          print("报错 ${e.toString()}");
        }
       
      // if(changeSelect){
      //   // AnalyzeMatchHistoryLogic.to.initData();
      //   // AnalyzeNewsLogic.to.onInit();
      //   // AnalyzeMatchResultLogic.to.onInit();
      //   // AnalyzeMatchDataLogic.to.onInit();
      //   // AnalyzeBattleArrayLogic.to.onInit();
      //   // AnalyzeMatchInformationLogic.to.onInit();
      //   // AnalyzeMatchOddsLogic.to.onInit();
      // }

      //
      // if((isFirstPlayBackShow && (!showBasketBall))) {
      //   page = page+1;
      // }
      // switch(tabController.index) {
      // // if(changeSelect){
      // //   // AnalyzeMatchHistoryLogic.to.initData();
      // //   // AnalyzeNewsLogic.to.onInit();
      // //   // AnalyzeMatchResultLogic.to.onInit();
      // //   // AnalyzeMatchDataLogic.to.onInit();
      // //   // AnalyzeBattleArrayLogic.to.onInit();
      // //   // AnalyzeMatchInformationLogic.to.onInit();
      // //   // AnalyzeMatchOddsLogic.to.onInit();
      // // }
      //   case 0:
      //     AnalyzeMatchHistoryLogic.to.initData();
      //     break;
      //   case 1:
      //     AnalyzeNewsLogic.to.initData();
      //     break;
      //   case 2:
      //     // AnalyzeMatchResultLogic.to.initData();
      //     break;
      //   case 3:
      //     AnalyzeMatchDataLogic.to.initData();
      //     break;
      //   case 4:
      //     // AnalyzeBattleArrayLogic.to.initData();
      //     break;
      //   case 5:
      //     AnalyzeMatchInformationLogic.to.initData();
      //     break;
      //   case 6:
      //     AnalyzeMatchOddsLogic.to.initData();
      //     break;
      // }
    });
  }

  @override
  void onClose() {
    super.onClose();
    tabController.dispose();
    analyzeTabState.scrollController.dispose();
  }

  void changeCategoryTab(int index) {
    print("=======>hashCode1 ${tabController.hashCode}");
    analyzeTabState.curMainTab.value = index;
    tabController.animateTo(index);
    update(["tableList"]);
  }

  requestHistoryData() {
    MatchDetailController controller = Get.find<MatchDetailController>(tag: tag);
    String mid = controller.detailState.mId;
    AnalyzeDetailApi.instance()
        .playbackVideoUrl(mid, "android", "0")
        .then((value) {
      isFirstPlayBackShow = value.data?.eventList?.isNotEmpty == true;

      print("========>isFirstPlayBackShow  ${isFirstPlayBackShow}");
      getBodyWidget();
      setTabController();

      // update(["tableList"]);
    });
  }

  int getBodyLength() {
    return result.length;
  }

  List<Widget> getBodyWidget() {
    print("=========>开始执行getBodyWidget");
    result.clear();
    categoryList.clear();

    if (isFirstPlayBackShow && (!showBasketBall)) {
      // 精彩回放
      result.add(analyzeMatchHistoryComponent);
      categoryList.add(LocaleKeys.highlights_title.tr);
    }
    if (isShowNews) {
      ///资讯
      result.add(analyzeNewsComponent);
      categoryList
          .add(LocaleKeys.analysis_football_matches_analysis_information.tr);
    }
    if (true) {
      //赛况
      result.add(analyzeMatchResultComponent);
      categoryList.add(LocaleKeys.match_result_match.tr);
    }
    if (true) {
      //数据
      result.add(analyzeMatchDataComponent);
      if (showBasketBall) {
        categoryList.add(LocaleKeys.analysis_football_matches_standings.tr);
      } else {
        categoryList.add(LocaleKeys.analysis_football_matches_analysis_data.tr);
      }
    }
    if (true) {
      // 阵容
      result.add(analyzeBattleArrayComponent);
      categoryList.add(LocaleKeys.analysis_football_matches_line_up.tr);
    }
    if (true && (!showBasketBall)) {
      // 情报
      result.add(analyzeMatchInformationComponent);
      categoryList.add(LocaleKeys.analysis_football_matches_intelligence.tr);
    }
    if (true && (!showBasketBall)) {
      // 赔率
      result.add(analyzeMatchOddsComponent);
      categoryList.add(LocaleKeys.pre_record_odds.tr);
    }
    return result;
  }
  setTabController(){
    tabController = TabController(
        initialIndex: analyzeTabState.curMainTab.value,
        length: getBodyLength(),
        vsync: this);
    update(["tableListTitle", "tableList"]);
    //
    tabController.addListener(() {
      analyzeTabState.curMainTab.value =  tabController.index;
      print("============>数据index ${tabController.index}");
      refreshData(tabController.index);
      update();
    });

  }
  onTitleIndex(int index) {
    analyzeTabState.curMainTab.value = index;
    print(
        "============>${analyzeTabState.curMainTab.value}  hashCode  ${tabController.hashCode}");
    tabController?.animateTo(index);
    update(["tableListTitle", "tableList"]);
  }

  void requestData() async {
    requestHistoryData();
  }

  void initMidData() {
    MatchDetailController controller = Get.find<MatchDetailController>(tag: tag);
    String mid = controller.detailState.mId;

    String csid = controller.detailState.match?.csid ?? "";
    if (csid == "2") {
      showBasketBall = true;
    }
  }

  void refreshData(int page)  {
    if(showBasketBall) {
      switch(page){
        case 0:
          AnalyzeNewsLogic.to.initData();
          break;
        case 1:
          AnalyzeMatchResultLogic.to.initData();
          break;
        case 2:
          AnalyzeMatchDataLogic.to.initData();
          break;
        case 3:
          AnalyzeBattleArrayLogic.to.initData();
          break;
      }
    }else{
      if(isFirstPlayBackShow==true) {
        page--;
      }
      if(isShowNews==false) {
        page--;
      }

      // isFirstPlayBackShow true   isShowNews true  都展示

      // isFirstPlayBackShow true   isShowNews false  精彩回放展示， 资讯不展示
      // isFirstPlayBackShow false   isShowNews true  精彩回放不展示，新闻展示
      //  isFirstPlayBackShow false   isShowNews false  都不展示


      print("===========>page${page}  isFirstPlayBackShow  ${isFirstPlayBackShow}");
      switch(page){
        case -1:
          AnalyzeMatchHistoryLogic.to.initData();
          break;
        case 0:
          AnalyzeNewsLogic.to.initData();
          break;
        case 1:
          AnalyzeMatchResultLogic.to.initData();
          if(isFirstPlayBackShow) {
            AnalyzeNewsLogic.to.initData();
          }
          break;
        case 2:

          AnalyzeMatchDataLogic.to.initData();
          break;
        case 3:
          AnalyzeBattleArrayLogic.to.initData();
          break;
        case 4:
          AnalyzeMatchInformationLogic.to.initData();
          break;
        case 5:
          AnalyzeMatchOddsLogic.to.initData();
          break;
      }
    }
  }

  void jumpPage(int page) {
    update(["tableListTitle"]);
  }
}
