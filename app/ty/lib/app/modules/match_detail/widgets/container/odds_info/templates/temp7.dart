import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'dart:math';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_map_operate.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/odds_info/odds_item.dart';
import 'package:get/get.dart';

import '../../../../../../global/data_store_controller.dart';
import '../../../../../../services/models/res/match_entity.dart';
import '../../../../models/bet_item_collection.dart';
import '../../../../models/odds_button_enum.dart';
import '../odds_button.dart';

/// 模板id=7 --用于有盘口&3个投注项玩法
class Temp7 extends StatelessWidget {
  Temp7({super.key, required this.matchHps, required this.fullscreen});

  final MatchHps matchHps;
  final bool fullscreen;

  // 其他
  final List<BetItemCollection> other = [];

  @override
  Widget build(BuildContext context) {
    MatchEntity? match = DataStoreController.to.getMatchById(matchHps.mid);
    List<MatchHpsTitle> titleList = matchHps.title as List<MatchHpsTitle>;

    List<BetItemCollection> collection = matchHps.collection;
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
    List list = getMixedList(total, collectionA, collectionB, collectionC);
    return Column(
      children: [
        // 标题
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ...List.generate(titleList.length, (index) => index).map(
              (e) => Container(
                width: fullscreen ? 100 : 116.h,
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
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: titleList.length,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: childAspectRatio(titleList.length, fullscreen),
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
        ),
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
      list.add(list1[i]);
      list.add(list2[i]);
      list.add(list3[i]);
    }
    return list;
  }
}
