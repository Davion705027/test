
import 'package:flutter_ty_app/app/modules/shop_cart/model/shop_cart_item.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_controller.dart';
import 'package:get/get.dart';

import '../../../services/api/bet_api.dart';
import '../../../services/models/req/bet_amount_req.dart';
import '../../../services/models/res/api_res.dart';
import '../../../services/models/res/bet_amount_entity.dart';
import '../../match_detail/models/odds_button_enum.dart';
import '../mix_bet/mix_bet_controller.dart';
import '../../../utils/utils.dart';

class EsportMixBetController extends MixBetController{
  @override
  void goSingle(){
    clearData();
    ShopCartController.to.isEsportParlay.value = false;
  }

  @override
  Future queryBetAmount() async {
    if (itemCount < minSeriesNum){
      betSpecialSeries.clear();
      return;
    }

    BetAmountReq req = BetAmountReq();
    for(ShopCartItem item in itemList) {
      BetAmountReqOrderMaxBetMoney orderMinMaxMoney = BetAmountReqOrderMaxBetMoney();
      orderMinMaxMoney.sportId = item.sportId;
      orderMinMaxMoney.marketId = item.marketId;
      orderMinMaxMoney.deviceType = getDevice();// 设备类型 "设备类型 1:H5，2：PC,3:Android,4:IOS,5:其他设备"
      orderMinMaxMoney.matchId = item.matchId;
      orderMinMaxMoney.oddsFinally = item.oddFinally.value;
      orderMinMaxMoney.oddsValue = item.odds.toString();
      orderMinMaxMoney.playId = item.playId;
      orderMinMaxMoney.playOptionId = item.playOptionsId;
      orderMinMaxMoney.playOptions = item.playOptions;
      orderMinMaxMoney.seriesType = 2; // 串关类型 1 单关 2串关
      orderMinMaxMoney.matchProcessId = item.matchMmp;
      orderMinMaxMoney.scoreBenchmark = '';
      orderMinMaxMoney.tenantId = 1; //商户id
      orderMinMaxMoney.tournamentLevel = item.tournamentLevel;
      orderMinMaxMoney.tournamentId = item.tournamentId;
      orderMinMaxMoney.dataSource = item.dataSource;
      orderMinMaxMoney.matchType = item.matchType;
      // 冠军没有赛事阶段
      if (item.betType == OddsBetType.guanjun) {
        orderMinMaxMoney.matchProcessId = null;
      }
      req.orderMaxBetMoney.add(orderMinMaxMoney);
    }

    ApiRes<List<BetAmountBetAmountInfo>> res;
    try{
      res = await BetApi.instance().queryMarketMaxMinBetMoney(req);
    }catch(e){
      Get.log(e.toString());
      res = ApiRes<List<BetAmountBetAmountInfo>>();
    }
    if(res.success){
      betSpecialSeries.forEach((element) {
        BetAmountBetAmountInfo? betAmountInfo = res.data?.firstWhereOrNull((info) => info.type == element.id);
        element.betAmountInfo.value = betAmountInfo;
      });
    }else{
      //设置default值
    }
    update(['input']);
  }

}