import 'package:dio/dio.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/models/odds_button_enum.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/model/bet_history_record.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/model/shop_cart_type.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_history.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_util.dart';
import 'package:flutter_ty_app/app/services/api/bet_api.dart';
import 'package:flutter_ty_app/app/services/models/req/bet_amount_req.dart';
import 'package:flutter_ty_app/app/core/constant/index.dart';
import 'package:get/get.dart';
import '../../../../generated/locales.g.dart';
import '../../../global/user_controller.dart';
import '../../../services/models/req/bet_req.dart';
import '../../../services/models/res/api_res.dart';
import '../../../services/models/res/bet_amount_entity.dart';
import '../../../services/models/res/bet_result_entity.dart';
import '../../../services/models/res/last_market_entity.dart';
import '../../../utils/utils.dart';
import '../../home/models/main_menu.dart';
import '../base/base_bet_controller.dart';
import '../model/shop_cart_item.dart';
import '../shop_cart_controller.dart';

class SingleBetController extends BaseBetController {
  Map<String,BetAmountBetAmountInfo> betMinMaxMoney = {};
  late BetHistoryRecord betHistoryRecord;

  @override
  String get minValue{
    ShopCartItem shopCartItem = itemList.first;
    BetAmountBetAmountInfo? betAmountInfo = betMinMaxMoney[shopCartItem.playOptionsId];
    if(betAmountInfo!=null){
      return betAmountInfo!.minBet;
    }
    return super.minValue;
  }
  @override
  String get maxValue{
    ShopCartItem shopCartItem = itemList.first;
    BetAmountBetAmountInfo? betAmountInfo = betMinMaxMoney[shopCartItem.playOptionsId];
    if(betAmountInfo!=null){
      return betAmountInfo!.orderMaxPay;
    }
    return super.maxValue;
  }

  @override
  List<int> get userCvoMoney{
    return  [
      UserController.to.userInfo.value?.cvo?.single?.qon??100,
      UserController.to.userInfo.value?.cvo?.single?.qtw??200,
      UserController.to.userInfo.value?.cvo?.single?.qth??500,
      UserController.to.userInfo.value?.cvo?.single?.qfo??1000,
      UserController.to.userInfo.value?.cvo?.single?.qfi??2000,
    ];
  }

  @override
  bool get isSpecialState{
    var item = itemList.firstWhereOrNull((element) => element.isColsed);

    return item!=null;
  }

  @override
  String get specialStateReason {
    return LocaleKeys.bet_close.tr;
  }

  @override
  double profitAmount(int index){
    double profitOdd = itemList.first.odds/100000.0 - 1.0;
    return inputAmount * profitOdd;
  }

  @override
  void onInit() {
    super.onInit();

    amountController = TextEditingController();
    amountController.addListener(() {
      inputAmount.value = double.tryParse(amountController.text)??0.0;
    });

    amountFocusNode = FocusNode();
    amountFocusNode.addListener(() {
      bool hasFocus = amountFocusNode.hasFocus;
      if(hasFocus){
        keyboardVisiable(true);
      }
    });

    //单关缺省显示键盘
    showKeyBoard = true;
  }

  @override
  void dispose(){
    super.dispose();
    amountController.dispose();
    amountFocusNode.dispose();
  }

  @override
  void addShopCartItem(ShopCartItem item){
    itemList.clear();//合并单关的话，判marketId是否相同，相同的替换
    super.addShopCartItem(item);

    betHistoryRecord = ShopCartHistory().getHistoryRecord(item);
    //amountController.text = betHistoryRecord.betAmount??'';
  }

  @override
  void closeBet(){
    betHistoryRecord.betAmount = amountController.text;
    clearData();
    super.closeBet();
  }

  void goPrebook(){
    betStatus.value = ShopCartBetStatus.Prebook;
  }

  void goParlay(){
    ShopCartItem item = itemList.first;
    closeBet();
    HomeController.to.changeMenu(MainMenu.menuList.firstWhere((element) => element.isMatchBet));
    Get.until((route) => Get.currentRoute == Routes.mainTab);
    ShopCartController.to.currentBetController?.addShopCartItem(item);
    ShopCartController.to.currentBetController?.queryBetAmount();
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

    ApiRes<BetAmountEntity> res;
    try {
      res = await BetApi.instance().queryBetAmount(req);
    }catch(e){
      Get.log(e.toString());
      res = ApiRes<BetAmountEntity>();
    }
    if(res.success){
      latestMarketInfoList = res.data?.latestMarketInfo??[];
      _setBetPreList(latestMarketInfoList);
      betMinMaxMoney.clear();
      res.data?.betAmountInfo.forEach((element) {
        betMinMaxMoney[element.playOptionsId] = element;
      });
    }else{
      //设置default值
    }
    update(['input']);
  }

