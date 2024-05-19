import 'package:get/get.dart';

import 'token_expired_logic.dart';

class TokenExpiredBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TokenExpiredLogic());
  }
}
