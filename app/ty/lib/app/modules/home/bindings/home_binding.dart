import 'package:flutter_ty_app/app/modules/dj/controllers/dj_controller.dart';
import 'package:get/get.dart';

import '../../shop_cart/shop_cart_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    //Get.lazyPut<ShopCartController>(() => ShopCartController(), fenix: true);

    //Get.lazyPut<DJController>(() => DJController());
  }
}
