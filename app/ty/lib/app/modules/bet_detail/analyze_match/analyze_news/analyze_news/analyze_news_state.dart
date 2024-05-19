import 'package:flutter_ty_app/app/services/models/res/analyze_news_entity.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../../../../services/models/res/analyze_favorite_article_entity.dart';
import '../../../../../services/models/res/match_details_news_entity.dart';

class AnalyzeNewsState {
  Rx<AnalyzeNewsEntity> analyzeNewsEntity=AnalyzeNewsEntity().obs;
  RxList<AnalyzeNewsEntity>  analyzeFavoriteArticleList=<AnalyzeNewsEntity>[].obs;
  AnalyzeNewsState() {
    ///Initialize variables
  }


}
