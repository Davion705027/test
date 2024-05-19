// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

import '../../../widgets/image_view.dart';

class InformationCopyView extends StatelessWidget {
  const InformationCopyView({
    Key? key,
    required this.information,
    required this.outcome,
  }) : super(key: key);
  final String information, outcome;

  @override
  Widget build(BuildContext context) {
    Color color = const Color(0xFF303442);

    if (context.isDarkMode) {
      color = Colors.white.withOpacity(0.8999999761581421);
    }

    return Container(
      margin: EdgeInsets.only(top: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            information,
            style: TextStyle(
              color: color,
              fontSize: 12.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w400,
            ),
          ),
          InkWell(
            onTap: () => {
              Clipboard.setData(ClipboardData(text: outcome)),
              ToastUtils.showGrayBackground(LocaleKeys.bet_record_copy_suc.tr+"！"),
            },
            child: Row(
              children: [
                Text(
                  outcome,
                  style: TextStyle(
                    color: color,
                    fontSize: 12.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  width: 4.w,
                ),
                ImageView(
                  'assets/images/bets/icon_copy.png',
                  width: 16.w,
                  height: 16.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
