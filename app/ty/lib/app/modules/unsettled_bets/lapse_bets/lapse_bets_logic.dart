import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../services/api/bet_api.dart';
import '../../../services/models/res/get_h5_pre_bet_orderlist_entity.dart';
import '../../login/login_head_import.dart';
import '../widgets/item/pre/pre_individually_item.dart';
import '../widgets/item/test_item.dart';

class LapseBetsLogic extends GetxController {
  List<GetH5PreBetOrderlistDataRecordxData> listData = [];

  //加载展示
  bool loading = true;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void onReady() {
    super.onReady();
    getH5PreBetOrderlist();
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }

  Future<void> getH5PreBetOrderlist() async {
    final res = await BetApi.instance().getH5PreBetOrderlist([2, 3, 4], '');
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

            ///便利map，把数据全部放在一起。
            reversedMap.forEach((key, value) {
              listData.addAll(value!.data);
            });
          }
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
        await BetApi.instance().getH5PreBetOrderlist([2, 3, 4], searchAfter);
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

    ///未结注单，已失效暂时只有单关这种列表
    if (seriesType == "1") {
      return PreIndividuallyItem(
        index: index,
        data: data,
        type: 1,
      );
    }
    return const TestItem();
  }
}
