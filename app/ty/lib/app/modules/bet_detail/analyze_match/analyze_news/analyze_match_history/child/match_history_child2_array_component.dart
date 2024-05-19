import 'package:flutter/cupertino.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/analyze_battle_array/widget/analyze_child_item.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/analyze_match_information/widget/match_analyze_child_item.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/widget/data/bottom_message_conpoment.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/analysis/item/item_header_widget.dart';

import '../../../../../login/login_head_import.dart';
import '../../../../../match_detail/widgets/container/analysis/item/analyze_divider.dart';
import '../widget/match_history_item.dart';

class MatchHistoryChild2ArrayComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
        Container(
          alignment: Alignment.centerLeft,
          width: 1.sw,
          decoration: BoxDecoration(
            color: Colors.white,
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
          child: buildList1(),
        ),
        SizedBox(height: 20,),
        //BottomMessageConpoment()
      ],
    );
  }

  buildList1() {
    return Column(
      children: [
        ItemHeaderWidget(name: "独赢"),
        Container(
          height: 24.w,
          child: Row(
            children: [
              Expanded(
                  flex: 5,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "公司",
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
                      "主胜",
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
                      "盘口",
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
                      "客胜",
                      style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF949AB6)),
                    ),
                  ))
            ],
          ),
        ),
        ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          scrollDirection: Axis.vertical,
          itemCount: 10,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          //列表项构造器
          itemBuilder: (BuildContext context, int index) {
            return const MatchHistoryItem();
          },
          //分割器构造器
          separatorBuilder: (BuildContext context, int index) {
            return AnalyzeDivider(

            );
          },
        )
      ],
    );
  }
}
