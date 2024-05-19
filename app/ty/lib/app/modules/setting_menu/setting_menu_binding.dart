import 'package:flutter_ty_app/app/modules/dj/controllers/dj_controller.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

import '../main_tab/main_tab_controller.dart';
import 'setting_menu_controller.dart';

class SettingMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingMenuController());
    Get.lazyPut(() => MainTabController());
    // Get.lazyPut(() =>  HomeController());
    Get.lazyPut(() => DJController());
  }
}
