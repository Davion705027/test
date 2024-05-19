import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/unsettled_bets/widgets/information_view.dart';
import 'package:flutter_ty_app/app/modules/unsettled_bets/widgets/title_view.dart';
import 'package:get/get.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../utils/oss_util.dart';
import '../../../../widgets/image_view.dart';

class BetsLoadingView extends StatelessWidget {
  const BetsLoadingView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {},
      child: Container(
        alignment: Alignment.topCenter,
        child: Container(
          width: double.infinity,
          height: 300.h,
          alignment: Alignment.center,
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
              color: context.isDarkMode ? null : Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageView(
                'assets/images/bets/loading.png',
                width: 180.w,
                height: 180.h,
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                LocaleKeys.app_h5_cathectic_data_loading.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: context.isDarkMode
                      ? Colors.white.withOpacity(0.6000000238418579)
                      : Color(0xFFAFB3C8),
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
