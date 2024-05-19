import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/amalyze_match_data/analyze_match_data_logic.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';

import '../../../../../../../generated/locales.g.dart';
import '../blue_text_view_new.dart';
import 'date_time_select_tab_widget_new.dart';
import 'gray_text_view_new.dart';

class ItemHistoryHeaderWidget extends StatelessWidget {
  final String? name;

  const ItemHistoryHeaderWidget({super.key, this.name});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AnalyzeMatchDataLogic>(
        id: "ItemHistoryHeaderWidget",
        builder: (controller) {
          return Container(
            height: 32.w,
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Container(
                  width: 2.w,
                  height: 12.w,
                  decoration: BoxDecoration(
                    // 右上 右下圆角
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(2.w),
                      bottomRight: Radius.circular(2.w),
                    ),
                    color: const Color(0xff179CFF),
                  ),
                ),
                SizedBox(
                  width: 6.w,
                ),
                Expanded(
                  child: Text(
                    name ?? '',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Get.theme.tabPanelSelectedColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    controller.setCurSelectTab1();
                  },
                  child: controller.state.curSelectTab1.value
                      ? BluetextNew(
                          LocaleKeys.analysis_football_matches_same_game.tr,
                          50.w,
                          20.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.w),
                            border: Border.all(
                              color: Get.theme.secondTabPanelSelectedFontColor,
                            ),
                          ),
                        )
                      : GraytextNew(
                          LocaleKeys.analysis_football_matches_same_game.tr,
                          50.w,
                          20.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.w),
                            border: Border.all(color: Colors.transparent),
                            color: Get.theme.foldColor,
                          ),
                        ),
                ),
                Text("  "),
                InkWell(
                  onTap: () {
                    controller.setCurSelectTab2();
                  },
                  child: controller.state.curSelectTab2.value
                      ? BluetextNew(
                          LocaleKeys
                              .analysis_football_matches_same_host_guest.tr,
                          50.w,
                          20.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.w),
                            border: Border.all(
                              color: Get.theme.secondTabPanelSelectedFontColor,
                            ),
                          ),
                        )
                      : GraytextNew(
                          LocaleKeys
                              .analysis_football_matches_same_host_guest.tr,
                          50.w,
                          20.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.w),
                            border: Border.all(color: Colors.transparent),
                            color: Get.theme.foldColor,
                          ),
                        ),
                ),
                Text("   "),
                DateSelectTabWidgetNew(
                  (days) {
                    controller.state.curDay.value = "$days";
                    controller.requestTeamsVSInfo(
                      day: controller.state.curDay.value,
                      flag: controller.state.curFlag.value,
                    );
                  },
                ),
              ],
            ),
          );
        });
  }
}
