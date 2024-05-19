import 'dart:convert';

import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/vr_sport_replay_entity.g.dart';

export 'package:flutter_ty_app/generated/json/vr_sport_replay_entity.g.dart';

@JsonSerializable()
class VrSportReplayEntity {
  dynamic lod;
  dynamic mmp;
  late String no = '';
  late String batchNo = '';
  late String nextBatchNo = '';
  late String nextTime = '';
  late int nextNo = 0;
  late Map<String, VrSportReplayDetailValue>? detail = {};
  late List<MatchEntity> matchs = [];

  VrSportReplayEntity();

  factory VrSportReplayEntity.fromJson(Map<String, dynamic> json) =>
      $VrSportReplayEntityFromJson(json);

  Map<String, dynamic> toJson() => $VrSportReplayEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class VrSportReplayDetailValue {
  late String csid = '';
  late List<VrSportReplayDetailScoreRanking> list = [];
  late String mgt = '';
  late String mid = '';
  late String thirdMatchVideoUrl = '';
  late String totalTime = '';

  @JSONField(
    serialize: false,
    deserialize: false, /* copyWith: false*/
  )
  int curScoreIndex = -1;

  VrSportReplayDetailValue();

  factory VrSportReplayDetailValue.fromJson(Map<String, dynamic> json) =>
      $VrSportReplayDetailValueFromJson(json);

  Map<String, dynamic> toJson() => $VrSportReplayDetailValueToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class VrSportReplayDetailScoreRanking {
  late String away = '';
  late String awayName = '';
  late String home = '';
  late String homeName = '';
  late String time = '';
  late String updateTime = '';

  // 赛马赛狗赛车排名字段
  late String ranking1 = '1';
  late String ranking2 = '2';
  late String ranking3 = '3';
  late String ranking4 = '4';
  late String ranking5 = '5';
  late String ranking6 = '6';

  VrSportReplayDetailScoreRanking();

  factory VrSportReplayDetailScoreRanking.fromJson(Map<String, dynamic> json) =>
      $VrSportReplayDetailScoreRankingFromJson(json);

  Map<String, dynamic> toJson() => $VrSportReplayDetailScoreRankingToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
