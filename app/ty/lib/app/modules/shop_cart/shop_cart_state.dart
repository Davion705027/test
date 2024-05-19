import 'package:get/get.dart';

import '../../services/models/res/dj_date_entity_entity.dart';
import '../home/models/main_menu.dart';

class ShopCartState {
  //购物车显示收敛控制开关
  final showShopCart = false.obs;
  final isMaintabDialogicOpen = false.obs;
  //早盘、滚球、串关、冠军 index
  MainMenu menu = MainMenu(0,'',0);
  //电竞冠军
  bool isDjGuanjun = false;
  //保存可预约的投注项
  final List<String> prebookOidList = [];


  ShopCartState() {
    ///Initialize variables
  }
}
