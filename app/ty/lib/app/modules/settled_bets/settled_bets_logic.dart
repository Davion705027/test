import 'package:flutter/widgets.dart';
import 'package:flutter_ty_app/app/modules/settled_bets/settled_bets_state.dart';
import 'package:flutter_ty_app/app/modules/unsettled_bets/widgets/item/test_item.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../services/api/bet_api.dart';
import '../../services/models/res/get_h5_order_list_entity.dart';
import '../unsettled_bets/widgets/item/order/order_champion_item.dart';
import '../unsettled_bets/widgets/item/order/order_individually_item.dart';
import '../unsettled_bets/widgets/item/order/order_merge_together_item.dart';

class SettledBetsLogic extends GetxController {
  final SettledBetsState state = SettledBetsState();
  List<GetH5OrderListDataRecordxData> listData = [];
  //加载展示
  bool loading = true;

  RefreshController refreshController =RefreshController(initialRefresh: false);

  @override
  void onReady() {
    super.onReady();
    getH5OrderList();
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }
  ///请求列表数据
  Future<void> getH5OrderList() async {
    ///传参，目前没有选择，些死，加入选着日期就动态改
    final res = await BetApi.instance().getH5OrderListSettled('1', '', 2, 3);
    String code = res.code;
    ///判断code == "0000000"就是成功拿到数据
    if (code == "0000000") {
      GetH5OrderListData data = res.data;
      if (data != null) {
        ///倒叙map(回来的数据是反的，最新日期在map最后面一条)
        if (data.record != null) {
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
  }

  onLoadMore() async {
    if (listData.isEmpty) {
      refreshController.loadComplete();
      return;
    }
    String searchAfter = listData.last.modifyTimeStr;
    final res =
        await BetApi.instance().getH5OrderListSettled('1', searchAfter, 2, 3);
    String code = res.code;

    ///判断code == "0000000"就是成功拿到数据
    if (code == "0000000") {
      GetH5OrderListData data = res.data;
      if (data != null) {
        ///倒叙map(回来的数据是反的，最新日期在map最后面一条)
        if (data.record != null) {
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
    GetH5OrderListDataRecordxData data = listData[index];
    if (data == null) {
      return const TestItem();
    }
    String seriesType = data.seriesType;
    if (seriesType == "1") {
      ///单关
      return OrderIndividuallyItem(
        type: 1,
        index: index,
        data: data,
      );
    } else if (seriesType == "3") {
      ///冠军
      return OrderChampionItem(
        type: 1,
        index: index,
        data: data,
      );
    } else {
      ///多串一
      return OrderMergeTogetherItem(
        type: 1,
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
///提前结算折叠
  onPreSettleExpand(int index) {
    listData[index].preSettleExpand=!listData[index].preSettleExpand;
    update();
  }
}
