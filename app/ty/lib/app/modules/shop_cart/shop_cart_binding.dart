import 'package:get/get.dart';

import 'shop_cart_controller.dart';

class ShopCartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ShopCartController());
  }
}
