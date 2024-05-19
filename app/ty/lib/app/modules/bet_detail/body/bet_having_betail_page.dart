import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../bet_analyze_controller.dart';
import 'bet_having_detail_controller.dart';

class BetHavingBetailPage extends StatelessWidget {
  BetHavingAnalyzeController controller = Get.put(BetHavingAnalyzeController());

  BetHavingBetailPage({super.key}) {}

  @override
  Widget build(BuildContext context) {
    return _body();
  }

  _body() {
    return GetBuilder<BetAnalyzeController>(
        id: "listBetAnalyzeController",
        builder: (controller) {
          return CustomScrollView(slivers: [
            _cover(),
            _sort(),
            _list(controller),
          ]);
        });
  }

  _cover() {
    return SliverToBoxAdapter(
        child: Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Text(
            '20221015-1000期',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 28,
          ),
          Image.asset(
            'assets/images/teselol/icon_waiting.png',
          ),
        ],
      ),
    ));
  }

  _sort() {
    return SliverToBoxAdapter(
      child: Container(
        height: 30,
        color: Colors.white.withOpacity(0.05),
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 6,
              child: Text(
                "",
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Text(
               "",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ),
            Expanded(
              flex: 9,
              child: Text(
                "",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Text(
               "",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ),
            Expanded(
              flex: 9,
              child: Text(
               "",
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _list(BetAnalyzeController logic) {
    return SliverToBoxAdapter(
        child: ListView.separated(
      itemCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 4),
      separatorBuilder: (context, index) {
        return Container(
          height: 1,
          color: Colors.white.withOpacity(0.02),
        );
      },
      itemBuilder: (context, index) {
        return _buildHistoryOrder();
      },
    ));
  }

  Widget _buildHistoryOrder() {
    return Container(
      color: Colors.white.withOpacity(0.05),
      height: 44.h,
      width: ScreenUtil().screenWidth,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Row(
              children: [
                Image.asset(
                  "assets/images/123.png",
                  width: 16.sp,
                  height: 16.sp,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                 '',
                  style: TextStyle(
                      fontSize: 12.sp, color: Colors.white.withOpacity(0.5)),
                ),
              ],
            ),
          ),

          Expanded(
            flex: 7,
            child: Text(
               '',
              style: TextStyle(
                  fontSize: 12.sp, color: Colors.white.withOpacity(0.5)),
            ),
          ),

          Expanded(
            flex: 9,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Image.asset(
                //   transPlay(lotteryOrderResData.betNum),
                //   width: 16.sp,
                //   height: 16.sp,
                // ),
                SizedBox(
                  width: 5,
                ),
                Text(

                 '',
                  style: TextStyle(
                      fontSize: 12.sp, color: Colors.white.withOpacity(0.5)),
                )
              ],
            ),
          ),

          Expanded(
            flex: 4,
            child: Text(
           '',
              style: TextStyle(
                  fontSize: 12.sp,
                  color:Colors.white),
              textAlign: TextAlign.right,
            ),
          ),
          // Icon(
          //   Icons.arrow_forward_ios,
          //   size: 12,
          //   color: Colors.white.withOpacity(0.4),
          // )
        ],
      ),
    );
  }

  String transPlay(betNum) {
    switch (betNum) {
      case 'nan':
        // 翻译
        return 'assets/images/teselol/heros/male.png';
      default:
        return 'assets/images/teselol/icon/hit.png';
    }
  }

  String omitCharacter(String char, int lengths) {
    if (char.runtimeType != String) {
      return '';
    }
    if (lengths.runtimeType != int) {
      return '';
    }
    if (char.length > lengths) {
      return '${char.substring(0, lengths - 1)}...';
    } else {
      return char;
    }
  }
}
