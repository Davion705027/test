import 'dart:async';
import 'dart:core';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_map_operate.dart';
import 'package:flutter_ty_app/app/global/user_controller.dart';
import 'package:flutter_ty_app/app/core/constant/index.dart';
import 'package:flutter_ty_app/app/global/ws/ws_type.dart';
import 'package:flutter_ty_app/app/modules/match_detail/models/odds_button_enum.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_util.dart';
import 'package:get/get.dart';


import '../../../core/format/common/module/format-score.dart';
import '../../../core/format/project/module/format-odds-conversion-mixin.dart';
import '../../../global/data_store_controller.dart';
import '../../../global/ws/ws_app_send.dart';
import '../../../services/api/bet_api.dart';
import '../../../services/models/req/latest_market_req.dart';
import '../../../services/models/res/bet_result_entity.dart';
import '../../../services/models/res/last_market_entity.dart';
import '../../../services/models/res/match_entity.dart';
import '../../../utils/bus/bus.dart';
import '../../../utils/bus/event_enum.dart';
import '../model/shop_cart_item.dart';
import '../model/shop_cart_type.dart';
import '../shop_cart_controller.dart';
import '../shop_cart_state.dart';

//单关、串关基类。定义投注通用接口
abstract class BaseBetController extends GetxController {
  final RxList<ShopCartItem> itemList = RxList.empty(growable: true);

  int get itemCount => itemList.length;

  late TextEditingController amountController;

  late FocusNode amountFocusNode;
  bool showKeyBoard = false;
  final inputAmount = 0.0.obs;
  final autoAcceptBetter = true.obs;

  Rx<ShopCartBetStatus> betStatus = ShopCartBetStatus.Normal.obs;

  List<BetResultOrderDetailRespList> orderRespList = [];
  List<BetResultSeriesOrderRespList> seriesOrderRespList = [];
  List<LastMarketEntity> latestMarketInfoList = [];

  StreamSubscription? subscription;

  //不能与ShopCartController互相嵌套初始化 final state = Get.find<ShopCartController>().state;
  ShopCartState? _state;

  ShopCartState get state {
    _state ??= ShopCartController.to.state;

    return _state!;
  }

  String get minValue {
    return '10';
  }

  String get maxValue {
    return '8888';
  }

  List<int> get userCvoMoney {
    return [100, 200, 500, 1000, 2000];
  }

  double get inputTotal {
    return inputAmount.value;
  }

  double profitAmount(int index) {
    return 0.0;
  }

  bool get isSpecialState {
    return false;
  }

  String get specialStateReason {
    return '';
  }

