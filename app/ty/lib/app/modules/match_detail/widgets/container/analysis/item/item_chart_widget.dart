import 'package:flutter_ty_app/app/global/data_store_operate/data_store_map_operate.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/widget/BoxShadowContaine.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/analysis/blue_text_view.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/analysis/item/analyze_divider.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/analysis/item_event_view.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';

import '../../../../../../global/data_store_controller.dart';
import '../../../../../../services/models/res/match_entity.dart';
import '../../../../../bet_detail/analyze_match/analyze_news/analyze_match_result/analyze_match_result_logic.dart';
import 'MatchlineProgressView.dart';
import 'item_header_widget.dart';
import 'match_circle_progress_view.dart';

class ItemChartWidget extends StatelessWidget {
  final String? name;

   ItemChartWidget({super.key, this.name});

  Color manColor = Color(0xFFF53F3F);
  Color awayColor = Color(0xFFFEAE2B);
  // Color manColor = Color(0xFF006EFF);
  // Color awayColor = Color(0xFFFFB000);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BoxShadowContainer(
          padding: EdgeInsets.only(left: 0.w, right: 0.2, bottom: 10.w),
          margin: EdgeInsets.symmetric(horizontal: 6.w, vertical: 8.w),
          color: Get.theme.tabPanelBackgroundColor,
          child: Container(
            color: Get.theme.tabPanelBackgroundColor,
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                ItemHeaderWidget(
                  name: LocaleKeys.match_result_statistics.tr,
                  showDivider: true,
                ),
                buildMatchHead(),
                buildMatchProgress(),
              ],
            ),
          ),
        ),
        // Container(
        //   margin: EdgeInsets.symmetric(horizontal: 6.w, vertical: 10.w),
        //   child: Card(
        //     color: Get.theme.tabPanelBackgroundColor,
        //     child: Container(
        //       color: Get.theme.tabPanelBackgroundColor,
        //       alignment: Alignment.centerLeft,
        //       child: Column(
        //         children: [
        //           ItemHeaderWidget(
        //             name: LocaleKeys.match_result_event.tr,
        //             showDivider: true,
        //           ),
        //           buildMatchEvent(),
        //           buildMatchEventList(),
        //         ],
        //       ),
        //     ),
        //   ),
        // )
      ],
    );
  }

  buildMatchHead() {
    return GetBuilder<AnalyzeMatchResultLogic>(
        id:"buildMatchProgress",
        builder: (controller) {
      print("==============>刷新数据");
      return GetBuilder<DataStoreController>(
          id: DataStoreController.to.getMatchId(controller?.mid ?? ""),
          builder: (dataController) {
            print("==============>刷新数据2 ${controller?.mid}");
            MatchEntity matchEntity =
                dataController.getMatchById(controller?.mid ?? "") ??
                    MatchEntity();
            print("==============>刷新数据3 ${controller.getTeamName(matchEntity, type: 2)}");
            print("==============>刷新数据3 ${controller.getTeamName(matchEntity, type: 1)}");


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
                            color: manColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.w))),
                      ),
                      Text(
                        "${controller.getTeamName(matchEntity, type: 1)}",
                        style: TextStyle(
                            fontSize: 12.w,
                            fontWeight: FontWeight.w400,
                            color: Get.theme.tabPanelSelectedColor),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "${controller.getTeamName(matchEntity, type: 2)}",
                        style: TextStyle(
                            fontSize: 12.w,
                            fontWeight: FontWeight.w400,
                            color: Get.theme.tabPanelSelectedColor),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 8.w, right: 5.w),
                        width: 6.w,
                        height: 6.w,
                        decoration: BoxDecoration(
                            color: awayColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.w))),
                      ),
                    ],
                  ),
                ],
              ),
            );
          });
    });
  }

  buildMatchProgress() {
    return GetBuilder<AnalyzeMatchResultLogic>(
        id: "buildMatchProgress",
        builder: (controller) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Column(
              children: [
                Container(
                  width: 1.sw,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: controller.first.map((e) {
                      print(
                          "=====> ${e.title}   ${e.home}  ${e.away}  ${e.proportion}");
                      return Column(
                        children: [
                          MatchCircleProgressView(e,
                              progress: e.proportion.toDouble()/100,
                              width: 65.w,
                              height: 65.w,
                              backgroundColor: manColor,
                              progressColor: awayColor,
                              centerContent:
                                  LocaleKeys.match_result_dangerous_offense.tr),
                        ],
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 12.w,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: controller.second
                        .map((e) => Container(
                              margin: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    e.title,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10.sp,
                                        color: Get.theme.resultTextColor),
                                  ),
                                  SizedBox(
                                    height: 4.w,
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "${e.home}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 12.sp,
                                              color: Get
                                                  .theme.tabPanelSelectedColor),
                                        ),
                                        SizedBox(
                                          width: 12.w,
                                        ),
                                        //ImageView('assets/images/bets/lock.svg',
                                        //           width: 16.w,
                                        //           height: 16.w,
                                        //         )
                                        _getWidget(e.icon),
                                        SizedBox(
                                          width: 12.w,
                                        ),

                                        Text(
                                          "${e.away}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 12.sp,
                                              color: Get
                                                  .theme.tabPanelSelectedColor),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                ),
                Column(
                  children: controller.three
                      .map((e) {
                    int total = e.home+e.away;
                    print("======>数据  e.proportion ${e.proportion} e.home ${e.home}  e.away ${e.away}");
                    print("======>数据  left  ${e.home > 0 ? (e.home / total) : 0}");

                        print("======>数据  right  e.proportion ${e.proportion}  e.away  ${e.away}  结果 ${(e.proportion > 0
                            ? e.proportion / total
                            : (e.away > 0 ? 0 : 0))}");
                        return MatchLineProgressView(e.home, e.away,
                            leftProgress: e.home > 0 ? (e.home / total) : 0,
                            rightProgress: e.away > 0
                                ? (e.away / total): 0,
                            // leftProgress:0,
                            // rightProgress:0,
                            leftColor: manColor,
                            rightColor: awayColor,
                            leftBackgroundColor: Color(0xFFd8d8d8),
                            rightBackgroundColor: Color(0xFFd8d8d8),

                            width: 54.w,
                            height: 54.w,
                            centerContent: e.title);
                  })
                      .toList(),
                ),
              ],
            ),
          );
        });
  }

  Widget _getWidget(String iconTitle) {
    String iconStr = "corner.svg";
    // if (iconTitle == "time_out_img") {
    //   iconStr = "red.svg";
    // } else if (iconTitle == "whistle_img") {
    //   iconStr = "yellow.svg";
    // }
    if (iconTitle == "red_card") {
      iconStr = "red.svg";
    } else if (iconTitle == "yellow_card") {
      iconStr = "yellow.svg";
    } else if (iconTitle == "whistle_img") {
      iconStr = "whistle.svg";
    } else if (iconTitle == "time_out_img") {
      iconStr = "time_out.svg";
    }
    return ImageView(
      'assets/images/bets/$iconStr',
      width: 12.w,
      height: 12.w,
    );
  }

