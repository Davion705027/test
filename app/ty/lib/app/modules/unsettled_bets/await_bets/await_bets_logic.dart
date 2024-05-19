import 'dart:core';

import 'package:flutter_ty_app/app/extension/map_extension.dart';
import 'package:flutter_ty_app/app/global/user_controller.dart';
import 'package:flutter_ty_app/app/global/ws/ws_app.dart';
import 'package:flutter_ty_app/app/global/ws/ws_app_send.dart';
import 'package:flutter_ty_app/app/utils/bus/event_enum.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


import '../../../services/api/bet_api.dart';
import '../../../services/models/res/get_cashout_max_amount_list_entity.dart';
import '../../../services/models/res/get_h5_order_list_entity.dart';
import '../../../utils/bus/bus.dart';
import '../../../utils/utils.dart';
import '../../login/login_head_import.dart';
import '../widgets/item/order/order_champion_item.dart';
import '../widgets/item/order/order_individually_item.dart';
import '../widgets/item/order/order_merge_together_item.dart';
import '../widgets/item/test_item.dart';

class AwaitBetsLogic extends GetxController {
  @override
  void onReady() {
    super.onReady();

    ///订阅ws
    orderPreSettleObserve();

    ///列表接口请求
    getH5OrderList();
  }

  ///数据列表
  List<GetH5OrderListDataRecordxData> listData = [];
  RefreshController refreshController =RefreshController(initialRefresh: false);

  ///加载展示
  bool loading = true;

  bool settleSwitch = UserController.to.isSettleSwitch();
  bool settleSwitchBasket = UserController.to.isSettleSwitchBasket();

  @override
  void onClose() {
    refreshController.dispose();
    _timer?.cancel();
    super.onClose();
  }

  orderPreSettleObserve() {
    ///注单订阅
    AppWebSocket.instance()
        .skt_send_order({'cuid': UserController.to.getUid()});
    Bus.getInstance().on(EventType.orderPreSettle, (Map<String, dynamic> data) {
      ///注单处理逻辑
     // print("AwaitBetsLogic----数据返回---" + data.toString());
      String orderNo = data.get("orderNo")!.toString();
      String status = data.get("status")!.toString();
      if (listData.isNotEmpty) {
        for (int i = 0; i < listData.length; i++) {
          if (listData[i].orderNo == orderNo) {
            ///1.只有是在已经等待提前结算才改状态，2避免bus 的重复通知。
            if (listData[i].earlySettlementSuccessfulType == 1) {
              ///1提前结算成功，2提前结算失败
              if (status == '1') {
                String preSettleAmount = data.get("preSettleAmount")!.toString();
                listData[i].maxCashout=preSettleAmount;
                listData[i].earlySettlementBeingRequested = false;
                listData[i].earlySettlementSuccessfulType = 2;
                update();
              } else if (status == '2') {
                listData[i].earlySettlementBeingRequested = false;
                listData[i].earlySettlementSuccessfulType = 3;
                update();
              }
            }
          }
        }
      }
    });
  }

  ///请求列表数据
  Future<void> getH5OrderList() async {
    ///传参，目前没有选择，些死，加入选着日期就动态改
    final res = await BetApi.instance().getH5OrderList('0','');
    String code = res.code;

    ///判断code == "0000000"就是成功拿到数据
    if (code == "0000000") {
      GetH5OrderListData data = res.data;
      if (data != null) {
        if (data.record != null) {
          ///倒叙map(回来的数据是反的，最新日期在map最后面一条)
          Map<String, GetH5OrderListDataRecordx?> record = data.record ?? {};
          List<MapEntry<String, GetH5OrderListDataRecordx?>> entries =
              record.entries.toList();
          Map<String, GetH5OrderListDataRecordx?> reversedMap =
              Map.fromEntries(entries);

          ///便利map，把数据全部房在一起。
          reversedMap.forEach((key, value) {
            listData.addAll(value!.data);
          });
        }
      }
    }
    loading = false;
    update();
    ///当列表中有单关，轮询请求提前结算接口。
    if (listData.isNotEmpty) {
        ///足球或者篮球开启提前结算，才去循环单关提起结算
      if (settleSwitch || settleSwitchBasket) {
        for (GetH5OrderListDataRecordxData element in listData) {
          if (element.seriesType == "1") {
            ///开始轮询提前结算接口
            setPollingIntervalRepeats();
            break;
          }
        }
      }
    }
  }

