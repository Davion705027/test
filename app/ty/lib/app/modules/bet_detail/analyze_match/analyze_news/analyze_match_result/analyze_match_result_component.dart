import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/widget/data/bottom_message_conpoment.dart';
import 'package:get/get.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../../../widgets/no_data.dart';
import '../../../../match_detail/widgets/container/analysis/item/item_chart_widget.dart';
import '../widget/data/nodata_view.dart';
import 'analyze_match_result_logic.dart';

class AnalyzeMatchResultComponent extends StatelessWidget {
  AnalyzeMatchResultComponent({Key? key}) : super(key: key);

  final logic = Get.put(AnalyzeMatchResultLogic());
  final state = Get.find<AnalyzeMatchResultLogic>().state;

  @override
  Widget build(BuildContext context) {
    return logic.noData == true
        ? CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: ItemChartWidget(),
              ),
              // SliverToBoxAdapter(
              //   child: //BottomMessageConpoment(),
              // )
            ],
          )
        : NoData(
            content: LocaleKeys.analysis_football_matches_no_data.tr,
            top: 30.h,
          );
  }
}
