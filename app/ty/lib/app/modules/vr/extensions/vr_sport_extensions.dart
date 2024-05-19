import 'package:flutter/cupertino.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_match_entity.dart';
import 'package:get/get.dart';

extension DiffSeconds on MatchEntity? {
  int get diffSeconds {
    if (this == null) return 0;
    debugPrint('this!.mgt: ${this!.mgt}');
    final beginSeconds = ((int.tryParse(this!.mgt) ?? 0) / 1000);
    final nowSeconds = DateTime.now().millisecondsSinceEpoch / 1000;
    int diffSeconds = (beginSeconds - nowSeconds).round();
    debugPrint('diffSeconds: $diffSeconds');
    return diffSeconds;
  }

  bool get didMatchBegin {
    final mgt = this?.mgt ?? '';
    if (mgt.isEmpty) return false;
    final endSeconds = ((int.tryParse(mgt) ?? 0) / 1000);
    final nowSeconds = DateTime.now().millisecondsSinceEpoch / 1000;
    return nowSeconds >= endSeconds;
  }
}

extension DogHorseCarBettingData on MatchEntity? {
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

extension TeamMidData on VrMatchEntity? {
  List<List<String>> get matchTeams =>
      this?.matchs.map((e) => e.teams).toList() ?? [];
  List<String> get matchMhlus =>
      this?.matchs.map((e) => e.mhlu as String? ?? '').toList() ?? [];
  List<String> get matchMalus =>
      this?.matchs.map((e) => e.malu as String? ?? '').toList() ?? [];

  List<String> get matchMids => this?.matchs.map((e) => e.mid).toList() ?? [];
}

extension BallsBettingHpns on VrMatchEntity? {
  List<String> get hpns {
    var hpns = this?.matchs.firstOrNull?.hps.map((e) => e.hpn).toList() ?? [];
    if (hpns.length > 3) {
      hpns = hpns.sublist(0, 3);
    }
    return hpns;
  }
}
