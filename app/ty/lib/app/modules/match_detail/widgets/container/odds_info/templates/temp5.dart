import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_map_operate.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/odds_info/odds_item.dart';
import 'package:get/get.dart';

import '../../../../../../global/data_store_controller.dart';
import '../../../../../../services/models/res/match_entity.dart';
import '../../../../models/bet_item_collection.dart';
import '../odds_button.dart';

/// 模板id=5 --用于多重条件&多个投注项的玩法，例如全场大小、进球大小
class Temp5 extends StatelessWidget {
  Temp5({super.key, required this.matchHps, required this.fullscreen});

  final MatchHps matchHps;
  final bool fullscreen;

  // 其他
  final List<BetItemCollection> other = [];

  /// 其他or平局
  final int otherOtd = 0;

  @override
  Widget build(BuildContext context) {
    MatchEntity? match = DataStoreController.to.getMatchById(matchHps.mid);
    List<MatchHpsTitle> titleList = matchHps.title as List<MatchHpsTitle>;

    List<BetItemCollection> collection = matchHps.collection;
    final List<BetItemCollection> other = matchHps.otherCollection;
    // 左
    List<BetItemCollection> collectionA = collection
        .where((element) => element.ol.otd == titleList.safe(0)?.otd)
        .toList();
    // 中
    List<BetItemCollection> collectionB = collection
        .where((element) => element.ol.otd == titleList.safe(1)?.otd)
        .toList();
    // 右
    List<BetItemCollection> collectionC = [];
    if (titleList.length > 2) {
      collectionC = collection
          .where((element) => element.ol.otd == titleList.safe(2)?.otd)
          .toList();
    }

    /// 获得最大列长度
    int total =
        max(max(collectionA.length, collectionB.length), collectionC.length);
    List list =
        getMixedList(total, titleList, collectionA, collectionB, collectionC);
    return Column(
      children: [
        // 标题
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 空白占位
            Expanded(child: Container()),
            ...List.generate(titleList.length, (index) => index).map(
              (e) => Expanded(
                child: Container(
                  height: fullscreen ? 35 : 35.w,
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: Text(
                    titleList.safe(e)?.osn ?? "",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: fullscreen ? 12 : 12.sp,
                      color: fullscreen
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
            crossAxisCount: titleList.length + 1,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio:
                childAspectRatio(titleList.length + 1, fullscreen),
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
              hps: matchHps,
              ol: c.ol,
              hl: c.hl,
              name: "",
              isDetail: true,
              fullscreen: fullscreen,
            );
          },
          itemCount: list.length,
        ),
        // 其他
        ...other.map((e) {
          BetItemCollection c = e;
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                height: fullscreen ? 44.5 : 44.5.h,
                alignment: Alignment.center,
                width: childAspectRatio(titleList.length + 1, fullscreen) *
                    (fullscreen ? 42.5 : 42.5.h),
                child: _buildOddsName(e.ol.on),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8, bottom: 8),
                  child: OddsButton(
                    height: fullscreen ? 44.5 : 44.5.h,
                    match: match,
                    hps: matchHps,
                    ol: c.ol,
                    hl: c.hl,
                    isDetail: true,
                    name: c.ol.on,
                    fullscreen: fullscreen,
                  ),
                ),
              ),
            ],
          );
        })
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
        // 其他or平局
        if (newOl.otd == otherOtd) {
          other.add(item);
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

  List getMixedList(
      int total,
      List<MatchHpsTitle> titleList,
      List<BetItemCollection> collectionA,
      List<BetItemCollection> collectionB,
      List<BetItemCollection> collectionC) {
    List list = [];
    List list1 = fillBlankPlaceholder(collectionA, total);
    List list2 = fillBlankPlaceholder(collectionB, total);
    List list3 = fillBlankPlaceholder(collectionC, total);
    for (int i = 0; i < total; i++) {
      if (collectionA[i].ol.otd == titleList[0].otd) {
        list.add(collectionA[i].ol.on);
      }
      // 改列为空则不进行混入
      if (list1[0] != null) list.add(list1[i]);
      if (list2[0] != null) list.add(list2[i]);
      if (list3[0] != null) list.add(list3[i]);
    }
    return list;
  }

  _buildOddsName(String on) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: fullscreen
            ? Colors.white.withOpacity(0.08)
            : Get.theme.oddsButtonBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        shadows: [
          BoxShadow(
            color: fullscreen
                ? Colors.transparent
                : Get.theme.oddsButtonShadowColor,
            blurRadius: 8,
            offset: const Offset(0, 2),
            spreadRadius: 0,
          )
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        on,
        style: TextStyle(
          fontSize: fullscreen ? 12 : 12.sp,
          color: fullscreen
              ? Colors.white.withOpacity(0.5)
              : Get.theme.oddsButtonNameFontColor,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
