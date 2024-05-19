import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import '../../../../../services/models/res/analyze_array_person_entity.dart';
class AnalyzeBattleArrayInfoState {  /// 当前一级标签页
  RxInt curMainTab = 0.obs;

  Rx<AnalyzeArrayPersonEntity> analyzeArrayPersonEntity=AnalyzeArrayPersonEntity().obs;
  Rx<AnalyzeArrayPersonEntity> analyzeArrayInfoPersonEntity2=AnalyzeArrayPersonEntity().obs;
  RxList<String> teamsNames=<String>[].obs;
  AnalyzeBattleArrayInfoState() {
    ///Initialize variables
  }


}
