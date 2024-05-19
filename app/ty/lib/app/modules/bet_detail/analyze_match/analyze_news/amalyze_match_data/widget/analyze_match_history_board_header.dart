import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

class AnalyzeMatchHistoryBoardHeader extends StatelessWidget {
  AnalyzeMatchHistoryBoardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      alignment: Alignment.center,
      height: 40.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: Get.theme.betPanelUnderlineColor,
                  width: 1,
                ),
              ),
            ),
            child: Text(
              LocaleKeys.virtual_sports_game.tr,
              style: TextStyle(
                fontSize: 11.sp,
                color: Get.theme.tabPanelSelectedColor,
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      LocaleKeys.analysis_football_matches_win_plate.tr,
                      style: TextStyle(
                          fontSize: 11.sp,
                          color: Get.theme.tabPanelSelectedColor),
                    ),
                  ),
                ),
                  Expanded(
                    flex: 2,
                    child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          LocaleKeys.analysis_football_matches_Move_plate.tr,
                          style: TextStyle(
                              fontSize: 11.sp,
                              color: Get.theme.tabPanelSelectedColor),
                        )),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        LocaleKeys.analysis_football_matches_Lose_plate.tr,
                        style: TextStyle(
                            fontSize: 11.sp,
                            color: Get.theme.tabPanelSelectedColor),
                      ),
                    ),
                  ),
                  Container(
                    width: 55.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border(
                          right:
                          BorderSide(color: Get.theme.betPanelUnderlineColor,
                              width: 1),
                        )),
                    child: Text(
                      LocaleKeys.app_losing_rate.tr,
                      style: TextStyle(
                          fontSize: 11.sp,
                          color: Get.theme.tabPanelSelectedColor),
                    ),
                  ),
                ],
              )),
          Expanded(
              flex: 1,
              child: Row(children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      LocaleKeys.analysis_football_matches_big_ball.tr,
                      style: TextStyle(
                          fontSize: 11.sp,
                          color: Get.theme.tabPanelSelectedColor),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      LocaleKeys.analysis_football_matches_Big_ball_rate.tr,
                      style: TextStyle(
                          fontSize: 11.sp,
                          color: Get.theme.tabPanelSelectedColor),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      LocaleKeys.analysis_football_matches_small_ball.tr,
                      style: TextStyle(
                          fontSize: 11.sp,
                          color: Get.theme.tabPanelSelectedColor),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      LocaleKeys.analysis_football_matches_small_ball_rate.tr,
                      style: TextStyle(
                          fontSize: 11.sp,
                          color: Get.theme.tabPanelSelectedColor),
                    ),
                  ),
                ),
              ],))
        ],
      ),
    );
  }
}
