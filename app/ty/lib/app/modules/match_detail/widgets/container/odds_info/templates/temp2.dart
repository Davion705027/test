import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_map_operate.dart';

import '../../../../../../global/data_store_controller.dart';
import '../../../../../../services/models/res/match_entity.dart';
import '../../../../models/bet_item_collection.dart';
import '../odds_button.dart';
import '../odds_item.dart';

/// 2号模板 只有两列 有个不同点是需要将title设置到投注项
class Temp2 extends StatelessWidget {
  const Temp2({super.key, required this.matchHps, required this.fullscreen});

  final MatchHps matchHps;
  final bool fullscreen;
  @override
  Widget build(BuildContext context) {
    MatchEntity? match = DataStoreController.to.getMatchById(matchHps.mid);
    List<BetItemCollection> collection = matchHps.collection;
    List<MatchHpsTitle> titleList = matchHps.title as List<MatchHpsTitle>;

    // 左
    List<BetItemCollection> collectionA = collection
        .where((element) => element.ol.otd == titleList[0].otd)
        .toList();

    // 右
    List<BetItemCollection> collectionB = collection
        .where((element) => element.ol.otd == titleList[1].otd)
        .toList();
    int total = max(collectionA.length, collectionB.length);
    List list = getMixedList(total, collectionA, collectionB);
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: childAspectRatio(2,fullscreen),
      ),
      itemBuilder: (BuildContext context, int index) {
        if (list[index] == null) {
          return Container();
        }
        BetItemCollection c = list[index] as BetItemCollection;
        return OddsButton(
          name: c.ol.on != "" ? c.ol.on : c.ol.ott,
          match: match,
          hps: matchHps,
          ol: c.ol,
          hl: c.hl,
          isDetail: true,
          fullscreen: fullscreen,
        );
      },
      itemCount: list.length,
    );
  }

  List getMixedList(int total, List<BetItemCollection> collectionA,
      List<BetItemCollection> collectionB) {
    List list = [];
    List list1 = fillBlankPlaceholder(collectionA, total);
    List list2 = fillBlankPlaceholder(collectionB, total);
    for (int i = 0; i < total; i++) {
      list.add(list1[i]);
      list.add(list2[i]);
    }
    return list;
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
}
