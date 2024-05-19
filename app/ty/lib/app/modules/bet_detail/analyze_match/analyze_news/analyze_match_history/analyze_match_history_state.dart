import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../services/models/res/analyze_back_video_info_entity_entity_entity_entity.dart';

class AnalyzeMatchHistoryState {
  RxInt curMainTab = 0.obs;

  AnalyzeBackVideoInfoEntityEntityEntityEventList?
      curAnalyzeBackVideoInfoEntityEntityEntityEventList;

  AnalyzeBackVideoInfoEntityEntityEntityEntity?
      analyzeBackVideoInfoEntityEntityEntity;
  RxList<AnalyzeBackVideoInfoEntityEntityEntityEventList> analyzeList =
      <AnalyzeBackVideoInfoEntityEntityEntityEventList>[].obs;


  AnalyzeMatchHistoryState() {
    ///Initialize variables
  }
}
