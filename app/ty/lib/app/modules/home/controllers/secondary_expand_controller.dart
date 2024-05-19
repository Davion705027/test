import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import '../../../services/models/res/match_entity.dart';
import '../../../utils/format_score_util.dart';
import '../widgets/item/profession/corner_play_temp.dart';
import 'home_controller.dart';

/// 子玩法管理

 class SecondaryController{



   static  Map<String, dynamic> map = {};/// 子玩法存取
   static int index = 0;//子玩法翻页


  /*
  是否翻页
  */
   static int setIndex(int indexs) {
    index = indexs;
    return index;
  }


   static  void clearMap() {
    map.clear();
  }


}
