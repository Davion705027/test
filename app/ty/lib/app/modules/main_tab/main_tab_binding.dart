import 'package:get/get.dart';

import '../setting_menu/setting_menu_controller.dart';
import 'main_tab_controller.dart';

class MainTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainTabController());
    Get.lazyPut(() => SettingMenuController());
  }
}
