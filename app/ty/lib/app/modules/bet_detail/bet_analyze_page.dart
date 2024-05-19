import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import 'package:get/get.dart';

import 'bet_analyze_controller.dart';
import 'body/bet_have_betail_page.dart';

class BetAnalyzePage extends StatelessWidget {

   BetAnalyzePage({super.key});
   BetAnalyzeController controller=Get.find<BetAnalyzeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Image.asset(
              "assets/images/teselol/return.png",
              width: 15.w,
            ),
          ),
        ),
        title: Text(
          "赛事分析",
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body: _body(),
      // bottomNavigationBar:
      //     GetBuilder<BetAnalyzeController>(builder: (controller) {
      //   return _bottomBar();
      // }),
    );
  }

  _body() {
    return Container(width: ScreenUtil().screenWidth,
    height: ScreenUtil().screenHeight,
    child: BetHaveBetailPage(),);

    // return  Obx(() => controller.isHave.value? const BetHaveBetailPage():BetHavingBetailPage());
  }
  _bottomBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      height: 50,
      color: Colors.white.withOpacity(0.05),
      child: Row(
        children: [
          Text(
           "",
            style: const TextStyle(
                fontWeight: FontWeight.w400, color: Colors.white),
          ),
          const Spacer(),
          const Text(
            '分析',
            style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
          ),
          const SizedBox(width: 50),
          const Text(
            '+12345678.00',
            style: TextStyle(
                fontWeight: FontWeight.w700, color: Color(0xffFD5E5F)),
          )
        ],
      ),
    );
  }
}
