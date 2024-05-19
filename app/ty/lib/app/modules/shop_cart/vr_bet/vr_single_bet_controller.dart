import '../esport_bet/esport_single_bet_controller.dart';
import '../model/shop_cart_item.dart';
import '../shop_cart_controller.dart';

class VrSingleBetController extends EsportSingleBetController{
  @override
  void goParlay(){
    ShopCartItem item = itemList.first;
    closeBet();
    ShopCartController.to.isVrParlay.value = true;
    ShopCartController.to.currentBetController?.addShopCartItem(item);
  }
}