import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/models/odds_button_enum.dart';
import 'package:flutter_ty_app/app/core/constant/index.dart';
import 'package:get/get.dart';
import '../../../../generated/locales.g.dart';
import '../../../global/user_controller.dart';
import '../../../routes/app_pages.dart';
import '../../../services/api/bet_api.dart';
import '../../../services/models/req/bet_amount_req.dart';
import '../../../services/models/req/bet_req.dart';
import '../../../services/models/res/api_res.dart';
import '../../../services/models/res/bet_amount_entity.dart';
import '../../../services/models/res/bet_result_entity.dart';
import '../../../utils/toast_util.dart';
import '../../../utils/utils.dart';
import '../../home/controllers/home_controller.dart';
import '../../home/models/main_menu.dart';
import '../base/base_bet_controller.dart';
import '../model/bet_count_model.dart';
import '../model/shop_cart_item.dart';
import '../model/shop_cart_type.dart';
import '../shop_cart_util.dart';

class MixBetController extends BaseBetController {
  final RxList<BetCountModel> betSpecialSeries = List<BetCountModel>.empty().obs;
  List<TextEditingController> amountControllerList = [];
  List<FocusNode> amountFocusNodeList = [];
  List<RxDouble> inputAmountList = [];
  ScrollController scrollController = ScrollController();
  final showScrollFlag = false.obs;

  @override
  String get minValue{
    int index = amountFocusNodeList.indexOf(amountFocusNode);
    return minValueOfSerie(index);
  }
  @override
  String get maxValue{
    int index = amountFocusNodeList.indexOf(amountFocusNode);
    return maxValueOfSerie(index);
  }

  @override
  double get inputTotal{
    double amountSum = 0.0;
    for(int i=0;i<betSpecialSeries.length;i++){
      BetCountModel betCountModel = betSpecialSeries[i];
      amountSum += inputAmountList[i].value * betCountModel.count;
    }

    return amountSum;
  }

  @override
  List<int> get userCvoMoney{
    return  [
      UserController.to.userInfo.value?.cvo?.series?.qon??10,
      UserController.to.userInfo.value?.cvo?.series?.qtw??50,
      UserController.to.userInfo.value?.cvo?.series?.qth??100,
      UserController.to.userInfo.value?.cvo?.series?.qfo??200,
      UserController.to.userInfo.value?.cvo?.series?.qfi??500,
    ];
  }

  // 获取商户配置的 串关投注项
  int get minSeriesNum =>
      UserController.to.userInfo.value?.configVO?.minSeriesNum??2;
  int get maxSeriesNum =>
      UserController.to.userInfo.value?.configVO?.maxSeriesNum??10;


  @override
  double get orderTotal{
    double amountSum = 0.0;
    seriesOrderRespList.forEach((element) {
      amountSum += double.tryParse(element.seriesBetAmount)??0.0;
    });
    return amountSum;
  }

  @override
  bool get isSpecialState{
    if(!(minSeriesNum <= itemList.length && itemList.length <= maxSeriesNum )){
      return true;
    }

    var item = itemList.firstWhereOrNull((element) => element.isColsed || !element.canParlay);

    return item!=null;
  }

  @override
  String get specialStateReason {
    if(!(minSeriesNum <= itemList.length && itemList.length <= maxSeriesNum )){
      String errorMsg = LocaleKeys.bet_bet_min_item.tr;
      errorMsg = errorMsg.replaceAll('{num}', minSeriesNum.toString());
      return errorMsg;
    }

    return LocaleKeys.bet_close.tr;
  }

  String minValueOfSerie(int index){
    String defaultValue = '5';
    if(index >=0 && index<betSpecialSeries.length ){
      BetCountModel betCountModel = betSpecialSeries[index];
      return betCountModel.betAmountInfo.value?.minBet??defaultValue;
    }

    return defaultValue;
  }

  String maxValueOfSerie(int index){
    if(index >=0 && index<betSpecialSeries.length ){
      BetCountModel betCountModel = betSpecialSeries[index];
      return betCountModel.betAmountInfo.value?.orderMaxPay??super.maxValue;
    }

    return super.maxValue;
  }

  @override
  double profitAmount(int index){
    if(index >=0 && index<betSpecialSeries.length ) {
      double profitOdd = (double.tryParse(betSpecialSeries[index].betAmountInfo.value?.seriesOdds??'') ?? 0) ;
      TextEditingController textEditingController = amountControllerList[index];
      double editAmount = double.tryParse(textEditingController.text)??0.0;
      return editAmount * profitOdd - betSpecialSeries[index].count * editAmount;
    }
    return super.profitAmount(index);
  }

