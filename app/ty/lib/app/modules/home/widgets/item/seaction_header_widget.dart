import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/home/models/section_group_enum.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import '../../../../../generated/locales.g.dart';

///新手版 赛事头部 进行中 展开
class SectionHeaderWidget extends StatelessWidget {
  const SectionHeaderWidget(
      {super.key,
      required this.isExpand,
      required this.onExpand,
      required this.sectionGroupEnum});

  final ValueChanged<bool> onExpand;
  final SectionGroupEnum sectionGroupEnum;

  /// 是否展开
  final bool isExpand;

  @override
  Widget build(BuildContext context) {
    Color dividerColor = const Color(0xff179CFF);
    String title = '';
    String icon = '';

    switch (sectionGroupEnum) {
      case SectionGroupEnum.IN_PROGRESS:
        dividerColor = const Color(0xff127DCC).withAlpha(70);
        // 早盘显示全部联赛
        if (HomeController.to.homeState.menu.type == 4) {
          title = LocaleKeys.filter_all_leagues.tr;
        } else {
          title = LocaleKeys.list_match_doing.tr;
        }
        icon = 'assets/images/league/icon_processing.svg';
        break;
      case SectionGroupEnum.NOT_STARTED:
        dividerColor = const Color(0xFFF53F3F).withAlpha(60);
        title = LocaleKeys.list_match_no_start.tr;
        icon = 'assets/images/league/icon_notstarted.svg';
        break;
      case SectionGroupEnum.ALL:
        dividerColor = const Color(0xFFFEAE2B).withAlpha(60);
        // title = LocaleKeys.ouzhou_menu_all_sports.tr;
        title = LocaleKeys.filter_all_leagues.tr;
        int? dateTime = HomeController.to.homeState.dateTime;
        if (dateTime != null) {
          if (dateTime <= 0) {
            title = LocaleKeys.filter_all_leagues.tr;
          } else {
            String time =
                DateUtil.formatDateMs(dateTime, format: LocaleKeys.time2.tr);
            Get.log('time $time  dateTime  = $dateTime');
            title = time;
          }
        }
        icon = 'assets/images/league/icon_all.svg';
        break;
    }

    return InkWell(
      onTap: () {
        if (ConfigController.to.accessConfig.value.tourSwitch) {
          onExpand(!isExpand);
        }
      },
      child: Column(
        children: [
          Container(
            height: 2,
            color: dividerColor,
          ),
          Container(
            color: context.isDarkMode
                ? Colors.white.withOpacity(0.03999999910593033)
                : Colors.white,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 14.w,vertical: 4.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ImageView(
                  icon,
                  width: 14.w,
                  height: 14.w,
                ),
                SizedBox(
                  width: 4.w,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    fontFamily: 'PingFang SC',
                    color: context.isDarkMode
                        ? Colors.white.withOpacity(0.8999999761581421)
                        : const Color(0xff303442),
                  ),
                ),
                const Spacer(),

                Obx(() {
                  if (ConfigController.to.accessConfig.value.tourSwitch) {
                    return  ImageView(isExpandIcon(isExpand ,context.isDarkMode),
                      width: 20.w,
                      height: 20.w,
                    );
                  } else {
                    return 0.verticalSpace;
                  }
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

   String isExpandIcon(bool isExpand ,bool isDarkMode){
    if(isExpand){
      return isDarkMode
          ? 'assets/images/league/seaction_expand_darkmode2.png'
          : 'assets/images/league/seaction_expand.png';
    }else{
      return isDarkMode
          ? 'assets/images/league/seaction_collpose_darkmode.png'
          : 'assets/images/league/seaction_collpose.png';
    }
  }
}
