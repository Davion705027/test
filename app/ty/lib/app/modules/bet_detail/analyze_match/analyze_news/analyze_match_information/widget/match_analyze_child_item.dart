import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/analysis/item/item_header_widget.dart';
import 'package:flutter_ty_app/app/services/models/res/match_intelligence_entity.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../../../services/models/res/analyze_match_information_entity.dart';
import '../../../../../../widgets/image_view.dart';

/// 下拉赛事选择项
class MatchAnalyzeItem extends StatelessWidget {
  AnalyzeMatchInformationEntity?
      sThirdMatchInformationDTOList;
  int index;
  MatchAnalyzeItem(this.index,
      AnalyzeMatchInformationEntity?
          sThirdMatchInformationDTOLists,
      {super.key}) {
    sThirdMatchInformationDTOList = sThirdMatchInformationDTOLists;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.w),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.w),
      width: 1.sw,
      decoration: BoxDecoration(
        color: Get.theme.tabPanelBackgroundColor,
        boxShadow: [
          // 阴影
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.04),
              blurRadius: 8,
              offset: Offset(0, 4.w),
              spreadRadius: 0,
              blurStyle: BlurStyle.normal),
        ],
        borderRadius: BorderRadius.all(Radius.circular(8.w)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ItemHeaderWidget(
            name:index==0?LocaleKeys.analysis_football_matches_Favorable_information.tr:(index==1?LocaleKeys.analysis_football_matches_Unfavorable_information.tr:LocaleKeys.analysis_football_matches_Neutral_Information.tr),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              sThirdMatchInformationDTOList!.content.toString(),
              style: TextStyle(
                color:Get.theme.tabPanelSelectedColor,
                fontSize: 12.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
