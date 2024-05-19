import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/models/odds_button_enum.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_controller.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_history.dart';
import 'package:get/get.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../core/constant/common/module/csid.dart';
import '../../../../global/user_controller.dart';
import '../../../../services/api/bet_api.dart';
import '../../../../services/models/req/bet_amount_req.dart';
import '../../../../services/models/req/bet_req.dart';
import '../../../../services/models/res/api_res.dart';
import '../../../../services/models/res/bet_amount_entity.dart';
import '../../../../services/models/res/bet_result_entity.dart';
import '../../../../services/models/res/last_market_entity.dart';
import '../../../../utils/toast_util.dart';
import '../../../../utils/utils.dart';
import '../../model/bet_history_record.dart';
import '../../model/shop_cart_item.dart';
import '../../model/shop_cart_type.dart';
import '../single_bet_controller.dart';

class SinglePrebookController extends SingleBetController {
  final prebookOdd = '0.0'.obs;

  static const maxOdd = 355;

  SinglePrebookController(ShopCartItem shopCartItem,Rx<ShopCartBetStatus> shopCartBetStatus,List<BetResultOrderDetailRespList> orderResp){
    itemList.add(shopCartItem);//共用SingleBetController中的shopCartItem
    betStatus = shopCartBetStatus;//共用SingleBetController中的betStatus
    orderRespList = orderResp;//共用SingleBetController中的orderRespList
    betHistoryRecord = ShopCartHistory().getHistoryRecord(itemList.first);
    prebookOdd.value = betHistoryRecord.prebookOdd??shopCartItem.oddFinally.value;
    queryBetAmount();
  }

  @override
  double profitAmount(int index) {
    double extraOdd = 1.0;
    if(itemList.first.oddsHsw.contains(Csid.odds_table[UserController.to.curOdds]??'') && UserController.to.curOdds == 'HK'){
      extraOdd = 0.0;
    }

    double profitOdd = (double.tryParse(prebookOdd.value)??1) - extraOdd;
    return inputAmount * profitOdd;
  }

  @override
  void onInit() {
    super.onInit();

    amountController.text = betHistoryRecord.prebookAmount??'';
    amountController.selection = TextSelection(baseOffset:amountController.text.length ,extentOffset:amountController.text.length );
    inputAmount.value = double.tryParse(amountController.text)??0.0;

    amountController.addListener(() {
      betHistoryRecord.prebookAmount = amountController.text;
    });
  }

  void cancelPrebook(){
    betStatus.value = ShopCartBetStatus.Normal;
  }

  // 预约赔率 减
  void reduceOdd(){
    double odd = double.parse(prebookOdd.value);
    double originalOdd = double.parse(itemList.first.oddFinally.value);
    if(odd <= originalOdd){
      // 已经是最小赔率 不做处理
      return;
    }else {
      odd -= odds_change_val(odd);
      prebookOdd.value = odd.toStringAsFixed(2);

      betHistoryRecord.prebookOdd = prebookOdd.value;
    }
  }

  // 预约 赔率 加
  void addOdd(){
    double odd = double.parse(prebookOdd.value);
    if(odd >= maxOdd){
      // 最大赔率 不做处理
      return;
    }else {
      odd += odds_change_val(odd);
      prebookOdd.value = odd.toStringAsFixed(2);

      betHistoryRecord.prebookOdd = prebookOdd.value;
    }
  }

