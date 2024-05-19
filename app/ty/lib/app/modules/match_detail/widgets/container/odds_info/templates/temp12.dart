import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_map_operate.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/odds_info/odds_item.dart';
import 'package:get/get.dart';

import '../../../../../../global/data_store_controller.dart';
import '../../../../../../services/models/res/match_entity.dart';
import '../../../../models/bet_item_collection.dart';
import '../odds_button.dart';

/// 玩法集模版 id=12 主队 客队
class Temp12 extends StatelessWidget {
  const Temp12({super.key, required this.matchHps, required this.fullscreen});

  final MatchHps matchHps;
  final bool fullscreen;

  @override
  Widget build(BuildContext context) {
    MatchEntity? match = DataStoreController.to.getMatchById(matchHps.mid);
    List<MatchHpsTitle> titleList = matchHps.title as List<MatchHpsTitle>;

    // ad1 = 1
    List<dynamic> collectionA = getAppendSingleList(matchHps, match, "1");
    // ad1 = 2
    List<dynamic> collectionB = getAppendSingleList(matchHps, match, "2");

    return Column(
      children: [
        // 主队
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 空白占位
            Expanded(
                child: Container(
              height: fullscreen ? 35 : 35.w,
              padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
              child: Text(
                match?.mhn ?? "",
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
            )),
            ...List.generate(titleList.length, (index) => index).map(
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
          padding: const EdgeInsets.all(8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: childAspectRatio(3, fullscreen),
          ),
          itemBuilder: (BuildContext context, int index) {
            BetItemCollection c = collectionA[index] as BetItemCollection;
            if (collectionA[index] == null) {
              return Container();
            } else if (collectionA[index] is String) {
              return _buildOddsName(collectionA[index]);
            }
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
          itemCount: collectionA.length,
        ),

        // 客队
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Container(
              height: fullscreen ? 35 : 35.w,
              padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
              child: Text(
                match?.man ?? "",
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
            )),
            ...List.generate(titleList.length, (index) => index).map(
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
          padding: const EdgeInsets.all(8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: childAspectRatio(3, fullscreen),
          ),
          itemBuilder: (BuildContext context, int index) {
            if (collectionB[index] == null) {
              return Container();
            } else if (collectionB[index] is String) {
              return _buildOddsName(collectionB[index]);
            }

            BetItemCollection c = collectionB[index] as BetItemCollection;
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
          itemCount: collectionB.length,
        ),
      ],
    );
  }

  // 附加盘投注项集合
  List<dynamic> getAppendSingleList(
      MatchHps data, MatchEntity? match, String ad1) {
    List<dynamic> result = [];
    List<MatchHpsHl> hl = data.hl;
    for (var i = 0; i < hl.length; i++) {
      if (ad1 == hl[i].ad1) {
        if (ad1 == "1") {
          result.add(hl[i].ad1 ?? "");
        } else {
          result.add(hl[i].ad2 ?? "");
        }
        List<MatchHpsHlOl> ol = hl[i].ol;
        for (var j = 0; j < ol.length; j++) {
          var item = BetItemCollection(
            ol: ol[j],
            hl: hl[i],
          );
          result.add(item);
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
            offset: Offset(0, 2.h),
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