  @override
  void onInit() {
    super.onInit();

    subscription = Bus.getInstance().wsReceive<WsType>().listen((event) {
      switch (event.type) {
        case WsType.C101:
        case WsType.C901:
          // 赛事状态
          setBetC101Change(event.data['cd'] as Map);
          break;
        case WsType.C102:
          // 赛事阶段
          setBetC102Change(event.data['cd'] as Map);
          break;
        case WsType.C103:
          // 赛事比分
          setBetC103Change(event.data['cd'] as Map);
          break;
        case WsType.C104:
          // 赛事级别盘口状态
          setBetC104Change(event.data['cd'] as Map);
          break;
        case WsType.C105:
        case WsType.C106:
          // 赛事订阅盘口赔率变更 修改投注项变更
          // 投注项变更
          setBetC106Change(event.data['cd'] as Map);
          break;
        case WsType.C109:
          // 赛事开启
          setBetC109Change(event.data['cd'] as List);
          break;
        case WsType.C112:
          //玩法移除或开启
          setBetC112Change(event.data['cd'] as Map);
          break;
        case WsType.C201:
          // 注单状态
          setBetC201Change(event.data['cd'] as Map);
          break;
        // case WsType.C203:
        //   //刷新余额:统一刷新
        //
        //   break;
        case WsType.C302:
        case WsType.C303:
          //赛事盘口变化
          setBetC303Change(event.data['cd'] as Map);
          break;
        default:
          break;
      }
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  void addShopCartItem(ShopCartItem item) {
    itemList.add(item);
    ShopCartController.to.subscribeMarket();
    //发起订阅可以放在UserController里
    //AppWebSocket.instance()
    //    .skt_send_order({'cuid': UserController.to.getUid()});
    betStatus.value = ShopCartBetStatus.Normal;
    Bus.getInstance().emit(EventType.oddsButtonUpdate);
  }

  void delShopCartItem(ShopCartItem item) {
    itemList.remove(item);
    Bus.getInstance().emit(EventType.oddsButtonUpdate);
  }

  void closeBet() {
    state.showShopCart.value = false;
  }

  void showBet({queryAmount=false}) {
    state.showShopCart.value = true;
    UserController.to.getBalance();

    if(queryAmount){
      queryBetAmount();
    }
  }

  void clearData() {
    //清理数据
    itemList.clear();
    orderRespList.clear();
    try {
      amountController.text = '';
    } catch (e) {
      //late未初始化，忽略
    }
    inputAmount.value = 0.0;
    Bus.getInstance().emit(EventType.oddsButtonUpdate);
  }

  Future<bool> doBet() async {
    clearData();

    return true;
  }

  //获取限额，子类中实现
  Future<void> queryBetAmount() async {}

  /*
  显示隐藏键盘
   */
  void keyboardVisiable(bool show) {
    showKeyBoard = show;
    if (!showKeyBoard) {
      amountFocusNode.unfocus();
    }
    update(['keyboard', 'input']);
  }

  /*
  数字键
   */
  void insertText(String myText) {
    final text = amountController.text;
    TextSelection textSelection = amountController.selection;
    if (textSelection.start < 0) {
      //未focus
      textSelection = TextSelection(baseOffset: 0, extentOffset: 0);
    }

    String newText = text.replaceRange(
      textSelection.start,
      textSelection.end,
      myText,
    );

    if(newText.substring(0,1) == '0' && newText.length>1 && newText.substring(1,2) != '.'){
      //0后面只能输入小数点
      return;
    }
    final newTextArray = newText.split('.');
    if (newTextArray.length > 1 && newTextArray[1].length > 2) {
      //小数点后只输入2位
      return;
    }
    if(newTextArray.length > 2) {
      //已有小数点
      return;
    }
    double maxInput = min((double.tryParse(maxValue) ?? 0),
        UserController.to.balanceAmount.value);
    if ((double.tryParse(newText) ?? 0) > maxInput) {
      newText = maxInput.toStringAsFixed(2);
      amountController.text = newText;
    } else {
      final myTextLength = myText.length;
      amountController.text = newText;
      amountController.selection = textSelection.copyWith(
        baseOffset: textSelection.start + myTextLength,
        extentOffset: textSelection.start + myTextLength,
      );
    }
    amountFocusNode.requestFocus();

    update(['keyboard']);
  }

  /*
  数字替换键
   */
  void replaceText(String myText) {
    double maxInput = min((double.tryParse(maxValue) ?? 0),
        UserController.to.balanceAmount.value);
    if ((double.tryParse(myText) ?? 0) > maxInput) {
      myText = maxInput.toStringAsFixed(2);
    }

    amountController.text = myText;

    amountFocusNode.requestFocus();

    update(['keyboard']);
  }

  /*
  最大值
   */
  void maxInputText() {
    double maxInput = min((double.tryParse(maxValue) ?? 0),
        UserController.to.balanceAmount.value);
    amountController.text = maxInput.toStringAsFixed(2);

    amountFocusNode.requestFocus();

    update(['keyboard']);
  }

  /*
  删除键
   */
  void backspace() {
    amountFocusNode.requestFocus();
    final text = amountController.text;
    final textSelection = amountController.selection;
    final selectionLength = textSelection.end - textSelection.start;

    // There is a selection.
    if (selectionLength > 0) {
      final newText = text.replaceRange(
        textSelection.start,
        textSelection.end,
        '',
      );
      amountController.text = newText;
      amountController.selection = textSelection.copyWith(
        baseOffset: textSelection.start,
        extentOffset: textSelection.start,
      );
      return;
    }

    // The cursor is at the beginning.
    if (textSelection.start == 0) {
      return;
    }

    // Delete the previous character
    final previousCodeUnit = text.codeUnitAt(textSelection.start - 1);
    final offset = _isUtf16Surrogate(previousCodeUnit) ? 2 : 1;
    final newStart = textSelection.start - offset;
    final newEnd = textSelection.start;
    final newText = text.replaceRange(
      newStart,
      newEnd,
      '',
    );
    amountController.text = newText;
    amountController.selection = textSelection.copyWith(
      baseOffset: newStart,
      extentOffset: newStart,
    );

    update(['keyboard']);
  }

  bool _isUtf16Surrogate(int value) {
    return value & 0xF800 == 0xD800;
  }

  Future queryLatestMarketInfo({String type = 'submit_bet'}) async {
    List<LatestMarketReqIdList> betMarketList = [];
    itemList.forEach((element) {
      if(element.betType == OddsBetType.common) {
        LatestMarketReqIdList latestMarketReqId = LatestMarketReqIdList();
        latestMarketReqId.marketId = element.marketId;
        latestMarketReqId.matchInfoId = element.matchId;
        latestMarketReqId.oddsId = element.playOptionsId;
        latestMarketReqId.oddsType = element.playOptions;
        latestMarketReqId.playId = element.playId;
        latestMarketReqId.placeNum = element.placeNum;
        latestMarketReqId.matchType = element.matchType;
        latestMarketReqId.sportId = element.sportId;

        betMarketList.add(latestMarketReqId);
      }
    });

    if(betMarketList.isEmpty){
      return;
    }

    LatestMarketReq req = LatestMarketReq();
    req.idList = betMarketList;

    // 1 ：早盘赛事 ，2： 滚球盘赛事，3：冠军，4：虚拟赛事，5：电竞赛事")
    if ([3, 4, 5].contains(req.idList.safeFirst?.matchType)) {
      return;
    }

    List<String> midsList = [];
    try {
      final res = await BetApi.instance().queryLatestMarketInfo(req);
      if (res.success) {
        bool isMarketChange = false;
        //坑位是否变更
        itemList.forEach((item) {
          res.data?.forEach((element) {
            // 当前返回的数据坑位
            LastMarketCurrentMarket? market = element.currentMarket;
            if (market == null || market.id.isEmpty) {
              //跳过该 element
              return;
            }

            if (element.matchInfoId == item.matchId &&
                element.playId == item.playId &&
                market?.placeNum == item.placeNum) {
              List<LastMarketCurrentMarketMarketOddsList> marketOddsList =
                  element.currentMarket?.marketOddsList ?? [];
              LastMarketCurrentMarketMarketOddsList? odds =
                  marketOddsList.firstWhereOrNull(
                      (page) => page.oddsType == item.playOptions);
              if (odds?.id.isNotEmpty ?? false) {
                // 赛事状态
                item.midMhs.value = element.matchHandicapStatus;
                // 投注项状态
                item.olOs.value = odds!.oddsStatus;
                // 盘口状态
                item.hlHs.value = market!.status;

                // ws断连后 需要对比数据 进行投注

                // 坑位变更
                if (item.playOptionsId != odds!.id &&
                    item.marketId != market!.id) {
                  item.olOs.value = 4;
                  isMarketChange = true;

                  midsList.add(item.matchId);
                }else if(type=='submit_bet'){
                  //更新数据仓库、因ws推送不及时导致数据有差异。临时代码
                  MatchHpsHlOl? olEntity = DataStoreController.to.getOlById(odds!.id);
                  if(olEntity!=null){
                    olEntity.ov = odds.oddsValue;
                    DataStoreController.to.updateOl(olEntity);
                  }
                }

                // 替换新id
                item.playOptionsId = odds!.id;
                // 盘口id
                item.marketId = market!.id;
                //赔率 10W位
                item.changeOdds(odds.oddsValue);

                //最终赔率
                item.oddFinally.value =
                    TYFormatOddsConversionMixin.computeValueByCurOddType(
                        item.odds,
                        item.playId,
                        item.oddsHsw.split(','),
                        int.tryParse(item.sportId) ?? 0);

                // 投注项类型
                item.playOptions = odds.oddsType;
                // 盘口值
                item.marketValue = market!.marketValue;
                // 球头
                if(item.handicapHv.value.isNotEmpty) {
                  // 篮球 让分/总分 足球 让球/大小
                  if( market_flag_basketball_list.contains(item.playId) || market_flag_list.contains(item.playId)) {
                    item.handicapHv.value = odds.playOptions.isNotEmpty
                        ? odds.playOptions
                        : (market!.marketValue.isNotEmpty
                        ? market!.marketValue
                        : item.handicapHv.value);
                  }else{
                    item.handicapHv.value = odds.playOptions.isNotEmpty
                        ? odds.playOptions
                        : (item.handicapHv.value.isNotEmpty
                        ? item.handicapHv.value
                        : market!.marketValue);
                  }
                }
                // let play_option_name = ''
                // // 主队 客队
                // if( odds.oddsType == 1 ){
                //   play_option_name = element.home ;
                // }else{
                //   play_option_name = element.away  ;
                // }
                item.playOptionName = item.handicap +
                    ' ' +
                    (odds.playOptions.isNotEmpty
                        ? odds.playOptions
                        : market!.marketValue);
                item.playOptions = odds.oddsType;

                //TODO 作用不明
                //item.placeNum = 'place_num';

                // 如果是早盘赛事 则设置当前的 赛事状态
                if (item.matchType == 1) {
                  // 赛事状态：0未开赛，1 进行中 4 结束 (对应:ms)
                  if (element.matchStatus == 0) {
                    item.matchType = 1;
                  }
                  // 1 ：早盘赛事 ，2： 滚球盘赛事，3：冠军，4：虚拟赛事，5：电竞赛事")
                  if (element.matchStatus == 1) {
                    item.matchType = 2;
                  }
                }

                Bus.getInstance().emit(EventType.oddsButtonUpdate);
              }
            }
          });
        });

        //坑位变化 预约状态flutter无需特殊处理

        //坑位变化
        if (isMarketChange && ShopCartController.to.currentBetController == this && betStatus.value == ShopCartBetStatus.Normal) {
          // 提示 您所选投注项的赔率，盘口及有效性产生变化
          ShopCartUtil.showBetError('0402009');

          //数据仓库处理C106，未处理坑位变化，暂时在这里加上
          if(type=='C106') {
            Bus.getInstance().emit(EventType.init302, midsList);
          }
        }

        // 坑位变化 重新获取限额
        // if(type != 'submit_bet'){
        //   queryBetAmount();
        // }
        // 现在不需要了？
        // set_market_id_to_ws()
        //不重新queryBetAmount的话，需要设置新的latestMarketInfoList
        latestMarketInfoList = res.data ?? latestMarketInfoList;
      }
    } catch (e) {
      Get.log(e.toString());
    }
  }

  /**
   * C101 数据
   * `mid` 赛事Id
   * `ms` 赛事状态 0:未开赛 1:赛事进行中  2:暂停 3:结束 4:关闭 5:取消 6:比赛放弃 7:延迟 8:未知 9:延期 10:比赛中断 110:即将开赛
   * @description: 赛事状态
   * @param {Object} obj socket推送的消息体
   * @return {undefined} undefined
   */
  void setBetC101Change(Map obj) {
    var ms = obj['ms'].toInt();
    // 赛事状态为 3:结束 4:关闭 5:取消 6:比赛放弃 8:未知 赛事进行关盘处理
    if (![3, 4, 5, 6, 8].contains(ms)) {
      return;
    }

    var mid = obj['mid'];
    setBetListDeactivated(mid);
  }

  void setBetListDeactivated(dynamic mid) {
    List midList = itemList.map((element) => element.matchId).toList();
    if (midList.contains(mid)) {
      itemList.forEach((element) {
        if (element.matchId == mid) {
          element.midMhs.value = 2;
        }
      });
    }
  }

  void setBetC102Change(Map obj) {
    var mmp = obj['mmp'];
    // 赛事阶段 999 结束
    if (mmp != '999') {
      return;
    }
    var mid = obj['mid'];
    setBetListDeactivated(mid);
  }

  void setBetC103Change(Map obj) {
    var mid = obj['mid'];
    List midList = itemList.map((element) => element.matchId).toList();
    if (midList.contains(mid)) {
      itemList.forEach((element) {
        if (element.matchId == mid) {
          // 更新 基准分
          //TODO 此处需要从数据仓库重新获取数据
          // const mid_obj = lodash_.get(query.list_to_obj, `mid_obj.${obj.matchId}_`, {})
          // const ol_obj = lodash_.get(query.list_to_obj, `ol_obj.${obj.matchId}_${obj.playOptionsId}`, {})
          // return calc_bifen(mid_obj.msc,mid_obj.csid,mid_obj.ms,ol_obj._hpid)
          MatchEntity? match = DataStoreController.to.getMatchById(element.matchId);
          element.markScore = ShopCartUtil.calcBifen(
              match?.msc??[],
              int.tryParse(element.sportId) ?? 0,
              element.matchMs,
              int.tryParse(element.playId) ?? 0);
          //element.scoreHomeAway = `(${get_score(item,'home')}-${get_score(item,'away')})`
          if(match!=null) {
            final score = TYFormatScore.formatTotalScore(match);
            element.scoreHomeAway = score.text.replaceAll(' ', '');
          }
        }
      });
    }
  }

  void setBetC104Change(Map obj) {
    var mid = obj['mid'];
    List midList = itemList.map((element) => element.matchId).toList();
    if (midList.contains(mid)) {
      itemList.forEach((element) {
        if (element.matchId == mid) {
          element.midMhs.value = obj['mhs'];
        }
      });
    }
  }

  void setBetC106Change(Map obj) {
    var mid = obj['mid'];
    List hls = obj['hls'] ?? [];
    List midList = itemList.map((element) => element.matchId).toList();
    if (midList.contains(mid)) {
      // 投注项中有 推送的数据 那么就会对盘口和投注项id进行比对筛选
      List marketList = itemList.map((element) => element.marketId).toList();
      hls.forEach((hslElement) {
        if (marketList.contains(hslElement['hid'])) {
          // 查询投注项中的 投注项id
          var olObj = itemList.firstWhereOrNull(
              (element) => element.marketId == hslElement['hid']);
          if (olObj != null) {
            // 有坑位 并且 坑位变更
            if (hslElement['hn'] != olObj.placeNum && olObj.placeNum != null) {
              var wsItemHn = hls.firstWhereOrNull((element) =>
                  olObj.placeNum == element['hn'] &&
                  olObj.playId == element['hpid']);
              List<Map> hslElementOl = [];
              wsItemHn?['ol']?.forEach((element) {
                hslElementOl.add(element as Map);
              });
              var wsOlObj = hslElementOl.firstWhereOrNull(
                  (element) => element['ot'] == olObj.playOptions);
              if (wsOlObj?['ov'] != null) {
                //更新赔率
                wsChangeOddsInfo(hslElement, wsOlObj!, olObj, isPlaceNum: true);
                // 更新投注项内容后 重新发起新的ws订阅
                ShopCartController.to.subscribeMarket();
              }
              // 获取最新的盘口值
              Future.delayed(Duration(milliseconds: 100), () {
                // 电子赛事更新太快 延迟100毫秒 使用最后一次更新
                queryLatestMarketInfo(type: 'C106');
              });

              return;
            }
            // 盘口状态，玩法级别 0：开 1：封 2：关 11：锁
            if (hslElement['hs'] != 0) {
              // 直接更新状态 设置关盘
              olObj.hlHs.value = hslElement['hs'];
              return;
            }
            // 更新 投注项 数据
            List<Map> hslElementOl = [];
            hslElement['ol'].forEach((element) {
              hslElementOl.add(element as Map);
            });
            var wsOlObj = hslElementOl.firstWhereOrNull(
                (element) => element['ot'] == olObj.playOptions);
            if (wsOlObj?['ov'] != null) {
              //更新赔率
              wsChangeOddsInfo(hslElement, wsOlObj!, olObj);
            }
          }
        }
      });
    }
  }

  void wsChangeOddsInfo(Map hlsItem, Map oddsItem, ShopCartItem shopCartItem,
      {bool isPlaceNum = false}) {
    if (oddsItem['ov'] != null) {
      // 投注项和状态一致不更新数据
      if (shopCartItem.odds == int.tryParse(oddsItem['ov']) &&
          shopCartItem.olOs.value == oddsItem['os'] &&
          shopCartItem.hlHs.value == hlsItem['hs']) {
        return;
      }
      int newOdds = int.tryParse(oddsItem['ov']) ?? shopCartItem.odds;
      // 重新设置赔率
      shopCartItem.changeOdds(newOdds);
      // 设置 投注项状态  1：开 2：封 3：关 4：锁
      shopCartItem.olOs.value = oddsItem['os'];
      // 盘口状态，玩法级别 0：开 1：封 2：关 11：锁
      shopCartItem.hlHs.value = hlsItem['hs'];

      // 坑位变化 后找到的新坑位数据
      if (isPlaceNum) {
        shopCartItem.marketId = hlsItem['hid'];
        shopCartItem.playOptionsId = oddsItem['oid'];
      }
      // 获取新的基准分   需同步数据仓库
      MatchEntity? match = DataStoreController.to.getMatchById(shopCartItem.matchId);
      shopCartItem.markScore = ShopCartUtil.calcBifen(
          match?.msc??[],
          int.tryParse(shopCartItem.sportId) ?? 0,
          shopCartItem.matchMs,
          int.tryParse(shopCartItem.playId) ?? 0);
      // 赔率数据
      shopCartItem.oddFinally.value =
          TYFormatOddsConversionMixin.computeValueByCurOddType(
              shopCartItem.odds,
              shopCartItem.playId,
              shopCartItem.oddsHsw.split(','),
              int.tryParse(shopCartItem.sportId) ?? 0);

      Bus.getInstance().emit(EventType.oddsButtonUpdate);
    }
  }

  void setBetC109Change(List listObj) {
    List midList = itemList.map((element) => element.matchId).toList();
    bool changed = false;
    listObj.forEach((obj) {
      var mid = obj['mid'];
      if (midList.contains(mid)) {
        changed = true;
        itemList.forEach((element) {
          // 赛事状态为 3:结束 4:关闭 5:取消 6:比赛放弃 8:未知 赛事进行关盘处理
          if (element.matchId == mid && ![3, 4, 5, 6, 8].contains(obj['ms'])) {
            // 更新 赛事状态
            element.midMhs.value = obj['hs'];
          }
        });

      }
      //暂无此设计
      //this.set_bet_oid_list()
      //this.set_options_state()
    });
    if(changed){
      queryLatestMarketInfo(type:'C109');
    }
  }

  /**
   * C112 推送数据
   * `mid` 赛事Id
   * `mcms` 状态2:开启，3：删除（与上游一致）
   * `mcid` 玩法id集合
   * @description: 玩法集变更
   * @param {Object} obj socket推送的消息体
   * @return {undefined} undefined
   */
  void setBetC112Change(Map obj) {
    var mid = obj['mid'];
    List midList = itemList.map((element) => element.matchId).toList();
    if (midList.contains(mid)) {
      var mcid = obj['mcid'];
      var mcms = obj['mcms'];
      itemList.forEach((element) {
        // 当前 赛事 和 玩法对应的投注项
        if (element.matchId == mid && mcid.contains(element.playId)) {
          /// 盘口状态，玩法级别 0：开 1：封 2：关 11：锁
          if (mcms == 2) {
            element.hlHs.value = 0;
          }
          if (mcms == 3) {
            element.hlHs.value = 2;
          }
        }
      });
      queryLatestMarketInfo(type:'C112');
    }
  }

  /**
   *  C201推动数据
   * `orderNo` 订单编号
   * `status` 订单状态(1:投注成功 2:投注失败)
   * `newTotalMaxWinAmount` 订单最高可赢金额
   * `isOddsChange` 赔率是否变更，为true时处理赔率变更集合
   * `newProcessOrder` 是否投注新流程订单 1:是 0:否
   * `tryNewProcessBet` 是否重试投注新流程订单 1:是 2:投注金额变更 0:否
   * `refuseCode` 拒单编码
   * `cuid` 用户Id
   * `preStatus` 是否提前结算状态：0:原有结算逻辑, 1:是提前结算
   * `orderStatus` 专指提前结算状态  1:通过  2:拒绝
   *
   ***/
  void setBetC201Change(Map obj) {
    // 订单id
    // 订单状态 订单状态(1:投注成功 2:投注失败)
    int status = obj['status'] ?? 0;
    List orderNoList = orderRespList.map((element) => element.orderNo).toList();
    if (orderNoList.contains(obj['orderNo'])) {
      // 订单已经完成 不需要去设置 用户点击了 保留选项 或者投注的确定
      // 单关 单注
      orderRespList.forEach((element) {
        if (element.orderNo == obj['orderNo']) {
          element.orderStatusCode = obj['status'];
        }
      });
      if (status == 1) {
        betStatus.value = ShopCartBetStatus.Success;
      }
      if (status == 2) {
        betStatus.value = ShopCartBetStatus.Failure;
      }
    }

    List seriesOrderNoList =
        seriesOrderRespList.map((element) => element.orderNo).toList();
    if (seriesOrderNoList.contains(obj['orderNo'])) {
      //串关
      seriesOrderRespList.forEach((element) {
        if (element.orderNo == obj['orderNo']) {
          //element.orderStatusCode = obj['status'];
          if (status == 1) {
            element.orderStatusCode = 1;
          }
          if (status == 2) {
            element.orderStatusCode = 0;
          }
        }
      });
      if(seriesOrderRespList.firstWhereOrNull((element) => element.orderStatusCode != 0 && element.orderStatusCode != 1)==null){
        if(seriesOrderRespList.firstWhereOrNull((element) => element.orderStatusCode != 0)==null){
          betStatus.value = ShopCartBetStatus.Failure;
        }else{
          betStatus.value = ShopCartBetStatus.Success;
        }
      }
      update(['series_order_resp']);
    }
  }

  //刷新lastest_market_info
  void setBetC303Change(Map obj) {
    var mid = obj['mid'];
    var csid = obj['csid'];
    var hpid = obj['hpid'];
    // 获取单关下的赛事id 多个（单关合并）
    List midList = itemList.map((element) => element.matchId).toList();
    // 赛种
    List scidList = itemList.map((element) => element.sportId).toList();
    // 玩法
    List hpidList = itemList.map((element) => element.playId).toList();

    // 判断赛事级别盘口状态 中是否包含 投注项中的赛种 赛事 玩法
    if (scidList.contains(csid)) {
      if (midList.contains(mid)) {
        if (hpidList.contains(hpid)) {
          // 303 推送不会推送105 106
          queryLatestMarketInfo(type: 'C303');
        }
      }
    }
  }
}
