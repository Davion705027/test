import 'package:get/get.dart';

import '../../global/data_store_controller.dart';
import 'sdk_home_controller.dart';

class SdkHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SdkHomeController());
  }
}
