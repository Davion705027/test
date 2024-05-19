import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../config/theme/app_color.dart';
import '../../../widgets/image_view.dart';
import 'daily_activities_controller.dart';

class DailyActivitiesPage extends StatefulWidget {
  const DailyActivitiesPage({Key? key}) : super(key: key);

  @override
  State<DailyActivitiesPage> createState() => _DailyActivitiesPageState();
}

class _DailyActivitiesPageState extends State<DailyActivitiesPage> {
  final controller = Get.find<DailyActivitiesController>();
  final logic = Get.find<DailyActivitiesController>().logic;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DailyActivitiesController>(
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: controller.progress == 100
                  ? Stack(
                  children: [

                    WebViewWidget(
                      controller: controller.webViewController,

                    ),
                    _title(),
                  ],
            )
                : Center(
                child: Container(
                  alignment: Alignment.center,
                  child: ImageView(
                    'assets/images/detail/odds-info-loading.gif',
                    width: 70.w,
                  ),
                ),
            ),
          ),
        );
      },
    );
  }

  //头部
  Widget _title() {
    return SizedBox(
      height: 48.h,
      child: Container(
        margin: EdgeInsets.only(left: 10.w,),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => Get.back(),
              child: Icon(
                Icons.arrow_back_ios,
                size: 30.w,
                color:Colors.black.withOpacity(0.0) ,
              ),
            ),
            const Expanded(child: SizedBox())
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<DailyActivitiesController>();
    super.dispose();
  }
}