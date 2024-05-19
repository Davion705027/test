import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import '../../global/assets/preloadImg.dart';
import '../../global/config_controller.dart';
import '../../global/user_controller.dart';
import '../../utils/systemchrome.dart';
import 'splash_logic.dart';

class SplashController extends GetxController with WidgetsBindingObserver {
  final Splashlogic logic = Splashlogic();

  @override
  void onInit() {
    super.onInit();

    ///ws开启 对app状态进行监听
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void onReady() {
    initData();
    PreloadImg.preloadMenu(Get.context!);
    PreloadImg.preloadLeague(Get.context!);
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> initData() async {
    String? token = StringKV.token.get();
    String api = StringKV.baseUrl.get() ?? '';
    Get.log('api: $api');
    SystemUtils.isDarkMode(Get.isDarkMode);

    if (ObjectUtil.isEmptyString(token)) {
      Get.offNamed(Routes.login);
    } else {
      ConfigController.to.fetchConfig();
      UserController.to.getUserInfo();
      Get.offNamed(Routes.mainTab);
    }
    // Get.offNamed(Routes.mainTab);
  }
}
