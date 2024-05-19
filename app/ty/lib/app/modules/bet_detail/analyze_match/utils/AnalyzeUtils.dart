import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import '../../../../../generated/locales.g.dart';

class AnalyzeUtils{

  static  Map<String,String>  getMap(){
    return {
      "goal":LocaleKeys.match_result_goal.tr,
      "corner":LocaleKeys.footer_menu_corner_kick.tr,
      "red_card":LocaleKeys.match_result_red_card.tr,
      "yellow_card":LocaleKeys.match_result_yellow_card.tr,
      "punish":LocaleKeys.highlights_type_penalty.tr,
      "yellow_red_card":LocaleKeys.highlights_type_card_yellow_red.tr,
    };
  }
}