import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_map_operate.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_detail_controller.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:get/get.dart';
import 'package:gif/gif.dart';

import '../../../../../../../generated/locales.g.dart';
import '../../../../../../global/data_store_controller.dart';
import '../../../../../../services/models/res/match_entity.dart';
import '../../../../../../utils/oss_util.dart';
import '../../../../../../widgets/scroll_index_widget.dart';
import '../../../../models/bet_item_collection.dart';
import '../odds_button.dart';
import '../odds_item.dart';

///  模板13 --针对让球/大小玩法，有多盘口时使用
///  页面第一屏最多展示3个，左右滑动可查看更多；盘口配置少于3个时，则按2个和1个的样式对应进行展示；
///  主盘放第一个，多盘口排序规则维持不变；坑位规则保持不变；
class Temp13 extends StatefulWidget {
  const Temp13(
      {super.key, required this.matchHps, this.fullscreen = false, this.tag});

  final MatchHps matchHps;
  final bool fullscreen;
  final String? tag;

  @override
  State<Temp13> createState() => _Temp13State();
}

class _Temp13State extends State<Temp13> {
  late PageController _pageController;

  /// 左右箭头标识
  bool _arrowLeft = false;
  int pageLength = 1;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // MatchEntity? match =
    //     DataStoreController.to.getMatchById(widget.matchHps.mid);
    List<BetItemCollection> collection = widget.matchHps.collection;
    int total = collection
        .where((element) =>
            element.ol.otd ==
            (widget.matchHps.title as List<MatchHpsTitle>).safe(0)?.otd)
        .length;