  /*
例如：
< 3.00的：如 1.99，2.00，2.01，2.99；
≥3 且＜5.00的：如 3.00，3.05， 3.55 ，4.95；
≥5 且 ＜10.00的：如5.00，5.10， 6.20 ，7.30，9.90；
≥10 且 ＜20.0的：如10.0，10.5， 11.5 ，18.5，20.0；
≥20 ～355：如20，21， 22 ，99，100，300，......

场景举例：
赔率18.5时，连续点击三次，为19.0，19.5，20
赔率19.0时，连续点击三次，为19.5，20, 21
*/
  double odds_change_val (double odds) {
    double num = 0.01;
    if(odds >= 3 && odds < 5){
      num = 0.05;
    }else if( odds >= 5 && odds < 10 ){
      num = 0.1;
    }else if ( odds >= 10 && odds < 20 ){
      num = 0.5;
    }else if (odds >= 20){
      num = 1;
    }
    return num;
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

    final res = await BetApi.instance().queryPreBetAmount(req);
    if(res.success){
      latestMarketInfoList = res.data?.latestMarketInfo??[];

      betMinMaxMoney.clear();
      res.data?.betAmountInfo.forEach((element) {
        betMinMaxMoney[element.playOptionsId] = element;
      });
    }else{
      //设置default值
    }
    update(['input']);
  }

  // 对比赔率，判断是否是预约投注 返回false走正常投注
  bool preBetComparison(){
    List<LastMarketMarketList> marketList = latestMarketInfoList.safeFirst?.marketList??[];
    ShopCartItem shopCartItem = itemList.first;
    int prebookOddValue = ((double.tryParse(prebookOdd.value)??0.0)*100000 + 0.001).floor();
    if(shopCartItem.marketTypeFinally == 'HK') //&& UserController.to.isCurDdds(item.oddsHsw) ) 此处修改了Vue得逻辑，当前是港赔都加1
    {
      prebookOddValue = prebookOddValue + 100000;
    }
    // 判断有没有 直接投注的盘口和投注项
    for(LastMarketMarketList market in marketList){
      if(market.marketValue == shopCartItem.marketValue){
        for(var odds in market.marketOddsList){
          if(odds.oddsValue == prebookOddValue){
            return false;
          }
        }
      }
    }

    return true;
  }

