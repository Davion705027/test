import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/match_bet_list_controller.dart';

class MatchBetListPage extends StatelessWidget {
  MatchBetListPage({Key? key}) : super(key: key);

  final logic = Get.find<MatchBetListController>();
  final state = Get.find<MatchBetListController>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Container(
            alignment: Alignment.center,
            child: Icon(
              Icons.arrow_back_ios,
              size: 20.w,
              color: Colors.grey,
            ),
          ),
        ),
        leadingWidth: 50.w,
        titleSpacing: 0,
        title: Text(
          '投注页',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
          ),
        ),
      ),
      body: Center(
        child: Text(
          '赛果',
          style: TextStyle(
            fontSize: 20.sp,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
