import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:flutter_ty_app/app/services/models/res/sport_config_info.dart';

import 'normal_results_controller.dart';

class NormalResultslogic {
  NormalResultslogic() {
    ///Initialize variables
  }


  // 获取普通赛果的菜单
  static List<TypeModel> getMenu(){
    List<SportConfigInfo>  originList = ConfigController.to.menuInit;

    var getName = ConfigController.to.getName;
    List<TypeModel> res = originList.where((element) => int.parse(element.mi) < 300)
                          .map((e){
                            var euid = int.parse(e.mi) - 100;
                            var sportId = e.mi;
                            // item.name = getName(item.sportId);
                            TypeModel item = TypeModel('',euid,'');
                            return item;
                          })
                          .toList();
    
    return res;                                                          
  }
}

// class ResultMenuItemModel{
//   late int euid;
//   late String sportId;
//   String name = '';
//   // ResultMenuItemModel({required this.euid,required this.sportId, required String name});
// }