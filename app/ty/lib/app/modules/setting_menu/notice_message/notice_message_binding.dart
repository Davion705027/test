import 'package:get/get.dart';

import 'notice_message_controller.dart';


class NoticeMessageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NoticeMessageController());
  }
}
