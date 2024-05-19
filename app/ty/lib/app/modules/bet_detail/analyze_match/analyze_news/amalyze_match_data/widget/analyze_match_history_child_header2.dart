import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

import '../analyze_match_data_logic.dart';

class AnalyzeMatchHistoryChildHeader2 extends StatefulWidget {
  ValueChanged<int>? onChanged;

  // 1 历史交战  2  近期战绩   3
  String? type;

  AnalyzeMatchHistoryChildHeader2({this.type, this.onChanged, super.key});

  @override
  State<StatefulWidget> createState() {
    return AnalyzeMatchHistoryHead2State();
  }
}

class AnalyzeMatchHistoryHead2State
    extends State<AnalyzeMatchHistoryChildHeader2> {
  int type = 0;
  bool value = false;
  Map<int, String> map = {
    0: LocaleKeys.analysis_football_matches_results.tr,
    1: LocaleKeys.analysis_football_matches_turn_around.tr,
    2: LocaleKeys.analysis_football_matches_size.tr,
  };

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AnalyzeMatchDataLogic>(
      id: "buildRecentHistory",
      builder: (controller) {
        return Container(
          height: 40.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    LocaleKeys.analysis_football_matches_date.tr,
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Get.theme.dataContainerTextColor,
                    ),
                  ),
                ),
              ),

              Expanded(
                flex: 3,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    LocaleKeys.analysis_football_matches_league.tr,
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Get.theme.dataContainerTextColor,
                    ),
                  ),
                ),
              ),
              // Expanded(
              //   flex: 2,
              //   child: controller.showBasketBall == false
              //       ? Container(
              //           alignment: Alignment.center,
              //           child: Text(
              //             LocaleKeys.app_ball_match.tr,
              //             style: TextStyle(
              //               fontSize: 11.sp,
              //               color: Get.theme.dataContainerTextColor,
              //             ),
              //           ),
              //         )
              //       : SizedBox(),
              // ),
              Expanded(
                flex: 4,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    LocaleKeys.analysis_football_matches_score.tr,
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Get.theme.dataContainerTextColor,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: controller.showBasketBall == false
                    ? Container(
                        alignment: Alignment.center,
                        child: Text(
                          LocaleKeys.app_team_name.tr,
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: Get.theme.dataContainerTextColor,
                          ),
                        ),
                      )
                    : SizedBox(),
              ),
              Expanded(
                flex: 2,
                child: InkWell(
                  onTap: () {
                    type++;
                    if (type >= 3) {
                      type = 0;
                    }
                    value = !value;

                    if (widget.onChanged != null) {
                      print("==========>变换 ${type}");
                      widget.onChanged!(type);
                    }
                    setState(() {});
                  },
                  child: Container(
                    child: Row(
                      children: [
                        Text(
                          map[type] ??
                              LocaleKeys
                                  .types_competitions_menu_itme_name_results.tr,
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: Get.theme.dataContainerTextColor,
                          ),
                        ),
                        ImageView(
                          'assets/images/bets/f-icon-pay-change-y0.svg',
                          // value
                          //     ? 'assets/images/home/icon_switch_sel.png'
                          //     : 'assets/images/home/icon_switch_nor.png',
                          width: 12.w,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
