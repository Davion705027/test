
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_map_operate.dart';
import '../../../../../global/data_store_controller.dart';
import '../../../../../services/models/res/match_entity.dart';
import '../../../../login/login_head_import.dart';
import '../../../controllers/home_controller.dart';
import '../../../models/play_info.dart';
import 'bodan/bodan_widget.dart';
import 'corner_play_temp.dart';
import 'package:flutter_ty_app/app/modules/home/logic/other_player_name_to_playid.dart';

import 'feature/feature_temp.dart';

class buildBodyWidget extends StatelessWidget {
  final match;
  final PlayInfo playInfo;
  final bool isMoreSelect;
  final bool isSelect;
  final String mid;

  buildBodyWidget({
    super.key,
    required this.match,
    required this.playInfo,
    required this.mid,
    this.isSelect = false,
    this.isMoreSelect = false,
  });

 
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetBuilder<HomeController>(
        id: DataStoreController.to.getMatchId(mid),
        builder: (controller) {
          return Column(
            children: [_buildBody(match)],
          );
        });
  }

  /// 晋级赛 1005      hpsOutright 1006    hpsCorner 1001
  /// 5分钟玩法 1009      15分钟玩法 1007    波胆 1008
  /// 特色组合 1010      罚牌 1003    加时赛 1002
  /// 点球大战 1004  十个

  Widget _buildBody(
      MatchEntity match,
      ) {
    if (playInfo.playId.isEmpty ||
        (isMoreSelect == false && isSelect == false)) {
      return const SizedBox();
    } else {
      /// 角球1001 加时赛1002 罚牌1003 点球大赛1004 晋级1005 冠军1006 15分钟 1007 波胆 1008 特色组合 1010
      ///
      /// 角球

      ///角球
      if (match.cosCorner && playInfo.playId == playIdConfig.hpsCorner) {
        return CornerPlayTemp(
          key: ValueKey(playInfo.playId + mid),
          match: match,
          hps: match.hpsCorner,
          playId: playInfo.playId,
          isMainPlay: false,
        );
      }

      ///15分钟
      if (match.cos15Minutes &&
          playInfo.playId == playIdConfig.hps15Minutes) {
        return CornerPlayTemp(
          key: ValueKey(playInfo.playId + mid),
          match: match,
          hps: match.hps15Minutes,
          playId: playInfo.playId,
          isMainPlay: false,
        );
      }

      ///罚牌
      if (match.cosPunish && playInfo.playId == playIdConfig.hpsPunish) {
        return CornerPlayTemp(
          key: ValueKey(playInfo.playId + mid),
          match: match,
          hps: match.hpsPunish,
          playId: playInfo.playId,
          isMainPlay: false,
        );
      }

      ///波胆
      if (match.cosBold && playInfo.playId == playIdConfig.hpsBold) {
        return BoDanWidget(
          key: ValueKey(playInfo.playId + mid),
          match: match,
          hps: match.hpsBold,
        );
      }

      ///特色组合
      if (match.compose && playInfo.playId == playIdConfig.hpsCompose) {
        return FeatureTemp(
          key: ValueKey(playInfo.playId + mid),
          matchEntity: match,
          hps: match.hpsCompose,
        );
      }

      /// 晋级1005
      if (match.cosPromotion &&
          playInfo.playId == playIdConfig.hpsPromotion) {
        return CornerPlayTemp(
          key: ValueKey(playInfo.playId + mid),
          match: match,
          hps: match.hpsPromotion,
          playId: playInfo.playId,
          isMainPlay: false,
        );
      }

      ///冠军
      if (match.cosOutright &&
          playInfo.playId == playIdConfig.hpsOutright) {
        return CornerPlayTemp(
          key: ValueKey(playInfo.playId + mid),
          match: match,
          hps: match.hpsOutright,
          playId: playInfo.playId,
          isMainPlay: false,
        );
      }

      ///加时赛
      if (match.cosOvertime &&
          playInfo.playId == playIdConfig.hpsOvertime) {
        return CornerPlayTemp(
          key: ValueKey(playInfo.playId + mid),
          match: match,
          hps: match.hpsOvertime,
          playId: playInfo.playId,
          isMainPlay: false,
        );
      }

      ///点球大战
      if (match.cosPenalty &&
          playInfo.playId == playIdConfig.hpsPenalty) {
        return CornerPlayTemp(
          key: ValueKey(playInfo.playId + mid),
          match: match,
          hps: match.hpsPenalty,
          playId: playInfo.playId,
          isMainPlay: false,
        );
      }
    }
    return SizedBox();
  }
}