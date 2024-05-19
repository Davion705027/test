import 'dart:math';

import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/analyze_match_history/analyze_match_history_logic.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/analysis/blue_text_view.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/analysis/item/MatchlineProgressView.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/analysis/item/match_circle_progress_view.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'analyze_history_timelien_view.dart';

class AnalyzeMatchHistoryChartWidget extends StatelessWidget {
  final String? name;

  const AnalyzeMatchHistoryChartWidget({super.key, this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 10.w),
          child: Card(
            child: Container(
              color: Colors.white,
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  buildMatchEvent(),
                  buildMatchEventList(),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  buildMatchHead() {
    return Container(
      height: 28.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 8.w, right: 5.w),
                width: 6.w,
                height: 6.w,
                decoration: BoxDecoration(
                    color: Color(0xFFF53F3F),
                    borderRadius: BorderRadius.all(Radius.circular(6.w))),
              ),
              Text(
                "波里索夫",
                style: TextStyle(
                    fontSize: 12.w,
                    fontWeight: FontWeight.w400,
                    color:Get.theme.tabPanelSelectedColor),
              )
            ],
          ),
          Row(
            children: [
              Text(
                "若季诺",
                style: TextStyle(
                    fontSize: 12.w,
                    fontWeight: FontWeight.w400,
                    color:Get.theme.tabPanelSelectedColor),
              ),
              Container(
                margin: EdgeInsets.only(left: 8.w, right: 5.w),
                width: 6.w,
                height: 6.w,
                decoration: BoxDecoration(
                    color: Color(0xFFFEAE2B),
                    borderRadius: BorderRadius.all(Radius.circular(6.w))),
              ),
            ],
          ),
        ],
      ),
    );
  }


//事件UI
  buildMatchEvent() {
    return Container(
      margin: EdgeInsets.only(top: 11.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ImageView("assets/images/analyze/analyze_history_icon1.png",width: 12,),
          Text(
            "14:00 全场结束 ",
            style: TextStyle(color:Get.theme.tabPanelSelectedColor, fontSize: 12.sp),
          ),
          Text(
            " [3-5]",
            style: TextStyle(color: Color(0xFF179CFF), fontSize: 12.sp),
          )
        ],
      ),
    );
  }

  buildMatchEventList() {
    return GetBuilder<AnalyzeMatchHistoryLogic>(
        id: "playbackVideoUrlList",
        builder: (controller) {
          return Column(
              children: controller.state.analyzeList
                  .map((element) => AnalyzeHistoryTimelineView(
                element,
                        "曼德拉  43'",
                        "",
                        "assets/images/event/event_${Random().nextInt(5) + 1}.png",
                        element.fragmentPic ?? "",
                        Random().nextInt(2) == 0,
                        showFirst: element == controller.state.analyzeList[0],
                      ))
                  .toList());
        });
  }
}
//AnalyzeHistoryTimelineView("", "40'  若季若  1-0 ", "assets/images/event/event_2.png", false, true),
//           AnalyzeHistoryTimelineView("波里索夫  28'", "", "assets/images/event/event_3.png", true, false),
//           AnalyzeHistoryTimelineView("波里索夫  28'", "", "assets/images/event/event_3.png", true, false),
//           AnalyzeHistoryTimelineView("", "28'  第 2 个角球", "assets/images/event/event_4.png", false, true),
//           AnalyzeHistoryTimelineView("", "25'  若季若", "assets/images/event/event_5.png", false, true),
//           AnalyzeHistoryTimelineView("", "18'  第 1 个角球", "assets/images/event/event_4.png", false, true),
//           bluetext("开始", 60, 30),
//           AnalyzeHistoryTimelineView("安苏曼法蒂", "塞巴斯蒂亚诺·艾斯", "2", true, true),
//           AnalyzeHistoryTimelineView("尼古拉斯凯奇·拉登", "塞巴斯蒂亚诺·艾斯", "", true, true),
//           AnalyzeHistoryTimelineView("亚伯拉罕·萨达姆", "", "", true, false),
//           AnalyzeHistoryTimelineView("帕特里克", "", "", true, false),
//           AnalyzeHistoryTimelineView("乔纳森", "", "", true, false),
//           AnalyzeHistoryTimelineView("塞巴斯蒂亚诺·艾斯", "", "", true, false),
//           bluetext("加时赛结束", 150, 30),
//           AnalyzeHistoryTimelineView("", "64'  第 5 个角球", "assets/images/event/event_4.png", false, true),
//           AnalyzeHistoryTimelineView("塞巴斯蒂亚诺·艾斯", "", "assets/images/event/event_4.png", true, false),
//           bluetext("下半场结束", 150, 30),
//           AnalyzeHistoryTimelineView("戈丁  89;", "", "assets/images/event/event_6.png", true, false),
//           AnalyzeHistoryTimelineView("德弗里  86'", "", "assets/images/event/event_4.png", true, false),
//           AnalyzeHistoryTimelineView("", "安苏曼法蒂", "assets/images/event/event_4.png", false, true),
//           AnalyzeHistoryTimelineView("", "", "", false, false),
//           AnalyzeHistoryTimelineView("", "40'  若季若  1-0 ", "assets/images/event/event_4.png", false, true),
//           AnalyzeHistoryTimelineView("第 3 个角球  25'", "", "assets/images/event/event_4.png", true, false),
//           AnalyzeHistoryTimelineView("", "40' 马拉多纳  1-0", "assets/images/event/event_6.png", false, true),
//           bluetext("开始", 60, 30),
//           ImageView(
//               height: 30,
//               image: AssetImage('assets/images/event/event_bottom.png')),