  // 设置预约投注显示状态 篮球足球显示预约投注
  void _setBetPreList(List<LastMarketEntity> betAmountLatestMarketInfoList){
    betAmountLatestMarketInfoList.forEach((element) {
      if(element.pendingOrderStatus!=0){
        String? oid = element.currentMarket?.marketOddsList.safeFirst?.id;
        if(oid!=null){
          state.prebookOidList.add(oid);
        }
      }
    });
  }

  bool checkAmount(){
    // 请输入投注金额
    if(inputAmount.value <=0){
      ShopCartUtil.showBetError("M400005");
      return false;
    }

    // 有金额的情况下 判断限额
    if(inputAmount.value < (double.tryParse(minValue)??0)){
      ShopCartUtil.showBetError("M400010");
      return false;
    }

    return true;
  }

  bool checkBet(){
    for(ShopCartItem item in itemList){
      // 投注项状态 1：开 2：封 3：关 4：锁
      // 盘口状态，玩法级别 0：开 1：封 2：关 11：锁
      // 赛事级别盘口状态（0:active 开盘, 1:suspended 封盘, 2:deactivated 关盘,11:锁盘状态）
      if(item.olOs.value == 4 || item.hlHs.value==11 || item.midMhs.value==11){
        ShopCartUtil.showBetError("400004");
        return false;
      }

      if( [2,3].contains(item.olOs.value) || [2,1].contains(item.hlHs.value) || [2,1].contains(item.midMhs.value)){
        ShopCartUtil.showBetError("0402001");
        return false;
      }
    }

    return true;
  }

  @override
  Future<bool> doBet() async{
    if(!checkAmount())
      return false;

    await queryLatestMarketInfo();

    if(!checkBet())
      return false;

    // 投注前获取最新的 投注信息 赔率 坑位 等
    // 投注已经准备好了 拿最新的数据 去投注

    // 获取当前币种
    String currency = UserController.to.currCurrency();
    if(currency == 'RMB') {
      // 人民币 使用CNY 不使用 RMB
      currency = "CNY";
    }

    BetReq betReq = BetReq();
    betReq.acceptOdds = int.tryParse(UserController.to.userPersonaliseEntity.toAccept)==1?1:2;          // 接受赔率变化情况
    betReq.tenantId = 1;
    betReq.deviceType = getDevice();        // 设备类型 1:H5，2：PC,3:Android,4:IOS,5:其他设备
    betReq.currencyCode = currency; // 币种
    betReq.deviceImei = '';         // 设备imei码，只有手机有，没有不添加
    betReq.fpId = '';               // 指纹55555555id
    betReq.openMiltSingle = 0;      // 是否为多个单关 0:1个 1:多个
    betReq.preBet = 0;              // 1 预约  0 不预约

    ShopCartItem item = itemList.first;
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
    orderDetail.odds = item.odds;                                   // 赔率 万位
    orderDetail.oddFinally = item.oddFinally.value;                 //赔率
    orderDetail.playName = item.playName;                           //玩法名称
    orderDetail.sportName = item.sportName;                         // 球种名称
    orderDetail.matchType = item.matchType;                         // 1 ：早盘赛事 ，2： 滚球盘赛事，3：冠军，4：虚拟赛事，5：电竞赛事
    orderDetail.matchName = item.matchName;                         //赛事名称
    orderDetail.playOptionName = item.playOptionName;               // 投注项名称
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
      betStatus.value = ShopCartBetStatus.Betting;
      orderRespList.clear();
      orderRespList.addAll(res.data?.orderDetailRespList??[]);
      // 订单状态 0:投注失败 1: 投注成功 2: 订单确认中
      if(orderRespList.safeFirst?.orderStatusCode == 1){
        betStatus.value = ShopCartBetStatus.Success;
      }else if(orderRespList.safeFirst?.orderStatusCode == 0){
        betStatus.value = ShopCartBetStatus.Invalid; //Vue中使用 status = 5 (投注项失效)
      }

      UserController.to.getBalance();
      return true;
    }else{
      ToastUtils.showGrayBackground(res.msg??res.code??'Error');
      return false;
    }



  }

}
