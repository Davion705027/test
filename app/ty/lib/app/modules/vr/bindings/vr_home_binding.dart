import 'package:get/get.dart';

class VrHomeBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<VrHomeController>(
    //   () => VrHomeController(),
    // );
    // TODO:可能需要做成全局 put，app 启动时就 put
    // Get.lazyPut<BettingCartController>(
    //   () => BettingCartController(),
    // );
  }
}
