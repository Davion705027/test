import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_map_operate.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/odds_info/odds_item.dart';
import 'package:get/get.dart';

import '../../../../../../../generated/locales.g.dart';
import '../../../../../../global/data_store_controller.dart';
import '../../../../../../services/models/res/match_entity.dart';
import '../../../../models/bet_item_collection.dart';
import '../../../../models/odds_button_enum.dart';
import '../odds_button.dart';

/// 模板id=6 --用于无盘口&区分主客的多个投注项玩法 比如最后进球球员
/// 两列，超过10个显示【显示更多】按钮，可折叠
class Temp6 extends StatefulWidget {
  const Temp6({super.key, required this.matchHps, required this.fullscreen});

  final MatchHps matchHps;
  final bool fullscreen;

  @override
  State<Temp6> createState() => _Temp6State();
}

class _Temp6State extends State<Temp6> {
  // 其他
  final List<BetItemCollection> other = [];

  /// 其他 底部横向一列
  final int otherOtd = -1;

  bool showMore = true;

  @override
  void initState() {
    // 对模板数据量大的玩法进行折叠处理
    int length = widget.matchHps.hl.safe(0)?.ol.length ?? 0;
    if (length > 10) {
      showMore = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MatchEntity? match =
        DataStoreController.to.getMatchById(widget.matchHps.mid);
    List<MatchHpsTitle> titleList =
        widget.matchHps.title as List<MatchHpsTitle>;

    List<BetItemCollection> collection = widget.matchHps.collection;
    final List<BetItemCollection> other = widget.matchHps.otherCollection;
    // 左
    List<BetItemCollection> collectionA = collection
        .where((element) =>
            (element.ol.otd == titleList.safe(0)?.otd) &&
            (element.ol.ot != 'Other') &&
            (element.ol.otd != -1) &&
            (element.ol.os != 3))
        .toList();
    // 右
    List<BetItemCollection> collectionB = collection
        .where((element) =>
            (element.ol.otd == titleList.safe(1)?.otd) &&
            (element.ol.ot != 'Other') &&
            (element.ol.otd != -1) &&
            (element.ol.os != 3))
        .toList();

    /// 获得最大列长度
    int total = max(collectionA.length, collectionB.length);
    List list = getMixedList(total, collectionA, collectionB);
    List listOther = other;
    if ((total + other.length) > 10 && showMore == false) {
      if (total > 5) {
        list = list.sublist(0, 10);
        listOther = [];
      } else {
        listOther = other.sublist(0, 5 - total);
      }
    }

    return Column(
      children: [
        // 标题
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ...List.generate(titleList.length, (index) => index).map(
              (e) => Expanded(
                child: Container(
                  height: widget.fullscreen ? 35 : 35.w,
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: Text(
                    titleList[e].osn,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: widget.fullscreen ? 12 : 12.sp,
                      color: widget.fullscreen
                          ? Colors.white.withOpacity(0.5)
                          : Get.theme.oddsButtonNameFontColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: childAspectRatio(2, widget.fullscreen),
          ),
          itemBuilder: (BuildContext context, int index) {
            if (list[index] == null) {
              return Container();
            } else if (list[index] is String) {
              return _buildOddsName(list[index]);
            }
            BetItemCollection c = list[index] as BetItemCollection;
            return OddsButton(
              match: match,
              hps: widget.matchHps,
              ol: c.ol,
              hl: c.hl,
              name: c.ol.on,
              isDetail: true,
              fullscreen: widget.fullscreen,
              direction: OddsTextDirection.horizontal,
            );
          },
          itemCount: list.length,
        ),
        // 其他
        ...listOther.map((e) {
          BetItemCollection c = e;
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                height: widget.fullscreen ? 44.5 : 44.5.h,
                alignment: Alignment.center,
                width:
                    childAspectRatio(titleList.length + 1, widget.fullscreen) *
                        (widget.fullscreen ? 42.5 : 42.5.h),
                child: _buildOddsName(e.ol.on),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8, bottom: 8),
                  child: OddsButton(
                    height: widget.fullscreen ? 44.5 : 44.5.h,
                    match: match,
                    hps: widget.matchHps,
                    ol: c.ol,
                    hl: c.hl,
                    isDetail: true,
                    name: c.ol.on,
                    fullscreen: widget.fullscreen,
                  ),
                ),
              ),
            ],
          );
        }),
        // 显示更多按钮 一列总长度大于10 显示
        if ((total + other.length) > 10)
          InkWell(
            onTap: () {
              setState(() {
                showMore = !showMore;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
              height: widget.fullscreen ? 44.5 : 44.5.h,
              child: _buildOddsName(showMore
                  ? LocaleKeys.match_info_pack_up.tr
                  : LocaleKeys.match_info_show_more.tr),
            ),
          )
      ],
    );
  }

  // 附加盘投注项集合
  List<BetItemCollection> getAppendSingleList(
      MatchHps data, MatchEntity? match) {
    List<BetItemCollection> result = [];
    List<MatchHpsHl> hl = data.hl;
    for (var i = 0; i < hl.length; i++) {
      List<MatchHpsHlOl> ol = hl[i].ol;
      for (var j = 0; j < ol.length; j++) {
        MatchHpsHlOl newOl =
            DataStoreController.to.getOlById(ol[j].oid) ?? ol[j];
        MatchHpsHl newHl = DataStoreController.to.getHlById(hl[i].hid) ?? hl[i];
        var item = BetItemCollection(
          ol: newOl,
          hl: newHl,
        );
        result.add(item);
        // 其他
        if (newOl.otd == otherOtd) {
          // 去重
          other.addIf(!other.any((element) => element == item), item);
        }
      }
    }
    return result;
  }

  /// 补充空白占位 不足total个 补到total个
  List fillBlankPlaceholder(List list, int total) {
    List newList = [...list];
    if (list.length < total) {
      int length = list.length;
      newList.addAll(List.filled(total - length, null).toList());
    }
    return newList;
  }

  List getMixedList(int total, List<BetItemCollection> collectionA,
      List<BetItemCollection> collectionB) {
    List list = [];
    List list1 = fillBlankPlaceholder(collectionA, total);
    List list2 = fillBlankPlaceholder(collectionB, total);
    for (int i = 0; i < total; i++) {
      // 改列为空则不进行混入
      if (list1[0] != null) list.add(list1[i]);
      if (list2[0] != null) list.add(list2[i]);
    }
    return list;
  }

  _buildOddsName(String on) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: widget.fullscreen
            ? Colors.white.withOpacity(0.08)
            : Get.theme.oddsButtonBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
        on,
        style: TextStyle(
          fontSize: widget.fullscreen ? 13 : 13.sp,
          color: widget.fullscreen
              ? Colors.white.withOpacity(0.5)
              : Get.theme.oddsButtonNameFontColor,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
