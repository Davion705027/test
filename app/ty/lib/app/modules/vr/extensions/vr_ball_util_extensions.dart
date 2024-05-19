import 'package:flutter/cupertino.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_match_entity.dart';
import 'package:get/get.dart';

extension VrMatchDidNewBegin on VrMatchEntity? {
  String get mgt =>
      this?.matchs.firstWhereOrNull((element) => element.mgt.isNotEmpty)?.mgt ??
      '';

  bool get didMatchBegin {
    return this
            ?.matchs
            .firstWhereOrNull((element) => element.mgt.isNotEmpty)
            ?.didMatchBegin ??
        false;
  }

  bool didMatchNewBeginWith(int type) {
    if (type == 2) return inNewGame || didMatchBegin;
    return didMatchBegin;
  }

  bool get inNewGame {
    if (this?.lod == 'INGAME') return true;
    return false;
  }
}

extension DiffBallNewSeconds on MatchEntity? {
  int get diffBallSeconds {
    if (this == null) return 0;
    final beginSeconds = ((int.tryParse(this!.mgt) ?? 0) / 1000);
    final nowSeconds = DateTime.now().millisecondsSinceEpoch / 1000;
    int diffSeconds = (beginSeconds - nowSeconds).round();
    debugPrint('diffSeconds: $diffSeconds');
    return diffSeconds;
  }

  bool get didMatchBegin {
    final mgt = this?.mgt ?? '';
    if (mgt.isEmpty) return false;
    final endMilliseconds = int.tryParse(mgt) ?? 0;
    final nowMilliseconds = DateTime.now().millisecondsSinceEpoch;
    // 提前 500 毫秒
    return nowMilliseconds - 500 >= endMilliseconds;
  }

  MatchHps? get championHps =>
      this?.hps.firstWhereOrNull((element) => element.hpn == '冠军');
  List<MatchHpsHlOl> get championOls => championHps?.hl.firstOrNull?.ol ?? [];

  MatchHps? get topTwoHps =>
      this?.hps.firstWhereOrNull((element) => element.hpn == '前二');
  List<MatchHpsHlOl> get topTwoOls => topTwoHps?.hl.firstOrNull?.ol ?? [];

  MatchHps? get topThreeHps =>
      this?.hps.firstWhereOrNull((element) => element.hpn == '前三');
  List<MatchHpsHlOl> get topThreeOls => topThreeHps?.hl.firstOrNull?.ol ?? [];

  MatchHps? get oddEvenHps =>
      this?.hps.firstWhereOrNull((element) => element.hpn == '单/双');
  List<MatchHpsHlOl> get oddEvenOls => oddEvenHps?.hl.firstOrNull?.ol ?? [];

  MatchHps? get sizeHps =>
      this?.hps.firstWhereOrNull((element) => element.hpn == '大/小');
  List<MatchHpsHlOl> get sizeOls => sizeHps?.hl.firstOrNull?.ol ?? [];
}

extension BettingNewData on VrMatchEntity? {
  List<List<String>> get matchTeams =>
      this?.matchs.map((e) => e.teams).toList() ?? [];
  List<String> get matchMhlus =>
      this?.matchs.map((e) => e.mhlu as String? ?? '').toList() ?? [];
  List<String> get matchMalus =>
      this?.matchs.map((e) => e.malu as String? ?? '').toList() ?? [];

  List<String> get matchMids => this?.matchs.map((e) => e.mid).toList() ?? [];
}

extension OlOvNewStr on MatchHpsHlOl? {
  String get ovStr {
    const divisor = 100000;
    final ovValue = this?.ov ?? 0;
    double result = ovValue / divisor;
    String ovStr;
    if (result >= 100) {
      ovStr = result.toStringAsFixed(0);
    } else if (result >= 10) {
      ovStr = result.toStringAsFixed(1);
    } else {
      ovStr = result.toStringAsFixed(2);
    }
    debugPrint('ovStr: $ovStr');
    return ovStr;
  }
}
