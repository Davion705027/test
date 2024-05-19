import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import 'package:get/get.dart';

import '../modules/match_detail/constant/detail_constant.dart';
import 'image_view.dart';

enum NoDataType {
  comingSoon,
  collect,
  noWifi,
  noMatch,
  noMatchNew,
  noMessage,
  noLive,
  oddsClosed, // 盘口关闭
  none
}

/// noData类型对应国际化文字
Map<NoDataType, String> noDataRef = {
  // '暂无关注的赛事哦',
  NoDataType.comingSoon: LocaleKeys.msg_msg_nodata_23.tr,
  // '暂无关注的赛事哦',
  NoDataType.collect: LocaleKeys.msg_msg_nodata_08.tr,
  //'网络不给力',
  NoDataType.noWifi: LocaleKeys.msg_msg_nodata_09.tr,
  //'暂无数据~',
  NoDataType.noMatch: LocaleKeys.analysis_football_matches_no_data.tr,
  //'空空如也~',
  NoDataType.noMatchNew: LocaleKeys.msg_msg_nodata_02.tr,
  //'暂无消息记录~',
  NoDataType.noMessage: LocaleKeys.msg_msg_nodata_17.tr,
  //'暂无直播的赛事哦',
  NoDataType.noLive: LocaleKeys.msg_msg_nodata_14.tr,
};

/// 无数据展示页 无网络带刷新按钮
class NoData extends StatelessWidget {
  const NoData(
      {super.key,
      this.content,
      this.top,
      this.bottom,
      this.backHeader = false,
      this.type = NoDataType.none,
      this.onRefresh,
      this.fullscreen = false});

  /// 带返回按钮
  final bool backHeader;

  /// NoDataType.none 时展示文本
  final String? content;

  final double? top;

  final double? bottom;

  /// 无数据类型
  final NoDataType type;

  /// 无网络时刷新按钮回调
  final Function? onRefresh;

  /// 全屏
  final bool fullscreen;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Get.isDarkMode;
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: Get.mediaQuery.padding.top,bottom:bottom??0 ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (backHeader)
            Container(
              height: appbarHeight,
              width: 1.sw,
              padding:
                  const EdgeInsets.only(left: 6, top: 4, bottom: 4, right: 14),
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  /// 返回
                  Positioned(
                    left: 0,
                    child: InkWell(
                      onTap: () => Get.back(),
                      child: Container(
                        width: 24,
                        height: appbarHeight,
                        alignment: Alignment.center,
                        child: ImageView(
                          isDark
                              ? "assets/images/detail/icon_arrowleft_nor_night.svg"
                              : "assets/images/detail/icon_arrowleft_nor.svg",
                          boxFit: BoxFit.fill,
                          width: 8,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(
            height: top ?? 144,
          ),
          Container(
            width: fullscreen ? 180 : 240,
            height: fullscreen ? 180 : 240,
            alignment: Alignment.center,
            child: _buildBgImage(),
          ),
          Text(
            /// 特殊使用content 没有的话使用映射国际化文本
            [NoDataType.oddsClosed, NoDataType.none].contains(type)
                ? content ?? LocaleKeys.msg_msg_nodata_02.tr
                : noDataRef[type] ?? LocaleKeys.msg_msg_nodata_02.tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isDark
                  ? Colors.white.withOpacity(0.5)
                  : const Color(0xFF7981A3),
              fontSize: 16,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w500,
            ),
          ),
          // 别紧张，刷新页面试试文本 onRefresh 有传时才显示
          if (type == NoDataType.noWifi && onRefresh != null)
            Text(
              LocaleKeys.msg_msg_nodata_07.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isDark
                    ? Colors.white.withOpacity(0.5)
                    : const Color(0xFF7981A3),
                fontSize: 16,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w500,
              ),
            ),
          // 无网络刷新按钮 有传回调才显示
          if (type == NoDataType.noWifi && onRefresh != null)
            InkWell(
              onTap: () => onRefresh!(),
              child: Container(
                width: 140,
                padding: const EdgeInsets.symmetric(vertical: 8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromRGBO(69, 176, 255, 1),
                      Color.fromRGBO(23, 156, 255, 1),
                    ], // 渐变色数组
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(8), // 圆角
                ),
                child: Text(
                  LocaleKeys.msg_msg_nodata_06.tr,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ).marginOnly(top: 12),
            )
        ],
      ),
    );
  }

  /// 显示图片
  _buildBgImage() {
    final bool isDark = Get.isDarkMode;
    if (type == NoDataType.none) {
      return Stack(
        alignment: Alignment.center,
        children: [
          ImageView(
            isDark
                ? 'assets/images/detail/no-data-bg-night.svg'
                : 'assets/images/detail/no-data-bg.svg',
            width: 239,
          ),
          ImageView(
            isDark
                ? 'assets/images/detail/no-data-night.svg'
                : 'assets/images/detail/no-data.svg',
            width: 186.80,
          )
        ],
      );
    } else {
      String url = "";
      if (type == NoDataType.noWifi) {
        url = 'assets/images/detail/fullscreen-nodata-network.svg';
      } else if (type == NoDataType.collect) {
        url = 'assets/images/detail/no_data_collect.png';
      } else if (type == NoDataType.oddsClosed) {
        url = isDark
            ? 'assets/images/detail/fullscreen-nodata-lock.svg'
            : 'assets/images/detail/def_marketclose.png';
      } else {
        url = 'assets/images/detail/fullscreen-nodata.svg';
      }

      return ImageView(
        url,
        width: 239,
      );
    }
  }
}
