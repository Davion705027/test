import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../../../../services/models/res/analyze_match_information_entity.dart';

class AnalyzeMatchInformationState {
  RxInt curMainTab = 0.obs;
  List<AnalyzeMatchInformationEntity> datalist=[];
  Map<String,dynamic>
  analyzeGetMatchAnalysiseDataItemEntity =
  {};

  List<List<AnalyzeMatchInformationEntity>> lineupInfo=[[],[],[]];

  AnalyzeMatchInformationState() {
    ///Initialize variables
  }
}
