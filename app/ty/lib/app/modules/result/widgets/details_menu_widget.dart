import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/result/results_details/results_details_controller.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:marquee/marquee.dart';

import '../../../../generated/locales.g.dart';
import '../../../core/format/common/module/format-score.dart';
import '../../../utils/oss_util.dart';
import '../../match_detail/controllers/match_detail_controller.dart';
import '../../match_detail/widgets/header/score/match_detail_score.dart';
import 'event_head_widget.dart';

class DetailsMenuWidget extends StatelessWidget {
  const DetailsMenuWidget({
    super.key,
    required this.isDark,
    required this.event,
    required this.bet,
    required this.playback,
    required this.onExpandAll,
    required this.onEventHeadIndex,
    required this.eventHeadIndex,
  });

  final bool isDark;
  final bool event;
  final bool bet;
  final bool playback;
  final VoidCallback? onExpandAll;
  final void Function(dynamic) onEventHeadIndex;
  final int eventHeadIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40.h,
        decoration: isDark
            ?  BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    OssUtil.getServerPath(
                      'assets/images/icon/head1.png',
                    ),
                  ),
                  fit: BoxFit.cover,
                ),
              )
            : const BoxDecoration(
                color: Colors.white,
              ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: onExpandAll,
              child: Container(
                margin: EdgeInsets.only(
                  left: 10.w,
                ),
                child: Obx(() {
                  return ImageView(
                    Get.find<MatchDetailController>().detailState.getFewer.value != 2
                        ? 'assets/images/icon/tab_up_btn.svg' : 'assets/images/icon/tab_up_btn_off.svg',
                    width: 12.w,
                    height: 12.h,
                    color: Colors.grey,
                  );
                }),
              ),
            ),
            Container(
              width: Get.width-30.w,
              child: SingleChildScrollView(
                scrollDirection : Axis.horizontal,
                child: Row(
                  children: [
                    EventHeadWidget(
                      onTap: () => onEventHeadIndex(0),
                      title: LocaleKeys.match_info_all_result.tr,
                      isSelected: eventHeadIndex == 0 ? true : false,
                      isDark: context.isDarkMode,
                    ),

                    if(event)
                      EventHeadWidget(
                        onTap: () => onEventHeadIndex(1),
                        title: LocaleKeys.match_info_select_event.tr,
                        isSelected: eventHeadIndex == 1 ? true : false,
                        isDark: context.isDarkMode,
                      ),
                    if(bet)
                      EventHeadWidget(
                        onTap: () => onEventHeadIndex(2),
                        title:  LocaleKeys.match_info_my_bets.tr,
                        isSelected: eventHeadIndex == 2 ? true : false,
                        isDark: context.isDarkMode,
                      ),
                    if(playback)
                      EventHeadWidget(
                        onTap: () => onEventHeadIndex(3),
                        title:  LocaleKeys.highlights_title.tr,
                        isSelected: eventHeadIndex == 3 ? true : false,
                        isDark: context.isDarkMode,
                      ),
                  ],
                ),
              ),
            )


          ],
        ));
  }
}