  @override
  void addShopCartItem(ShopCartItem item){
    for(int i=0;i<itemList.length;i++){
      ShopCartItem shopCartItem = itemList[i];
      if(shopCartItem.matchId == item.matchId){
        itemList.removeAt(i);
        break;
      }
    }

    super.addShopCartItem(item);
    betSpecialSeries.clear();
    betSpecialSeries.addAll(ShopCartUtil.getBetCountJoint(itemCount));

    amountControllerList.forEach((element) {
      element.text = '';
    });
  }

  @override
  void delShopCartItem(ShopCartItem item){
    super.delShopCartItem(item);
    betSpecialSeries.clear();
    betSpecialSeries.addAll(ShopCartUtil.getBetCountJoint(itemCount));
    amountControllerList.forEach((element) {
      element.text = '';
    });
    if(showKeyBoard) {
      int index = amountControllerList.indexOf(amountController);
      if (betSpecialSeries.length <= index) {
        keyboardVisiable(false);
      }
    }
    queryBetAmount();
  }

  @override
  void onInit() {
    super.onInit();

    for(int i=0;i<10;i++) {
      inputAmountList.add(0.0.obs);

      TextEditingController textEditingController = TextEditingController();
      textEditingController.addListener(() {
        double inputValue = double.tryParse(textEditingController.text) ?? 0.0;
        inputAmount.value = inputValue;
        inputAmountList[i].value = inputValue;
        update(['input_total']);
      });
      amountControllerList.add(textEditingController);

      FocusNode focusNode = FocusNode();
      focusNode.addListener(() {
        bool hasFocus = focusNode.hasFocus;
        if (hasFocus) {
          amountController = amountControllerList[i];
          amountFocusNode = focusNode;
          keyboardVisiable(true);
          update(['input_total']);
        }
      });
      amountFocusNodeList.add(focusNode);
    }
    scrollController.addListener(() {
      //滚动后隐藏滚动标志
      if(scrollController.offset > 0){
        showScrollFlag.value = false;
      }else{
        showScrollFlag.value = true;
      }
    });
  }

  @override
  void keyboardVisiable(bool show){
    super.keyboardVisiable(show);
    if(showKeyBoard){
      double bottomHeight = -20.0;
      if(itemCount < maxSeriesNum){
        bottomHeight += 46 + 2;
      }
      for(int i = betSpecialSeries.length-1;i>=0;i--){
        TextEditingController textEditingController = amountControllerList[i];
        if(textEditingController != amountController){
          bottomHeight += 32.h + 20;
          if(textEditingController.text.length > 0 || textEditingController == amountController){
            bottomHeight += 16.sp + 10;
          }
        }else{
          break;
        }
      }
      //需等待scroll重新布局
      Future.delayed(Duration(milliseconds: 100),(){
        double  currEditOffset = max(0,scrollController.position.maxScrollExtent - bottomHeight);
        //scrollController.animateTo(max(currEditOffset,scrollController.offset), duration: const Duration(milliseconds: 100), curve: Curves.ease);
        scrollController.jumpTo(max(currEditOffset,scrollController.offset));
      });

    }
  }

  ///判断是否显示滚动标志
  void postFrameCallback(){
    if(scrollController.positions.isNotEmpty) {
      if (scrollController.position.maxScrollExtent > 0 &&
          scrollController.offset == 0) {
        showScrollFlag.value = true;
      }else{
        showScrollFlag.value = false;
      }
    }
  }

  @override
  void clearData(){
    amountControllerList.forEach((element) {
      element.text = '';
    });
    super.clearData();
  }

  @override
  void closeBet(){
    showKeyBoard = false;
    if(betStatus.value != ShopCartBetStatus.Normal){
      clearData();
    }
    super.closeBet();
  }

  void goSingle(){
    closeBet();
    HomeController.to.changeMenu(MainMenu.menuList[0]);
    Get.until((route) => Get.currentRoute == Routes.mainTab);
  }

  void keepBet(){
    betStatus.value = ShopCartBetStatus.Normal;
    showKeyBoard = false;
    orderRespList.clear();
    seriesOrderRespList.clear();
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
      orderMinMaxMoney.deviceType =
      3; // 设备类型 "设备类型 1:H5，2：PC,3:Android,4:IOS,5:其他设备"
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

    ApiRes<BetAmountEntity> res;
    try {
      res = await BetApi.instance().queryBetAmount(req);
    }catch(e){
      Get.log(e.toString());
      res = ApiRes<BetAmountEntity>();
    }
    if(res.success){
      betSpecialSeries.forEach((element) {
        BetAmountBetAmountInfo? betAmountInfo = res.data?.betAmountInfo?.firstWhereOrNull((info) => info.type == element.id);
        element.betAmountInfo.value = betAmountInfo;
      });
    }else{
      //设置default值
    }
    update(['input']);
  }

