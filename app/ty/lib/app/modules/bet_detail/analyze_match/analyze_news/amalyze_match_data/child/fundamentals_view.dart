import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/amalyze_match_data/widget/analyze_fundamentals_card2.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/amalyze_match_data/widget/analyze_fundamentals_card3.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/amalyze_match_data/widget/analyze_fundamentals_card4.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/amalyze_match_data/widget/analyze_match_history_child_header2.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/amalyze_match_data/widget/analyze_match_history_recent_card.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/analysis/item/analyze_divider.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/analysis/item/text_no_data.dart';
import 'package:flutter_ty_app/app/services/models/res/match_analysises_third_match_sidelined_dto_data_bean.dart';

import '../../../../../../../generated/locales.g.dart';
import '../../../../../../services/models/res/analyze_get_match_analysise_data_match_history_battle_entity.dart';
import '../../../../../../widgets/no_data.dart';
import '../../../../../login/login_head_import.dart';
import '../../../../../match_detail/controllers/match_detail_controller.dart';
import '../../../../../match_detail/widgets/container/analysis/item/item_header_widget.dart';
import '../../../../../match_detail/widgets/container/analysis/item/item_history_header_two_widget.dart';
import '../../../../../match_detail/widgets/container/analysis/item/item_history_header_widget.dart';
import '../../../../../unsettled_bets/widgets/bets_loading/bets_loading_view.dart';
import '../analyze_match_data_logic.dart';
import '../widget/analyze_fundamentals_card1.dart';
import '../widget/analyze_match_history_child_basketball_header.dart';
import '../widget/analyze_match_history_child_basketball_item.dart';
import '../widget/analyze_match_history_child_header.dart';
import '../widget/analyze_match_history_child_item.dart';
import '../widget/analyze_match_history_child_item2.dart';
import '../widget/analyze_match_stop_list_card.dart';

/**
 * @author[xiongwei]
 * @version[创建日期，2024/2/29 10:57]
 * @function[功能简介 ]
 **/
class fundamentals_view extends StatefulWidget {
  fundamentals_view() {}

  @override
  State<StatefulWidget> createState() {
    return _CounterState();
  }
}

class _CounterState extends State<fundamentals_view> {
  bool expand = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetBuilder<AnalyzeMatchDataLogic>(
        id: "analyzeList",
        builder: (controller) {
          MatchDetailController detailController =
              Get.find<MatchDetailController>(tag: controller.tag);
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 6.w),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              controller: ScrollController(),
              child: Column(
                children: [
                  //联赛积分
                  AnalyzeFundamentalsCard1(),
                  //历史交战
                  AnalyzeFundamentalsCard2(),
                  //近期战绩
                  if ((controller.state.home.isNotEmpty ||
                      controller.state.away.isNotEmpty))
                    AnalyzeFundamentalsCard3(),
                  //伤停情况
                  Visibility(
                      visible: detailController.detailState.match?.csid == "1",
                      child: AnalyzeFundamentalsCard4()),
                ],
              ),
            ),
          );
        });
  }
}
