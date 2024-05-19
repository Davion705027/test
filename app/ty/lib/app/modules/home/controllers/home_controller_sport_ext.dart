import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';

import '../../../services/models/res/menu_count_info_entity.dart';
import '../../../utils/bus/bus.dart';
import '../../../utils/bus/event_enum.dart';

extension HomeControllerSportExt on HomeController {

  //  ///菜单栏目统计
  // ///菜单栏目数量变化时触发
  addListenerC301() {
    Bus.getInstance().on(EventType.RCMD_C301, (wsObj) {
      List<MenuCountInfoEntity> list = [];
      (wsObj as List).forEach((element) {
        list.add(MenuCountInfoEntity.fromJson(element));
      });
      bool isRefresh = false;

      ///插入对应位置球种数量
      list.forEach((menuCountInfoEntity) {
        int index = homeSportMenuState.sportMenuList.indexWhere((element) =>
            element.euid.toString() == menuCountInfoEntity.menuId.toString());
        if (index >= 0) {
          homeSportMenuState.sportMenuList[index].count =
              menuCountInfoEntity.count;
          isRefresh = true;
        }
      });
      if (isRefresh && homeState.endScroll) {
        homeSportMenuState.sportMenuList.refresh();
      }
    });
  }

  removeListenerC301() {
    Bus.getInstance().off(EventType.RCMD_C301);
  }
}
