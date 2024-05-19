import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/analyze_match_odds/widget/triangle_path.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/analysis/item/item_header_widget.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_get_match_analysise_third_odds_entity.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../../../widgets/image_view.dart';

/// 下拉赛事选择项
class OddsAnalyzeChildHead extends StatelessWidget {

  OddsAnalyzeChildHead( {super.key});

  @override
  Widget build(BuildContext context) {
    return buildListHeader();
  }
  buildListHeader() {
    return Container(
      height: 24.w,
      child: Row(
        children: [
          Expanded(
              flex: 5,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  LocaleKeys.analysis_football_matches_company.tr,
                  style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF949AB6)),
                ),
              )),
          Expanded(
              flex: 4,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  LocaleKeys.analysis_football_matches_home_win1.tr,
                  style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF949AB6)),
                ),
              )),
          Expanded(
              flex: 4,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  LocaleKeys.analysis_football_matches_handicap.tr,
                  style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF949AB6)),
                ),
              )),
          Expanded(
              flex: 4,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  LocaleKeys.analysis_football_matches_away_win.tr,
                  style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF949AB6)),
                ),
              ))
        ],
      ),
    );
  }
}
