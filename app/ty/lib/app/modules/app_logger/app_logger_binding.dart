import 'package:get/get.dart';

import 'app_logger_logic.dart';

class AppLoggerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AppLoggerLogic());
  }
}
