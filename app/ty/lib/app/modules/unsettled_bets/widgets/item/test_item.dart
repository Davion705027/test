import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


import '../../../../utils/oss_util.dart';
import '../information_important_view.dart';


class TestItem extends StatelessWidget {
  const TestItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => {},
        child: Container(
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
          margin: EdgeInsets.only(bottom: 20.h),
          padding:
              const EdgeInsets.only(top: 8, left: 12, right: 12, bottom: 16),
          child: const Column(
            children: [
              InformationImportantView(
                information: "占位用的-----",
                outcome: "占位用的----",
              ),
            ],
          ),
        ));
  }



}
