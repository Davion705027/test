import 'package:flutter/cupertino.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/analyze_battle_array/widget/analyze_child_item.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/analyze_match_history/widget/analyze_match_history_chart_widget.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/analyze_match_information/widget/match_analyze_child_item.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/widget/data/bottom_message_conpoment.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/analysis/item/item_chart_widget.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/analysis/item/item_header_widget.dart';

import '../../../../../login/login_head_import.dart';
import '../widget/match_history_item.dart';

class MatchHistoryArrayComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      child: Column(
        children: [
          buildBody(),
        ],
      ),
    );
  }

  buildBody() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnalyzeMatchHistoryChartWidget(),
        //BottomMessageConpoment()
      ],
    );
  }

}
