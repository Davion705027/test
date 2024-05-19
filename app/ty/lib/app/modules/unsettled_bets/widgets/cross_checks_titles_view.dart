import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../widgets/image_view.dart';

class CrossChecksTitlesView extends StatelessWidget {
  const CrossChecksTitlesView({
    Key? key, required this.information,
  }) : super(key: key);
  final String information;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36.h,
      decoration:  BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        color: context.isDarkMode
            ? const Color(0xFF127DCC)
            : const Color(0xff179CFF),
      ),
      padding: const EdgeInsets.only(left: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ImageView(
            'assets/images/bets/duplex.png',
            width: 16.w,
            height: 16.w,
          ),
          Container(
            width: 5,
          ),
          Text(
            information,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
