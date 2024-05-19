import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/unsettled_bets/widgets/information_view.dart';
import 'package:flutter_ty_app/app/modules/unsettled_bets/widgets/title_view.dart';
import 'package:get/get.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../utils/oss_util.dart';
import '../../../../widgets/image_view.dart';

class NoDataHintsView extends StatelessWidget {
  const NoDataHintsView({
    super.key,
    required this.type,
  });

  ///0 ：未结算
  ///1 : 预约中
  ///2 : 已失效
  ///3 : 已结注单
  final int type;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {},
      child: Container(
        alignment: Alignment.topCenter,
        child: Container(
          width: double.infinity,
          height: 300.h,
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(top: 60.h, bottom: 40.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              image: DecorationImage(
                image: NetworkImage(
                  OssUtil.getServerPath(
                    context.isDarkMode
                        ? 'assets/images/bets/nighttime_bg.png'
                        : 'assets/images/bets/daytime_bg.png',
                  ),
                ),
                fit: BoxFit.cover,
              ),
              color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ImageView(
                context.isDarkMode
                    ? 'assets/images/bets/nobetrecord_night.png'
                    : 'assets/images/bets/nobetrecord_day.png',
                width: 180.w,
                height: 180.h,
              ),
              Text(
                type == 0
                    ? LocaleKeys.app_h5_cathectic_no_data_unsettle.tr
                    : type == 1
                        ? LocaleKeys.app_h5_cathectic_no_data_pre.tr
                        : type == 2
                            ? LocaleKeys.app_h5_cathectic_no_data_invalid.tr
                            : LocaleKeys.app_h5_cathectic_no_data_settle.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: context.isDarkMode ? Colors.white : Color(0xFF7981A3),
                  fontSize: 12,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