    // 冰球第1节让球出现otd不等情况 直接遍历hl.ol 显示
    if (total == 0) {
      List<BetItemCollection> newCollection = collection.reversed.toList();
      MatchEntity? match =
          DataStoreController.to.getMatchById(widget.matchHps.mid);
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: newCollection.length,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio:
              childAspectRatio(newCollection.length, widget.fullscreen),
        ),
        itemBuilder: (BuildContext context, int index) {
          BetItemCollection c = newCollection[index];
          return OddsButton(
            name: c.ol.ott + c.ol.on,
            match: match,
            hps: widget.matchHps,
            ol: c.ol,
            hl: c.hl,
            isDetail: true,
            fullscreen: widget.fullscreen,
          );
        },
        itemCount: newCollection.length,
      );
    }

    // 页面第一屏最多展示3个，左右滑动可查看更多；盘口配置少于3个时，则按2个和1个的样式对应进行展示；
    pageLength = (total / 3).ceil();

    double quarterWidth = (1.sw - 10.w - 8.w * 5) / 4;
    return Stack(
      alignment: Alignment.center,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            height: widget.fullscreen
                ? 92 + 16
                : quarterWidth / (85 / 42) * 2 + 8.h + 16.h,
            width:
                widget.fullscreen ? 243.25 + 8 : 1.sw - 10 - quarterWidth - 8.w,
            alignment: Alignment.center,
            // padding: EdgeInsets.only(left: widget.fullscreen ? 8 : 8.w),
            child: PageView(
              // clipBehavior: widget.fullscreen || Get.isDarkMode
              //     ? Clip.hardEdge
              //     : Clip.none,
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  if (index == 0) {
                    _arrowLeft = false;
                  } else {
                    _arrowLeft = true;
                  }
                });
              },
              children: List.generate(pageLength, (index) {
                return _buildOddButtonPage(collection, index, total);
              }),
            ),
          ),
        ),
        // 大小
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: widget.fullscreen ? 8 : 8.h),
            padding: EdgeInsets.only(left: widget.fullscreen ? 8 : 8.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: widget.fullscreen ? 42 : quarterWidth / (85 / 42),
                  width: widget.fullscreen ? 73 : quarterWidth,
                  decoration: ShapeDecoration(
                    color: widget.fullscreen
                        ? Colors.white.withOpacity(0.08)
                        : Get.theme.oddsButtonBackgroundColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    shadows: [
                      BoxShadow(
                        color: widget.fullscreen
                            ? Colors.transparent
                            : Get.theme.oddsButtonShadowColor,
                        blurRadius: 8,
                        offset: Offset(0, 2.h),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    (widget.matchHps.title as List<MatchHpsTitle>)[0].osn,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: widget.fullscreen
                          ? Colors.white.withOpacity(0.5)
                          : Get.theme.oddsButtonNameFontColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(
                  height: widget.fullscreen ? 8 : 8.h,
                ),
                Container(
                  height: widget.fullscreen ? 42 : quarterWidth / (85 / 42),
                  width: widget.fullscreen ? 73 : quarterWidth,
                  clipBehavior: Clip.none,
                  decoration: ShapeDecoration(
                    color: widget.fullscreen
                        ? Colors.white.withOpacity(0.08)
                        : Get.theme.oddsButtonBackgroundColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    shadows: [
                      BoxShadow(
                        color: widget.fullscreen
                            ? Colors.transparent
                            : Get.theme.oddsButtonShadowColor,
                        blurRadius: 8,
                        offset: Offset(0, 2.h),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    (widget.matchHps.title as List<MatchHpsTitle>)[1].osn,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: widget.fullscreen
                          ? Colors.white.withOpacity(0.5)
                          : Get.theme.oddsButtonNameFontColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        // 左右指示器
        if (pageLength > 1)
          Align(
            alignment: Alignment.centerRight,
            child: Gif(
              fps: 30,
              controller: Get.find<MatchDetailController>(tag: widget.tag)
                  .detailState
                  .gifController,
              autostart: Get.find<MatchDetailController>(tag: widget.tag)
                      .detailState
                      .gifAnimatedStatus
                      .value
                  ? Autostart.loop
                  : Autostart.no,
              image: NetworkImage(
                OssUtil.getServerPath(
                  !_arrowLeft
                      ? "assets/images/detail/ico_arrow_left.gif"
                      : "assets/images/detail/ico_arrow_right.gif",
                ),
              ),
              fit: BoxFit.fill,
              width: widget.fullscreen ? 12 : 12.w,
              height: widget.fullscreen ? 12 : 12.w,
              // ImageView(
              //             !_arrowLeft
              //                 ? "assets/images/detail/ico_arrow_left.gif"
              //                 : "assets/images/detail/ico_arrow_right.gif",
              //             boxFit: BoxFit.fill,
              //             width: 12.w,
              //           ),
            ),
          ),
      ],
    );
  }

  // 玩法分页
  Widget _buildOddButtonPage(
      List<BetItemCollection> collection, int pageIndex, int total) {
    // 大
    List<BetItemCollection> bigCollection = collection
        .where((element) =>
            element.ol.otd ==
            (widget.matchHps.title as List<MatchHpsTitle>).safe(0)?.otd)
        .toList()
        .sublist(pageIndex * 3,
            (pageLength - 1) == pageIndex ? total : (pageIndex * 3 + 3));

    // 小 排球存在空情况
    List<BetItemCollection> smallCollection = collection
        .where((element) =>
            element.ol.otd ==
            (widget.matchHps.title as List<MatchHpsTitle>).safe(1)?.otd)
        .toList()
        .safeSublist(pageIndex * 3,
            (pageLength - 1) == pageIndex ? total : (pageIndex * 3 + 3));
    List<dynamic> list1 = [...bigCollection, ...smallCollection];
    // 宽长比设定
    double childAspectRatio1 = widget.fullscreen ? 73 / 42.5 : 85 / 42;

    int cLength = bigCollection.length;
    int crossAxisCount = 1;
    if (cLength == 1) {
      crossAxisCount = 1;
      childAspectRatio1 = widget.fullscreen ? 238 / 42.5 : 271 / 42;
    } else if (cLength == 2) {
      crossAxisCount = 2;
      childAspectRatio1 = widget.fullscreen ? 116 / 42.5 : 131.5 / 42;
    } else if (cLength == 3) {
      crossAxisCount = 3;
      childAspectRatio1 = widget.fullscreen ? 73 / 42.5 : 85 / 42;
    } else {
      crossAxisCount = 3;
    }

    // 最后一页 如果是滑动的则按照三个大小的尺寸
    if (pageLength > 1 && pageIndex == (pageLength - 1)) {
      crossAxisCount = 3;
      childAspectRatio1 = widget.fullscreen ? 73 / 42.5 : 85 / 42;
      list1 = [
        ...fillBlankPlaceholder(bigCollection),
        ...fillBlankPlaceholder(smallCollection)
      ];
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(
          horizontal: widget.fullscreen ? 8 : 8.w,
          vertical: widget.fullscreen ? 8 : 8.h),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: widget.fullscreen ? 8 : 8.h,
        crossAxisSpacing: widget.fullscreen ? 8 : 8.w,
        childAspectRatio: childAspectRatio1,
      ),
      itemBuilder: (BuildContext context, int index) {
        if (list1[index] == null) {
          return Container();
        }
        BetItemCollection c = list1[index]!;
        MatchEntity? match =
            DataStoreController.to.getMatchById(widget.matchHps.mid);
        return OddsButton(
          match: match,
          hps: widget.matchHps,
          ol: c.ol,
          hl: c.hl,
          name: c.ol.on
              .replaceAll(LocaleKeys.analysis_football_matches_big.tr, "")
              .replaceAll(LocaleKeys.analysis_football_matches_small.tr, "")
              .trim(),
          isDetail: true,
          fullscreen: widget.fullscreen,
        );
      },
      itemCount: list1.length,
    );
  }

  /// 补充空白占位 不足3个 补到3个 超过3个取前三个
  List fillBlankPlaceholder(List list) {
    List newList = [...list];

    if (list.length < 3) {
      int length = list.length;
      newList.addAll(List.filled(3 - length, null).toList());
    } else if (list.length > 3) {
      newList.sublist(0, 3);
    }

    return newList;
  }
}
