import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../widgets/image_view.dart';
import 'sdk_home_controller.dart';

class SdkHomePage extends StatefulWidget {
  const SdkHomePage({Key? key}) : super(key: key);

  @override
  State<SdkHomePage> createState() => _SdkHomePageState();
}

class _SdkHomePageState extends State<SdkHomePage> {
  final controller = Get.find<SdkHomeController>();
  final logic = Get.find<SdkHomeController>().logic;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        child: ImageView(
          'assets/images/detail/odds-info-loading.gif',
          width: 70.w,
        ),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<SdkHomeController>();
    super.dispose();
  }
}