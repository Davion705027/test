import 'dart:math';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_map_operate.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:get/get.dart';

import '../../../../../../global/data_store_controller.dart';
import '../../../../../../services/models/res/match_entity.dart';
import '../../../../models/bet_item_collection.dart';
import '../odds_button.dart';
import '../odds_item.dart';

/// 模板14，用于获胜&总分、独赢&进球大小等混合玩法模板 特色组合
class Temp14 extends StatelessWidget {
  Temp14({super.key, required this.matchHps, required this.fullscreen});

  final MatchHps matchHps;
  final bool fullscreen;

  // 其他
  final List<BetItemCollection> other = [];

  /// 玩法ID:353(独赢 & 最先进球球队) [无进球]投注项的otd
  final int otherOtd = 1130;

  @override
  Widget build(BuildContext context) {
    MatchEntity? match = DataStoreController.to.getMatchById(matchHps.mid);
    List<MatchHpsTitle> titleList = matchHps.title as List<MatchHpsTitle>;

    List<BetItemCollection> collection = matchHps.collection;
    // 左
    List<BetItemCollection> collectionA = collection
        .where((element) => element.ol.otd == titleList[0].otd)
        .toList();
    // 中
    List<BetItemCollection> collectionB = collection
        .where((element) => element.ol.otd == titleList[1].otd)
        .toList();
    // 右
    List<BetItemCollection> collectionC = [];
    if (titleList.length > 2) {
      collectionC = collection
          .where((element) => element.ol.otd == titleList[2].otd)
          .toList();
    }

    /// 获得最大列长度
    int total =
        max(max(collectionA.length, collectionB.length), collectionC.length);
    List list = getMixedList(total, collectionA, collectionB, collectionC);
    return Column(
      children: [
        // 标题
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ...List.generate(titleList.length > 2 ? 3 : 2, (index) => index)
                .map(
              (e) => Expanded(
                child: Container(
                  height: fullscreen ? 35 : 35.w,
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: Text(
                    titleList[e].osn,
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
          padding: EdgeInsets.all(8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: titleList.length > 2 ? 3 : 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: titleList.length > 2
                ? childAspectRatio(3, fullscreen)
                : childAspectRatio(2, fullscreen),
          ),
          itemBuilder: (BuildContext context, int index) {
            if (list[index] == null) {
              return Container();
            }
            BetItemCollection c = list[index] as BetItemCollection;
            return OddsButton(
              match: match,
              hps: matchHps,
              ol: c.ol,
              hl: c.hl,
              name: c.ol.on,
              isDetail: true,
              fullscreen: fullscreen,
            );
          },
          itemCount: list.length,
        ),
        // 其他
        ...other.map((e) {
          BetItemCollection c = e;
          return Padding(
            padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
            child: OddsButton(
              height: fullscreen ? 44.5 : 44.5.w,
              match: match,
              hps: matchHps,
              ol: c.ol,
              hl: c.hl,
              isDetail: true,
              name: ObjectUtil.isNotEmpty(c.ol.on) ? c.ol.on : c.ol.ott,
              fullscreen: fullscreen,
            ),
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
        var item = BetItemCollection(
          ol: ol[j],
          hl: hl[i],
        );
        result.add(item);
        // [无进球]投注项的otd
        if (ol[j].otd == otherOtd) {
          // 合并数据，根据id去重
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
      List<BetItemCollection> collectionA,
      List<BetItemCollection> collectionB,
      List<BetItemCollection> collectionC) {
    List list = [];
    List list1 = fillBlankPlaceholder(collectionA, total);
    List list2 = fillBlankPlaceholder(collectionB, total);
    List list3 = fillBlankPlaceholder(collectionC, total);
    for (int i = 0; i < total; i++) {
      // 改列为空则不进行混入
      if (list1[0] != null) list.add(list1[i]);
      if (list2[0] != null) list.add(list2[i]);
      if (list3[0] != null) list.add(list3[i]);
    }
    return list;
  }
}
