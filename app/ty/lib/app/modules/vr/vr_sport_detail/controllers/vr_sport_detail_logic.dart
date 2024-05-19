import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_map_operate.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_detail_controller.dart';
import 'package:flutter_ty_app/app/modules/vr/controllers/vr_home_controller.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/api/vr_detail_api.dart';
import 'package:flutter_ty_app/app/services/models/res/item_disuse_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_sports_menu_entity.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_match_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_ranking_entity.dart';
import 'package:synchronized/extension.dart';
import '../../../../global/data_store_controller.dart';
import '../vr_sport_detail_state.dart';

class VrSportDetailLogic extends GetxController with GetTickerProviderStateMixin {
  static VrSportDetailLogic get to => Get.find();
  final VrSportDetailState state = VrSportDetailState();

  @override
  void onInit() {
    // 列表进入
    Get.log("VrMatchEntity =   void onInit() ");
    Get.log("VrMatchEntity =   ${(Get.arguments is Map) } ");
    if (Get.arguments is Map) {
      Map<String, dynamic>? arguments = Get.arguments;

      Get.log("VrMatchEntity =   arguments $arguments");
      state.vrMatch = arguments?['vrMatch'] ?? '';
      state.match = arguments?['match'] ?? '';
      bool isBalls = arguments?['isBalls'] ?? false;
      if(state.match != null){
        state.historyScore = state.match!.msc;
        state.lod = state.match!.lod;
        state.batchNo = state.match?.batchNo;
        Get.log("VrMatchEntity = ${state.lod} state.lod state.batchNo = ${state.batchNo}");
        /// 加载vr详情投注列表
        var detailController = Get.find<MatchDetailController>();
        detailController.detailState.mId = state.match!.mid;
        detailController.detailState.match = state.match;
        detailController.fetchCategoryList();
        DataStoreController.to.updateMatch(state.match!);

      }
      Get.log("VrMatchEntity = ${state.match}  isBalls = $isBalls");

      var vrHomeController = Get.find<VrHomeController>();
      state.topMenu = vrHomeController.topMenu;
    }


    registTabController();
    // TODO: implement onInit
    super.onInit();
  }


  @override
  void onReady() {

    Get.log("VrMatchEntity =   void onReady() ");
    getData();

  }

  getData(){
    if(state.topMenu  !=null){
      if(state.topMenu?.menuId == '1001') { //足球
        getRankingData();
      }else if(state.topMenu?.menuId != '1004'){//不为篮球
        getHistory();
      }
    }
  }

