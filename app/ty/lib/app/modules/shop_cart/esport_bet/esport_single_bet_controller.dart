import 'package:get/get.dart';
import '../../../services/api/bet_api.dart';
import '../../../services/models/req/bet_amount_req.dart';
import '../../../services/models/res/api_res.dart';
import '../../../services/models/res/bet_amount_entity.dart';
import '../../../utils/utils.dart';
import '../../match_detail/models/odds_button_enum.dart';
import '../model/shop_cart_item.dart';
import '../shop_cart_controller.dart';
import '../single_bet/single_bet_controller.dart';

class EsportSingleBetController extends SingleBetController{
  @override
  void goParlay(){
    ShopCartItem item = itemList.first;
    closeBet();
    ShopCartController.to.isEsportParlay.value = true;
    ShopCartController.to.currentBetController?.addShopCartItem(item);
  }


  @override
  Future queryBetAmount() async{
    BetAmountReq req = BetAmountReq();
    BetAmountReqOrderMaxBetMoney orderMinMaxMoney = BetAmountReqOrderMaxBetMoney();
    ShopCartItem item = itemList.first;
    orderMinMaxMoney.sportId = item.sportId;
    orderMinMaxMoney.marketId = item.marketId;
    orderMinMaxMoney.deviceType = getDevice();// 设备类型 "设备类型 1:H5，2：PC,3:Android,4:IOS,5:其他设备"
    orderMinMaxMoney.matchId = item.matchId;
    orderMinMaxMoney.oddsFinally = item.oddFinally.value;
    orderMinMaxMoney.oddsValue = item.odds.toString();
    orderMinMaxMoney.playId = item.playId;
    orderMinMaxMoney.playOptionId = item.playOptionsId;
    orderMinMaxMoney.playOptions = item.playOptions;
    orderMinMaxMoney.seriesType = 1;// 串关类型 // 串关类型 1 单关 2串关
    orderMinMaxMoney.matchProcessId = item.matchMmp;
    orderMinMaxMoney.scoreBenchmark = '';
    orderMinMaxMoney.tenantId = 1;//商户id
    orderMinMaxMoney.tournamentLevel = item.tournamentLevel;
    orderMinMaxMoney.tournamentId = item.tournamentId;
    orderMinMaxMoney.dataSource = item.dataSource;
    orderMinMaxMoney.matchType = item.matchType;
    // 冠军没有赛事阶段
    if(item.betType == OddsBetType.guanjun){
      orderMinMaxMoney.matchProcessId = null;
    }
    req.orderMaxBetMoney = [orderMinMaxMoney];

    ApiRes<List<BetAmountBetAmountInfo>> res;
    try{
      res = await BetApi.instance().queryMarketMaxMinBetMoney(req);
    }catch(e){
      Get.log(e.toString());
      res = ApiRes<List<BetAmountBetAmountInfo>>();
    }
    if(res.success){
      betMinMaxMoney.clear();
      res.data?.forEach((element) {
        betMinMaxMoney[element.playOptionsId] = element;
      });
    }else{
      //设置default值
    }
    update(['input']);
  }

}