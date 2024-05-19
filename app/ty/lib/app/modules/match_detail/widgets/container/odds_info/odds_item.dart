import 'package:auto_size_text/auto_size_text.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_map_operate.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/odds_info_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/odds_info/templates/temp0.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/odds_info/templates/temp10.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/odds_info/templates/temp11.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/odds_info/templates/temp12.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/odds_info/templates/temp13.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/odds_info/templates/temp14.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/odds_info/templates/temp15.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/odds_info/templates/temp2.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/odds_info/templates/temp3.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/odds_info/templates/temp4.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/odds_info/templates/temp5.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/odds_info/templates/temp51.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/odds_info/templates/temp6.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/odds_info/templates/temp9.dart';
import 'package:get/get.dart';

import '../../../../../global/data_store_controller.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../services/models/res/match_entity.dart';
import '../../../../../widgets/image_view.dart';
import '../../../controllers/match_detail_controller.dart';
import 'templates/temp1.dart';
import 'templates/temp18.dart';
import 'templates/temp7.dart';

/// 详情玩法组件集合
class OddsItem extends StatefulWidget {
  const OddsItem({
    super.key,
    required this.item,
    this.tag,
    required this.index,
    required this.htonCallback,
  });

  final MatchHps item;
  final int index;
  final String? tag;
  final Function htonCallback;

  @override
  State<OddsItem> createState() => _OddsItemState();
}

