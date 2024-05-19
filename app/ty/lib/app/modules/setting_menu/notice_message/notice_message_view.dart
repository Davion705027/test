import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/widget_extensions.dart';
import 'package:flutter_ty_app/app/widgets/no_data.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import 'package:get/get.dart';

import '../../../config/theme/app_color.dart';
import 'notice_message_controller.dart';

class NoticeMessagePage extends StatefulWidget {
  const NoticeMessagePage({Key? key}) : super(key: key);

  @override
  State<NoticeMessagePage> createState() => _NoticeMessagePageState();
}

class _NoticeMessagePageState extends State<NoticeMessagePage> {
  final controller = Get.find<NoticeMessageController>();
  final logic = Get.find<NoticeMessageController>().logic;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NoticeMessageController>(
      builder: (controller) {
        if (controller.tabController == null) return const SizedBox();
        final mtls = controller.mtls[controller.tabController!.index];

        return Scaffold(
          appBar: _buildAppBar(context),
          backgroundColor: AppColor.colorBorder4,
          body: Column(
            children: [
              _buildTabBar(),
              if (mtls.isEmpty)
                NoData(
                  content: LocaleKeys.common_no_data.tr,
                ).center
              else
                ListView.separated(
                  itemCount: mtls.length,
                  padding: EdgeInsets.only(top: 10.w),
                  itemBuilder: (BuildContext context, int index) {
                    final mtl =
                        controller.mtls[controller.tabController!.index][index];
                    return ColoredBox(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(mtl.title),
                              Text('2024-05-08 17:19'),
                            ],
                          ).marginSymmetric(horizontal: 16.w, vertical: 10.w),
                          Divider(),
                          Text(mtl.context).marginSymmetric(
                              horizontal: 16.w, vertical: 10.w),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(height: 10.w),
                ).expanded(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(bottom: 2.w),
      child: TabBar(
        isScrollable: true,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            color: const Color(0xFF179CFF),
            width: 2.w,
          ),
          borderRadius: BorderRadius.circular(2.w),
        ),
        dividerHeight: 0,
        padding: EdgeInsets.symmetric(horizontal: 7.w),
        labelColor: const Color(0xFF179CFF),
        unselectedLabelColor: const Color(0xFF7981A3),
        labelPadding: EdgeInsets.symmetric(horizontal: 7.w),
        indicatorPadding: EdgeInsets.symmetric(horizontal: 10.w),
        controller: controller.tabController,
        onTap: controller.onTabChanged,
        tabs: List.generate(
          controller.tabTitles.length,
          (index) {
            final title = controller.tabTitles[index];
            return Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                fontFamily: 'PingFang SC',
              ),
            ).marginOnly(bottom: 4.w);
          },
        ).toList(),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor:
          context.isDarkMode ? AppColor.titleBackgroundColor : Colors.white,
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
            color: context.isDarkMode ? Colors.white : const Color(0xFF303442),
          ),
        ),
      ),
      title: Text(
        '公告中心'.tr,
        style: TextStyle(
          color: context.isDarkMode ? Colors.white : const Color(0xFF303442),
          fontSize: 16.sp,
          fontFamily: 'PingFang SC',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<NoticeMessageController>();
    super.dispose();
  }
}
