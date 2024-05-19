import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_map_operate.dart';

import '../../../../../../global/data_store_controller.dart';
import '../../../../../../services/models/res/match_entity.dart';
import '../../../../models/bet_item_collection.dart';
import '../../../../models/odds_button_enum.dart';
import '../odds_button.dart';
import '../odds_item.dart';

/// 进球、独赢、赢 玩法集模版 id=1 3列 竖着往下排列 需要区分电竞
class Temp1 extends StatelessWidget {
  const Temp1(
      {super.key,
      required this.matchHps,
      required this.isESport,
      required this.fullscreen});

  final MatchHps matchHps;

  /// 是否是电竞
  final bool isESport;
  final bool fullscreen;

  @override
  Widget build(BuildContext context) {
    MatchEntity? match = DataStoreController.to.getMatchById(matchHps.mid);
    List<BetItemCollection> collection = matchHps.collection;

    if (isESport) {
      return GridView.builder(
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
          BetItemCollection c = collection[index];
          return OddsButton(
            name: c.ol.ott + c.ol.on,
            match: match,
            hps: matchHps,
            ol: c.ol,
            hl: c.hl,
            isDetail: true,
            betType: isESport ? OddsBetType.esport : OddsBetType.common,
            fullscreen: fullscreen,
          );
        },
        itemCount: collection.length,
      );
    } else {
      int length = (matchHps.title ?? []).length;
      if(length == 0){
        return Container();
      }

      List<BetItemCollection> collectionA = [];
      if (length > 0) {
        collectionA = collection
            .where((element) =>
                element.ol.otd ==
                (matchHps.title as List<MatchHpsTitle>).safe(0)?.otd)
            .toList();
      }

      List<BetItemCollection> collectionB = [];
      if (length > 1) {
        collectionB = collection
            .where((element) =>
                element.ol.otd ==
                (matchHps.title as List<MatchHpsTitle>).safe(1)?.otd)
            .toList();
      }

      List<BetItemCollection> collectionC = [];
      if (length > 2) {
        collectionC = collection
            .where((element) =>
                element.ol.otd ==
                (matchHps.title as List<MatchHpsTitle>).safe(2)?.otd)
            .toList();
      }

      /// 获得最大列长度
      int total =
          max(max(collectionA.length, collectionB.length), collectionC.length);
      List list = getMixedList(total, collectionA, collectionB, collectionC);
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: length,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: childAspectRatio(length, fullscreen),
        ),
        itemBuilder: (BuildContext context, int index) {
          if (list[index] == null) {
            return Container();
          }
          BetItemCollection c = list[index] as BetItemCollection;
          return OddsButton(
            name: c.ol.ott + c.ol.on,
            match: match,
            hps: matchHps,
            ol: c.ol,
            hl: c.hl,
            isDetail: true,
            betType: isESport ? OddsBetType.esport : OddsBetType.common,
            fullscreen: fullscreen,
          );
        },
        itemCount: list.length,
      );
    }
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
