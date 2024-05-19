import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/models/header_type_enum.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../../../../services/models/res/analyze_array_person_entity.dart';

class AnalyzeBattleArrayState {  /// 当前一级标签页
  RxInt curMainTab = 0.obs;

  Rx<AnalyzeArrayPersonEntity> analyzeArrayPersonEntity=AnalyzeArrayPersonEntity().obs;
  Rx<AnalyzeArrayPersonEntity> analyzeArrayPersonEntity2=AnalyzeArrayPersonEntity().obs;
  RxList<String> teamsNames=<String>[].obs;
  AnalyzeBattleArrayState() {
    ///Initialize variables
  }


}