  onLoadMore() async {
    if (listData.isEmpty) {
      refreshController.loadComplete();
      return;
    }
    String searchAfter = listData.last.modifyTimeStr;
    ///传参，目前没有选择，些死，加入选着日期就动态改
    final res = await BetApi.instance().getH5OrderList('0',searchAfter);
    ///判断code == "0000000"就是成功拿到数据
      String code = res.code;
    if (code == "0000000") {
      GetH5OrderListData data = res.data;
      if (data != null) {
        if (data.record != null) {
          ///倒叙map(回来的数据是反的，最新日期在map最后面一条)
          Map<String, GetH5OrderListDataRecordx?> record = data.record ?? {};
          List<MapEntry<String, GetH5OrderListDataRecordx?>> entries =
          record.entries.toList();
          Map<String, GetH5OrderListDataRecordx?> reversedMap =
          Map.fromEntries(entries);
          ///便利map，把数据全部房在一起。
          reversedMap.forEach((key, value) {
            listData.addAll(value!.data);
          });
          refreshController.loadComplete();
        }else{
          refreshController.loadNoData();
        }
      }
    } else {
      refreshController.loadComplete();
    }
    update();
  }

  Timer? _timer;

  ///轮询5秒提前结算
  setPollingIntervalRepeats() {
    getCashoutMaxAmountList();
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      getCashoutMaxAmountList();
    });
  }

  ///提前结算请求
  getCashoutMaxAmountList() async {
    String orderNo = '';
    String splicing = '';

    ///拼接所有单号用 ，号拼接
    for (GetH5OrderListDataRecordxData element in listData) {
      if (element.seriesType == "1") {
        orderNo = orderNo + splicing + element.orderNo;
        splicing = ',';
      }
    }
    final res = await BetApi.instance().getCashoutMaxAmountList(orderNo);

    ///判断code == "0000000"就是成功拿到数据
    if (res.code == "0000000") {
      List<GetCashoutMaxAmountListData> data = res.data;
      if (data.isNotEmpty) {
        for (int i = 0; i < listData.length; i++) {
          ///只更改单关
          if (listData[i].seriesType == "1") {
            int sportId =listData[i].orderVOS[0].sportId;
            if ((!settleSwitch && sportId == 1) ||  ///当是足球，足球开关是关闭的时候
                (!settleSwitchBasket && sportId == 2)) { ///当是篮球，篮球开关是关闭的时候
                  continue;
            }
            ///当已经提前结算和，提前结算等待处理中是不更改状态的
            int earlySettlementSuccessfulType =
                listData[i].earlySettlementSuccessfulType;
            if (earlySettlementSuccessfulType == 0||earlySettlementSuccessfulType == 3){
              ///重新回到没有提前结算状态
              listData[i].earlySettlementSuccessfulType=0;
              ///正在发起提起结算请求，不能改状态
              if (!listData[i].earlySettlementBeingRequested) {
                /// 提前结算功能页面页全部关闭
                listData[i].turnOnEarlySettlement = false;
                listData[i].exhibitEarlySettlement = false;
                for (var element in data) {
                  String orderNo = element.orderNo;
                  ///轮询回来的单号，开启提前结算界面
                  if (listData[i].orderNo == orderNo) {

                      listData[i].exhibitEarlySettlement = true;
                      ///轮询回来的数据，每次轮询请求回来，都要更改提前结算金额
                      listData[i].maxCashout = element.preSettleMaxWin;
                  }
                }
              }
            }
          }
        }
      }
    } else {
      for (int i = 0; i < listData.length; i++) {
        ///只更改单关
        if (listData[i].seriesType == "1") {
          ///已结提前结算成功了，就不能改状态。
          int earlySettlementSuccessfulType =
              listData[i].earlySettlementSuccessfulType;
          if (earlySettlementSuccessfulType == 0||earlySettlementSuccessfulType == 3) {
            ///如果轮询回来没有单号，所有提前结算（所有）界面都关闭
            listData[i].exhibitEarlySettlement = false;
            /// 提前结算功能全部关闭
            listData[i].turnOnEarlySettlement = false;
            ///重新回到没有提前结算状态
            listData[i].earlySettlementSuccessfulType = 0;
          }
        }
      }
    }
    update();
  }

  ///开启提前结算功能
  setTurnOnEarlySettlement(int index) {
    ///正在提前结算中是不能，再发起提前结算的
    if (listData[index].earlySettlementBeingRequested) {
      return;
    }

    ///已经提前结算成功的，和已提前结算等待的，不能再次发起提起结算
    if (listData[index].earlySettlementSuccessfulType != 0) {
      return;
    }

    ///判断是否开始提前结算（点击1次，开启提前结算，点击2次才提前结算）
    if (!listData[index].turnOnEarlySettlement) {
      ///开启提前结算
      listData[index].turnOnEarlySettlement = true;
      update();
    } else {
      ///开始请求提前结算
      listData[index].earlySettlementBeingRequested = true;
      update();

      ///请求提前结算
      orderPreSettle(index);
    }
  }


  orderPreSettle(int index) async {
    int deviceType = getDevice();
    String frontSettleAmount = listData[index].maxCashout.toString();
    String orderNo = listData[index].orderNo;
    double settleAmount = listData[index].orderAmountTotal;
    final res = await BetApi.instance()
        .orderPreSettle(deviceType, frontSettleAmount, orderNo, settleAmount);
    String code = res.code;
    listData[index].turnOnEarlySettlement = false;
    if (res.code == "0000000" || res.code == "200") {
      ///提前结算成功
      listData[index].earlySettlementBeingRequested = false;
      listData[index].earlySettlementSuccessfulType = 2;

    // Get.dialog(
    //   const EarlySettlementDialogPage(
    //     state: true,
    //   ),
    //   barrierColor: Colors.black.withOpacity(0.8),
    // );
    } else if (code == "0400524") {
      ///只有040052提前请求，等待处理，通过ws 来确定状态
      listData[index].earlySettlementSuccessfulType = 1;
     //Get.dialog(
     //  const EarlySettlementDialogPage(
     //    state: false,
     //  ),
     //  barrierColor: Colors.black.withOpacity(0.8),
     //);
    } else {
      ///提前结算，失败。
      listData[index].earlySettlementBeingRequested = false;
      listData[index].earlySettlementSuccessfulType = 3;

      String msg = "";
      if (res.msg.isNotEmpty) {
        msg = res.msg;
      }
      ToastUtils.showGrayBackground(msg);
    }
    update();
  }

  Widget getItem(int index) {
    GetH5OrderListDataRecordxData data = listData[index];
    if (data == null) {
      return const TestItem();
    }
    String seriesType = data.seriesType;
    if (seriesType == "1") {
      ///单关
      return OrderIndividuallyItem(
        type: 0,
        index: index,
        data: data,
      );
    } else if (seriesType == "3") {
      ///冠军
      return OrderChampionItem(
        type: 0,
        index: index,
        data: data,
      );
    } else {
      ///各种串关
      return OrderMergeTogetherItem(
          type: 0,
          index: index,
          data: data,
          onTap: () => onTextExpand(index),
      );
    }
  }

  ///串关折叠
  onTextExpand(int index) {
    listData[index].isExpand = !listData[index].isExpand;
    update();
  }
}
