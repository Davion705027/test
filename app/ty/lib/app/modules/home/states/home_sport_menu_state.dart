import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

import '../models/sport_menu.dart';

class HomeSportMenuState {
  final leftShow = false.obs;
  final rightShow = false.obs;
  RxList<SportMenu> sportMenuList = RxList();
}
