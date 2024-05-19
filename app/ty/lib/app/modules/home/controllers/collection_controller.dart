import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_map_operate.dart';
import 'package:flutter_ty_app/app/global/user_controller.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/home/models/sport_menu.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/api/match_api.dart';
import 'package:oktoast/oktoast.dart';

import '../../../services/models/res/match_entity.dart';

String COLLECTION_TID = 'collection_tid_';
String COLLECTION_MID = 'collection_mid_';

class CollectionController extends GetxController {
  static CollectionController get to =>
      Get.put(CollectionController(), permanent: true);

  Set<String> commonCollectionTidList = {};
  Set<String> commonCollectionMidList = {};

  Set<String> championCollectionMidList = {};
  Set<String> djCollectionMidList = {};

  int collectionCount = 0;

  addOrCancelTournament(String tid) {
    bool tf = commonCollectionTidList.contains(tid);
    MatchApi.instance()
        .addOrCancelTournament(UserController.to.getUid(), tid, tf ? 0 : 1)
        .then((value) {
      if (value.success) {
        if (tf) {
          HomeController.to.removeMatchs(tid);
        }
        CollectionController.to.updateCollection();
        CollectionController.to.fetchCollectionCount();
      }
    });
  }

  addOrCancelTournamentGuanjun(MatchEntity match) {
    String mid = match.mid;
    bool tf = championCollectionMidList.contains(mid) || match.tf;
    match.tf = !tf;
    Get.log("match.tf = ${match.tf} addOrCancelTournamentGuanjun =  $match ");
    championCollectionMidList.remove(mid);
    DataStoreController.to.updateMatch(match);
    MatchApi.instance()
        .addOrCancelTournamentGuanjun(
            UserController.to.getUid(), mid, tf ? 0 : 1)
        .then((value) {
      Get.log('addOrCancelTournamentGuanjun = $value tf = $tf');
      if (value.success) {
        if (tf) {
          HomeController.to.removeMatch(mid);
        }
        CollectionController.to.updateCollection();
        CollectionController.to.fetchCollectionCount();
      }
    });
  }

  addOrCancelMatch(MatchEntity match) {
    bool mf = commonCollectionMidList.contains(match.mid) || match.mf;
    MatchApi.instance()
        .addOrCancelMatch(UserController.to.getUid(), match.mid, mf ? 0 : 1)
        .then((value) {
      if (value.success) {
        if (mf) {
          HomeController.to.removeMatch(match.mid);
        }
        match.mf = !mf;
        DataStoreController.to.updateMatch(match);
        CollectionController.to.updateCollection();
        CollectionController.to.fetchCollectionCount();
      }
    });
  }

  updateCollection() async {
    try {
      final res = await MatchApi.instance()
          .collectMatches(0, UserController.to.getUid());
      if (res.success && res.data != null) {
        commonCollectionTidList = (res.data!["1"]?.tids ?? []).toSet();
        commonCollectionMidList = (res.data!["1"]?.mids ?? []).toSet();
        championCollectionMidList = (res.data!['2']?.mids ?? []).toSet();
        Get.log("冠军 = $championCollectionMidList");
        djCollectionMidList = (res.data!['3']?.mids ?? []).toSet();
        update();
      }
    } catch (e) {
      showToast(LocaleKeys.msg_msg_nodata_09.tr);
      print(e);
    }
  }


  /// 更新收藏数据
  Future<void> fetchCollectionCount() async {
    try {
      SportMenu? sportMenu = ConfigController.to
          .getSportMenuListByMenuMi(HomeController.to.homeState.menu)
          .safeFirst;
      if (sportMenu == null) return;
      if (sportMenu.mi == '50000') {
        final res = await MatchApi.instance().updateCollectMatches(
            UserController.to.getUid(),
            sportMenu.euid,
            HomeController.to.homeState.matchListReq.sort,
            HomeController.to.homeState.matchListReq.type);
        if (res.success && res.data != null) {
          collectionCount = res.data!
                  .where((element) => ObjectUtil.isEmptyString(element.sportId))
                  .toList()
                  .safeFirst
                  ?.count ??
              0;
          ConfigController.to.updateTopCount(collectionCount, '50000');
          update(['50000']);
        }
      }
    } catch (e) {
      Get.log('fetchCollectionCount error: $e');
    }
  }
}
