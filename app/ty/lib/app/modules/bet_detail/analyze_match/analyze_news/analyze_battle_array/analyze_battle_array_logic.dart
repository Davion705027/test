import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/db/app_cache.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_map_operate.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_detail_controller.dart';
import 'package:flutter_ty_app/app/modules/match_detail/models/header_type_enum.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:get/get.dart';

import '../../../../../global/data_store_controller.dart';
import '../../../../../services/api/analyze_detail_api.dart';
import '../../../../../services/api/match_detail_api.dart';
import '../../../../../services/models/res/analyze_array_person_entity.dart';
import '../../../../../services/models/res/analyze_news_entity.dart';
import '../../../../match_detail/controllers/analyze_tab_controller.dart';
import '../analyze_news/Test.dart';
import '../widget/data/data_tab.dart';
import '../widget/data/data_tab_new.dart';
import 'analyze_battle_array_state.dart';

class AnalyzeBattleArrayLogic extends GetxController
    with GetSingleTickerProviderStateMixin {
  static AnalyzeBattleArrayLogic get to => Get.find();
  final AnalyzeBattleArrayState state = AnalyzeBattleArrayState();
  late TabController tabController;
  late bool noData = true;
  bool showBasketBall = false;

  double bgImgWidth = ScreenUtil().screenWidth * 1;
  double bgImgHeight = ScreenUtil().screenWidth * 0.88;
  double bgImgWidthRatio = 0;
  double bgImgHeightRatio = 0;
  Map<int, Rect> showBasketMap = {};
  String? mid;
  Map<int, Rect> map = {};
  AnalyzeArrayPersonEntity? line_up_data_home;
  AnalyzeArrayPersonEntity? line_up_data_away;
  List<Up>? basketball_data;
  int number = 0;
  List<List<Up>> football_filtered_data_home = [];
  List<List<Up>> football_filtered_data_away = [];
  GlobalKey<MSTabbarDemo1State>  mSTabbarDemo1StateKey=GlobalKey();
  String? tag;
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this)
      ..addListener(() {
        if (tabController.index.toDouble() == tabController.animation?.value) {
          print("=======>切花数据${tabController.index}");
          state.curMainTab.value = tabController.index;
          requestMatchLineUpList(index: state.curMainTab.value + 1);
          update(["analyzeList", "analyzeChildArrayComponent"]);
          update(["analyzeList2", "analyzeChildArrayComponent2"]);
        }
      });
  }

  @override
  void onReady(){
    initData();
    super.onReady();
  }

  void requestData() async {
    print("=======>切花数据requestData");

    update(["analyzeChildArrayComponent2"]);
    requestMatchLineUpList(index: 1);
  }

  Rect requestPosition(Up e, int position, int index) {

    if (showBasketBall) {
      //375  *715 设计稿分辨率
      return showBasketMap[index] ?? Rect.fromLTRB(-100.w, -100.w, 0, 0);
    } else {
      //375  *715 设计稿分辨率
      return map[position] ?? Rect.fromLTRB(-100.w, -100.w, 0, 0);
    }
  }

  void requestMatchLineUpList({int index = 1}) {
    AnalyzeDetailApi.instance()
        .getMatchLineupList(mid, "${index}")
        .then((value) {
      print("=========>value  ${value.data?.toJson()}");
      dealData(value.data ?? AnalyzeArrayPersonEntity(), index-1);
      if (index == 1) {
        state.analyzeArrayPersonEntity.value =
            value.data ?? AnalyzeArrayPersonEntity();
        print("=========>value2  ${ state.analyzeArrayPersonEntity.value?.toJson()}");
      } else {
        state.analyzeArrayPersonEntity2.value =
            value.data ?? AnalyzeArrayPersonEntity();
      }
      update(["analyzeList", "analyzeChildArrayComponent"]);
      update(["buildList"]);
    });


    //测试代码
    bool env = const bool.fromEnvironment("PACKAGE_MOCK", defaultValue: false);
    if (env) {
      requestTest();
    }
  }

  getTeamName(
    MatchEntity otherMatch, {
    int? type,
  }) {
    return Get.find<MatchDetailController>(tag: tag).getTeamName(
        type: type ?? 1, match: otherMatch);
  }

  void initMatchData() async {
    state.teamsNames.clear();
    MatchEntity matchEntity =
        DataStoreController.to.getMatchById(mid ?? "") ?? MatchEntity();
    // 1主队 2客队
    String team1 = getTeamName(matchEntity, type: 1);
    String team2 = getTeamName(matchEntity, type: 2);
    state.teamsNames.add(team1);
    state.teamsNames.add(team2);
    mSTabbarDemo1StateKey.currentState?.initTeams(state.teamsNames);
    update(["tabListChange"]);
  }

  void requestTest() {
    // //  测试代码
    Future.delayed(Duration(seconds: 6), () {
      String data =
          "{\"homeFormation\":\"0-0-0\",\"up\":[{\"awayFormation\":\"0-0-0\",\"createTime\":\"1713541200823\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"0-0-0\",\"id\":\"9:8921172:12935:1131974\",\"invalid\":0,\"matchInfoId\":\"3403524\",\"modifyTime\":\"1713540933475\",\"position\":1,\"positionEnName\":\"Guard\",\"positionName\":\"后卫\",\"shirtNumber\":22,\"sportId\":\"2\",\"substitute\":0,\"thirdPlayerEnName\":\"Stephen Brown Jr.\",\"thirdPlayerName\":\"小斯蒂芬·布朗\",\"thirdPlayerPicUrl\":\"https://img.tysondata.com/players/20240419233528680_150x150.png\",\"thirdPlayerSourceId\":\"1131974\",\"thirdTeamSourceId\":\"12935\"}],\"down\":[{\"awayFormation\":\"0-0-0\",\"createTime\":\"1713541200823\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"0-0-0\",\"id\":\"9:8921172:12935:1138226\",\"invalid\":0,\"matchInfoId\":\"3403524\",\"modifyTime\":\"1713540923482\",\"position\":0,\"positionEnName\":\"Center Striker\",\"positionName\":\"中锋\",\"shirtNumber\":16,\"sportId\":\"2\",\"substitute\":1,\"thirdPlayerEnName\":\"Adam Łapeta\",\"thirdPlayerName\":\"亚当·拉佩塔\",\"thirdPlayerPicUrl\":\"https://img.tysondata.com/players/20240419233508115_150x150.png\",\"thirdPlayerSourceId\":\"1138226\",\"thirdTeamSourceId\":\"12935\"},{\"awayFormation\":\"0-0-0\",\"createTime\":\"1713541200823\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"0-0-0\",\"id\":\"9:8921172:12935:1168535\",\"invalid\":0,\"matchInfoId\":\"3403524\",\"modifyTime\":\"1713540923483\",\"position\":1,\"positionEnName\":\"Guard\",\"positionName\":\"后卫\",\"shirtNumber\":20,\"sportId\":\"2\",\"substitute\":1,\"thirdPlayerEnName\":\"Alex Stein\",\"thirdPlayerName\":\"亚历克斯·斯坦因\",\"thirdPlayerPicUrl\":\"https://img.tysondata.com/players/20240419233509424_150x150.png\",\"thirdPlayerSourceId\":\"1168535\",\"thirdTeamSourceId\":\"12935\"},{\"awayFormation\":\"0-0-0\",\"createTime\":\"1713541200823\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"0-0-0\",\"id\":\"9:8921172:12935:488807\",\"invalid\":0,\"matchInfoId\":\"3403524\",\"modifyTime\":\"1713540923481\",\"position\":1,\"positionEnName\":\"Guard\",\"positionName\":\"后卫\",\"shirtNumber\":0,\"sportId\":\"2\",\"substitute\":1,\"thirdPlayerEnName\":\"Kowalczyk, Sebastian\",\"thirdPlayerName\":\"塞巴斯蒂安科瓦尔奇克\",\"thirdPlayerPicUrl\":\"https://img.tysondata.com/players/20240419233505859_150x150.png\",\"thirdPlayerSourceId\":\"488807\",\"thirdTeamSourceId\":\"12935\"},{\"awayFormation\":\"0-0-0\",\"createTime\":\"1713541200823\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"0-0-0\",\"id\":\"9:8921172:12935:1129911\",\"invalid\":0,\"matchInfoId\":\"3403524\",\"modifyTime\":\"1713540902003\",\"position\":2,\"positionEnName\":\"Forward\",\"positionName\":\"前锋\",\"shirtNumber\":2,\"sportId\":\"2\",\"substitute\":1,\"thirdPlayerEnName\":\"Simons\",\"thirdPlayerName\":\"西蒙斯\",\"thirdPlayerPicUrl\":\"https://img.tysondata.com/players/20240419233459628_150x150.png\",\"thirdPlayerSourceId\":\"1129911\",\"thirdTeamSourceId\":\"12935\"},{\"awayFormation\":\"0-0-0\",\"createTime\":\"1713541200823\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"0-0-0\",\"id\":\"9:8921172:12935:1131975\",\"invalid\":0,\"matchInfoId\":\"3403524\",\"modifyTime\":\"1713540948931\",\"position\":2,\"positionEnName\":\"Forward\",\"positionName\":\"前锋\",\"shirtNumber\":25,\"sportId\":\"2\",\"substitute\":1,\"thirdPlayerEnName\":\"Dominik Grudzinski\",\"thirdPlayerName\":\"多米尼克·格鲁津斯基\",\"thirdPlayerPicUrl\":\"https://img.tysondata.com/players/20240419233543517_150x150.png\",\"thirdPlayerSourceId\":\"1131975\",\"thirdTeamSourceId\":\"12935\"},{\"awayFormation\":\"0-0-0\",\"createTime\":\"1713541200823\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"0-0-0\",\"id\":\"9:8921172:12935:1131973\",\"invalid\":0,\"matchInfoId\":\"3403524\",\"modifyTime\":\"1713540933473\",\"position\":11,\"positionEnName\":\"Ball-Handling Striker\",\"positionName\":\"控球前锋\",\"shirtNumber\":21,\"sportId\":\"2\",\"substitute\":1,\"thirdPlayerEnName\":\"Damian Kruzynski\",\"thirdPlayerName\":\"达米安·克鲁津斯基\",\"thirdPlayerPicUrl\":\"https://img.tysondata.com/players/20240419233526892_150x150.png\",\"thirdPlayerSourceId\":\"1131973\",\"thirdTeamSourceId\":\"12935\"}]}";
      AnalyzeArrayPersonEntity analyzeArrayPersonEntity =
          AnalyzeArrayPersonEntity.fromJson(jsonDecode(data));
      print("开始处理=====>");
      dealData(analyzeArrayPersonEntity, 0);
      print("开始刷新=====>");
      state.analyzeArrayPersonEntity.value = analyzeArrayPersonEntity;
      update(["buildList", "analyzeChildArrayComponent"]);
    });

    Future.delayed(Duration(seconds: 6), () {
      String data =
          "{\"homeFormation\":\"0-0-0\",\"up\":[{\"awayFormation\":\"0-0-0\",\"createTime\":\"1713541200823\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"0-0-0\",\"id\":\"9:8921172:12935:1131974\",\"invalid\":0,\"matchInfoId\":\"3403524\",\"modifyTime\":\"1713540933475\",\"position\":1,\"positionEnName\":\"Guard\",\"positionName\":\"后卫\",\"shirtNumber\":22,\"sportId\":\"2\",\"substitute\":0,\"thirdPlayerEnName\":\"Stephen Brown Jr.\",\"thirdPlayerName\":\"小斯蒂芬·布朗\",\"thirdPlayerPicUrl\":\"https://img.tysondata.com/players/20240419233528680_150x150.png\",\"thirdPlayerSourceId\":\"1131974\",\"thirdTeamSourceId\":\"12935\"},{\"awayFormation\":\"0-0-0\",\"createTime\":\"1713542100766\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"0-0-0\",\"id\":\"9:8921172:12935:488974\",\"invalid\":0,\"matchInfoId\":\"3403524\",\"modifyTime\":\"1713541857697\",\"position\":1,\"positionEnName\":\"Guard\",\"positionName\":\"后卫\",\"shirtNumber\":null,\"sportId\":\"2\",\"substitute\":0,\"thirdPlayerEnName\":\"Gruszecki, Karol\",\"thirdPlayerName\":\"格吕塞基\",\"thirdPlayerPicUrl\":\"https://img.tysondata.com/players/20240419233544746_150x150.png\",\"thirdPlayerSourceId\":\"488974\",\"thirdTeamSourceId\":\"12935\"},{\"awayFormation\":\"0-0-0\",\"createTime\":\"1713542100766\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"0-0-0\",\"id\":\"9:8921172:12935:419166\",\"invalid\":0,\"matchInfoId\":\"3403524\",\"modifyTime\":\"1713541857696\",\"position\":2,\"positionEnName\":\"Forward\",\"positionName\":\"前锋\",\"shirtNumber\":null,\"sportId\":\"2\",\"substitute\":0,\"thirdPlayerEnName\":\"Langovic, Aleksandar\",\"thirdPlayerName\":\"亚历山大兰戈维奇\",\"thirdPlayerPicUrl\":\"https://img.tysondata.com/players/20240419233506967_150x150.png\",\"thirdPlayerSourceId\":\"419166\",\"thirdTeamSourceId\":\"12935\"}],\"down\":[{\"awayFormation\":\"0-0-0\",\"createTime\":\"1713541200823\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"0-0-0\",\"id\":\"9:8921172:12935:1138226\",\"invalid\":0,\"matchInfoId\":\"3403524\",\"modifyTime\":\"1713540923482\",\"position\":0,\"positionEnName\":\"Center Striker\",\"positionName\":\"中锋\",\"shirtNumber\":16,\"sportId\":\"2\",\"substitute\":1,\"thirdPlayerEnName\":\"Adam Łapeta\",\"thirdPlayerName\":\"亚当·拉佩塔\",\"thirdPlayerPicUrl\":\"https://img.tysondata.com/players/20240419233508115_150x150.png\",\"thirdPlayerSourceId\":\"1138226\",\"thirdTeamSourceId\":\"12935\"},{\"awayFormation\":\"0-0-0\",\"createTime\":\"1713541200823\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"0-0-0\",\"id\":\"9:8921172:12935:1168535\",\"invalid\":0,\"matchInfoId\":\"3403524\",\"modifyTime\":\"1713540923483\",\"position\":1,\"positionEnName\":\"Guard\",\"positionName\":\"后卫\",\"shirtNumber\":20,\"sportId\":\"2\",\"substitute\":1,\"thirdPlayerEnName\":\"Alex Stein\",\"thirdPlayerName\":\"亚历克斯·斯坦因\",\"thirdPlayerPicUrl\":\"https://img.tysondata.com/players/20240419233509424_150x150.png\",\"thirdPlayerSourceId\":\"1168535\",\"thirdTeamSourceId\":\"12935\"},{\"awayFormation\":\"0-0-0\",\"createTime\":\"1713541200823\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"0-0-0\",\"id\":\"9:8921172:12935:488807\",\"invalid\":0,\"matchInfoId\":\"3403524\",\"modifyTime\":\"1713540923481\",\"position\":1,\"positionEnName\":\"Guard\",\"positionName\":\"后卫\",\"shirtNumber\":0,\"sportId\":\"2\",\"substitute\":1,\"thirdPlayerEnName\":\"Kowalczyk, Sebastian\",\"thirdPlayerName\":\"塞巴斯蒂安科瓦尔奇克\",\"thirdPlayerPicUrl\":\"https://img.tysondata.com/players/20240419233505859_150x150.png\",\"thirdPlayerSourceId\":\"488807\",\"thirdTeamSourceId\":\"12935\"},{\"awayFormation\":\"0-0-0\",\"createTime\":\"1713541200823\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"0-0-0\",\"id\":\"9:8921172:12935:1129911\",\"invalid\":0,\"matchInfoId\":\"3403524\",\"modifyTime\":\"1713540902003\",\"position\":2,\"positionEnName\":\"Forward\",\"positionName\":\"前锋\",\"shirtNumber\":2,\"sportId\":\"2\",\"substitute\":1,\"thirdPlayerEnName\":\"Simons\",\"thirdPlayerName\":\"西蒙斯\",\"thirdPlayerPicUrl\":\"https://img.tysondata.com/players/20240419233459628_150x150.png\",\"thirdPlayerSourceId\":\"1129911\",\"thirdTeamSourceId\":\"12935\"},{\"awayFormation\":\"0-0-0\",\"createTime\":\"1713541200823\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"0-0-0\",\"id\":\"9:8921172:12935:1131975\",\"invalid\":0,\"matchInfoId\":\"3403524\",\"modifyTime\":\"1713540948931\",\"position\":2,\"positionEnName\":\"Forward\",\"positionName\":\"前锋\",\"shirtNumber\":25,\"sportId\":\"2\",\"substitute\":1,\"thirdPlayerEnName\":\"Dominik Grudzinski\",\"thirdPlayerName\":\"多米尼克·格鲁津斯基\",\"thirdPlayerPicUrl\":\"https://img.tysondata.com/players/20240419233543517_150x150.png\",\"thirdPlayerSourceId\":\"1131975\",\"thirdTeamSourceId\":\"12935\"},{\"awayFormation\":\"0-0-0\",\"createTime\":\"1713541200823\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"0-0-0\",\"id\":\"9:8921172:12935:1131973\",\"invalid\":0,\"matchInfoId\":\"3403524\",\"modifyTime\":\"1713540933473\",\"position\":11,\"positionEnName\":\"Ball-Handling Striker\",\"positionName\":\"控球前锋\",\"shirtNumber\":21,\"sportId\":\"2\",\"substitute\":1,\"thirdPlayerEnName\":\"Damian Kruzynski\",\"thirdPlayerName\":\"达米安·克鲁津斯基\",\"thirdPlayerPicUrl\":\"https://img.tysondata.com/players/20240419233526892_150x150.png\",\"thirdPlayerSourceId\":\"1131973\",\"thirdTeamSourceId\":\"12935\"}]}";
      AnalyzeArrayPersonEntity analyzeArrayPersonEntity =
          AnalyzeArrayPersonEntity.fromJson(jsonDecode(data));
      dealData(analyzeArrayPersonEntity, 1);
      state.analyzeArrayPersonEntity2.value = analyzeArrayPersonEntity;
      update(["buildList2", "analyzeChildArrayComponent2"]);
    });
  }

  Map<int, Rect> initMap() {
    MatchDetailController controller = Get.find<MatchDetailController>(tag: tag);
    mid = controller.detailState.mId;

    String csid = controller.detailState.match?.csid ?? "";
    if (csid == "2") {
      showBasketBall = true;
    }
    return showBasketMap;
  }

  void initData() async {
    initMap();
    requestData();
    initMatchData();
  }

  void dealData(AnalyzeArrayPersonEntity data, int index) {
    // 如果是足球赛事
    if (showBasketBall == false) {
      if (index == 0) {
        line_up_data_home = AnalyzeArrayPersonEntity.fromJson(jsonDecode(jsonEncode(data.toJson())));
        filter_numbers(data.homeFormation ?? "", index);
      } else {
        line_up_data_away = data;
        filter_numbers(data.awayFormation ?? "?", index);
      }
    } else {
      //  如果是 篮球赛事
      basketball_data = data.up;
      update(["analyzeList", "analyzeChildArrayComponent"]);
    }
  }

  filter_numbers(String data, int index) {
    if (data.isEmpty) {
      return;
    }
    number = int.tryParse(data.substring(data.length - 1, data.length)) ?? 0;
    ;
    List<String> number_columns = data.split('-');
    number_columns.removeLast();
    if (number_columns.isEmpty || number_columns.length < 2) {
      return;
    }
    int number1 = int.tryParse(number_columns[0]) ?? 0;
    int number2 = int.tryParse(number_columns[1]) ?? 0;
    // line_up_data_home?.up
    //     ?.removeWhere((element) => element.shirtNumber == null);
    // line_up_data_home?.down
    //     ?.removeWhere((element) => element.shirtNumber == null);
    if (number_columns.length == 2) {
      if (index == 0) {
        // 主队
        football_filtered_data_home = [];
        football_filtered_data_home
            .add(line_up_data_home?.up?.sublist(1, number1 + 1) ?? []);
        football_filtered_data_home.add(line_up_data_home?.up
                ?.sublist(number1 + 1, number1 + number2 + 1) ??
            []);

        if (data == "4-3-3") {
          Up lastThree = line_up_data_home
                  ?.up?[(line_up_data_home?.up?.length ?? 3) - 3] ??
              Up();
          Up lastEnd = line_up_data_home?.up?.last ?? Up();

          Up lastTwo = line_up_data_home
                  ?.up?[(line_up_data_home?.up?.length ?? 2) - 2] ??
              Up();

          football_filtered_data_home.add([lastTwo]);

          football_filtered_data_home.add([lastThree, lastEnd]);
        }
      } else {
        // 客队
        football_filtered_data_away = [];
        football_filtered_data_away
            .add(line_up_data_away?.up?.sublist(1, number1 + 1) ?? []);
        football_filtered_data_away.add(line_up_data_away?.up
                ?.sublist(number1 + 1, number1 + number2 + 1) ??
            []);

        if (data == "4-3-3") {
          Up lastThree = line_up_data_away
                  ?.down?[(line_up_data_away?.down?.length ?? 3) - 3] ??
              Up();
          Up lastEnd = line_up_data_away?.down?.last ?? Up();

          Up lastTwo = line_up_data_away
                  ?.down?[(line_up_data_away?.down?.length ?? 2) - 2] ??
              Up();
          football_filtered_data_away.add([lastTwo]);
          football_filtered_data_away.add([lastThree, lastEnd]);
        }
      }
    } else if (number_columns.length == 3) {
      int number3 = int.tryParse(number_columns[2]) ?? 0;
      if (index == 0) {
        // 主队
        football_filtered_data_home = [];
        football_filtered_data_home
            .add(line_up_data_home?.up?.sublist(1, number1 + 1) ?? []);
        football_filtered_data_home.add(line_up_data_home?.up
                ?.sublist(number1 + 1, number1 + number2 + 1) ??
            []);
        football_filtered_data_home.add(line_up_data_home?.up?.sublist(
                number1 + number2 + 1, number1 + number2 + number3 + 1) ??
            []);
      } else {
        // 客队
        football_filtered_data_away = [];
        football_filtered_data_away
            .add(line_up_data_away?.up?.sublist(1, number1 + 1) ?? []);
        football_filtered_data_away.add(line_up_data_away?.up
                ?.sublist(number1 + 1, number1 + number2 + 1) ??
            []);
        football_filtered_data_away.add(line_up_data_away?.up?.sublist(
                number1 + number2 + 1, number1 + number2 + number3 + 1) ??
            []);
      }
    }
  }

  //足球
  bool showItem(bool first, Up item) {
    AnalyzeArrayPersonEntity? entity =
        (state.curMainTab.value == 0 ? line_up_data_home : line_up_data_away);
    if (first) {
      if (entity == null ||
          entity.up?.isEmpty == true ||
          entity.up?.first == null) {
        return false;
      }
    } else {
      if (entity == null ||
          entity.up?.isEmpty == true ||
          entity.up?.last == null) {
        return false;
      }
    }

    print("===number${number}  item.position ${item.position}");
    bool show = ((number == 3 && (item.position ?? 0) > 8) ||
            item.position == 1 ||
            (number == 2 && (item?.position ?? 0) > 9) ||
            (number == 1 && (item.position ?? 0) > 10)) &&
        (item.position ?? 0) <= 11;
    if (item.homeFormation == "4-3-3" && first == false) {
      show = false;
    }

    print("======>show  ${show}");
    return show;
  }
  List<Up>? getBodyUpData(){
    if(state.curMainTab.value==0){
      return state.analyzeArrayPersonEntity.value.up;
    }else{
      return state.analyzeArrayPersonEntity2.value.up;
    }
  }
  List<Up>? getBodyDownData(){
    if(state.curMainTab.value==0){
      return state.analyzeArrayPersonEntity.value.down;
    }else{
      return state.analyzeArrayPersonEntity2.value.down;
    }
  }

  bool isBodyUpEmpty(){
    bool result=true;
    if(state.curMainTab.value==0){

      result=(state.analyzeArrayPersonEntity.value.up == null ||
          state.analyzeArrayPersonEntity.value.up?.isEmpty ==
              true);
    }else{
      result=(state.analyzeArrayPersonEntity2.value.up == null ||
          state.analyzeArrayPersonEntity2.value.up?.isEmpty ==
              true);
    }

    return result;
  }

  bool isBodyDownEmpty(){
    bool result=true;
    print("==========>length   ${state.analyzeArrayPersonEntity.value.down?.length}");
    if(state.curMainTab.value==0){
      result=(state.analyzeArrayPersonEntity.value.down == null ||
          state.analyzeArrayPersonEntity.value.down?.isEmpty ==
              true);
    }else{
      result=(state.analyzeArrayPersonEntity2.value.down == null ||
          state.analyzeArrayPersonEntity2.value.down?.isEmpty ==
              true);
    }
    return result;
  }


}
