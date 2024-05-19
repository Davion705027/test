import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

class AnalyzeMatchHistoryTechnicalHeader extends StatelessWidget {
  AnalyzeMatchHistoryTechnicalHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(
        color: Get.isDarkMode
            ? const Color.fromRGBO(108, 123, 168, 1)
            : Get.theme.tabPanelSelectedColor,
      ),
      child: Container(
        height: 40.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  LocaleKeys.analysis_football_matches_age.tr,
                  style: TextStyle(
                    fontSize: 11.sp,
                    // color: Get.theme.tabPanelSelectedColor,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  // "战术分析",
                  LocaleKeys.app_tactical_analysis.tr,
                  style: TextStyle(
                    fontSize: 11.sp,
                    // color: Get.theme.tabPanelSelectedColor,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  // "均场得分",
                  LocaleKeys.app_points_per_game.tr,
                  style: TextStyle(
                    fontSize: 11.sp,
                    // color: Get.theme.tabPanelSelectedColor,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  // "出站",
                  LocaleKeys.app_outbound.tr,
                  style: TextStyle(
                    fontSize: 11.sp,
                    // color: Get.theme.tabPanelSelectedColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
