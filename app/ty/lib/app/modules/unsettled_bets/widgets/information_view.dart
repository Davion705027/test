// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

class InformationView extends StatelessWidget {
  const InformationView({
    Key? key,
    required this.information,
    this.outcome = '',
    this.titleColorType = 0,
    this.InformationColorType = 0,
    this.top = 8,
    this.isAmount = false,
  }) : super(key: key);
  final String information;
  final String outcome;
  final int top;

  /*
  titleColorType,InformationColorType
   0 ： 默认的黑色
   1 ： 灰色
   2 ： 蓝色
   3 ： 红色
   */
  final int titleColorType, InformationColorType;
  ///当是金额
  final bool isAmount;

  @override
  Widget build(BuildContext context) {
    List<Color> listColor = [
      const Color(0xFF303442),
      const Color(0xFFAFB3C8),
      const Color(0xFF179CFF),
      const Color(0xFFF53F3F)
    ];
    if (context.isDarkMode) {
      listColor[0] = Colors.white.withOpacity(0.8999999761581421);
      listColor[2] = const Color(0xFF127DCC);
    }
    return Container(
      margin: EdgeInsets.only(top: top.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              information,
              style: TextStyle(
                color: listColor[titleColorType],
                fontSize: 12.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            outcome,
            style: TextStyle(
              color: listColor[InformationColorType],
              fontSize: 12.sp,
              fontFamily: 'PingFang SC',
              fontWeight: isAmount ? FontWeight.w500 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
