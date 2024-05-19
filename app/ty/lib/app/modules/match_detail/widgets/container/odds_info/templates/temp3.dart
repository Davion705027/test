import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_map_operate.dart';

import '../../../../../../global/data_store_controller.dart';
import '../../../../../../services/models/res/match_entity.dart';
import '../../../../models/bet_item_collection.dart';
import '../../../../models/odds_button_enum.dart';
import '../odds_button.dart';
import '../odds_item.dart';

/// 模板3 取第一个hl 按照ol循环 这里不看title
class Temp3 extends StatelessWidget {
  const Temp3(
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
    List<BetItemCollection> collection = getAppendSingleList(matchHps, match);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: childAspectRatio(2, fullscreen),
      ),
      itemBuilder: (BuildContext context, int index) {
        BetItemCollection c = collection[index];
        return OddsButton(
          name: c.ol.on != "" ? c.ol.on : c.ol.ott,
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
  }

  // 附加盘投注项集合
  List<BetItemCollection> getAppendSingleList(
      MatchHps data, MatchEntity? match) {
    List<BetItemCollection> result = [];
    List<MatchHpsHl> hl = data.hl;
    MatchHpsHl? hl0 = hl.safeFirst;
    if (hl0 != null) {
      List<MatchHpsHlOl> ol = hl0.ol;
      for (var j = 0; j < ol.length; j++) {
        result.add(BetItemCollection(
          ol: ol[j],
          hl: hl0,
        ));
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
}
