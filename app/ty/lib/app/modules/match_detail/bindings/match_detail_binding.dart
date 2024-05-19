import 'package:get/get.dart';
import '../controllers/analyze_tab_controller.dart';
import '../controllers/match_detail_controller.dart';

class MatchDetailBinding extends Bindings {
  @override
  void dependencies() {
    /// 赛事详情
    Get.lazyPut(() => MatchDetailController());

    /// 赛事分析
    Get.lazyPut(() => AnalyzeTabController());
  }
}
