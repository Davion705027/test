import 'package:get/get.dart';

import 'vr_competition_detail_controller.dart';

class VrCompetitionDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VrCompetitionDetailController>(
      () => VrCompetitionDetailController(),
    );
  }
}
