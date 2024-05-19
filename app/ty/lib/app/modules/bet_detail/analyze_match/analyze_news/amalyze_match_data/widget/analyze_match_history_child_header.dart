import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

class AnalyzeMatchHistoryChildHeader extends StatelessWidget {
  AnalyzeMatchHistoryChildHeader({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 40.w,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              LocaleKeys.analysis_football_matches_rank.tr,
              textAlign: TextAlign.center,

              style:
                  TextStyle(fontSize: 11.sp, color: Get.theme.dataContainerTextColor),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              LocaleKeys.ouzhou_search_team.tr,
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontSize: 11.sp, color: Get.theme.dataContainerTextColor),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              LocaleKeys.analysis_football_matches_game.tr,
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontSize: 11.sp, color: Get.theme.dataContainerTextColor),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              LocaleKeys.analysis_football_matches_victory.tr,
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontSize: 11.sp, color: Get.theme.dataContainerTextColor),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              LocaleKeys.analysis_football_matches_negative.tr,
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontSize: 11.sp, color: Get.theme.dataContainerTextColor),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              LocaleKeys.analysis_football_matches_flat.tr,
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontSize: 11.sp, color: Get.theme.dataContainerTextColor),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              LocaleKeys.analysis_football_matches_gain_loss.tr,
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontSize: 11.sp, color: Get.theme.dataContainerTextColor),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              LocaleKeys.analysis_football_matches_net_win.tr,
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontSize: 11.sp, color: Get.theme.dataContainerTextColor),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              LocaleKeys.virtual_sports_integral.tr,
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontSize: 11.sp, color: Get.theme.dataContainerTextColor),
            ),
          ),
        ],
      ),
    );
  }
}
