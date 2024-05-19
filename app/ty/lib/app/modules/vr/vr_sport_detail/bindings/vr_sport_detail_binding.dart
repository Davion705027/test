import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_detail_controller.dart';
import 'package:get/get.dart';

import '../controllers/vr_sport_detail_logic.dart';

class VrSportDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VrSportDetailLogic());

    /// 赛事详情
    Get.lazyPut(() => MatchDetailController());
  }
}
