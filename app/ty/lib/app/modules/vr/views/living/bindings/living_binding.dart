import 'package:get/get.dart';

import '../controllers/living_view_controller.dart';

class VrLivingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VrLivingViewController>(
      () => VrLivingViewController(),
    );
  }
}
