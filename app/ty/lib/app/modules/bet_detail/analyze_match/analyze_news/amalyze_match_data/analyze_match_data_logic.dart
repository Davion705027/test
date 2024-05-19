import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_map_operate.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/unsettled_bets/widgets/bets_loading/bets_loading_view.dart';
import 'package:flutter_ty_app/app/services/api/analyze_detail_api.dart';
import 'package:flutter_ty_app/app/services/api/analyze_v_s_info_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_get_match_analysise_data_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_get_match_analysise_data_item_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_team_vs_history_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_team_vs_other_team_item_entity_entity.dart';
import 'package:get/get.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../../../global/data_store_controller.dart';
import '../../../../../services/models/res/match_details_league_points_entity.dart';
import '../../../../../services/models/res/match_entity.dart';
import '../../../../match_detail/controllers/analyze_tab_controller.dart';
import '../../../../match_detail/controllers/match_detail_controller.dart';
import 'analyze_match_data_state.dart';

class AnalyzeMatchDataLogic extends GetxController
    with GetSingleTickerProviderStateMixin {
  static AnalyzeMatchDataLogic get to => Get.find();
  final AnalyzeMatchDataState state = AnalyzeMatchDataState();
  late TabController tabController;
  MatchDetailsLeaguePointsEntity? matchDetailsLeaguePointsEntity;
  bool showBasketBall=false;
  late bool noData = false;
  String? mid;
  List<String> teamsNames=<String>[];
  bool  expand=false;
  int buildHistoryType=0;

  int buildRecentHistoryType=0;
  //加载展示
  bool loading = true;
  String? tag;
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this)
      ..addListener(() {
        if (tabController.index.toDouble() == tabController.animation?.value) {
          state.curMainTab.value = tabController.index;
          AnalyzeMatchDataLogic logc = Get.find<AnalyzeMatchDataLogic>();
          logc.requestMatchAnalysiseData(
              sonMenuId: "${tabController.index + 1}");
        }
      });
  }

  @override
  void onReady(){
    initData();
    super.onReady();
  }

  void requestData() async {
    mid = Get.find<MatchDetailController>(tag: tag).detailState.mId;
    print("==================>${Get.find<MatchDetailController>(tag: tag).detailState.mId}");
    requestVSInfo();
    requestTeamsVSInfo();
    requestOtherTeamsVSInfo();
    requestMatchAnalysiseData( sonMenuId: "${tabController.index + 1}");
    //测试代码
    bool env =const bool.fromEnvironment("PACKAGE_MOCK", defaultValue: false);
    if(env){
      requestTest();
    }
    handleData();

  }

  Future<void> initData() async {
    if (matchDetailsLeaguePointsEntity?.data == null) {
      noData = true;
    } else {
      noData = false;
    }
    initTeams();

    print("==============?${jsonEncode(teamsNames)}");
    update();
    update(["buildRecentHistory"]);

    requestData();
  }

  void initTeams() {

    mid = Get.find<MatchDetailController>(tag: tag).detailState.mId;
    String csid=Get.find<MatchDetailController>(tag: tag).detailState.match?.csid??"";
    if(csid=="2"){
      showBasketBall=true;
    }


    print("======>csid  ${csid}");
    teamsNames.clear();
    MatchEntity matchEntity =
        DataStoreController.to.getMatchById(mid??"") ?? MatchEntity();
    // 1主队 2客队
    String team1 = getTeamName(matchEntity, type: 1);
    String team2 = getTeamName(matchEntity, type: 2);
    print("=========>team1 ${team1}  team2  ${team2}");
    teamsNames.add(team1);
    teamsNames.add(team2);
    update(["buildRecentHistory"]);

  }
  void requestVSInfo({String flag=""}) async {
    loading=true;
    update(["buildLeagueTable"]);
    AnalyzeDetailApi.instance().vsInfo(mid, flag,"1709986348483").then((value) {
      state.analyzeList.value = value.data ?? [];
      print("==========>1  ${ state.analyzeList.value.length}");
      loading=false;
      update(["analyzeList","pointTitleList"]);
      update(["buildLeagueTable"]);

    });

  }

  void requestOtherTeamsVSInfo({String day = "5", String flag = "0"}) async {
    AnalyzeDetailApi.instance().teamVsOtherTeam(mid, flag, day).then((value) {
      if (!value.success || value.data == null) {
        return;
      }
      state.analyzeTeamVsOtherTeamItemList.value = value.data ?? [];
      if (value.data?.isEmpty == true) {
        return;
      }
      List<AnalyzeTeamVsOtherTeamItemEntityEntity>? data  = value.data;
      var findId = data?.safeFirst?.teamGroup ?? "";
      List<AnalyzeTeamVsOtherTeamItemEntityEntity> home = [];
      List<AnalyzeTeamVsOtherTeamItemEntityEntity> away = [];
      for (AnalyzeTeamVsOtherTeamItemEntityEntity item
      in state.analyzeTeamVsOtherTeamItemList.value) {
        if (item.teamGroup == findId) {
          home.add(item);
        } else {
          away.add(item);
        }
      }

      state.homeVSHistoryMap = caculatorResult(home);
      state.awayVSHistoryMap = caculatorResult(away);
      state.home = home;
      state.away = away;
      update(["analyzeList", "buildRecentHistory"]);
    });

  }

  void requestMatchAnalysiseData({String sonMenuId = "1"}) async {
    AnalyzeDetailApi.instance()
        .getMatchAnalysiseData(
      "2",
      sonMenuId,
      mid,
    )
        .then((value) {
      state.analyzeGetMatchAnalysiseDataItemEntity = value.data ?? {};
      print(
          "==================>数据${jsonEncode(state.analyzeGetMatchAnalysiseDataItemEntity)}");
      update([
        "buildPanmian",
        "buildRecentHistory",
        "pointTitleList",
        "technical_aspect",
        "buildStopMeunList"
      ]);
    });

  }

  void requestTeamsVSInfo({String day = "5", String flag = "0"}) async {

    AnalyzeDetailApi.instance().teamVSHistory(mid, flag, day).then((value) {
      print("===========>数据${ value.data?.length}");
      state.analyzeTeamsList.value = value.data ?? [];
      update(["analyzeList", "ItemHistoryHeaderWidget", "buildHistory"]);
    });


  }

  setCurSelectTab1() {
    print("========>setCurSelectTab1");
    state.curSelectTab1.value = !state.curSelectTab1.value;
    readyRequestTeamsOn();
    update(["ItemHistoryHeaderWidget"]);
  }

  setCurSelectTab2() {
    print("========>setCurSelectTab2");
    state.curSelectTab2.value = !state.curSelectTab2.value;
    readyRequestTeamsOn();
    update(["ItemHistoryHeaderWidget"]);
  }

  setcurOtherSelectTab1() {
    state.curOtherSelectTab1.value = !state.curOtherSelectTab1.value;

    readyOtherRequestTeamsOn();
    update(["itemHistoryHeaderTwoWidget"]);
  }

  setcurOtherSelectTab2() {
    state.curOtherSelectTab2.value = !state.curOtherSelectTab2.value;
    readyOtherRequestTeamsOn();
    update(["itemHistoryHeaderTwoWidget"]);
  }

  // // 加工 胜 平 负的数量
  Map<String, int> caculatorResult(
      List<AnalyzeTeamVsOtherTeamItemEntityEntity>? data) {
    Map<String, int> vsHistoryMap = {};
    vsHistoryMap["success"] = 0;
    vsHistoryMap["lose"] = 0;
    vsHistoryMap["flat"] = 0;
    for (AnalyzeTeamVsOtherTeamItemEntityEntity item in data ?? []) {
      if (item.result == 4) {
        vsHistoryMap["success"] = (vsHistoryMap["success"] ?? 0) + 1;
      } else if (item.result == 2) {
        vsHistoryMap["flat"] = (vsHistoryMap["flat"] ?? 0) + 1;
      } else if (item.result == 3) {
        vsHistoryMap["lose"] = (vsHistoryMap["lose"] ?? 0) + 1;
      }
    }
    return vsHistoryMap;
  }

  void readyRequestTeamsOn() {
    String flag = "0";
    if(showBasketBall) {
      if (state.curSelectTab1.value == true &&
          state.curSelectTab2.value == false) {
        flag = "1";
      } else if (state.curSelectTab1.value == false &&
          state.curSelectTab2.value == true) {
        flag = "2";
      } else if (state.curSelectTab1.value == true &&
          state.curSelectTab2.value == true) {
        flag = "3";
      }
    }else{

      if (state.curSelectTab1.value == true &&
          state.curSelectTab2.value == false) {
        flag = "1";
      } else if (state.curSelectTab1.value == false &&
          state.curSelectTab2.value == true) {
        flag = "2";
      } else if (state.curSelectTab1.value == true &&
          state.curSelectTab2.value == true) {
        flag = "3";
      }
    }


    print("==========>flag ${flag}");


    state.curFlag.value = flag;
    requestTeamsVSInfo(day: state.curDay.value, flag: state.curFlag.value);
  }

  void readyOtherRequestTeamsOn() {
    String flag = "0";
    if (state.curOtherSelectTab1.value == true &&
        state.curOtherSelectTab2.value == false) {
      flag = "1";
    } else if (state.curOtherSelectTab1.value == false &&
        state.curOtherSelectTab2.value == true) {
      flag = "2";
    } else if (state.curOtherSelectTab1.value == true &&
        state.curOtherSelectTab2.value == true) {
      flag = "3";
    }
    state.curOtherFlag.value = flag;
    requestOtherTeamsVSInfo(
        day: state.curOtherDay.value, flag: state.curOtherFlag.value);
  }
  getTeamName(
      MatchEntity otherMatch, {
        int? type,
      }) {
    return Get.find<MatchDetailController>(tag: tag).getTeamName(
        type: type ?? 1, match: otherMatch);
  }

  void handleData() {
    MatchEntity matchEntity =
        DataStoreController.to.getMatchById(mid??"") ?? MatchEntity();
  }

  void switchBuildHistory(int type) {
    buildHistoryType=type;
    print("===============>${buildHistoryType}");
    update(["analyzeMatchHistoryChildItem2"]);

  }
  void switchBuildRecentHistoryType(int type,String teamName) {
    buildRecentHistoryType=type;
    print("===============>${buildRecentHistoryType}");

    update(["analyzeMatchHistoryChildItem3${teamName}"]);

  }


  String getWinResultStr(num? type){
    if(showBasketBall){
      //2平 3 负 4 赢
      if(type==2){
        //平
        return LocaleKeys.analysis_football_matches_flat.tr;
      }else if(type==3){
        //负
        return LocaleKeys.analysis_football_matches_negative.tr;
      }else if(type==4){
        //赢
        return LocaleKeys.analysis_football_matches_victory.tr;

      }
    }else{
      //2平 3 负 4 赢
      if(type==2){
        //平
        return LocaleKeys.analysis_football_matches_flat.tr;
      }else if(type==3){
        //负
        return LocaleKeys.analysis_football_matches_negative.tr;
      }else if(type==4){
        //赢
        return LocaleKeys.analysis_football_matches_win.tr;
      }
    }

    return  LocaleKeys.analysis_football_matches_victory.tr;
  }

  Color getWinResultTextColor(String type){
    Map<String,Color> map={
      LocaleKeys.analysis_football_matches_flat.tr: Get.theme.equalResultColor,
      LocaleKeys.analysis_football_matches_negative.tr: Get.theme.winResultColor,
      LocaleKeys.analysis_football_matches_victory.tr: Get.theme.loseResultColor,


      LocaleKeys.analysis_football_matches_lose.tr: Get.theme.winResultColor,
      LocaleKeys.analysis_football_matches_win.tr: Get.theme.loseResultColor,


      LocaleKeys.analysis_football_matches_big.tr: Get.theme.loseResultColor,
      LocaleKeys.analysis_football_matches_small.tr: Get.theme.winResultColor,
      LocaleKeys.analysis_football_matches_level.tr: Get.theme.equalResultColor,
    };
    return  map[type]??Colors.grey;
  }
  String getWinResultStr1(num? type){
    //2平 3 负 4 胜
    if(type==2){
      //平
      return LocaleKeys.analysis_football_matches_level.tr;
    }else if(type==3){
      //负
      return LocaleKeys.analysis_football_matches_lose.tr;
    }else if(type==4){
      //负
      return  LocaleKeys.analysis_football_matches_win.tr;
    }
    return  LocaleKeys.ouzhou_no_data_no_data.tr;
  }

  String getWinResultStr2(num? type){
    //2平 3 负 4 胜
    if(type==3){
      //平
      //负
      return LocaleKeys.analysis_football_matches_small.tr;

    }else if(type==4){
      return LocaleKeys.analysis_football_matches_big.tr;
    }
    return  LocaleKeys.ouzhou_no_data_no_data.tr;
  }

  String getWinResultStr3(num? type){
    //2平 3 负 4 胜
    if(type==4){
      //平
      return LocaleKeys.bet_record_bet_win.tr;
    }else if(type==3){
      //负
      return LocaleKeys.analysis_football_matches_lose.tr;
    }else if(type==2){
      //负
      return  LocaleKeys.analysis_football_matches_level.tr;
    }
    return  LocaleKeys.ouzhou_no_data_no_data.tr;

  }
  requestTest(){


    //  测试代码  联赛积分
    Future.delayed(Duration(seconds:8), () {
      String data ="[{\"drawTotal\":4,\"goalDiffTotal\":6,\"goalsAgainstTotal\":35,\"goalsForTotal\":41,\"lossTotal\":13,\"matchCount\":32,\"matchGroup\":0,\"pointsTotal\":49,\"positionTotal\":7,\"teamFlag\":\"t1\",\"teamLogo\":\"group1/M00/18/8A/CgURt2QBoSiAZBYTAAAb_Kak85Q859.png\",\"teamName\":\"拉齐奥\",\"thirdTeamSourceId\":\"1129\",\"tournamentName\":\"意甲\",\"tournamentType\":1,\"winTotal\":15},{\"drawTotal\":12,\"goalDiffTotal\":-4,\"goalsAgainstTotal\":39,\"goalsForTotal\":35,\"lossTotal\":11,\"matchCount\":32,\"matchGroup\":0,\"pointsTotal\":39,\"positionTotal\":12,\"teamFlag\":\"t2\",\"teamLogo\":\"group1/M00/00/28/CgURt17rI02AZL0sAAAQMtJ1izY156.png\",\"teamName\":\"热那亚\",\"thirdTeamSourceId\":\"1142\",\"tournamentName\":\"意甲\",\"tournamentType\":1,\"winTotal\":9}]";
      List<AnalyzeVSInfoEntity> dataList = (jsonDecode(data) as List)
          .map((e) => AnalyzeVSInfoEntity.fromJson(e))
          .toList();
      state.analyzeList.value = dataList;
      print("==========>2 ${ state.analyzeList.value.length}");
      update(["analyzeList","pointTitleList"]);
    });

    //  测试代码
    Future.delayed(Duration(seconds: 3), () {
      String data =
          "[{\"awayTeamId\":\"8667\",\"awayTeamName\":\"阿东那\",\"awayTeamScore\":\"0\",\"beginTime\":\"1708839000000\",\"boldTagName\":\"欧克莱卡诺\",\"handicapOdds\":\"\",\"handicapResult\":null,\"handicapVal\":\"\",\"homeTeamId\":\"7701\",\"homeTeamName\":\"欧克莱卡诺\",\"homeTeamScore\":\"3\",\"matchGroup\":0,\"overunderOdds\":\"\",\"overunderResult\":null,\"overunderVal\":\"\",\"result\":4,\"sportId\":\"1\",\"teamGroup\":\"\",\"thirdMatchId\":\"1746174595117568003\",\"tournamentName\":\"澳维国家超\",\"winnerOdds\":\"\"},{\"awayTeamId\":\"8667\",\"awayTeamName\":\"阿东那\",\"awayTeamScore\":\"0\",\"beginTime\":\"1692957600000\",\"boldTagName\":\"欧克莱卡诺\",\"handicapOdds\":\"\",\"handicapResult\":4,\"handicapVal\":\"-1/1.5\",\"homeTeamId\":\"7701\",\"homeTeamName\":\"欧克莱卡诺\",\"homeTeamScore\":\"5\",\"matchGroup\":0,\"overunderOdds\":\"\",\"overunderResult\":4,\"overunderVal\":\"3.25\",\"result\":4,\"sportId\":\"1\",\"teamGroup\":\"\",\"thirdMatchId\":\"1694398024174751746\",\"tournamentName\":\"澳维国家超\",\"winnerOdds\":\"\"},{\"awayTeamId\":\"7701\",\"awayTeamName\":\"欧克莱卡诺\",\"awayTeamScore\":\"1\",\"beginTime\":\"1690013700000\",\"boldTagName\":\"阿东那\",\"handicapOdds\":\"\",\"handicapResult\":null,\"handicapVal\":\"\",\"homeTeamId\":\"8667\",\"homeTeamName\":\"阿东那\",\"homeTeamScore\":\"2\",\"matchGroup\":0,\"overunderOdds\":\"\",\"overunderResult\":null,\"overunderVal\":\"\",\"result\":3,\"sportId\":\"1\",\"teamGroup\":\"\",\"thirdMatchId\":\"1613194134331281410\",\"tournamentName\":\"澳维国家超\",\"winnerOdds\":\"\"},{\"awayTeamId\":\"8667\",\"awayTeamName\":\"阿东那\",\"awayTeamScore\":\"1\",\"beginTime\":\"1682073000000\",\"boldTagName\":\"欧克莱卡诺\",\"handicapOdds\":\"\",\"handicapResult\":4,\"handicapVal\":\"-1.5\",\"homeTeamId\":\"7701\",\"homeTeamName\":\"欧克莱卡诺\",\"homeTeamScore\":\"5\",\"matchGroup\":0,\"overunderOdds\":\"\",\"overunderResult\":4,\"overunderVal\":\"3.25\",\"result\":4,\"sportId\":\"1\",\"teamGroup\":\"\",\"thirdMatchId\":\"1613194119564316676\",\"tournamentName\":\"澳维国家超\",\"winnerOdds\":\"\"},{\"awayTeamId\":\"8667\",\"awayTeamName\":\"阿东那\",\"awayTeamScore\":\"0\",\"beginTime\":\"1655544600000\",\"boldTagName\":\"欧克莱卡诺\",\"handicapOdds\":\"\",\"handicapResult\":null,\"handicapVal\":\"\",\"homeTeamId\":\"7701\",\"homeTeamName\":\"欧克莱卡诺\",\"homeTeamScore\":\"3\",\"matchGroup\":0,\"overunderOdds\":\"\",\"overunderResult\":null,\"overunderVal\":\"\",\"result\":4,\"sportId\":\"1\",\"teamGroup\":\"\",\"thirdMatchId\":\"0\",\"tournamentName\":\"澳维国家超\",\"winnerOdds\":\"\"}]";
      List<AnalyzeTeamVsHistoryEntity> dataList = (jsonDecode(data) as List)
          .map((e) => AnalyzeTeamVsHistoryEntity.fromJson(e))
          .toList();
      state.analyzeTeamsList.value = dataList;
      update(["buildHistory"]);
    });

    //  测试代码
    Future.delayed(Duration(seconds: 10), () {
      String data ="{\"inParam\":{\"historyAddition\":null,\"histroyQueryMatchSize\":null,\"homeNearAddition\":null,\"homeNearMatchSize\":null,\"lang\":\"zs\",\"parentMenuId\":2,\"sonMenuId\":3,\"standardMatchId\":\"3253141\"},\"basicInfoMap\":{\"sThirdMatchSidelinedDTOMap\":{\"1\":[{\"homeAway\":1,\"playerName\":\"卡佩尔普日比尔科\",\"positionName\":\"后卫\",\"reason\":\"受伤\",\"shirtNumber\":27,\"thirdPlayerPicUrl\":\"https://img.tysondata.com/players/20240220010135142_150x150.png\"}],\"2\":[{\"homeAway\":2,\"playerName\":\"奎维辛\",\"positionName\":\"后卫\",\"reason\":\"黄牌\",\"shirtNumber\":94,\"thirdPlayerPicUrl\":\"https://img.tysondata.com/players/20240406200357439_150x150.png\"},{\"homeAway\":2,\"playerName\":\"杰塞克波德戈斯基\",\"positionName\":\"\",\"reason\":\"黄牌\",\"shirtNumber\":6,\"thirdPlayerPicUrl\":\"https://img.tysondata.com/players/20240406200413872_150x150.png\"},{\"homeAway\":2,\"playerName\":\"约阿夫奥夫梅斯泰\",\"positionName\":\"\",\"reason\":\"红牌\",\"shirtNumber\":null,\"thirdPlayerPicUrl\":\"\"},{\"homeAway\":2,\"playerName\":\"基里洛-彼得罗夫\",\"positionName\":\"\",\"reason\":\"受伤\",\"shirtNumber\":90,\"thirdPlayerPicUrl\":\"https://img.tysondata.com/players/20240329011043162_150x150.png\"}]},\"sThirdMatchFutureStatisticsDTOMap\":{\"1\":[{\"awayTeamName\":\"拉多麦科\",\"beginTime\":\"1713542400000\",\"homeTeamName\":\"科罗纳\",\"intervalDay\":8,\"tournamentName\":\"波兰超级联赛\"},{\"awayTeamName\":\"科罗纳\",\"beginTime\":\"1714410000000\",\"homeTeamName\":\"涅波沃米采\",\"intervalDay\":18,\"tournamentName\":\"波兰超级联赛\"},{\"awayTeamName\":\"皮亚斯特\",\"beginTime\":\"1714914000000\",\"homeTeamName\":\"科罗纳\",\"intervalDay\":23,\"tournamentName\":\"波兰超级联赛\"},{\"awayTeamName\":\"科罗纳\",\"beginTime\":\"1715441400000\",\"homeTeamName\":\"乔治罗尼亚\",\"intervalDay\":29,\"tournamentName\":\"波兰超级联赛\"},{\"awayTeamName\":\"罗切霍茹夫\",\"beginTime\":\"1716048000000\",\"homeTeamName\":\"科罗纳\",\"intervalDay\":37,\"tournamentName\":\"波兰超级联赛\"}],\"2\":[{\"awayTeamName\":\"梅莱茨钢铁\",\"beginTime\":\"1713805200000\",\"homeTeamName\":\"波兹南瓦塔\",\"intervalDay\":11,\"tournamentName\":\"波兰超级联赛\"},{\"awayTeamName\":\"波兹南瓦塔\",\"beginTime\":\"1714147200000\",\"homeTeamName\":\"皮亚斯特\",\"intervalDay\":15,\"tournamentName\":\"波兰超级联赛\"},{\"awayTeamName\":\"维泽夫洛兹\",\"beginTime\":\"1714905000000\",\"homeTeamName\":\"波兹南瓦塔\",\"intervalDay\":23,\"tournamentName\":\"波兰超级联赛\"},{\"awayTeamName\":\"波兹南瓦塔\",\"beginTime\":\"1715509800000\",\"homeTeamName\":\"涅波沃米采\",\"intervalDay\":30,\"tournamentName\":\"波兰超级联赛\"},{\"awayTeamName\":\"华沙莱吉亚\",\"beginTime\":\"1716048000000\",\"homeTeamName\":\"波兹南瓦塔\",\"intervalDay\":37,\"tournamentName\":\"波兰超级联赛\"}]}},\"sThirdMatchHistoryOddsDTOList\":[{\"bookName\":\"金宝博\",\"handicapOddsDTOList\":[{\"active\":1,\"directions\":null,\"handicapVal\":-0.75,\"returnRate\":null,\"type\":\"1\",\"value\":1.66,\"value0\":1.92,\"value0WinRate\":null,\"valueWinRate\":null},{\"active\":1,\"directions\":{\"value0\":-1,\"handicapVal\":1,\"value\":1},\"handicapVal\":-0.5,\"returnRate\":null,\"type\":\"2\",\"value\":1.8,\"value0\":1.92,\"value0WinRate\":null,\"valueWinRate\":null}]},{\"bookName\":\"VBet\",\"handicapOddsDTOList\":[{\"active\":null,\"directions\":null,\"handicapVal\":-0.5,\"returnRate\":null,\"type\":\"1\",\"value\":1.92,\"value0\":1.78,\"value0WinRate\":null,\"valueWinRate\":null},{\"active\":null,\"directions\":{\"value0\":1,\"handicapVal\":-1,\"value\":-1},\"handicapVal\":-0.75,\"returnRate\":null,\"type\":\"2\",\"value\":1.86,\"value0\":1.84,\"value0WinRate\":null,\"valueWinRate\":null}]},{\"bookName\":\"Bet365\",\"handicapOddsDTOList\":[{\"active\":1,\"directions\":null,\"handicapVal\":-0.75,\"returnRate\":null,\"type\":\"1\",\"value\":1.83,\"value0\":1.98,\"value0WinRate\":null,\"valueWinRate\":null},{\"active\":1,\"directions\":{\"value0\":-1,\"handicapVal\":1,\"value\":1},\"handicapVal\":0.25,\"returnRate\":null,\"type\":\"2\",\"value\":1.95,\"value0\":1.85,\"value0WinRate\":null,\"valueWinRate\":null}]},{\"bookName\":\"18Bet\",\"handicapOddsDTOList\":[{\"active\":1,\"directions\":null,\"handicapVal\":-0.5,\"returnRate\":null,\"type\":\"1\",\"value\":1.97,\"value0\":1.79,\"value0WinRate\":null,\"valueWinRate\":null},{\"active\":1,\"directions\":{\"value0\":1,\"handicapVal\":-1,\"value\":-1},\"handicapVal\":-0.5,\"returnRate\":null,\"type\":\"2\",\"value\":1.89,\"value0\":1.87,\"value0WinRate\":null,\"valueWinRate\":null}]},{\"bookName\":\"HG皇冠\",\"handicapOddsDTOList\":[{\"active\":1,\"directions\":null,\"handicapVal\":-0.75,\"returnRate\":null,\"type\":\"1\",\"value\":1.62,\"value0\":1.91,\"value0WinRate\":null,\"valueWinRate\":null},{\"active\":1,\"directions\":{\"value0\":-1,\"handicapVal\":1,\"value\":1},\"handicapVal\":-0.5,\"returnRate\":null,\"type\":\"2\",\"value\":1.79,\"value0\":1.91,\"value0WinRate\":null,\"valueWinRate\":null}]},{\"bookName\":\"平博\",\"handicapOddsDTOList\":[{\"active\":1,\"directions\":null,\"handicapVal\":-0.5,\"returnRate\":null,\"type\":\"1\",\"value\":1.96,\"value0\":1.74,\"value0WinRate\":null,\"valueWinRate\":null},{\"active\":1,\"directions\":{\"value0\":1,\"handicapVal\":-1,\"value\":-1},\"handicapVal\":-0.5,\"returnRate\":null,\"type\":\"2\",\"value\":1.93,\"value0\":1.81,\"value0WinRate\":null,\"valueWinRate\":null}]}],\"matchHistoryBattleDTOMap\":{\"1\":{\"handicapResultList\":[3,4,4,3,2,2,2,2,2,4],\"matchHistoryBattleDetailDTOList\":[{\"handicapResultEqual\":5,\"handicapResultLose\":2,\"handicapResultWin\":3,\"handicapResultWinRate\":0.3,\"overunderResultEqual\":4,\"overunderResultLose\":1,\"overunderResultLoseRate\":0.1,\"overunderResultWin\":5,\"overunderResultWinRate\":0.5,\"postionFlag\":1},{\"handicapResultEqual\":2,\"handicapResultLose\":2,\"handicapResultWin\":2,\"handicapResultWinRate\":0.3333,\"overunderResultEqual\":2,\"overunderResultLose\":1,\"overunderResultLoseRate\":0.1667,\"overunderResultWin\":3,\"overunderResultWinRate\":0.5,\"postionFlag\":2},{\"handicapResultEqual\":3,\"handicapResultLose\":0,\"handicapResultWin\":1,\"handicapResultWinRate\":0.25,\"overunderResultEqual\":2,\"overunderResultLose\":0,\"overunderResultLoseRate\":0,\"overunderResultWin\":2,\"overunderResultWinRate\":0.5,\"postionFlag\":3}],\"overunderResultList\":[3,4,4,4,2,2,2,2,4,4]},\"2\":{\"handicapResultList\":[4,2,4,2,2,4,2,2,2,3],\"matchHistoryBattleDetailDTOList\":[{\"handicapResultEqual\":6,\"handicapResultLose\":1,\"handicapResultWin\":3,\"handicapResultWinRate\":0.3,\"overunderResultEqual\":5,\"overunderResultLose\":3,\"overunderResultLoseRate\":0.3,\"overunderResultWin\":2,\"overunderResultWinRate\":0.2,\"postionFlag\":1},{\"handicapResultEqual\":5,\"handicapResultLose\":0,\"handicapResultWin\":0,\"handicapResultWinRate\":0,\"overunderResultEqual\":4,\"overunderResultLose\":1,\"overunderResultLoseRate\":0.2,\"overunderResultWin\":0,\"overunderResultWinRate\":0,\"postionFlag\":2},{\"handicapResultEqual\":1,\"handicapResultLose\":1,\"handicapResultWin\":3,\"handicapResultWinRate\":0.6,\"overunderResultEqual\":1,\"overunderResultLose\":2,\"overunderResultLoseRate\":0.4,\"overunderResultWin\":2,\"overunderResultWinRate\":0.4,\"postionFlag\":3}],\"overunderResultList\":[4,2,3,2,3,4,2,2,2,3]}},\"homeAwayGoalAndCoachMap\":{\"homeGoalMap\":{},\"sThirdMatchCoachDTOMap\":{\"1\":[{\"coachBirthdate\":\"1976-02-05\",\"coachGameCount\":null,\"coachName\":\"约翰阿洛伊西\",\"coachStyle\":\"4-2-3-1\",\"drawCount\":45,\"homeAway\":1,\"loseCount\":98,\"score\":\"1.29\",\"winCount\":82}],\"2\":[{\"coachBirthdate\":\"1973-07-04\",\"coachGameCount\":null,\"coachName\":\"波波维奇\",\"coachStyle\":\"4-2-3-1\",\"drawCount\":79,\"homeAway\":2,\"loseCount\":112,\"score\":\"1.50\",\"winCount\":138}]},\"awayGoalMap\":{}}}";
      var analyzeGetMatchAnalysiseDataItemEntity=jsonDecode(data);
      state.analyzeGetMatchAnalysiseDataItemEntity= analyzeGetMatchAnalysiseDataItemEntity ;
      update([
        "buildPanmian",
        "buildRecentHistory",
        "pointTitleList",
        "technical_aspect",
        "buildStopMeunList"
      ]);
    });
    //  测试代码
    Future.delayed(Duration(seconds: 3), () {
      String dataValue ="[{\"awayTeamId\":\"10943\",\"awayTeamName\":\"西隆拉庄\",\"awayTeamScore\":\"0\",\"beginTime\":\"1710077400000\",\"boldTagName\":\"皇家克什米尔\",\"handicapOdds\":\"\",\"handicapResult\":4,\"handicapVal\":\"-0/0.5\",\"homeTeamId\":\"13040\",\"homeTeamName\":\"皇家克什米尔\",\"homeTeamScore\":\"0\",\"matchGroup\":0,\"overunderOdds\":\"\",\"overunderResult\":3,\"overunderVal\":\"2.5\",\"result\":2,\"sportId\":\"1\",\"teamGroup\":\"10943\",\"thirdMatchId\":\"1759312732259528706\",\"tournamentName\":\"印度I\",\"winnerOdds\":\"\"},{\"awayTeamId\":\"10943\",\"awayTeamName\":\"西隆拉庄\",\"awayTeamScore\":\"3\",\"beginTime\":\"1709550000000\",\"boldTagName\":\"皇家克什米尔\",\"handicapOdds\":\"\",\"handicapResult\":4,\"handicapVal\":\"-0.5/1\",\"homeTeamId\":\"346764\",\"homeTeamName\":\"皇家克什米尔\",\"homeTeamScore\":\"2\",\"matchGroup\":0,\"overunderOdds\":\"\",\"overunderResult\":4,\"overunderVal\":\"2.5\",\"result\":4,\"sportId\":\"1\",\"teamGroup\":\"10943\",\"thirdMatchId\":\"1751918022959255553\",\"tournamentName\":\"印度I\",\"winnerOdds\":\"\"},{\"awayTeamId\":\"10943\",\"awayTeamName\":\"西隆拉庄\",\"awayTeamScore\":\"1\",\"beginTime\":\"1709118000000\",\"boldTagName\":\"皇家克什米尔\",\"handicapOdds\":\"\",\"handicapResult\":4,\"handicapVal\":\"0/0.5\",\"homeTeamId\":\"10168\",\"homeTeamName\":\"皇家克什米尔\",\"homeTeamScore\":\"0\",\"matchGroup\":0,\"overunderOdds\":\"\",\"overunderResult\":3,\"overunderVal\":\"2.5\",\"result\":4,\"sportId\":\"1\",\"teamGroup\":\"10943\",\"thirdMatchId\":\"1750417151859445762\",\"tournamentName\":\"印度I\",\"winnerOdds\":\"\"},{\"awayTeamId\":\"10943\",\"awayTeamName\":\"西隆拉庄\",\"awayTeamScore\":\"1\",\"beginTime\":\"1708772400000\",\"boldTagName\":\"皇家克什米尔\",\"handicapOdds\":\"\",\"handicapResult\":3,\"handicapVal\":\"0/0.5\",\"homeTeamId\":\"464426\",\"homeTeamName\":\"皇家克什米尔\",\"homeTeamScore\":\"1\",\"matchGroup\":0,\"overunderOdds\":\"\",\"overunderResult\":3,\"overunderVal\":\"2.75\",\"result\":2,\"sportId\":\"1\",\"teamGroup\":\"10943\",\"thirdMatchId\":\"1750417151708450817\",\"tournamentName\":\"印度I\",\"winnerOdds\":\"\"},{\"awayTeamId\":\"10943\",\"awayTeamName\":\"西隆拉庄\",\"awayTeamScore\":\"2\",\"beginTime\":\"1708263000000\",\"boldTagName\":\"皇家克什米尔\",\"handicapOdds\":\"\",\"handicapResult\":4,\"handicapVal\":\"-0/0.5\",\"homeTeamId\":\"5142\",\"homeTeamName\":\"皇家克什米尔\",\"homeTeamScore\":\"0\",\"matchGroup\":0,\"overunderOdds\":\"\",\"overunderResult\":3,\"overunderVal\":\"2.5\",\"result\":4,\"sportId\":\"1\",\"teamGroup\":\"10943\",\"thirdMatchId\":\"1750417151226105857\",\"tournamentName\":\"印度I\",\"winnerOdds\":\"\"},{\"awayTeamId\":\"6562\",\"awayTeamName\":\"皇家克什米尔\",\"awayTeamScore\":\"2\",\"beginTime\":\"1709982000000\",\"boldTagName\":\"皇家克什米尔\",\"handicapOdds\":\"\",\"handicapResult\":4,\"handicapVal\":\"0\",\"homeTeamId\":\"10168\",\"homeTeamName\":\"西隆拉庄\",\"homeTeamScore\":\"1\",\"matchGroup\":0,\"overunderOdds\":\"\",\"overunderResult\":4,\"overunderVal\":\"2.75\",\"result\":4,\"sportId\":\"1\",\"teamGroup\":\"6562\",\"thirdMatchId\":\"1759312732192419842\",\"tournamentName\":\"印度I\",\"winnerOdds\":\"\"},{\"awayTeamId\":\"6562\",\"awayTeamName\":\"皇家克什米尔\",\"awayTeamScore\":\"1\",\"beginTime\":\"1709559000000\",\"boldTagName\":\"皇家克什米尔\",\"handicapOdds\":\"\",\"handicapResult\":4,\"handicapVal\":\"-0/0.5\",\"homeTeamId\":\"5142\",\"homeTeamName\":\"西隆拉庄\",\"homeTeamScore\":\"1\",\"matchGroup\":0,\"overunderOdds\":\"\",\"overunderResult\":3,\"overunderVal\":\"2.5\",\"result\":2,\"sportId\":\"1\",\"teamGroup\":\"6562\",\"thirdMatchId\":\"1751918022963449857\",\"tournamentName\":\"印度I\",\"winnerOdds\":\"\"},{\"awayTeamId\":\"193834\",\"awayTeamName\":\"西隆拉庄\",\"awayTeamScore\":\"2\",\"beginTime\":\"1709127000000\",\"boldTagName\":\"西隆拉庄\",\"handicapOdds\":\"\",\"handicapResult\":3,\"handicapVal\":\"-0.5/1\",\"homeTeamId\":\"6562\",\"homeTeamName\":\"皇家克什米尔\",\"homeTeamScore\":\"2\",\"matchGroup\":0,\"overunderOdds\":\"\",\"overunderResult\":4,\"overunderVal\":\"2.75\",\"result\":2,\"sportId\":\"1\",\"teamGroup\":\"6562\",\"thirdMatchId\":\"1750417151897194497\",\"tournamentName\":\"印度I\",\"winnerOdds\":\"\"},{\"awayTeamId\":\"6562\",\"awayTeamName\":\"皇家克什米尔\",\"awayTeamScore\":\"2\",\"beginTime\":\"1708867800000\",\"boldTagName\":\"皇家克什米尔\",\"handicapOdds\":\"\",\"handicapResult\":4,\"handicapVal\":\"0.5\",\"homeTeamId\":\"100124\",\"homeTeamName\":\"西隆拉庄\",\"homeTeamScore\":\"1\",\"matchGroup\":0,\"overunderOdds\":\"\",\"overunderResult\":2,\"overunderVal\":\"3\",\"result\":4,\"sportId\":\"1\",\"teamGroup\":\"6562\",\"thirdMatchId\":\"1750417151729422338\",\"tournamentName\":\"印度I\",\"winnerOdds\":\"\"},{\"awayTeamId\":\"6562\",\"awayTeamName\":\"皇家克什米尔\",\"awayTeamScore\":\"2\",\"beginTime\":\"1708245000000\",\"boldTagName\":\"皇家克什米尔\",\"handicapOdds\":\"\",\"handicapResult\":4,\"handicapVal\":\"0.5/1\",\"homeTeamId\":\"13041\",\"homeTeamName\":\"西隆拉庄\",\"homeTeamScore\":\"0\",\"matchGroup\":0,\"overunderOdds\":\"\",\"overunderResult\":3,\"overunderVal\":\"3.25\",\"result\":4,\"sportId\":\"1\",\"teamGroup\":\"6562\",\"thirdMatchId\":\"1750417151268048897\",\"tournamentName\":\"印度I\",\"winnerOdds\":\"\"}]";
      List<AnalyzeTeamVsOtherTeamItemEntityEntity> data =
      (jsonDecode(dataValue) as List)
          .map((e) => AnalyzeTeamVsOtherTeamItemEntityEntity.fromJson(e))
          .toList();
      state.analyzeTeamVsOtherTeamItemList.value = data ;
      var findId = data![0]?.teamGroup??"";
      List<AnalyzeTeamVsOtherTeamItemEntityEntity> home =[];
      List<AnalyzeTeamVsOtherTeamItemEntityEntity> away =[];
      for(AnalyzeTeamVsOtherTeamItemEntityEntity item in data??[]) {
        if (item.teamGroup == findId) {
          home.add(item);
        } else {
          away.add(item);
        }
      }

      state.homeVSHistoryMap=caculatorResult(home);
      state.awayVSHistoryMap=caculatorResult(away);
      state.home=home;
      state.away=away;
      update(["analyzeList","buildRecentHistory"]);
    });

  }
  String getPlayImage(String awayTeamName) {

    MatchEntity matchEntity =
        DataStoreController.to.getMatchById(mid??"") ?? MatchEntity();
    // 1主队 2客队
    String team1 = getTeamName(matchEntity, type: 1);
    String url="";

    if(awayTeamName==  team1){
      url=  Get.find<MatchDetailController>(tag: tag).detailState.match?.mhlu[0];
    }else{
      url=  Get.find<MatchDetailController>(tag: tag).detailState.match?.malu[0];
    }
    print("------->url   ${url}  ");


    return url;
  }
}