  bool checkAmount(){
    // 串关 数量不是大于1条投注项 则提示
    if(itemList.length < minSeriesNum){
      String errorMsg = LocaleKeys.bet_bet_min_item.tr;
      errorMsg = errorMsg.replaceAll('{num}', minSeriesNum.toString());
      ToastUtils.showGrayBackground(errorMsg);
      return false;
    }
    // 串关 数量不能大于设置的数量
    if(itemList.length > maxSeriesNum){
      String errorMsg = LocaleKeys.bet_bet_max_item.tr;
      errorMsg = errorMsg.replaceAll('{num}', maxSeriesNum.toString());
      ToastUtils.showGrayBackground(errorMsg);
      return false;
    }

    // 请输入投注金额
    if(inputTotal <=0){
      ShopCartUtil.showBetError("M400005");
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

    for(int i=0;i<betSpecialSeries.length;i++) {
      // 有金额的情况下 判断限额
      BetCountModel betCountModel = betSpecialSeries[i];
      double inputValue = inputAmountList[i].value;
      // 投注金额 小于最小限额
      if(inputValue>0 && inputValue< (double.tryParse(betCountModel.betAmountInfo.value?.minBet??'')??0.0)){
        ShopCartUtil.showBetError("M400010");
        return false;
      }
    }

    // 获取当前币种
    String currency = UserController.to.currCurrency();
    if(currency == 'RMB') {
      // 人民币 使用CNY 不使用 RMB
      currency = "CNY";
    }

    BetReq betReq = BetReq();
    betReq.acceptOdds = int.tryParse(UserController.to.userPersonaliseEntity.toAccept)==1?1:2;          // 接受赔率变化情况
    betReq.tenantId = 1;
    betReq.deviceType = getDevice();          // 设备类型 1:H5，2：PC,3:Android,4:IOS,5:其他设备
    betReq.currencyCode = currency; // 币种
    betReq.deviceImei = '';         // 设备imei码，只有手机有，没有不添加
    betReq.fpId = '';               // 指纹55555555id

    List<BetReqSeriesOrders> seriesOrders = [];
    for(int i=0;i<betSpecialSeries.length;i++){
      BetCountModel betCountModel = betSpecialSeries[i];
      double inputValue = inputAmountList[i].value;
      List<BetReqSeriesOrdersOrderDetailList> orderDetailList = [];
      if(inputValue > 0.0){
        for(ShopCartItem item in itemList){
          BetReqSeriesOrdersOrderDetailList orderDetail = BetReqSeriesOrdersOrderDetailList();
          orderDetail.sportId = item.sportId;                             // 赛种id
          orderDetail.matchId = item.matchId;                             // 赛事id
          orderDetail.tournamentId = item.tournamentId;                   // 联赛id
          orderDetail.betAmount = inputValue.toStringAsFixed(2);          //投注金额
          //orderDetail.placeNum = item.placeNum!=0?item.placeNum.toString():'';    //盘口坑位
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
          //orderDetail.tournamentLevel = item.tournamentLevel;             // 联赛级别
          orderDetail.playId = item.playId;                               // 玩法id
          //orderDetail.dataSource = item.dataSource;                       // 数据源

          // 电竞 vr 投注不需要一下数据
          if(item.betType == OddsBetType.common){
            orderDetail.scoreBenchmark = '';
            orderDetail.placeNum = item.placeNum?.toString()??''; //盘口坑位
            orderDetail.tournamentLevel = item.tournamentLevel;   // 联赛级别
            orderDetail.dataSource = item.dataSource;  // 数据源
          }

          // 获取当前投注项 如果不支持当前的赔率 就使用欧赔
          if(!UserController.to.isCurDdds(item.oddsHsw)){
            orderDetail.marketTypeFinally = 'EU';
          }

          orderDetailList.add(orderDetail);
        }

        BetReqSeriesOrders betReqSeriesOrders = BetReqSeriesOrders();
        betReqSeriesOrders.seriesSum = betCountModel.count;                 // 串关数量
        betReqSeriesOrders.seriesType = int.tryParse(betCountModel.id)??0;
        betReqSeriesOrders.fullBet = 0;                                     // 是否满额投注，1：是，0：否
        betReqSeriesOrders.orderDetailList = orderDetailList;

        seriesOrders.add(betReqSeriesOrders);
      }
    }

    betReq.seriesOrders = seriesOrders;

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
      seriesOrderRespList.clear();
      seriesOrderRespList.addAll(res.data?.seriesOrderRespList??[]);
      //<!-- 订单状态 0:投注失败 1: 投注成功 2: 订单确认中 -->
      if(seriesOrderRespList.firstWhereOrNull((element) => element.orderStatusCode != 0 && element.orderStatusCode != 1)==null){
        if(seriesOrderRespList.firstWhereOrNull((element) => element.orderStatusCode != 0)==null){
          betStatus.value = ShopCartBetStatus.Failure;
        }else{
          betStatus.value = ShopCartBetStatus.Success;
        }
      }

      UserController.to.getBalance();

      return true;
    }else{
      ToastUtils.showGrayBackground(res.msg??res.code??'Error');
      return false;
    }

  }
}
