import '../esport_bet/esport_mix_bet_controller.dart';
import '../shop_cart_controller.dart';

class VrMixBetController extends EsportMixBetController{
  @override
  void goSingle(){
    clearData();
    ShopCartController.to.isVrParlay.value = false;
  }
}