class _OddsItemState extends State<OddsItem>
    with SingleTickerProviderStateMixin {
  // 动画控制器
  late final AnimationController _controller;

  late final Animation<double> _animation;

  // 定义动画开始与结束值
  late final Tween<double> _sizeTween;

  // 有些玩法（主要是角球）要换行显示比分,有总比分和基准分要展示时，只展示基准分不显示总比分,所以后面6个玩法从数组中去除了
  // 33 -->  15分钟进球({a}-{b})-让球  232 --> 15分钟角球({a}-{b})-让球 113 --> 角球让球(全场) 121 --> 上半场角球让球
  // 32、231 --> 15分钟(进球/角球)独赢  34、233 --> 15分钟(进球/角球)大小
  final List<String> cornerBall = [
    "111",
    "114",
    "115",
    "116",
    "117",
    "118",
    "119",
    "122",
    "123",
    "124",
    "226",
    "227",
    "228",
    "229"
  ];

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
    _sizeTween = Tween(begin: 0, end: 1);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MatchDetailController>(
        tag: widget.tag,
        id: "hpid_${widget.item.hpid}_${widget.item.topKey}",
        builder: (controller) {
          MatchHps item = widget.item;
          MatchEntity? match =
              DataStoreController.to.getMatchById(widget.item.mid);
          // 根据默认状态判断是否展开
          _toggleAnimated(item, controller);
          String route = Get.currentRoute;
          if (route != Routes.matchResultsDetails) {
            if (isRemove(item) || isHide(item)) {
              return Container();
            }
          }

          return Container(
            clipBehavior: Clip.hardEdge,
            margin: const EdgeInsets.only(left: 5, right: 5, bottom: 8),
            decoration: BoxDecoration(
              color: controller.detailState.fullscreen.value
                  ? Colors.white.withOpacity(0.08)
                  : Get.theme.betPanelBackGroundColor,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0A000000),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => controller.setHShow(item),
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: controller.detailState.fullscreen.value
                                ? 12
                                : 12.w,
                            vertical: controller.detailState.fullscreen.value
                                ? 8
                                : 8.h),
                        height:
                            controller.detailState.fullscreen.value ? 36 : 36.h,
                        alignment: Alignment.center,
                        child: _buildTitle(widget.item, controller, match),
                      ),
                      SizedBox(
                        height:
                            controller.detailState.fullscreen.value ? 36 : 36.h,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () => widget.htonCallback(),
                              child: Container(
                                width: controller.detailState.fullscreen.value
                                    ? 36
                                    : 36.h,
                                height: controller.detailState.fullscreen.value
                                    ? 36
                                    : 36.h,
                                alignment: Alignment.center,
                                child: ImageView(
                                  item.hton != "0"
                                      ? Get.isDarkMode
                                          ? 'assets/images/detail/odds-pin-active-night.svg'
                                          : 'assets/images/detail/odds-pin-active.svg'
                                      : controller.detailState.fullscreen.value
                                          ? 'assets/images/detail/odds-pin-night.svg'
                                          : Get.isDarkMode
                                              ? 'assets/images/detail/odds-pin-night.svg'
                                              : 'assets/images/detail/odds-pin.svg',
                                  width: controller.detailState.fullscreen.value
                                      ? 12
                                      : 12.w,
                                  height:
                                      controller.detailState.fullscreen.value
                                          ? 12
                                          : 12.w,
                                  boxFit: BoxFit.cover,
                                ),
                              ),
                            ),
                            AnimatedRotation(
                              duration: const Duration(milliseconds: 200),
                              turns: item.hshow == "Yes" ? 0 : -0.25,
                              child: ImageView(
                                controller.detailState.fullscreen.value
                                    ? 'assets/images/detail/ico_arrowdown_nor_night.svg'
                                    : Get.isDarkMode
                                        ? 'assets/images/detail/ico_arrowdown_nor_night.svg'
                                        : 'assets/images/detail/ico_arrowdown_nor.svg',
                                width: controller.detailState.fullscreen.value
                                    ? 12
                                    : 12.w,
                                height: controller.detailState.fullscreen.value
                                    ? 12
                                    : 12.w,
                              ),
                            ).marginOnly(
                                right: controller.detailState.fullscreen.value
                                    ? 10
                                    : 10.w,
                                left: controller.detailState.fullscreen.value
                                    ? 8
                                    : 8.w),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (item.hshow == "Yes")
                  Container(
                    height: 0.5,
                    color: controller.detailState.fullscreen.value
                        ? Colors.white.withOpacity(0.08)
                        : Get.theme.betPanelUnderlineColor,
                  ),
                // if (item.hshow == "Yes")
                // _buildOddWidget(item, controller),
                SizeTransition(
                  sizeFactor: _sizeTween.animate(_animation),
                  child: _buildOddWidget(item, controller),
                ),
              ],
            ),
          );
        });
  }

  _toggleAnimated(MatchHps item, MatchDetailController controller) {
    if (controller.detailState.toggleAnimate) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        try {
          if (widget.item.hshow == "Yes") {
            _controller.forward();
          } else {
            _controller.reverse();
          }
          controller.detailState.toggleAnimate = false;
        } catch (e) {
          Get.log("oddsItem _toggleAnimated: $e");
        }
      });
    } else {
      if (widget.item.hshow == "Yes") {
        _controller.value = 1.0;
      } else {
        _controller.value = 0.0;
      }
    }
  }

  _buildTitle(
      MatchHps item, MatchDetailController controller, MatchEntity? match) {
    // 角球相关玩法
    if (cornerBall.contains(item.hpid)) {
      return Text(
        item.hpn +
            ((match?.ms ?? 0) != 0 && getMatchHpsScore(item).isNotEmpty
                ? "(${getMatchHpsScore(item)})"
                : "")
        // + item.hpt.toString()
        ,
        style: TextStyle(
            color: controller.detailState.fullscreen.value
                ? Colors.white.withOpacity(0.9)
                : Get.theme.betPanelFontColor,
            fontWeight: FontWeight.w600,
            fontSize: controller.detailState.fullscreen.value ? 13 : 13.sp),
      );
    }

    // 普通赛事基准分
    else {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 45.w),
        child: Text(
          // ms=0时不展示基准分
          item.hpn +
              ((match?.ms ?? 0) != 0 && getMatchHpsScore(item).isNotEmpty
                  ? "(${getMatchHpsScore(item)})"
                  : "")
          // + item.hpt.toString()
          ,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: controller.detailState.fullscreen.value
                  ? Colors.white.withOpacity(0.9)
                  : Get.theme.betPanelFontColor,
              fontWeight: FontWeight.w600,
              fontSize: controller.detailState.fullscreen.value ? 13 : 13.sp),
        ),
      );
    }
  }

  /// 获取当前玩法实时比分
  String getMatchHpsScore(MatchHps item) {
    try {
      return ObjectUtil.isEmptyString(item.hps)
          ? ""
          : item.hps.split("|")[1].replaceAll(":", "-");
    } catch (e) {
      Get.log("${item.hpid}:hps格式不正确");
      return "";
    }
  }

  /// 根据hpt对应模板
  _buildOddWidget(MatchHps item, MatchDetailController controller) {
    switch (item.hpt) {
      case 0:
        return Temp0(
          matchHps: item,
          fullscreen: controller.detailState.fullscreen.value,
        );
      // 包含电竞
      case 1:
        return Temp1(
          matchHps: item,
          isESport: controller.detailState.isDJDetail,
          fullscreen: controller.detailState.fullscreen.value,
        );
      case 2:
        return Temp2(
          matchHps: item,
          fullscreen: controller.detailState.fullscreen.value,
        );
      // 包含电竞
      case 3:
        return Temp3(
          matchHps: item,
          isESport: controller.detailState.isDJDetail,
          fullscreen: controller.detailState.fullscreen.value,
        );
      case 4:
        return Temp4(
          matchHps: item,
          fullscreen: controller.detailState.fullscreen.value,
        );
      case 5:
        return Temp5(
          matchHps: item,
          fullscreen: controller.detailState.fullscreen.value,
        );
      case 6:
        return Temp6(
          matchHps: item,
          fullscreen: controller.detailState.fullscreen.value,
        );
      case 7:
        return Temp7(
          matchHps: item,
          fullscreen: controller.detailState.fullscreen.value,
        );
      // 9 - 11 vr虚拟体育
      case 9:
        return Temp9(
          matchHps: item,
        );
      case 10:
        return Temp10(
          matchHps: item,
        );
      case 11:
        return Temp11(
          matchHps: item,
        );
      case 12:
        return Temp12(
          matchHps: item,
          fullscreen: controller.detailState.fullscreen.value,
        );
      case 13:
        return Temp13(
            matchHps: item,
            fullscreen: controller.detailState.fullscreen.value,
            tag: widget.tag);
      case 14:
        return Temp14(
          matchHps: item,
          fullscreen: controller.detailState.fullscreen.value,
        );
      case 15:
        return Temp15(
          matchHps: item,
          fullscreen: controller.detailState.fullscreen.value,
        );
      case 18:
        return Temp18(
          matchHps: item,
          fullscreen: controller.detailState.fullscreen.value,
        );
      // 电竞
      case 51:
        return Temp51(
          matchHps: item,
          isESport: controller.detailState.isDJDetail,
          fullscreen: controller.detailState.fullscreen.value,
        );
      default:
        return Container();
      // return Text(
      //   "${item.hpt}未知",
      //   style: const TextStyle(color: Colors.green, fontSize: 20),
      // );
    }
  }

  ///@description hl里面的每一个盘口都关盘的话，移除这个玩法
  ///@return {Boolean}
  bool isRemove(MatchHps item) {
    List<MatchHpsHl> hl_ = item.hl;
    bool res = true;
    res = hl_.every((data) => data.hs == 2);
    // var hotName = props["item_data"]["hotName"];
    // if (hotName != null && hotName.isNotEmpty) {
    //   return false;
    // }
    return res;
  }

  ///@description 判断玩法盘口的显示或者是隐藏
  ///@param {Undefined}
  ///@return {String} 是否显示主盘或者附加盘
  bool isHide(MatchHps item) {
    var len = item.hl.length;
    // var hotName = props["item_data"]["hotName"];
    // if (hotName != null && hotName.isNotEmpty) {
    //   return false;
    // }
    if (len <= 0) {
      return true;
    } else {
      return false;
    }
  }
}

// 根据数量获取对应宽高比
double childAspectRatio(int length, bool fullscreen) {
  switch (length) {
    case 4:
      return fullscreen ? 75.75 / 42 : 85 / 42;
    case 3:
      return fullscreen ? 100 / 42 : 116 / 42;
    case 2:
      return fullscreen ? 159 / 42 : 178 / 42;
    case 1:
      return fullscreen ? 340 / 42 : 364 / 42;
    default:
      return fullscreen ? 75.75 / 42 : 85 / 42;
  }
}

Widget blankPlaceholder(fullscreen, {double? width, double? height}) {
  return Container(
    width: width,
    height: height,
    alignment: Alignment.center,
    clipBehavior: Clip.antiAlias,
    decoration: ShapeDecoration(
      color: fullscreen
          ? Colors.white.withOpacity(0.08)
          : Get.theme.oddsButtonBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      shadows: [
        BoxShadow(
          color:
              fullscreen ? Colors.transparent : Get.theme.oddsButtonShadowColor,
          blurRadius: 8,
          offset: Offset(0, 2.h),
          spreadRadius: 0,
        )
      ],
    ),
  );
}
