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
import '../../../../match_detail/controllers/analyze_tab_controller.dart';
import 'analyze_battle_array_state.dart';

class AnalyzeBattleArrayLogic extends GetxController
    with GetSingleTickerProviderStateMixin {
  static AnalyzeBattleArrayLogic get to => Get.find();
  final AnalyzeBattleArrayState state = AnalyzeBattleArrayState();
  late TabController tabController;
  late bool noData = true;
  bool showBasketBall=false;

  double bgImgWidth = ScreenUtil().screenWidth*1;
  double bgImgHeight = ScreenUtil().screenHeight * 0.92;
  double bgImgWidthRatio = 0;
  double bgImgHeightRatio =0;
  var showBasketMap ={};
  String? mid;
  MatchDetailController matchDetailController =
      Get.find<MatchDetailController>(tag: AnalyzeTabController.to.tag);
  Map<int, Rect> map = {};

  @override
  void onInit() {
    super.onInit();
    showBasketMap= {
      0: Rect.fromLTRB(bgImgWidth * 0.405,bgImgHeight*0.1, 0, 0),
      1: Rect.fromLTRB(bgImgWidth * 0.1,bgImgHeight * 0.45, 0, 0),
      2: Rect.fromLTRB(bgImgWidth * 0.7,bgImgHeight * 0.45, 0, 0),



      3: Rect.fromLTRB(bgImgWidth * 0.25,bgImgHeight * 0.75, 0, 0),
      4: Rect.fromLTRB(bgImgWidth * 0.55,bgImgHeight * 0.75, 0, 0),


      5: Rect.fromLTRB(40 * bgImgWidthRatio, 220 * bgImgHeightRatio, 0, 0),
      6: Rect.fromLTRB(bgImgWidth * 0.5 - 40 * bgImgWidthRatio,


          220 * bgImgHeightRatio, 0, 0),
      7: Rect.fromLTRB(
          bgImgWidth - 100 * bgImgWidthRatio, 220 * bgImgHeightRatio, 0, 0),
      8: Rect.fromLTRB(55 * bgImgWidthRatio, 350 * bgImgHeightRatio, 0, 0),
      9: Rect.fromLTRB(245 * bgImgWidthRatio, 350 * bgImgHeightRatio, 0, 0),
      10: Rect.fromLTRB(bgImgWidth * 0.5 - 50 * bgImgWidthRatio,
          315 * bgImgHeightRatio, 0, 0),
    };
     bgImgWidthRatio = bgImgWidth/ 375;
     bgImgHeightRatio =bgImgHeight / 375;
    tabController = TabController(length: 2, vsync: this)
      ..addListener(() {
        if (tabController.index.toDouble() == tabController.animation?.value) {
          state.curMainTab.value = tabController.index;
          update(["analyzeList", "analyzeChildArrayComponent"]);
          update(["analyzeList2", "analyzeChildArrayComponent2"]);
        }
      });
    map = {
      1: Rect.fromLTRB(bgImgWidth * 0.5 - 35 * bgImgWidthRatio, 30.w, 0, 0),
      2: Rect.fromLTRB(10 * bgImgWidthRatio, 100 * bgImgHeightRatio, 0, 0),
      5: Rect.fromLTRB(
          bgImgWidth - 130 * bgImgWidthRatio, 100 * bgImgHeightRatio, 0, 0),
      3: Rect.fromLTRB(100 * bgImgWidthRatio, 100 * bgImgHeightRatio, 0, 0),
      4: Rect.fromLTRB(200 * bgImgWidthRatio, 100 * bgImgHeightRatio, 0, 0),
      6: Rect.fromLTRB(40 * bgImgWidthRatio, 220 * bgImgHeightRatio, 0, 0),
      7: Rect.fromLTRB(bgImgWidth * 0.5 - 40 * bgImgWidthRatio,
          220 * bgImgHeightRatio, 0, 0),
      8: Rect.fromLTRB(
          bgImgWidth - 100 * bgImgWidthRatio, 220 * bgImgHeightRatio, 0, 0),
      9: Rect.fromLTRB(55 * bgImgWidthRatio, 350 * bgImgHeightRatio, 0, 0),
      10: Rect.fromLTRB(245 * bgImgWidthRatio, 350 * bgImgHeightRatio, 0, 0),
      11: Rect.fromLTRB(bgImgWidth * 0.5 - 50 * bgImgWidthRatio,
          315 * bgImgHeightRatio, 0, 0),
    };

    requestData();
    initMatchData();

  }

  void requestData() async {
    MatchDetailController controller = Get.find<MatchDetailController>(tag: AnalyzeTabController.to.tag);
    mid = controller.detailState.mId;

    String csid=controller.detailState.match?.csid??"";
    if(csid=="2"){
      showBasketBall=true;
    }
    update(["analyzeChildArrayComponent2"]);
    requestGetArticle();
  }


  Rect requestPosition(Up e, int position,int index) {

    print("-------------index  $index  position ${position}   e  ${jsonEncode(e.toJson())}");

    if(showBasketBall) {


        //375  *715 设计稿分辨率
        return showBasketMap[index] ?? Rect.fromLTRB(-100.w, -100.w, 0, 0);



    }else{

      //375  *715 设计稿分辨率
      return map[position] ?? Rect.fromLTRB(-100.w, -100.w, 0, 0);
    }

  }

  void requestGetArticle() {
    AnalyzeDetailApi.instance().getMatchLineupList(mid, "1").then((value) {
      print("=========>value  ${value.data?.toJson()}");

      state.analyzeArrayPersonEntity.value = value.data??AnalyzeArrayPersonEntity();
      update(["analyzeList", "analyzeChildArrayComponent"]);
    });

    AnalyzeDetailApi.instance().getMatchLineupList(mid, "2").then((value) {
      state.analyzeArrayPersonEntity2.value = value.data??AnalyzeArrayPersonEntity();
      update(["analyzeList2", "analyzeChildArrayComponent"]);

    });
    update(["buildList"]);

    // //  测试代码
    // Future.delayed(Duration(seconds: 3), () {
    //   String data =
    //       "{\"homeFormation\":\"4-3-3\",\"up\":[{\"awayFormation\":\"3-4-2-1\",\"createTime\":\"1710776102168\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"4-3-3\",\"id\":\"9:9537118:9858:70514\",\"invalid\":0,\"matchInfoId\":\"3288665\",\"modifyTime\":\"1710775881223\",\"position\":1,\"positionEnName\":\"Goalkeeper\",\"positionName\":\"门将\",\"shirtNumber\":93,\"sportId\":\"1\",\"substitute\":0,\"thirdPlayerEnName\":\"Florin Iacob\",\"thirdPlayerName\":\"弗洛林-雅科布\",\"thirdPlayerPicUrl\":\"http://img.tysondata.com/players/20240318222815227_150x150.png\",\"thirdPlayerSourceId\":\"70514\",\"thirdTeamSourceId\":\"9858\"},{\"awayFormation\":\"3-4-2-1\",\"createTime\":\"1710776102168\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"4-3-3\",\"id\":\"9:9537118:9858:167855\",\"invalid\":0,\"matchInfoId\":\"3288665\",\"modifyTime\":\"1710775881223\",\"position\":2,\"positionEnName\":\"Guard\",\"positionName\":\"后卫\",\"shirtNumber\":98,\"sportId\":\"1\",\"substitute\":0,\"thirdPlayerEnName\":\"Tiberiu Capusa\",\"thirdPlayerName\":\"蒂贝留-卡普萨\",\"thirdPlayerPicUrl\":\"http://img.tysondata.com/players/20240318222818601_150x150.png\",\"thirdPlayerSourceId\":\"167855\",\"thirdTeamSourceId\":\"9858\"},{\"awayFormation\":\"3-4-2-1\",\"createTime\":\"1710776102168\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"4-3-3\",\"id\":\"9:9537118:9858:52378\",\"invalid\":0,\"matchInfoId\":\"3288665\",\"modifyTime\":\"1710775881223\",\"position\":3,\"positionEnName\":\"Guard\",\"positionName\":\"后卫\",\"shirtNumber\":4,\"sportId\":\"1\",\"substitute\":0,\"thirdPlayerEnName\":\"Alexandru Constantin Benga\",\"thirdPlayerName\":\"亚力克山德鲁-本加\",\"thirdPlayerPicUrl\":\"http://img.tysondata.com/players/20240318222825307_150x150.png\",\"thirdPlayerSourceId\":\"52378\",\"thirdTeamSourceId\":\"9858\"},{\"awayFormation\":\"3-4-2-1\",\"createTime\":\"1710776102168\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"4-3-3\",\"id\":\"9:9537118:9858:9494\",\"invalid\":0,\"matchInfoId\":\"3288665\",\"modifyTime\":\"1710775881223\",\"position\":4,\"positionEnName\":\"Guard\",\"positionName\":\"后卫\",\"shirtNumber\":15,\"sportId\":\"1\",\"substitute\":0,\"thirdPlayerEnName\":\"Ibrahima Sory Souare\",\"thirdPlayerName\":\"易卜拉欣\",\"thirdPlayerPicUrl\":\"http://img.tysondata.com/players/20240318222828698_150x150.png\",\"thirdPlayerSourceId\":\"9494\",\"thirdTeamSourceId\":\"9858\"},{\"awayFormation\":\"3-4-2-1\",\"createTime\":\"1710776102168\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"4-3-3\",\"id\":\"9:9537118:9858:5073100\",\"invalid\":0,\"matchInfoId\":\"3288665\",\"modifyTime\":\"1710775881223\",\"position\":5,\"positionEnName\":\"Guard\",\"positionName\":\"后卫\",\"shirtNumber\":2,\"sportId\":\"1\",\"substitute\":0,\"thirdPlayerEnName\":\"Diogo Miguel Costa Rodrigues\",\"thirdPlayerName\":\"迪奥戈米格尔科斯塔罗德里格斯\",\"thirdPlayerPicUrl\":\"http://img.tysondata.com/players/20240318222834029_150x150.png\",\"thirdPlayerSourceId\":\"5073100\",\"thirdTeamSourceId\":\"9858\"},{\"awayFormation\":\"3-4-2-1\",\"createTime\":\"1710776102168\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"4-3-3\",\"id\":\"9:9537118:9858:169370\",\"invalid\":0,\"matchInfoId\":\"3288665\",\"modifyTime\":\"1710775881223\",\"position\":6,\"positionEnName\":\"Half-Time\",\"positionName\":\"中场\",\"shirtNumber\":14,\"sportId\":\"1\",\"substitute\":0,\"thirdPlayerEnName\":\"Marcelo Freitas\",\"thirdPlayerName\":\"马塞洛弗雷塔斯\",\"thirdPlayerPicUrl\":\"http://img.tysondata.com/players/20240318222838385_150x150.png\",\"thirdPlayerSourceId\":\"169370\",\"thirdTeamSourceId\":\"9858\"},{\"awayFormation\":\"3-4-2-1\",\"createTime\":\"1710776102168\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"4-3-3\",\"id\":\"9:9537118:9858:870667\",\"invalid\":0,\"matchInfoId\":\"3288665\",\"modifyTime\":\"1710775881223\",\"position\":7,\"positionEnName\":\"Half-Time\",\"positionName\":\"中场\",\"shirtNumber\":21,\"sportId\":\"1\",\"substitute\":0,\"thirdPlayerEnName\":\"Cristian Mihai\",\"thirdPlayerName\":\"克里斯蒂安-米海\",\"thirdPlayerPicUrl\":\"http://img.tysondata.com/players/20231122023451279_150x150.png\",\"thirdPlayerSourceId\":\"870667\",\"thirdTeamSourceId\":\"9858\"},{\"awayFormation\":\"3-4-2-1\",\"createTime\":\"1710776102168\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"4-3-3\",\"id\":\"9:9537118:9858:192551\",\"invalid\":0,\"matchInfoId\":\"3288665\",\"modifyTime\":\"1710775881223\",\"position\":8,\"positionEnName\":\"Half-Time\",\"positionName\":\"中场\",\"shirtNumber\":10,\"sportId\":\"1\",\"substitute\":0,\"thirdPlayerEnName\":\"Andrej Fabry\",\"thirdPlayerName\":\"安德烈法布里\",\"thirdPlayerPicUrl\":\"http://img.tysondata.com/players/20240318222847981_150x150.png\",\"thirdPlayerSourceId\":\"192551\",\"thirdTeamSourceId\":\"9858\"},{\"awayFormation\":\"3-4-2-1\",\"createTime\":\"1710776102168\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"4-3-3\",\"id\":\"9:9537118:9858:965291\",\"invalid\":0,\"matchInfoId\":\"3288665\",\"modifyTime\":\"1710775881223\",\"position\":9,\"positionEnName\":\"Half-Time\",\"positionName\":\"中场\",\"shirtNumber\":55,\"sportId\":\"1\",\"substitute\":0,\"thirdPlayerEnName\":\"Rares Pop\",\"thirdPlayerName\":\"雷尔斯-波普\",\"thirdPlayerPicUrl\":\"http://img.tysondata.com/players/20240318222853350_150x150.png\",\"thirdPlayerSourceId\":\"965291\",\"thirdTeamSourceId\":\"9858\"},{\"awayFormation\":\"3-4-2-1\",\"createTime\":\"1710776102168\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"4-3-3\",\"id\":\"9:9537118:9858:86820\",\"invalid\":0,\"matchInfoId\":\"3288665\",\"modifyTime\":\"1710775881223\",\"position\":10,\"positionEnName\":\"Forward\",\"positionName\":\"前锋\",\"shirtNumber\":42,\"sportId\":\"1\",\"substitute\":0,\"thirdPlayerEnName\":\"Kevin Luckassen\",\"thirdPlayerName\":\"凯文-卢卡森\",\"thirdPlayerPicUrl\":\"http://img.tysondata.com/players/20240318222858762_150x150.png\",\"thirdPlayerSourceId\":\"86820\",\"thirdTeamSourceId\":\"9858\"},{\"awayFormation\":\"3-4-2-1\",\"createTime\":\"1710776102168\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"4-3-3\",\"id\":\"9:9537118:9858:193632\",\"invalid\":0,\"matchInfoId\":\"3288665\",\"modifyTime\":\"1710775881223\",\"position\":11,\"positionEnName\":\"Half-Time\",\"positionName\":\"中场\",\"shirtNumber\":19,\"sportId\":\"1\",\"substitute\":0,\"thirdPlayerEnName\":\"Claudiu Micovschi\",\"thirdPlayerName\":\"克劳迪乌-米科夫斯基\",\"thirdPlayerPicUrl\":\"http://img.tysondata.com/players/20240318222902700_150x150.png\",\"thirdPlayerSourceId\":\"193632\",\"thirdTeamSourceId\":\"9858\"},{\"awayFormation\":\"3-4-2-1\",\"createTime\":\"1710776102168\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"4-3-3\",\"id\":\"9:9537118:9858:30732\",\"invalid\":0,\"matchInfoId\":\"3288665\",\"modifyTime\":\"1710775881223\",\"position\":100,\"positionEnName\":\"Guard\",\"positionName\":\"后卫\",\"shirtNumber\":null,\"sportId\":\"1\",\"substitute\":0,\"thirdPlayerEnName\":\"Mircea Rednic\",\"thirdPlayerName\":\"米尔恰-雷德尼克\",\"thirdPlayerPicUrl\":\"http://img.tysondata.com/managers/20240223201750266_150x150.png\",\"thirdPlayerSourceId\":\"30732\",\"thirdTeamSourceId\":\"9858\"}],\"down\":[{\"awayFormation\":\"3-4-2-1\",\"createTime\":\"1710776102168\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"4-3-3\",\"id\":\"9:9537118:9858:106260\",\"invalid\":0,\"matchInfoId\":\"3288665\",\"modifyTime\":\"1710775881223\",\"position\":0,\"positionEnName\":\"Half-Time\",\"positionName\":\"中场\",\"shirtNumber\":8,\"sportId\":\"1\",\"substitute\":1,\"thirdPlayerEnName\":\"Joao Pedro Almeida Machado\",\"thirdPlayerName\":\"若奥-佩德罗\",\"thirdPlayerPicUrl\":\"http://img.tysondata.com/players/20240318222931061_150x150.png\",\"thirdPlayerSourceId\":\"106260\",\"thirdTeamSourceId\":\"9858\"},{\"awayFormation\":\"3-4-2-1\",\"createTime\":\"1710776102168\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"4-3-3\",\"id\":\"9:9537118:9858:114544\",\"invalid\":0,\"matchInfoId\":\"3288665\",\"modifyTime\":\"1710775881223\",\"position\":0,\"positionEnName\":\"Forward\",\"positionName\":\"前锋\",\"shirtNumber\":9,\"sportId\":\"1\",\"substitute\":1,\"thirdPlayerEnName\":\"Alexandru Tudorie\",\"thirdPlayerName\":\"亚历山德鲁-图多里\",\"thirdPlayerPicUrl\":\"http://img.tysondata.com/players/20240318222953964_150x150.png\",\"thirdPlayerSourceId\":\"114544\",\"thirdTeamSourceId\":\"9858\"},{\"awayFormation\":\"3-4-2-1\",\"createTime\":\"1710776102168\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"4-3-3\",\"id\":\"9:9537118:9858:115664\",\"invalid\":0,\"matchInfoId\":\"3288665\",\"modifyTime\":\"1710775881223\",\"position\":0,\"positionEnName\":\"Guard\",\"positionName\":\"后卫\",\"shirtNumber\":30,\"sportId\":\"1\",\"substitute\":1,\"thirdPlayerEnName\":\"Marko Stolnik\",\"thirdPlayerName\":\"马科斯托尼克\",\"thirdPlayerPicUrl\":\"http://img.tysondata.com/players/20240318222916382_150x150.png\",\"thirdPlayerSourceId\":\"115664\",\"thirdTeamSourceId\":\"9858\"},{\"awayFormation\":\"3-4-2-1\",\"createTime\":\"1710776102168\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"4-3-3\",\"id\":\"9:9537118:9858:221246\",\"invalid\":0,\"matchInfoId\":\"3288665\",\"modifyTime\":\"1710775881223\",\"position\":0,\"positionEnName\":\"Forward\",\"positionName\":\"前锋\",\"shirtNumber\":24,\"sportId\":\"1\",\"substitute\":1,\"thirdPlayerEnName\":\"Eric Johana Omondi\",\"thirdPlayerName\":\"埃里克-奥蒙迪-约翰纳\",\"thirdPlayerPicUrl\":\"http://img.tysondata.com/players/20240318223000034_150x150.png\",\"thirdPlayerSourceId\":\"221246\",\"thirdTeamSourceId\":\"9858\"},{\"awayFormation\":\"3-4-2-1\",\"createTime\":\"1710776102168\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"4-3-3\",\"id\":\"9:9537118:9858:570495\",\"invalid\":0,\"matchInfoId\":\"3288665\",\"modifyTime\":\"1710775881223\",\"position\":0,\"positionEnName\":\"Half-Time\",\"positionName\":\"中场\",\"shirtNumber\":18,\"sportId\":\"1\",\"substitute\":1,\"thirdPlayerEnName\":\"Catalin Alin Vulturar\",\"thirdPlayerName\":\"卡特琳-维尔图拉尔\",\"thirdPlayerPicUrl\":\"http://img.tysondata.com/players/20240318222929228_150x150.png\",\"thirdPlayerSourceId\":\"570495\",\"thirdTeamSourceId\":\"9858\"},{\"awayFormation\":\"3-4-2-1\",\"createTime\":\"1710776102168\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"4-3-3\",\"id\":\"9:9537118:9858:761077\",\"invalid\":0,\"matchInfoId\":\"3288665\",\"modifyTime\":\"1710775881223\",\"position\":0,\"positionEnName\":\"Half-Time\",\"positionName\":\"中场\",\"shirtNumber\":29,\"sportId\":\"1\",\"substitute\":1,\"thirdPlayerEnName\":\"Razvan Alin Trif\",\"thirdPlayerName\":\"拉兹万-阿林-特里夫\",\"thirdPlayerPicUrl\":\"http://img.tysondata.com/players/20240318222943626_150x150.png\",\"thirdPlayerSourceId\":\"761077\",\"thirdTeamSourceId\":\"9858\"},{\"awayFormation\":\"3-4-2-1\",\"createTime\":\"1710776102168\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"4-3-3\",\"id\":\"9:9537118:9858:76842\",\"invalid\":0,\"matchInfoId\":\"3288665\",\"modifyTime\":\"1710775881223\",\"position\":0,\"positionEnName\":\"Forward\",\"positionName\":\"前锋\",\"shirtNumber\":17,\"sportId\":\"1\",\"substitute\":1,\"thirdPlayerEnName\":\"Vlad Morar\",\"thirdPlayerName\":\"弗拉杜特-莫拉尔\",\"thirdPlayerPicUrl\":\"http://img.tysondata.com/players/20240318222947742_150x150.png\",\"thirdPlayerSourceId\":\"76842\",\"thirdTeamSourceId\":\"9858\"},{\"awayFormation\":\"3-4-2-1\",\"createTime\":\"1710776102168\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"4-3-3\",\"id\":\"9:9537118:9858:813948\",\"invalid\":0,\"matchInfoId\":\"3288665\",\"modifyTime\":\"1710775881223\",\"position\":0,\"positionEnName\":\"Half-Time\",\"positionName\":\"中场\",\"shirtNumber\":5,\"sportId\":\"1\",\"substitute\":1,\"thirdPlayerEnName\":\"Ariel Lopez\",\"thirdPlayerName\":\"爱丽尔洛佩兹\",\"thirdPlayerPicUrl\":\"http://img.tysondata.com/players/20240318222924869_150x150.png\",\"thirdPlayerSourceId\":\"813948\",\"thirdTeamSourceId\":\"9858\"},{\"awayFormation\":\"3-4-2-1\",\"createTime\":\"1710776102168\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"4-3-3\",\"id\":\"9:9537118:9858:881594\",\"invalid\":0,\"matchInfoId\":\"3288665\",\"modifyTime\":\"1710775881223\",\"position\":0,\"positionEnName\":\"Goalkeeper\",\"positionName\":\"门将\",\"shirtNumber\":13,\"sportId\":\"1\",\"substitute\":1,\"thirdPlayerEnName\":\"Danilo Kucher\",\"thirdPlayerName\":\"达尼洛-库彻\",\"thirdPlayerPicUrl\":\"http://img.tysondata.com/players/202403182229010014_150x150.png\",\"thirdPlayerSourceId\":\"881594\",\"thirdTeamSourceId\":\"9858\"},{\"awayFormation\":\"3-4-2-1\",\"createTime\":\"1710776102168\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"4-3-3\",\"id\":\"9:9537118:9858:90845\",\"invalid\":0,\"matchInfoId\":\"3288665\",\"modifyTime\":\"1710775881223\",\"position\":0,\"positionEnName\":\"Half-Time\",\"positionName\":\"中场\",\"shirtNumber\":20,\"sportId\":\"1\",\"substitute\":1,\"thirdPlayerEnName\":\"Andrei David\",\"thirdPlayerName\":\"安德烈大卫\",\"thirdPlayerPicUrl\":\"http://img.tysondata.com/players/20240318222935726_150x150.png\",\"thirdPlayerSourceId\":\"90845\",\"thirdTeamSourceId\":\"9858\"},{\"awayFormation\":\"3-4-2-1\",\"createTime\":\"1710776102168\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"4-3-3\",\"id\":\"9:9537118:9858:967083\",\"invalid\":0,\"matchInfoId\":\"3288665\",\"modifyTime\":\"1710775881223\",\"position\":0,\"positionEnName\":\"Guard\",\"positionName\":\"后卫\",\"shirtNumber\":26,\"sportId\":\"1\",\"substitute\":1,\"thirdPlayerEnName\":\"Darius Iurasciuc\",\"thirdPlayerName\":\"尤拉修克，大流士\",\"thirdPlayerPicUrl\":\"http://img.tysondata.com/players/20240318222911655_150x150.png\",\"thirdPlayerSourceId\":\"967083\",\"thirdTeamSourceId\":\"9858\"}]}";
    //   AnalyzeArrayPersonEntity analyzeArrayPersonEntity =
    //       AnalyzeArrayPersonEntity.fromJson(jsonDecode(data));
    //   state.analyzeArrayPersonEntity.value = analyzeArrayPersonEntity;
    //   update(["buildList", "analyzeChildArrayComponent"]);
    // });
    //
    // Future.delayed(Duration(seconds: 3), () {
    //   String data =
    //       "{\"homeFormation\":\"1-3-1\",\"up\":[{\"awayFormation\":\"3-4-2-1\",\"createTime\":\"1710776102168\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"4-3-3\",\"id\":\"9:9537118:9858:70514\",\"invalid\":0,\"matchInfoId\":\"3288665\",\"modifyTime\":\"1710775881223\",\"position\":1,\"positionEnName\":\"Goalkeeper\",\"positionName\":\"门将\",\"shirtNumber\":93,\"sportId\":\"1\",\"substitute\":0,\"thirdPlayerEnName\":\"Florin Iacob\",\"thirdPlayerName\":\"弗洛林-雅科布\",\"thirdPlayerPicUrl\":\"http://img.tysondata.com/players/20240318222815227_150x150.png\",\"thirdPlayerSourceId\":\"70514\",\"thirdTeamSourceId\":\"9858\"},{\"awayFormation\":\"3-4-2-1\",\"createTime\":\"1710776102168\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"4-3-3\",\"id\":\"9:9537118:9858:167855\",\"invalid\":0,\"matchInfoId\":\"3288665\",\"modifyTime\":\"1710775881223\",\"position\":2,\"positionEnName\":\"Guard\",\"positionName\":\"后卫\",\"shirtNumber\":98,\"sportId\":\"1\",\"substitute\":0,\"thirdPlayerEnName\":\"Tiberiu Capusa\",\"thirdPlayerName\":\"蒂贝留-卡普萨\",\"thirdPlayerPicUrl\":\"http://img.tysondata.com/players/20240318222818601_150x150.png\",\"thirdPlayerSourceId\":\"167855\",\"thirdTeamSourceId\":\"9858\"},{\"awayFormation\":\"3-4-2-1\",\"createTime\":\"1710776102168\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"4-3-3\",\"id\":\"9:9537118:9858:52378\",\"invalid\":0,\"matchInfoId\":\"3288665\",\"modifyTime\":\"1710775881223\",\"position\":3,\"positionEnName\":\"Guard\",\"positionName\":\"后卫\",\"shirtNumber\":4,\"sportId\":\"1\",\"substitute\":0,\"thirdPlayerEnName\":\"Alexandru Constantin Benga\",\"thirdPlayerName\":\"亚力克山德鲁-本加\",\"thirdPlayerPicUrl\":\"http://img.tysondata.com/players/20240318222825307_150x150.png\",\"thirdPlayerSourceId\":\"52378\",\"thirdTeamSourceId\":\"9858\"},{\"awayFormation\":\"3-4-2-1\",\"createTime\":\"1710776102168\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"4-3-3\",\"id\":\"9:9537118:9858:9494\",\"invalid\":0,\"matchInfoId\":\"3288665\",\"modifyTime\":\"1710775881223\",\"position\":4,\"positionEnName\":\"Guard\",\"positionName\":\"后卫\",\"shirtNumber\":15,\"sportId\":\"1\",\"substitute\":0,\"thirdPlayerEnName\":\"Ibrahima Sory Souare\",\"thirdPlayerName\":\"易卜拉欣\",\"thirdPlayerPicUrl\":\"http://img.tysondata.com/players/20240318222828698_150x150.png\",\"thirdPlayerSourceId\":\"9494\",\"thirdTeamSourceId\":\"9858\"},{\"awayFormation\":\"3-4-2-1\",\"createTime\":\"1710776102168\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"4-3-3\",\"id\":\"9:9537118:9858:5073100\",\"invalid\":0,\"matchInfoId\":\"3288665\",\"modifyTime\":\"1710775881223\",\"position\":5,\"positionEnName\":\"Guard\",\"positionName\":\"后卫\",\"shirtNumber\":2,\"sportId\":\"1\",\"substitute\":0,\"thirdPlayerEnName\":\"Diogo Miguel Costa Rodrigues\",\"thirdPlayerName\":\"迪奥戈米格尔科斯塔罗德里格斯\",\"thirdPlayerPicUrl\":\"http://img.tysondata.com/players/20240318222834029_150x150.png\",\"thirdPlayerSourceId\":\"5073100\",\"thirdTeamSourceId\":\"9858\"},{\"awayFormation\":\"3-4-2-1\",\"createTime\":\"1710776102168\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"4-3-3\",\"id\":\"9:9537118:9858:169370\",\"invalid\":0,\"matchInfoId\":\"3288665\",\"modifyTime\":\"1710775881223\",\"position\":6,\"positionEnName\":\"Half-Time\",\"positionName\":\"中场\",\"shirtNumber\":14,\"sportId\":\"1\",\"substitute\":0,\"thirdPlayerEnName\":\"Marcelo Freitas\",\"thirdPlayerName\":\"马塞洛弗雷塔斯\",\"thirdPlayerPicUrl\":\"http://img.tysondata.com/players/20240318222838385_150x150.png\",\"thirdPlayerSourceId\":\"169370\",\"thirdTeamSourceId\":\"9858\"},{\"awayFormation\":\"3-4-2-1\",\"createTime\":\"1710776102168\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"4-3-3\",\"id\":\"9:9537118:9858:870667\",\"invalid\":0,\"matchInfoId\":\"3288665\",\"modifyTime\":\"1710775881223\",\"position\":7,\"positionEnName\":\"Half-Time\",\"positionName\":\"中场\",\"shirtNumber\":21,\"sportId\":\"1\",\"substitute\":0,\"thirdPlayerEnName\":\"Cristian Mihai\",\"thirdPlayerName\":\"克里斯蒂安-米海\",\"thirdPlayerPicUrl\":\"http://img.tysondata.com/players/20231122023451279_150x150.png\",\"thirdPlayerSourceId\":\"870667\",\"thirdTeamSourceId\":\"9858\"},{\"awayFormation\":\"3-4-2-1\",\"createTime\":\"1710776102168\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"4-3-3\",\"id\":\"9:9537118:9858:192551\",\"invalid\":0,\"matchInfoId\":\"3288665\",\"modifyTime\":\"1710775881223\",\"position\":8,\"positionEnName\":\"Half-Time\",\"positionName\":\"中场\",\"shirtNumber\":10,\"sportId\":\"1\",\"substitute\":0,\"thirdPlayerEnName\":\"Andrej Fabry\",\"thirdPlayerName\":\"安德烈法布里\",\"thirdPlayerPicUrl\":\"http://img.tysondata.com/players/20240318222847981_150x150.png\",\"thirdPlayerSourceId\":\"192551\",\"thirdTeamSourceId\":\"9858\"},{\"awayFormation\":\"3-4-2-1\",\"createTime\":\"1710776102168\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"4-3-3\",\"id\":\"9:9537118:9858:965291\",\"invalid\":0,\"matchInfoId\":\"3288665\",\"modifyTime\":\"1710775881223\",\"position\":9,\"positionEnName\":\"Half-Time\",\"positionName\":\"中场\",\"shirtNumber\":55,\"sportId\":\"1\",\"substitute\":0,\"thirdPlayerEnName\":\"Rares Pop\",\"thirdPlayerName\":\"雷尔斯-波普\",\"thirdPlayerPicUrl\":\"http://img.tysondata.com/players/20240318222853350_150x150.png\",\"thirdPlayerSourceId\":\"965291\",\"thirdTeamSourceId\":\"9858\"},{\"awayFormation\":\"3-4-2-1\",\"createTime\":\"1710776102168\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"4-3-3\",\"id\":\"9:9537118:9858:86820\",\"invalid\":0,\"matchInfoId\":\"3288665\",\"modifyTime\":\"1710775881223\",\"position\":10,\"positionEnName\":\"Forward\",\"positionName\":\"前锋\",\"shirtNumber\":42,\"sportId\":\"1\",\"substitute\":0,\"thirdPlayerEnName\":\"Kevin Luckassen\",\"thirdPlayerName\":\"凯文-卢卡森\",\"thirdPlayerPicUrl\":\"http://img.tysondata.com/players/20240318222858762_150x150.png\",\"thirdPlayerSourceId\":\"86820\",\"thirdTeamSourceId\":\"9858\"},{\"awayFormation\":\"3-4-2-1\",\"createTime\":\"1710776102168\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"4-3-3\",\"id\":\"9:9537118:9858:193632\",\"invalid\":0,\"matchInfoId\":\"3288665\",\"modifyTime\":\"1710775881223\",\"position\":11,\"positionEnName\":\"Half-Time\",\"positionName\":\"中场\",\"shirtNumber\":19,\"sportId\":\"1\",\"substitute\":0,\"thirdPlayerEnName\":\"Claudiu Micovschi\",\"thirdPlayerName\":\"克劳迪乌-米科夫斯基\",\"thirdPlayerPicUrl\":\"http://img.tysondata.com/players/20240318222902700_150x150.png\",\"thirdPlayerSourceId\":\"193632\",\"thirdTeamSourceId\":\"9858\"},{\"awayFormation\":\"3-4-2-1\",\"createTime\":\"1710776102168\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"4-3-3\",\"id\":\"9:9537118:9858:30732\",\"invalid\":0,\"matchInfoId\":\"3288665\",\"modifyTime\":\"1710775881223\",\"position\":100,\"positionEnName\":\"Guard\",\"positionName\":\"后卫\",\"shirtNumber\":null,\"sportId\":\"1\",\"substitute\":0,\"thirdPlayerEnName\":\"Mircea Rednic\",\"thirdPlayerName\":\"米尔恰-雷德尼克\",\"thirdPlayerPicUrl\":\"http://img.tysondata.com/managers/20240223201750266_150x150.png\",\"thirdPlayerSourceId\":\"30732\",\"thirdTeamSourceId\":\"9858\"}],\"down\":[{\"awayFormation\":\"3-4-2-1\",\"createTime\":\"1710776102168\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"4-3-3\",\"id\":\"9:9537118:9858:106260\",\"invalid\":0,\"matchInfoId\":\"3288665\",\"modifyTime\":\"1710775881223\",\"position\":0,\"positionEnName\":\"Half-Time\",\"positionName\":\"中场\",\"shirtNumber\":8,\"sportId\":\"1\",\"substitute\":1,\"thirdPlayerEnName\":\"Joao Pedro Almeida Machado\",\"thirdPlayerName\":\"若奥-佩德罗\",\"thirdPlayerPicUrl\":\"http://img.tysondata.com/players/20240318222931061_150x150.png\",\"thirdPlayerSourceId\":\"106260\",\"thirdTeamSourceId\":\"9858\"},{\"awayFormation\":\"3-4-2-1\",\"createTime\":\"1710776102168\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"4-3-3\",\"id\":\"9:9537118:9858:114544\",\"invalid\":0,\"matchInfoId\":\"3288665\",\"modifyTime\":\"1710775881223\",\"position\":0,\"positionEnName\":\"Forward\",\"positionName\":\"前锋\",\"shirtNumber\":9,\"sportId\":\"1\",\"substitute\":1,\"thirdPlayerEnName\":\"Alexandru Tudorie\",\"thirdPlayerName\":\"亚历山德鲁-图多里\",\"thirdPlayerPicUrl\":\"http://img.tysondata.com/players/20240318222953964_150x150.png\",\"thirdPlayerSourceId\":\"114544\",\"thirdTeamSourceId\":\"9858\"},{\"awayFormation\":\"3-4-2-1\",\"createTime\":\"1710776102168\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"4-3-3\",\"id\":\"9:9537118:9858:115664\",\"invalid\":0,\"matchInfoId\":\"3288665\",\"modifyTime\":\"1710775881223\",\"position\":0,\"positionEnName\":\"Guard\",\"positionName\":\"后卫\",\"shirtNumber\":30,\"sportId\":\"1\",\"substitute\":1,\"thirdPlayerEnName\":\"Marko Stolnik\",\"thirdPlayerName\":\"马科斯托尼克\",\"thirdPlayerPicUrl\":\"http://img.tysondata.com/players/20240318222916382_150x150.png\",\"thirdPlayerSourceId\":\"115664\",\"thirdTeamSourceId\":\"9858\"},{\"awayFormation\":\"3-4-2-1\",\"createTime\":\"1710776102168\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"4-3-3\",\"id\":\"9:9537118:9858:221246\",\"invalid\":0,\"matchInfoId\":\"3288665\",\"modifyTime\":\"1710775881223\",\"position\":0,\"positionEnName\":\"Forward\",\"positionName\":\"前锋\",\"shirtNumber\":24,\"sportId\":\"1\",\"substitute\":1,\"thirdPlayerEnName\":\"Eric Johana Omondi\",\"thirdPlayerName\":\"埃里克-奥蒙迪-约翰纳\",\"thirdPlayerPicUrl\":\"http://img.tysondata.com/players/20240318223000034_150x150.png\",\"thirdPlayerSourceId\":\"221246\",\"thirdTeamSourceId\":\"9858\"},{\"awayFormation\":\"3-4-2-1\",\"createTime\":\"1710776102168\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"4-3-3\",\"id\":\"9:9537118:9858:570495\",\"invalid\":0,\"matchInfoId\":\"3288665\",\"modifyTime\":\"1710775881223\",\"position\":0,\"positionEnName\":\"Half-Time\",\"positionName\":\"中场\",\"shirtNumber\":18,\"sportId\":\"1\",\"substitute\":1,\"thirdPlayerEnName\":\"Catalin Alin Vulturar\",\"thirdPlayerName\":\"卡特琳-维尔图拉尔\",\"thirdPlayerPicUrl\":\"http://img.tysondata.com/players/20240318222929228_150x150.png\",\"thirdPlayerSourceId\":\"570495\",\"thirdTeamSourceId\":\"9858\"},{\"awayFormation\":\"3-4-2-1\",\"createTime\":\"1710776102168\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"4-3-3\",\"id\":\"9:9537118:9858:761077\",\"invalid\":0,\"matchInfoId\":\"3288665\",\"modifyTime\":\"1710775881223\",\"position\":0,\"positionEnName\":\"Half-Time\",\"positionName\":\"中场\",\"shirtNumber\":29,\"sportId\":\"1\",\"substitute\":1,\"thirdPlayerEnName\":\"Razvan Alin Trif\",\"thirdPlayerName\":\"拉兹万-阿林-特里夫\",\"thirdPlayerPicUrl\":\"http://img.tysondata.com/players/20240318222943626_150x150.png\",\"thirdPlayerSourceId\":\"761077\",\"thirdTeamSourceId\":\"9858\"},{\"awayFormation\":\"3-4-2-1\",\"createTime\":\"1710776102168\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"4-3-3\",\"id\":\"9:9537118:9858:76842\",\"invalid\":0,\"matchInfoId\":\"3288665\",\"modifyTime\":\"1710775881223\",\"position\":0,\"positionEnName\":\"Forward\",\"positionName\":\"前锋\",\"shirtNumber\":17,\"sportId\":\"1\",\"substitute\":1,\"thirdPlayerEnName\":\"Vlad Morar\",\"thirdPlayerName\":\"弗拉杜特-莫拉尔\",\"thirdPlayerPicUrl\":\"http://img.tysondata.com/players/20240318222947742_150x150.png\",\"thirdPlayerSourceId\":\"76842\",\"thirdTeamSourceId\":\"9858\"},{\"awayFormation\":\"3-4-2-1\",\"createTime\":\"1710776102168\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"4-3-3\",\"id\":\"9:9537118:9858:813948\",\"invalid\":0,\"matchInfoId\":\"3288665\",\"modifyTime\":\"1710775881223\",\"position\":0,\"positionEnName\":\"Half-Time\",\"positionName\":\"中场\",\"shirtNumber\":5,\"sportId\":\"1\",\"substitute\":1,\"thirdPlayerEnName\":\"Ariel Lopez\",\"thirdPlayerName\":\"爱丽尔洛佩兹\",\"thirdPlayerPicUrl\":\"http://img.tysondata.com/players/20240318222924869_150x150.png\",\"thirdPlayerSourceId\":\"813948\",\"thirdTeamSourceId\":\"9858\"},{\"awayFormation\":\"3-4-2-1\",\"createTime\":\"1710776102168\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"4-3-3\",\"id\":\"9:9537118:9858:881594\",\"invalid\":0,\"matchInfoId\":\"3288665\",\"modifyTime\":\"1710775881223\",\"position\":0,\"positionEnName\":\"Goalkeeper\",\"positionName\":\"门将\",\"shirtNumber\":13,\"sportId\":\"1\",\"substitute\":1,\"thirdPlayerEnName\":\"Danilo Kucher\",\"thirdPlayerName\":\"达尼洛-库彻\",\"thirdPlayerPicUrl\":\"http://img.tysondata.com/players/202403182229010014_150x150.png\",\"thirdPlayerSourceId\":\"881594\",\"thirdTeamSourceId\":\"9858\"},{\"awayFormation\":\"3-4-2-1\",\"createTime\":\"1710776102168\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"4-3-3\",\"id\":\"9:9537118:9858:90845\",\"invalid\":0,\"matchInfoId\":\"3288665\",\"modifyTime\":\"1710775881223\",\"position\":0,\"positionEnName\":\"Half-Time\",\"positionName\":\"中场\",\"shirtNumber\":20,\"sportId\":\"1\",\"substitute\":1,\"thirdPlayerEnName\":\"Andrei David\",\"thirdPlayerName\":\"安德烈大卫\",\"thirdPlayerPicUrl\":\"http://img.tysondata.com/players/20240318222935726_150x150.png\",\"thirdPlayerSourceId\":\"90845\",\"thirdTeamSourceId\":\"9858\"},{\"awayFormation\":\"3-4-2-1\",\"createTime\":\"1710776102168\",\"dataSourceCode\":\"TS\",\"homeAway\":1,\"homeFormation\":\"4-3-3\",\"id\":\"9:9537118:9858:967083\",\"invalid\":0,\"matchInfoId\":\"3288665\",\"modifyTime\":\"1710775881223\",\"position\":0,\"positionEnName\":\"Guard\",\"positionName\":\"后卫\",\"shirtNumber\":26,\"sportId\":\"1\",\"substitute\":1,\"thirdPlayerEnName\":\"Darius Iurasciuc\",\"thirdPlayerName\":\"尤拉修克，大流士\",\"thirdPlayerPicUrl\":\"http://img.tysondata.com/players/20240318222911655_150x150.png\",\"thirdPlayerSourceId\":\"967083\",\"thirdTeamSourceId\":\"9858\"}]}";
    //   AnalyzeArrayPersonEntity analyzeArrayPersonEntity =
    //       AnalyzeArrayPersonEntity.fromJson(jsonDecode(data));
    //   state.analyzeArrayPersonEntity2.value = analyzeArrayPersonEntity;
    //   update(["buildList2", "analyzeChildArrayComponent2"]);
    // });
  }

  getTeamName(
    MatchEntity otherMatch, {
    int? type,
  }) {
    return matchDetailController.getTeamName(
        type: type ?? 1, match: otherMatch);
  }

  void initMatchData() {
    print("======>mid  ${mid}");
    state.teamsNames.clear();
    MatchEntity matchEntity =
        DataStoreController.to.getMatchById(mid??"") ?? MatchEntity();
    // 1主队 2客队
    String team1 = getTeamName(matchEntity, type: 1);
    String team2 = getTeamName(matchEntity, type: 2);
    print("=========>team1 ${team1}  team2  ${team2}");
    state.teamsNames.add(team1);
    state.teamsNames.add(team2);
    update(["tabListChange"]);
// //  测试代码
// Future.delayed(Duration(seconds: 3), () {
//   String data =Test.data;
//   AnalyzeNewsEntity  dataList = AnalyzeNewsEntity.fromJson(jsonDecode(data));
//   dataList.showTime="${RelativeDateFormat.format(DateTime.fromMicrosecondsSinceEpoch(int.parse(dataList?.showTime??"0")))}";
//
//   state.analyzeNewsEntity.value = dataList;
//   if (dataList == null) {
//     noData = true;
//   } else {
//     noData = false;
//   }
//   update(["analyzeNewsComponent"]);
// });
  }
}
