import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_map_operate.dart';
import 'package:flutter_ty_app/app/global/user_controller.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/services/api/match_api.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../utils/bus/bus.dart';
import '../../../utils/bus/event_enum.dart';
import '../../../utils/debounce_throttle.dart';

extension HomeControllerEventBus on HomeController {
  handleEventBus() {
    /// 切换联赛
    Bus.getInstance().on(EventType.changeLang, (value) {
      changeLanguage();
    });

    var updateThrottle = throttle(() {
      handleData(true);
    });

    /// 删除赛事
    Bus.getInstance().on(EventType.removeMatch, (value) {
      int index =
          homeState.matchtSet.indexWhere((element) => element.mid == value);
      if (index >= 0) {
        homeState.matchtSet.removeAt(index);
        if (visiable && !homeState.isSearch) {
          updateThrottle();
        }
      }
    });

    var fetchThrottle = throttle(() {
      fetchData(isWsFetch: true);
    });

    /// C109增加赛事
    Bus.getInstance().on(EventType.RCMD_C109, (value) {
      ///进入详情 列表接口需要屏蔽
      if (DataStoreController.to.isEnterDatail == true) return;
      List maps =
          JsonUtil.getObjectList(value, (v) => v as Map<String, dynamic>) ?? [];
      List<String> csids = [];
      for (var map in maps) {
        String csid = map['csid'];
        csids.add(csid);
      }
      bool contain = homeState.matchtSet
              .indexWhere((element) => csids.contains(element.csid)) >=
          0;
      if (contain && visiable && !homeState.isSearch) {
        fetchThrottle();
      }
    });

    /// 赛事玩法级变更
    Bus.getInstance().on(EventType.socketOddinfo, (value) async {
      // List<String> mid = value DataStoreController.to.showMatchIdList.
      if (visiable && !homeState.isSearch && !homeState.endScroll) {
        Get.log('+++++++++++++++++++++++++++ socketOddinfo: $value');
        _updateByMidList(value);
      }
    });

    /// 赛事开赛状态/新增玩法盘口通知
    Bus.getInstance().on(EventType.init302, (value) {
      ///进入详情 列表接口需要屏蔽
      if (DataStoreController.to.isEnterDatail == true) return;
      bool contain = DataStoreController.to.showMatchIdList
              .indexWhere((element) => value.contains(element)) >=
          0;
      contain = true;
      if (visiable && !homeState.isSearch && contain && !homeState.endScroll) {
        Get.log('+++++++++++++++++++++++++++ init302: $value');
        _updateByMidList(value);
      }
    });

    /// 未开赛到开赛
    Bus.getInstance().on(EventType.RCMD_C101, (value) async {
      ///进入详情 列表接口需要屏蔽
      if (DataStoreController.to.isEnterDatail == true) return;
      Map<String, dynamic> map = (value as List).safeFirst;
      String? mid = map['cd']['mid'];
      int? ms = map['cd']['ms'];
      int? oldMs = map['oldMs'];

      if (mid == null || ms == null) return;

      /// ms 从0到1要拉数据
      if (oldMs == 0 && ms == 1 && visiable && !homeState.isSearch) {
        final res = await MatchApi.instance().getMatchBaseInfo(
            mid,
            UserController.to.getUid(),
            homeState.matchListReq.sort,
            homeState.matchListReq.euid,
            homeState.matchListReq.device ?? 'v2_h5_st',
            null,
            null,
            null,
            /*       "0",
          null,
          0,*/
            []);
        if (res.success && ObjectUtil.isNotEmpty(res.data)) {
          for (var element in res.data!) {
            DataStoreController.to.updateMatch(element, keepSecondary: true);
          }

          /// 列表更新排序
          handleData(true);
        }
      }
    });

    // 盘口设置
    Bus.getInstance().on(EventType.changeOddType, (_) {
      update();
    });
  }
  ///去掉推送监听
  removeBus() {
    Bus.getInstance().off(EventType.changeLang);
    Bus.getInstance().off(EventType.changeOddType);
    Bus.getInstance().off(EventType.removeMatch);
    Bus.getInstance().off(EventType.RCMD_C109);
    Bus.getInstance().off(EventType.socketOddinfo);
    Bus.getInstance().off(EventType.init302);
    Bus.getInstance().off(EventType.RCMD_C101);
  }

  Future<void> _updateByMidList(List<String> mids) async {
    List<String> targetMids = mids
        .where((element) =>
            DataStoreController.to.showMatchIdList.contains(element))
        .toList();
    if (targetMids.isNotEmpty) {
      try {
        final res = await MatchApi.instance().getMatchBaseInfo(
            mids.join(','),
            UserController.to.getUid(),
            homeState.matchListReq.sort,
            homeState.matchListReq.euid,
            homeState.matchListReq.device ?? 'v2_h5_st',
            null,
            null,
            null,
            /*       "0",
            null,
            0,*/
            []);
        if (res.success && ObjectUtil.isNotEmpty(res.data)) {
          res.data!.forEach((element) {
            DataStoreController.to.updateMatch(element, keepSecondary: true);
          });
        }
      } catch (e) {}
    }
  }
}
