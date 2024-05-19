import 'package:get/get.dart';

import '../../../../../services/api/analyze_detail_api.dart';
import '../../../../login/login_head_import.dart';
import '../../../../match_detail/controllers/analyze_tab_controller.dart';
import '../../../../match_detail/controllers/match_detail_controller.dart';
import 'analyze_match_odds_state.dart';

class AnalyzeMatchOddsLogic extends GetxController
    with GetSingleTickerProviderStateMixin {
  static AnalyzeMatchOddsLogic get to => Get.find();
  final AnalyzeMatchOddsState state = AnalyzeMatchOddsState();
  late TabController tabController;
  String? mid;
  String? tag;


  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this)
      ..addListener(() {
        if (tabController.index.toDouble() == tabController.animation?.value) {
          print("======>");
          state.curMainTab.value = tabController.index;
          requestMatchAnalysiseData("5", "${state.curMainTab.value+1}", mid);
        }
      });
  }

  @override
  void onReady(){
    initData();
    super.onReady();
  }

  void requestMatchAnalysiseData(
    String? parentMenuId,
    String? sonMenuId,
    String? standardMatchId,
  {int updateIndex=0}
  ) async {


    AnalyzeDetailApi.instance()
        .getMatchAnalysiseData(
      parentMenuId,
      sonMenuId,
      mid,
    ).then((value) {

      state.analyzeGetMatchAnalysiseDataItemEntity = value.data ?? {};

      print(
          "------------------->analyzeMatchOddsLogic${sonMenuId}");

      update([
        "analyzeMatchOddsLogic${sonMenuId}",
      ]);
    });

    //测试代码
    bool env =const bool.fromEnvironment("PACKAGE_MOCK", defaultValue: false);
    if(env){
      requestTest();
    }

  }

  void requestTest() {
    //  测试代码
    Future.delayed(Duration(seconds: 3), () {
      String data ="{\"inParam\":{\"historyAddition\":null,\"histroyQueryMatchSize\":null,\"homeNearAddition\":null,\"homeNearMatchSize\":null,\"lang\":\"zs\",\"parentMenuId\":2,\"sonMenuId\":3,\"standardMatchId\":\"3253141\"},\"sThirdMatchHistoryOddsDTOList\":[{\"bookName\":\"金宝博\",\"handicapOddsDTOList\":[{\"active\":1,\"directions\":null,\"handicapVal\":-0.75,\"returnRate\":null,\"type\":\"1\",\"value\":1.66,\"value0\":1.92,\"value0WinRate\":null,\"valueWinRate\":null},{\"active\":1,\"directions\":{\"value0\":-1,\"handicapVal\":1,\"value\":1},\"handicapVal\":-0.5,\"returnRate\":null,\"type\":\"2\",\"value\":1.8,\"value0\":1.92,\"value0WinRate\":null,\"valueWinRate\":null}]},{\"bookName\":\"VBet\",\"handicapOddsDTOList\":[{\"active\":null,\"directions\":null,\"handicapVal\":-0.5,\"returnRate\":null,\"type\":\"1\",\"value\":1.92,\"value0\":1.78,\"value0WinRate\":null,\"valueWinRate\":null},{\"active\":null,\"directions\":{\"value0\":1,\"handicapVal\":-1,\"value\":-1},\"handicapVal\":-0.75,\"returnRate\":null,\"type\":\"2\",\"value\":1.86,\"value0\":1.84,\"value0WinRate\":null,\"valueWinRate\":null}]},{\"bookName\":\"Bet365\",\"handicapOddsDTOList\":[{\"active\":1,\"directions\":null,\"handicapVal\":-0.75,\"returnRate\":null,\"type\":\"1\",\"value\":1.83,\"value0\":1.98,\"value0WinRate\":null,\"valueWinRate\":null},{\"active\":1,\"directions\":{\"value0\":-1,\"handicapVal\":1,\"value\":1},\"handicapVal\":0.25,\"returnRate\":null,\"type\":\"2\",\"value\":1.95,\"value0\":1.85,\"value0WinRate\":null,\"valueWinRate\":null}]},{\"bookName\":\"18Bet\",\"handicapOddsDTOList\":[{\"active\":1,\"directions\":null,\"handicapVal\":-0.5,\"returnRate\":null,\"type\":\"1\",\"value\":1.97,\"value0\":1.79,\"value0WinRate\":null,\"valueWinRate\":null},{\"active\":1,\"directions\":{\"value0\":1,\"handicapVal\":-1,\"value\":-1},\"handicapVal\":-0.5,\"returnRate\":null,\"type\":\"2\",\"value\":1.89,\"value0\":1.87,\"value0WinRate\":null,\"valueWinRate\":null}]},{\"bookName\":\"HG皇冠\",\"handicapOddsDTOList\":[{\"active\":1,\"directions\":null,\"handicapVal\":-0.75,\"returnRate\":null,\"type\":\"1\",\"value\":1.62,\"value0\":1.91,\"value0WinRate\":null,\"valueWinRate\":null},{\"active\":1,\"directions\":{\"value0\":-1,\"handicapVal\":1,\"value\":1},\"handicapVal\":-0.5,\"returnRate\":null,\"type\":\"2\",\"value\":1.79,\"value0\":1.91,\"value0WinRate\":null,\"valueWinRate\":null}]},{\"bookName\":\"平博\",\"handicapOddsDTOList\":[{\"active\":1,\"directions\":null,\"handicapVal\":-0.5,\"returnRate\":null,\"type\":\"1\",\"value\":1.96,\"value0\":1.74,\"value0WinRate\":null,\"valueWinRate\":null},{\"active\":1,\"directions\":{\"value0\":1,\"handicapVal\":-1,\"value\":-1},\"handicapVal\":-0.5,\"returnRate\":null,\"type\":\"2\",\"value\":1.93,\"value0\":1.81,\"value0WinRate\":null,\"valueWinRate\":null}]}],\"matchHistoryBattleDTOMap\":{\"1\":{\"handicapResultList\":[3,4,4,3,2,2,2,2,2,4],\"matchHistoryBattleDetailDTOList\":[{\"handicapResultEqual\":5,\"handicapResultLose\":2,\"handicapResultWin\":3,\"handicapResultWinRate\":0.3,\"overunderResultEqual\":4,\"overunderResultLose\":1,\"overunderResultLoseRate\":0.1,\"overunderResultWin\":5,\"overunderResultWinRate\":0.5,\"postionFlag\":1},{\"handicapResultEqual\":2,\"handicapResultLose\":2,\"handicapResultWin\":2,\"handicapResultWinRate\":0.3333,\"overunderResultEqual\":2,\"overunderResultLose\":1,\"overunderResultLoseRate\":0.1667,\"overunderResultWin\":3,\"overunderResultWinRate\":0.5,\"postionFlag\":2},{\"handicapResultEqual\":3,\"handicapResultLose\":0,\"handicapResultWin\":1,\"handicapResultWinRate\":0.25,\"overunderResultEqual\":2,\"overunderResultLose\":0,\"overunderResultLoseRate\":0,\"overunderResultWin\":2,\"overunderResultWinRate\":0.5,\"postionFlag\":3}],\"overunderResultList\":[3,4,4,4,2,2,2,2,4,4]},\"2\":{\"handicapResultList\":[4,2,4,2,2,4,2,2,2,3],\"matchHistoryBattleDetailDTOList\":[{\"handicapResultEqual\":6,\"handicapResultLose\":1,\"handicapResultWin\":3,\"handicapResultWinRate\":0.3,\"overunderResultEqual\":5,\"overunderResultLose\":3,\"overunderResultLoseRate\":0.3,\"overunderResultWin\":2,\"overunderResultWinRate\":0.2,\"postionFlag\":1},{\"handicapResultEqual\":5,\"handicapResultLose\":0,\"handicapResultWin\":0,\"handicapResultWinRate\":0,\"overunderResultEqual\":4,\"overunderResultLose\":1,\"overunderResultLoseRate\":0.2,\"overunderResultWin\":0,\"overunderResultWinRate\":0,\"postionFlag\":2},{\"handicapResultEqual\":1,\"handicapResultLose\":1,\"handicapResultWin\":3,\"handicapResultWinRate\":0.6,\"overunderResultEqual\":1,\"overunderResultLose\":2,\"overunderResultLoseRate\":0.4,\"overunderResultWin\":2,\"overunderResultWinRate\":0.4,\"postionFlag\":3}],\"overunderResultList\":[4,2,3,2,3,4,2,2,2,3]}},\"homeAwayGoalAndCoachMap\":{\"homeGoalMap\":{},\"sThirdMatchCoachDTOMap\":{\"1\":[{\"coachBirthdate\":\"1976-02-05\",\"coachGameCount\":null,\"coachName\":\"约翰阿洛伊西\",\"coachStyle\":\"4-2-3-1\",\"drawCount\":45,\"homeAway\":1,\"loseCount\":98,\"score\":\"1.29\",\"winCount\":82}],\"2\":[{\"coachBirthdate\":\"1973-07-04\",\"coachGameCount\":null,\"coachName\":\"波波维奇\",\"coachStyle\":\"4-2-3-1\",\"drawCount\":79,\"homeAway\":2,\"loseCount\":112,\"score\":\"1.50\",\"winCount\":138}]},\"awayGoalMap\":{}}}";
      var analyzeGetMatchAnalysiseDataItemEntity=jsonDecode(data);
      state.analyzeGetMatchAnalysiseDataItemEntity= analyzeGetMatchAnalysiseDataItemEntity ;
      update(["buildPanmian","buildRecentHistory"]);
    });

  }

  void initData() async {
    MatchDetailController controller = Get.find<MatchDetailController>(tag: tag);
    mid = controller.detailState.mId;
    requestMatchAnalysiseData("5", "${state.curMainTab.value+1}", mid);
  }
}
