import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_controller.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';

class ShopCartNavigatorObserver extends GetObserver {

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (route.settings.name == Routes.vrHomePage) {
      ShopCartController.to.isVrBet.value = true;
    }
    if (route.settings.name == Routes.DJView) {
      ShopCartController.to.isEsportBet.value = true;
    }
    ShopCartController.to.state.isMaintabDialogicOpen.value = Get.currentRoute == Routes.mainTab && (Get.isDialogOpen == true || Get.isBottomSheetOpen == true);
    ShopCartController.to.changeMenuIndex(ShopCartController.to.state.menu);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    if (route.settings.name == Routes.vrHomePage) {
      ShopCartController.to.isVrBet.value = false;
    }
    if (route.settings.name == Routes.DJView) {
      ShopCartController.to.isEsportBet.value = false;
    }
    ShopCartController.to.state.isMaintabDialogicOpen.value = Get.currentRoute == Routes.mainTab && (Get.isDialogOpen == true || Get.isBottomSheetOpen == true);
    ShopCartController.to.changeMenuIndex(ShopCartController.to.state.menu);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    if (route.settings.name == Routes.vrHomePage) {
      ShopCartController.to.isVrBet.value = false;
    }
    if (route.settings.name == Routes.DJView) {
      ShopCartController.to.isEsportBet.value = false;
    }
    ShopCartController.to.state.isMaintabDialogicOpen.value = Get.currentRoute == Routes.mainTab && (Get.isDialogOpen == true || Get.isBottomSheetOpen == true);
    ShopCartController.to.changeMenuIndex(ShopCartController.to.state.menu);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute?.settings.name == Routes.vrHomePage) {
      ShopCartController.to.isVrBet.value = true;
    } else if (oldRoute?.settings.name == Routes.vrHomePage) {
      ShopCartController.to.isVrBet.value = true;
    }
    if (newRoute?.settings.name == Routes.DJView) {
      ShopCartController.to.isEsportBet.value = true;
    } else if (oldRoute?.settings.name == Routes.DJView) {
      ShopCartController.to.isEsportBet.value = true;
    }
    ShopCartController.to.state.isMaintabDialogicOpen.value = Get.currentRoute == Routes.mainTab && (Get.isDialogOpen == true || Get.isBottomSheetOpen == true);
    ShopCartController.to.changeMenuIndex(ShopCartController.to.state.menu);
  }
}