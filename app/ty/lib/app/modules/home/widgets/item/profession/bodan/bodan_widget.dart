import 'dart:collection';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_map_operate.dart';
import 'package:flutter_ty_app/app/modules/home/logic/bold_util.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/modules/home/logic/other_player_name_to_playid.dart';
import '../../../../../../../generated/locales.g.dart';
import '../../../../../match_detail/widgets/container/odds_info/odds_button.dart';
import '../../../../controllers/home_controller.dart';
import 'bodan_Item.dart';

///波胆
class BoDanWidget extends StatelessWidget {
  BoDanWidget({
    super.key,
    required this.match,
    required this.hps,
  });

  final List<MatchHps> hps;

  final MatchEntity match;
  List<MatchHps> targetHpsList = [];

  int maxLine = 3;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DataStoreController>(
        id: DataStoreController.to.getMatchId(match.mid),
        builder: (logic) {
          //  MatchEntity targetMatch = logic.getMatchById(match.mid) ?? match ;
          MatchEntity targetMatch = match;
          //过滤掉没有标题的
          targetMatch.hpsBold.forEach((element) {
            if (element.hl.isNotEmpty &&
                element.hl.first.title.isNotEmpty &&
                element.hl.first.ol.isNotEmpty) {
              targetHpsList.add(element);
            }
          });

          MatchHps targetHpsListSafeFirst =
              targetHpsList.safeFirst ?? MatchHps();
          MatchHps targetHpsListSafeLast = MatchHps();
          if (targetHpsList.isNotEmpty) {
            if (targetHpsList.length > 2) {
              targetHpsListSafeLast = targetHpsList[1];
            } else {
              targetHpsListSafeFirst = targetHpsList.safeFirst ?? MatchHps();
            }

          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildGroud(targetHpsListSafeFirst, 0),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      // print('点击右边');
                    },
                    child: _buildGroud(targetHpsListSafeLast, 1),
                  )
                ],
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  // print('点击右边');
                },
                child: SizedBox(
                  height: 8.w,
                ),
              ),
            ],
          );
        });
  }
  MatchHpsHlOl? first ;
  MatchHpsHlOl? last;


  _buildGroud(MatchHps boldHps, int type) {
    LinkedHashMap<int, MatchHpsTitle> map = LinkedHashMap();
    Map<int, List<MatchHpsHlOl>> olMap = {};
    boldHps.hl.safeFirst?.title.forEach((element) {
      map[element.otd] = element;
    });


    if (map.isEmpty) {
      map[1] = MatchHpsTitle()
        ..osn = match.mhn
        ..otd = 1;
      map[2] = MatchHpsTitle()
        ..osn = match.man
        ..otd = 2;

      map[0] = MatchHpsTitle()
        ..osn = '半场平局'
        ..otd = 0;
    }
    olMap = BoldUtil.getFromBoldMatchHps(boldHps);
    if (olMap.isEmpty) {
      olMap[1] = [MatchHpsHlOl(), MatchHpsHlOl(), MatchHpsHlOl(),];
      olMap[2] = [MatchHpsHlOl(), MatchHpsHlOl(), MatchHpsHlOl(),];
      olMap[0] = [MatchHpsHlOl(), MatchHpsHlOl(), MatchHpsHlOl(),];
    }

    olMap.values.forEach((element) {
      if (element.length > maxLine) {
        maxLine = element.length;
      }
    });

    if(type==0){
      first= olMap[-1]?.first;
      HomeController.to.setFirstMap(first);

    }else {
      last= olMap[-1]?.first;
      HomeController.to.setLastMap(last);
    }
    double width = ((Get.width - 28.w - 9.w) / 2).toInt().toDouble();
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            bodan_Item(
              match: match,
              title: map[1]?.osn ?? '',
              list: olMap[1] ?? [],
              hps: boldHps,
              type: type,
              maxLine: maxLine,
            ),
            SizedBox(
              width: 2.w,
            ),
            bodan_Item(
                match: match,
                title: type == 0
                    ? LocaleKeys.football_playing_way_full_time_draw.tr
                    : LocaleKeys.football_playing_way_half_time_draw.tr,
                list: olMap[0] ?? [],
                hps: boldHps,
                maxLine: maxLine,
                type: type),
            SizedBox(
              width: 2.w,
            ),
            bodan_Item(
              match: match,
              title: map[2]?.osn ?? '',
              list: olMap[2] ?? [],
              hps: boldHps,
              type: type,
              maxLine: maxLine,
            ),
          ],
        ),
      // if(olMap[-1]?.first!=null)
      if(first!=null||last!=null)
        OddsButton(
          //type: 3,///波胆 其他
          playId: playIdConfig.hpsBold,
          name: LocaleKeys.list_other.tr,
          height: 30.w,
          width: width,
          radius: 4.w,
          match: match,
          hl: boldHps.hl.safeFirst,
          hps: boldHps,
          ol: olMap[-1]?.first,
          nameColor: const Color(0xff3AA6FC),
        ).marginOnly(top: 2.w)
      ],
    );
  }
}
