import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../generated/locales.g.dart';
import '../../../services/api/bet_api.dart';
import '../../../services/models/res/get_h5_pre_bet_orderlist_entity.dart';
import '../../login/login_head_import.dart';

import '../dialog/rule_statement_dialog/cancel_appointment_dialog.dart';
import '../widgets/item/pre/pre_individually_item.dart';
import '../widgets/item/test_item.dart';

class BookinBetsLogic extends GetxController {
  List<GetH5PreBetOrderlistDataRecordxData> listData = [];

  //加载展示
  bool loading = true;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getH5PreBetOrderlist();
  }

  @override
  void onClose() {
    refreshController.dispose();
    // TODO: implement onClose
    super.onClose();
  }

  ///请求列表数据
  Future<void> getH5PreBetOrderlist() async {
    final res = await BetApi.instance().getH5PreBetOrderlist([0], '');
    String code = res.code;

    ///判断code == "0000000"就是成功拿到数据
    if (code == "0000000") {
      listData.clear();
      GetH5PreBetOrderlistData data = res.data;
      if (data != null) {
        if (data.record != null) {
          ///倒叙map(回来的数据是反的，最新日期在map最后面一条)
          late Map<String, GetH5PreBetOrderlistDataRecordx?> record =
              data.record ?? {};
          List<MapEntry<String, GetH5PreBetOrderlistDataRecordx?>> entries =
              record.entries.toList();
          Map<String, GetH5PreBetOrderlistDataRecordx?> reversedMap =
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
  }

  onLoadMore() async {
    if (listData.isEmpty) {
      refreshController.loadComplete();
      return;
    }
    String searchAfter = listData.last.modifyTimeStr;
    final res = await BetApi.instance().getH5PreBetOrderlist([0], searchAfter);
    String code = res.code;

    ///判断code == "0000000"就是成功拿到数据
    if (code == "0000000") {
      GetH5PreBetOrderlistData data = res.data;
      if (data != null) {
        if (data.record != null) {
          ///倒叙map(回来的数据是反的，最新日期在map最后面一条)
          late Map<String, GetH5PreBetOrderlistDataRecordx?> record =
              data.record ?? {};
          if (record.isNotEmpty) {
            List<MapEntry<String, GetH5PreBetOrderlistDataRecordx?>> entries =
                record.entries.toList();
            Map<String, GetH5PreBetOrderlistDataRecordx?> reversedMap =
                Map.fromEntries(entries);

            ///便利map，把数据全部房在一起。
            reversedMap.forEach((key, value) {
              listData.addAll(value!.data);
            });
          }
          refreshController.loadComplete();
        } else {
          refreshController.loadNoData();
        }
      }
    } else {
      refreshController.loadComplete();
    }
    update();
  }

  ///添加item
  Widget getItem(int index) {
    GetH5PreBetOrderlistDataRecordxData data = listData[index];
    if (data == null) {
      return const TestItem();
    }
    String seriesType = data.seriesType;

    ///未结注单，预约中暂时只有单关这种列表
    if (seriesType == "1") {
      return PreIndividuallyItem(
        index: index,
        data: data,
        type: 0,
      );
    }
    return const TestItem();
  }

  ///修改赔率
  ///index 是你哪个一条
  ///type 0:减赔率，1:减赔率，2: 取消预约（走取消赔率接口），3：修改，4: 取消，5：确认(走更改赔率接口)
  setModifyOdds(int index, int type) {
    switch (type) {
      case 0:
        listData[index].detailList[0].oddFinallyChange =
            setMinusOdds(listData[index].detailList[0].oddFinallyChange);
        update();
        break;
      case 1:
        listData[index].detailList[0].oddFinallyChange =
            setIncreaseOdds(listData[index].detailList[0].oddFinallyChange);
        update();
        break;
      case 2:
        Get.dialog(
          CancelAppointmentDialogPage(
            index: index,
          ),
          barrierColor: Colors.black.withOpacity(0.8),
        );
        break;
      case 3:
        listData[index].canBeModified = true;
        update();
        break;
      case 4:
        listData[index].canBeModified = false;
        update();
        break;
      case 5:
        int odds =
            (double.parse(listData[index].detailList[0].oddFinallyChange) *
                    100000)
                .toInt();
        String marketType = listData[index].detailList[0].marketType ?? "";
        //当是香港盘的时候，更改赔率要加100000
        if (marketType=='HK'){
          odds = odds + 100000;
        }
        upDatePreBetOdds(
            listData[index].marketType, odds, listData[index].orderNo, index);
        break;
    }
  }

  double change = 0.01;

  ///减少赔率
  String setMinusOdds(String odds) {
    double parse = double.parse(odds);
    if (parse != 0.00) {
      parse = parse - change;
    } else {
      parse = 0.00;
    }
    return parse.toStringAsFixed(2);
  }

  ///增加赔率
  setIncreaseOdds(String odds) {
    double parse = double.parse(odds);
    parse = parse + change;
    return parse.toStringAsFixed(2);
  }

  ///修改赔率请求
  upDatePreBetOdds(
      String marketType, int odds, String orderNo, int index) async {
    final res =
        await BetApi.instance().updatePreBetOdds(marketType, odds, orderNo);
    String toast = LocaleKeys.bet_edit_fail.tr;
    if (res.code == "0000000") {
      // listData[index].canBeModified = false;
      // listData[index].detailList[0].oddFinally=listData[index].detailList[0].oddFinallyChange;
      // update();
      ///更改成功再去请求列表书记
      getH5PreBetOrderlist();
      toast = LocaleKeys.bet_edit_success.tr;
    }
    ToastUtils.showGrayBackground(toast);
  }

  ///未结注单-预约中-取消预约
  cancelPreBetOrder(int index) async {
    int orderNo = int.parse(listData[index].orderNo);
    final res = await BetApi.instance().cancelPreBetOrder(orderNo);
    if (res.code == "0000000") {
      getH5PreBetOrderlist();
    } else {
      ToastUtils.showGrayBackground(res.msg);
    }
  }
}