//事件UI
  buildMatchEvent() {
    return Container(
      height: 38.w,
      margin: EdgeInsets.only(top: 13.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 130,
            margin: EdgeInsets.only(left: 10.w),
            child: AnalyzeDivider(),
          ),
          bluetext(LocaleKeys.match_result_midfield.tr, 60, 30),
          Container(
            width: 130,
            margin: EdgeInsets.only(right: 10.w),
            child: AnalyzeDivider(),
          )
        ],
      ),
    );
  }

  buildMatchEventList() {
    return const Column(
      children: [
        item_event_view(
            "曼德拉  43'", "", "assets/images/event/event_1.png", true, false),
        item_event_view("", "40'  若季若  1-0 ", "assets/images/event/event_2.png",
            false, true),
        item_event_view(
            "波里索夫  28'", "", "assets/images/event/event_3.png", true, false),
        item_event_view(
            "波里索夫  28'", "", "assets/images/event/event_3.png", true, false),
        item_event_view(
            "", "28'  第 2 个角球", "assets/images/event/event_4.png", false, true),
        item_event_view(
            "", "25'  若季若", "assets/images/event/event_5.png", false, true),
        item_event_view(
            "", "18'  第 1 个角球", "assets/images/event/event_4.png", false, true),
        bluetext("开始", 60, 30),
        item_event_view("安苏曼法蒂", "塞巴斯蒂亚诺·艾斯", "2", true, true),
        item_event_view("尼古拉斯凯奇·拉登", "塞巴斯蒂亚诺·艾斯", "", true, true),
        item_event_view("亚伯拉罕·萨达姆", "", "", true, false),
        item_event_view("帕特里克", "", "", true, false),
        item_event_view("乔纳森", "", "", true, false),
        item_event_view("塞巴斯蒂亚诺·艾斯", "", "", true, false),
        bluetext("加时赛结束", 150, 30),
        item_event_view(
            "", "64'  第 5 个角球", "assets/images/event/event_4.png", false, true),
        item_event_view(
            "塞巴斯蒂亚诺·艾斯", "", "assets/images/event/event_4.png", true, false),
        bluetext("下半场结束", 150, 30),
        item_event_view(
            "戈丁  89;", "", "assets/images/event/event_6.png", true, false),
        item_event_view(
            "德弗里  86'", "", "assets/images/event/event_4.png", true, false),
        item_event_view(
            "", "安苏曼法蒂", "assets/images/event/event_4.png", false, true),
        item_event_view("", "", "", false, false),
        item_event_view("", "40'  若季若  1-0 ", "assets/images/event/event_4.png",
            false, true),
        item_event_view(
            "第 3 个角球  25'", "", "assets/images/event/event_4.png", true, false),
        item_event_view("", "40' 马拉多纳  1-0", "assets/images/event/event_6.png",
            false, true),
        bluetext("开始", 60, 30),
        Image(
            height: 30,
            image: AssetImage('assets/images/event/event_bottom.png')),
      ],
    );
  }
}