  ///========================== 逻辑 ========================///
  registTabController() {
    int initIndex = 0;
    if(state.topMenu  !=null ){
      if(state.topMenu?.menuId == '1001'){//足球
        state.matchDetailList = [
          LocaleKeys.virtual_sports_match_detail_historical_results.tr,
          LocaleKeys.virtual_sports_match_detail_bet.tr,
          LocaleKeys.virtual_sports_match_detail_leaderboard.tr
        ];
        initIndex = 1;
      }else if(state.topMenu?.menuId == '1004'){//篮球
        state.matchDetailList = [
        ];
      }else{
        state.matchDetailList = [
          LocaleKeys.virtual_sports_match_detail_bet.tr,
          LocaleKeys.virtual_sports_match_detail_historical_results.tr,
        ];
        initIndex = 0;
      }
    }
    state.matchTabController = TabController(
        initialIndex: initIndex, vsync: this, length: state.matchDetailList.length);
    state.matchTabController?.addListener(() {
      if (state.matchTabController?.index == state.matchTabController?.animation?.value) {
        // matchDetailList.refresh();
        update(['bottomPage']);
      }
    });
    state.matchTabController?.animateTo(initIndex,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  ///没数据 弱提示 名称拼接
  String getdisuseRowName(int index) {
    String name = LocaleKeys.virtual_sports_quarter_finals.tr;
    // String name = LocaleKeys.virtual_sports_Q4.tr;
    if (state.disuseIndex.value == 1) {
      name = LocaleKeys.virtual_sports_SEMIFINAL.tr;
    } else if (state.disuseIndex.value == 2) {
      name = LocaleKeys.virtual_sports_FINAL.tr;
    }
    name = '$name\n${replaceEnglishNumber(index.toString())}';
    return name;
  }

  String replaceEnglishNumber(String input) {
    const arabic = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9','10', '11', '12', '13', '14', '15', '16', '17', '18',
      '19','20', '21', '22', '23', '24', '25'];
    const english = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J','K','L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S',
      'T', 'U','V', 'W', 'X', 'Y', 'Z'];
    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(arabic[i], english[i]);
    }
    return input;
  }
  ///格式化 赛事比分
  List getMatchScore(String Score) {
    List scoreList = [];
    List temp = [];
    if (Score.isNotEmpty) {
      temp = Score.split(',');
    }
    for (int i = 0; i < 3; i++) {
      if(i<temp.length){
        scoreList.add(temp[i]);
      }else{
        scoreList.add("-");
      }
    }

    return scoreList;
  }

  ///小组赛 淘汰赛tab点击
  clickGroupIndex(int index) {
    state.groudIndex.value = index;
    state.groudIndex.refresh();

    if (state.groudIndex.value == 1) {
      ///请求接口
      // getdisuseScore();
    }
  }

  ///点击淘汰赛 类型
  void clickDisuse(int index) {
    // reloadDisuse(index);
  }
  @override
  void onClose() {
    state.scrollController?.dispose();
    state.matchTabController?.dispose();
    // TODO: implement onClose
    super.onClose();
  }

  void getRankingData() {

    if (state.vrMatch!.mmp.isEmpty) {
      state.isCup.value = false;
    } else{
      state.isCup.value = true;
      if(state.vrMatch!.mmp == "GROUPS"){
        state.groudIndex.value = 0;
      }
    }
    Get.log('state.vrMatch?.mmp = ${state.vrMatch?.mmp}');
    Get.log(' state.isCup.value = ${ state.isCup.value}');
    var tid =  Get.find<VrHomeController>().subMenu?.menuId??'';
    if(state.isCup.value){
      if(state.groudIndex.value == 0){
        VrDetailApi.instance().getVirtualSportXZTeamRanking(tid/*'86945115832995842'*/).then((value) {
          state.groupList = value.data!;
          update();
        });
      }else{
        // tid: 86945115832995842
        // batchNo: 457652
        // lod: 2
        // mmp: SEMIFINAL
        // beginTime: 1710419160000
        // t: 1710419105589
        //https://api.jlsdfj012.com/yewu11/v1/w/virtual/getMatchSorce?tid=86945115832995842&batchNo=457704&lod=1&mmp=Q8&beginTime=1710428520000&t=1710428466015

        // https://api.0yeex2e.com/yewu11/v1/w/virtual/getMatchSorce?tid=367673662706831362&batchNo=87529&lod=1&mmp=Q4&beginTime=1710430979717&t=1710431390172
        // https://api-c.sportxxx1zx.com/yewu11/v1/w/virtual/getMatchSorce?tid=86945115832995842&batchNo=457725&lod=1&mmp=Q4&beginTime=1710432300000&t=1710432257002
        // https://api.jlsdfj012.com/yewu11/v1/w/virtual/getMatchSorce?tid=367673662706831362&batchNo=87546&lod=1&mmp=Q8&beginTime=1710434040000&t=1710433988043
        String mmp = state.vrMatch?.mmp??'Q8';
        String lod = state.lod??'1';

        VrDetailApi.instance().getMatchSorce(/*"367673662706831362"*/tid,
            state.batchNo??''/*"87546"*/,
            lod/*"1"*/,
            mmp,
            "1710434040000").then((value) {
          if(value.data != null){
            // String key = 'Q8';
            // if(disuseIndex.value == 0){
            //   key = 'Q8';
            // }else if(disuseIndex.value == 2){
            //   value.data?['Q4'].forEach((element){
            //     disuseList.add(ItemDisuseEntity.fromJson(element));
            //   });
            // }else if(disuseIndex.value == 3){
            //   value.data?['SEMIFINAL'].forEach((element){
            //     disuseList.add(ItemDisuseEntity.fromJson(element));
            //   });
            // }
            List<String> keyList = ['Q8','Q4','SEMIFINAL',"FINAL"];
            keyList.forEach((key) {
              List<ItemDisuseEntity> temp = [];
              if(value.data?[key]!=null){
                value.data?[key].forEach((element){
                  temp.add(ItemDisuseEntity.fromJson(element));
                });
                state.disuseListMap[key] = temp;
              }
            });
            for (int i = 0; i <  keyList.length; i++) {
              if(keyList[i] == mmp){
                state.disuseIndex.value = i;
              }
            }
            state.disuseList = state.disuseListMap[keyList[state.disuseIndex.value]]!;
            Get.log("state.disuseIndex.value = ${state.disuseIndex.value}");
            Get.log("state.disuseListMap = ${state.disuseListMap}");
          }
          update();
        });

      }
    }else{
      VrDetailApi.instance().getVirtualSportTeamRanking(tid/*'23622704727740417'*/).then((value) {
        // ！报错
        if(value.success && ObjectUtil.isNotEmpty(value.data)){
          state.rankList = value.data!;
          update();
        }

      });
    }
  }

  void getHistory() {
    VrDetailApi.instance().getVirtualMatchDetailCount(state.match!.mid).then((value) {
      state.historyScoreDog = value.data!;
      update();
    });
  }
}
