import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../generated/locales.g.dart';
import '../../../config/theme/app_color.dart';
import '../../../global/assets/webview_cache.dart';
import '../../../widgets/image_view.dart';
import 'rule_description_controller.dart';

class RuleDescriptionPage extends StatefulWidget {
  const RuleDescriptionPage({Key? key}) : super(key: key);

  @override
  State<RuleDescriptionPage> createState() => _RuleDescriptionPageState();
}

class _RuleDescriptionPageState extends State<RuleDescriptionPage> {
  final controller = Get.find<RuleDescriptionController>();
  final logic = Get.find<RuleDescriptionController>().logic;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RuleDescriptionController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: context.isDarkMode
                ? AppColor.titleBackgroundColor
                : Colors.white,
            elevation: 0,
            centerTitle: true,
            leading: InkWell(
              onTap: () => Get.back(),
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(
                  left: 10.w,
                ),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 20.w,
                  color: context.isDarkMode
                      ? Colors.white
                      : const Color(0xFF303442),
                ),
              ),
            ),
            title: Text(
              LocaleKeys.setting_menu_rule_description.tr,
              style: TextStyle(
                color:
                    context.isDarkMode ? Colors.white : const Color(0xFF303442),
                fontSize: 16.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: WebviewCacheController.to.getRule(),
        );
      },
    );
  }

  @override
  void dispose() {
    Get.delete<RuleDescriptionController>();
    super.dispose();
  }
}
