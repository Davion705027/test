import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/core/format/common/module/format-date.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/extension/widget_extensions.dart';
import 'package:flutter_ty_app/app/services/models/res/notice_center_entity.dart';
import 'package:flutter_ty_app/app/widgets/no_data.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import 'package:get/get.dart';

import '../../../config/theme/app_color.dart';
import 'notice_center_controller.dart';

class NoticeCenterPage extends StatefulWidget {
  const NoticeCenterPage({Key? key}) : super(key: key);

  @override
  State<NoticeCenterPage> createState() => _NoticeCenterPageState();
}

class _NoticeCenterPageState extends State<NoticeCenterPage> {
  final controller = Get.find<NoticeCenterController>();
  final logic = Get.find<NoticeCenterController>().logic;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NoticeCenterController>(
      builder: (controller) {
        return Scaffold(
            appBar: _buildAppBar(context),
            backgroundColor: context.isDarkMode
                ? AppColor.titleBackgroundColor
                : '#F2F2F6'.hexColor,
            body: Builder(
              builder: (context) {
                if (controller.tabController == null) {
                  return const SizedBox();
                }

                if (controller.mtls.isEmpty) {
                  return NoData(
                    content: LocaleKeys.common_no_data.tr,
                  ).center;
                }

                // 测试用
                final mtls = false
                    ? [
                        NoticeCenterNlMtl.fromJson(
                          {
                            "context":
                                "足球 : 2024-04-15 16:50:00 PM独家VS联赛-中国中超  (  vs  ) -因比赛取消，所有注单一律视为无效。连串注单该场赛事相关盘口赔率以（1）计算。请再次检查您的注单，造成不便之处，敬请见谅！",
                            "id": "7485",
                            "isShuf": 1,
                            "isTop": 0,
                            "noticeType": 1,
                            "noticeTypeName": "足球赛事",
                            "sendTime": "05/10/24",
                            "sendTimeOther": "1715315415444",
                            "title": "比赛取消"
                          },
                        ),
                        NoticeCenterNlMtl.fromJson(
                          {
                            "context":
                                "足球 : 2024-04-15 16:50:00 PM独家VS联赛-中国中超  (  vs  ) -因比赛取消，所有注单一律视为无效。连串注单该场赛事相关盘口赔率以（1）计算。请再次检查您的注单，造成不便之处，敬请见谅！",
                            "id": "7485",
                            "isShuf": 1,
                            "isTop": 0,
                            "noticeType": 1,
                            "noticeTypeName": "足球赛事",
                            "sendTime": "05/10/24",
                            "sendTimeOther": "1715315415444",
                            "title": "比赛取消"
                          },
                        ),
                        NoticeCenterNlMtl.fromJson(
                          {
                            "context":
                                "足球 : 2024-04-15 16:50:00 PM独家VS联赛-中国中超  (  vs  ) -因比赛取消，所有注单一律视为无效。连串注单该场赛事相关盘口赔率以（1）计算。请再次检查您的注单，造成不便之处，敬请见谅！",
                            "id": "7485",
                            "isShuf": 1,
                            "isTop": 0,
                            "noticeType": 1,
                            "noticeTypeName": "足球赛事",
                            "sendTime": "05/10/24",
                            "sendTimeOther": "1715315415444",
                            "title": "比赛取消"
                          },
                        ),
                        NoticeCenterNlMtl.fromJson(
                          {
                            "context":
                                "足球 : 2024-04-15 16:50:00 PM独家VS联赛-中国中超  (  vs  ) -因比赛取消，所有注单一律视为无效。连串注单该场赛事相关盘口赔率以（1）计算。请再次检查您的注单，造成不便之处，敬请见谅！",
                            "id": "7485",
                            "isShuf": 1,
                            "isTop": 0,
                            "noticeType": 1,
                            "noticeTypeName": "足球赛事",
                            "sendTime": "05/10/24",
                            "sendTimeOther": "1715315415444",
                            "title": "比赛取消"
                          },
                        ),
                      ]
                    : controller.mtls[controller.tabController!.index];
                return Column(
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
                          final mtl = mtls[index];
                          return Container(
                            color: Get.isDarkMode ? null : Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  color: Get.isDarkMode
                                      ? '#0AFFFFFF'.hexColor
                                      : null,
                                  child: Row(
                                    children: [
                                      Text(
                                        mtl.title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Get.isDarkMode
                                              ? '#E5FFFFFF'.hexColor
                                              : '#424141'.hexColor,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ).expanded(),
                                      SizedBox(width: 8.w),
                                      Text(
                                        TYFormatDate.format_Y_M_D_H_M(
                                          int.tryParse(mtl.sendTimeOther),
                                        ),
                                        style: TextStyle(
                                          color: Get.isDarkMode
                                              ? '#4DFFFFFF'.hexColor
                                              : '#AFB3C8'.hexColor,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ).marginSymmetric(
                                      horizontal: 16.w, vertical: 10.w),
                                ),
                                if (!Get.isDarkMode) const Divider(),
                                Container(
                                  color: Get.isDarkMode
                                      ? '#05FFFFFF'.hexColor
                                      : null,
                                  child: Text(
                                    mtl.context,
                                    style: TextStyle(
                                      color: Get.isDarkMode
                                          ? '#4DFFFFFF'.hexColor
                                          : '#303442'.hexColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ).marginSymmetric(
                                      horizontal: 16.w, vertical: 10.w),
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(height: 8.w),
                      ).expanded(),
                  ],
                );
              },
            ));
      },
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: Get.isDarkMode ? null : Colors.white,
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
        LocaleKeys.app_notice_center.tr,
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
    Get.delete<NoticeCenterController>();
    super.dispose();
  }
}