  @override
  Future<bool> doBet() async{
    if(!checkAmount())
      return false;

    //Vue中，预约投注未走queryLatestMarketInfo
    await queryLatestMarketInfo();

    if(!preBetComparison()){
      // 取消 预约投注
      return super.doBet();
    }

    if(!checkBet())
      return false;

    // 获取当前币种
    String currency = UserController.to.currCurrency();
    if(currency == 'RMB') {
      // 人民币 使用CNY 不使用 RMB
      currency = "CNY";
    }

    BetReq betReq = BetReq();
    betReq.acceptOdds = int.tryParse(UserController.to.userPersonaliseEntity.toAccept)==1?1:2;          // 接受赔率变化情况
    betReq.tenantId = 1;
    betReq.deviceType = getDevice();         // 设备类型 1:H5，2：PC,3:Android,4:IOS,5:其他设备
    betReq.currencyCode = currency; // 币种
    betReq.deviceImei = '';         // 设备imei码，只有手机有，没有不添加
    betReq.fpId = '';               // 指纹55555555id
    betReq.openMiltSingle = 0;      // 是否为多个单关 0:1个 1:多个
    betReq.preBet = 1;              // 1 预约  0 不预约

    ShopCartItem item = itemList.first;
    String playOptionName = item.playOptionName;
    if(item.handicap.isNotEmpty){
      //playOptionName = '${item.handicap} ${item.marketValue}';
      //因为现在不预约盘口值，所以直接使用handicapHv。marketValue中缺少+号。placeNum也直接使用原来得
      playOptionName = '${item.handicap} ${item.handicapHv.value}';
    }
    int preOdds = ((double.tryParse(prebookOdd.value)??0.0)*100000 + 0.001).floor();
    // 支持港赔 并且是港赔
    if(item.marketTypeFinally == 'HK') //&& UserController.to.isCurDdds(item.oddsHsw) ) 此处修改了Vue得逻辑，当前是港赔都加1
    {
      preOdds = preOdds + 100000;
    }

    BetReqSeriesOrdersOrderDetailList orderDetail = BetReqSeriesOrdersOrderDetailList();
    orderDetail.sportId = item.sportId;                             // 赛种id
    orderDetail.matchId = item.matchId;                             // 赛事id
    orderDetail.tournamentId = item.tournamentId;                   // 联赛id
    orderDetail.betAmount = inputAmount.value.toStringAsFixed(2);   //投注金额
    orderDetail.placeNum = item.placeNum?.toString()??'';    //盘口坑位
    orderDetail.marketId = item.marketId;                           //盘口id
    orderDetail.playOptionsId = item.playOptionsId;                 // 投注项id
    orderDetail.marketTypeFinally = item.marketTypeFinally;         // 欧洲版默认是欧洲盘 HK代表香港盘
    orderDetail.marketValue = item.marketValue;
    orderDetail.odds = preOdds;                                     // 赔率 万位
    orderDetail.oddFinally = prebookOdd.value;                      //赔率
    orderDetail.playName = item.playName;                           //玩法名称
    orderDetail.sportName = item.sportName;                         // 球种名称
    orderDetail.matchType = item.matchType;                         // 1 ：早盘赛事 ，2： 滚球盘赛事，3：冠军，4：虚拟赛事，5：电竞赛事
    orderDetail.matchName = item.matchName;                         //赛事名称
    orderDetail.playOptionName = playOptionName;                    // 投注项名称
    orderDetail.playOptions = item.playOptions;                     // 投注项配置项
    orderDetail.tournamentLevel = item.tournamentLevel;             // 联赛级别
    orderDetail.playId = item.playId;                               // 玩法id
    orderDetail.dataSource = item.dataSource;                       // 数据源

    // 获取当前投注项 如果不支持当前的赔率 就使用欧赔
    if(!UserController.to.isCurDdds(item.oddsHsw)){
      orderDetail.marketTypeFinally = 'EU';
    }

    BetReqSeriesOrders betReqSeriesOrders = BetReqSeriesOrders();
    betReqSeriesOrders.seriesSum = 1;
    betReqSeriesOrders.seriesType = 1;
    betReqSeriesOrders.fullBet = 0;
    betReqSeriesOrders.seriesValues = "单关";
    betReqSeriesOrders.orderDetailList = [orderDetail];

    betReq.seriesOrders = [betReqSeriesOrders];

    ApiRes<BetResultEntity> res;
    try {
      res = await BetApi.instance().bet(betReq);
    }on DioException catch(dioException){
      Get.log(dioException.toString());
      if(dioException.type == DioExceptionType.sendTimeout
          || dioException.type == DioExceptionType.receiveTimeout){
        ToastUtils.showGrayBackground(LocaleKeys.bet_err_msg13.tr);
      }else{
        ToastUtils.showGrayBackground(LocaleKeys.bet_err_msg02.tr);
      }
      return false;
    }catch(e){
      Get.log(e.toString());
      ToastUtils.showGrayBackground(LocaleKeys.bet_msg02.tr);
      return false;
    }

    if(res.success){
      betStatus.value = ShopCartBetStatus.Prebooking;
      orderRespList.clear();
      orderRespList.addAll(res.data?.orderDetailRespList??[]);
      if(orderRespList.safeFirst?.preOrderDetailStatus == 0 ){
        betStatus.value = ShopCartBetStatus.PrebookSuccess;//预约状态 0:预约中 1: 预约成功 2: 预约取消  此处Vue代码与注释不符
      }else if(orderRespList.safeFirst?.preOrderDetailStatus == 1){
        betStatus.value = ShopCartBetStatus.PrebookSuccess;
      }else if(orderRespList.safeFirst?.preOrderDetailStatus == 2){
        betStatus.value = ShopCartBetStatus.PrebookCancel;
      }

      ShopCartHistory().removeHistoryRecord(item);
      UserController.to.getBalance();

      return true;
    }else{
      ToastUtils.showGrayBackground(res.msg??res.code??'Error');
      return false;
    }

  }
}
