import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_sport_replay_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';


VrSportReplayEntity $VrSportReplayEntityFromJson(Map<String, dynamic> json) {
  final VrSportReplayEntity vrSportReplayEntity = VrSportReplayEntity();
  final dynamic lod = json['lod'];
  if (lod != null) {
    vrSportReplayEntity.lod = lod;
  }
  final dynamic mmp = json['mmp'];
  if (mmp != null) {
    vrSportReplayEntity.mmp = mmp;
  }
  final String? no = jsonConvert.convert<String>(json['no']);
  if (no != null) {
    vrSportReplayEntity.no = no;
  }
  final String? batchNo = jsonConvert.convert<String>(json['batchNo']);
  if (batchNo != null) {
    vrSportReplayEntity.batchNo = batchNo;
  }
  final String? nextBatchNo = jsonConvert.convert<String>(json['nextBatchNo']);
  if (nextBatchNo != null) {
    vrSportReplayEntity.nextBatchNo = nextBatchNo;
  }
  final String? nextTime = jsonConvert.convert<String>(json['nextTime']);
  if (nextTime != null) {
    vrSportReplayEntity.nextTime = nextTime;
  }
  final int? nextNo = jsonConvert.convert<int>(json['nextNo']);
  if (nextNo != null) {
    vrSportReplayEntity.nextNo = nextNo;
  }
  final Map<String, VrSportReplayDetailValue>? detail =
  (json['detail'] as Map<String, dynamic>?)?.map(
          (k, e) => MapEntry(k, jsonConvert.convert<VrSportReplayDetailValue>(
          e) as VrSportReplayDetailValue));
  if (detail != null) {
    vrSportReplayEntity.detail = detail;
  }
  final List<MatchEntity>? matchs = (json['matchs'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<MatchEntity>(e) as MatchEntity).toList();
  if (matchs != null) {
    vrSportReplayEntity.matchs = matchs;
  }
  return vrSportReplayEntity;
}

Map<String, dynamic> $VrSportReplayEntityToJson(VrSportReplayEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['lod'] = entity.lod;
  data['mmp'] = entity.mmp;
  data['no'] = entity.no;
  data['batchNo'] = entity.batchNo;
  data['nextBatchNo'] = entity.nextBatchNo;
  data['nextTime'] = entity.nextTime;
  data['nextNo'] = entity.nextNo;
  data['detail'] = entity.detail;
  data['matchs'] = entity.matchs.map((v) => v.toJson()).toList();
  return data;
}

extension VrSportReplayEntityExtension on VrSportReplayEntity {
  VrSportReplayEntity copyWith({
    dynamic lod,
    dynamic mmp,
    String? no,
    String? batchNo,
    String? nextBatchNo,
    String? nextTime,
    int? nextNo,
    Map<String, VrSportReplayDetailValue>? detail,
    List<MatchEntity>? matchs,
  }) {
    return VrSportReplayEntity()
      ..lod = lod ?? this.lod
      ..mmp = mmp ?? this.mmp
      ..no = no ?? this.no
      ..batchNo = batchNo ?? this.batchNo
      ..nextBatchNo = nextBatchNo ?? this.nextBatchNo
      ..nextTime = nextTime ?? this.nextTime
      ..nextNo = nextNo ?? this.nextNo
      ..detail = detail ?? this.detail
      ..matchs = matchs ?? this.matchs;
  }
}

VrSportReplayDetailValue $VrSportReplayDetailValueFromJson(
    Map<String, dynamic> json) {
  final VrSportReplayDetailValue vrSportReplayDetailValue = VrSportReplayDetailValue();
  final String? csid = jsonConvert.convert<String>(json['csid']);
  if (csid != null) {
    vrSportReplayDetailValue.csid = csid;
  }
  final List<VrSportReplayDetailScoreRanking>? list = (json['list'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<VrSportReplayDetailScoreRanking>(
          e) as VrSportReplayDetailScoreRanking).toList();
  if (list != null) {
    vrSportReplayDetailValue.list = list;
  }
  final String? mgt = jsonConvert.convert<String>(json['mgt']);
  if (mgt != null) {
    vrSportReplayDetailValue.mgt = mgt;
  }
  final String? mid = jsonConvert.convert<String>(json['mid']);
  if (mid != null) {
    vrSportReplayDetailValue.mid = mid;
  }
  final String? thirdMatchVideoUrl = jsonConvert.convert<String>(
      json['thirdMatchVideoUrl']);
  if (thirdMatchVideoUrl != null) {
    vrSportReplayDetailValue.thirdMatchVideoUrl = thirdMatchVideoUrl;
  }
  final String? totalTime = jsonConvert.convert<String>(json['totalTime']);
  if (totalTime != null) {
    vrSportReplayDetailValue.totalTime = totalTime;
  }
  return vrSportReplayDetailValue;
}

Map<String, dynamic> $VrSportReplayDetailValueToJson(
    VrSportReplayDetailValue entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['csid'] = entity.csid;
  data['list'] = entity.list.map((v) => v.toJson()).toList();
  data['mgt'] = entity.mgt;
  data['mid'] = entity.mid;
  data['thirdMatchVideoUrl'] = entity.thirdMatchVideoUrl;
  data['totalTime'] = entity.totalTime;
  return data;
}

extension VrSportReplayDetailValueExtension on VrSportReplayDetailValue {
  VrSportReplayDetailValue copyWith({
    String? csid,
    List<VrSportReplayDetailScoreRanking>? list,
    String? mgt,
    String? mid,
    String? thirdMatchVideoUrl,
    String? totalTime,
    int? curScoreIndex,
  }) {
    return VrSportReplayDetailValue()
      ..csid = csid ?? this.csid
      ..list = list ?? this.list
      ..mgt = mgt ?? this.mgt
      ..mid = mid ?? this.mid
      ..thirdMatchVideoUrl = thirdMatchVideoUrl ?? this.thirdMatchVideoUrl
      ..totalTime = totalTime ?? this.totalTime
      ..curScoreIndex = curScoreIndex ?? this.curScoreIndex;
  }
}

VrSportReplayDetailScoreRanking $VrSportReplayDetailScoreRankingFromJson(
    Map<String, dynamic> json) {
  final VrSportReplayDetailScoreRanking vrSportReplayDetailScoreRanking = VrSportReplayDetailScoreRanking();
  final String? away = jsonConvert.convert<String>(json['away']);
  if (away != null) {
    vrSportReplayDetailScoreRanking.away = away;
  }
  final String? awayName = jsonConvert.convert<String>(json['awayName']);
  if (awayName != null) {
    vrSportReplayDetailScoreRanking.awayName = awayName;
  }
  final String? home = jsonConvert.convert<String>(json['home']);
  if (home != null) {
    vrSportReplayDetailScoreRanking.home = home;
  }
  final String? homeName = jsonConvert.convert<String>(json['homeName']);
  if (homeName != null) {
    vrSportReplayDetailScoreRanking.homeName = homeName;
  }
  final String? time = jsonConvert.convert<String>(json['time']);
  if (time != null) {
    vrSportReplayDetailScoreRanking.time = time;
  }
  final String? updateTime = jsonConvert.convert<String>(json['updateTime']);
  if (updateTime != null) {
    vrSportReplayDetailScoreRanking.updateTime = updateTime;
  }
  final String? ranking1 = jsonConvert.convert<String>(json['ranking1']);
  if (ranking1 != null) {
    vrSportReplayDetailScoreRanking.ranking1 = ranking1;
  }
  final String? ranking2 = jsonConvert.convert<String>(json['ranking2']);
  if (ranking2 != null) {
    vrSportReplayDetailScoreRanking.ranking2 = ranking2;
  }
  final String? ranking3 = jsonConvert.convert<String>(json['ranking3']);
  if (ranking3 != null) {
    vrSportReplayDetailScoreRanking.ranking3 = ranking3;
  }
  final String? ranking4 = jsonConvert.convert<String>(json['ranking4']);
  if (ranking4 != null) {
    vrSportReplayDetailScoreRanking.ranking4 = ranking4;
  }
  final String? ranking5 = jsonConvert.convert<String>(json['ranking5']);
  if (ranking5 != null) {
    vrSportReplayDetailScoreRanking.ranking5 = ranking5;
  }
  final String? ranking6 = jsonConvert.convert<String>(json['ranking6']);
  if (ranking6 != null) {
    vrSportReplayDetailScoreRanking.ranking6 = ranking6;
  }
  return vrSportReplayDetailScoreRanking;
}

Map<String, dynamic> $VrSportReplayDetailScoreRankingToJson(
    VrSportReplayDetailScoreRanking entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['away'] = entity.away;
  data['awayName'] = entity.awayName;
  data['home'] = entity.home;
  data['homeName'] = entity.homeName;
  data['time'] = entity.time;
  data['updateTime'] = entity.updateTime;
  data['ranking1'] = entity.ranking1;
  data['ranking2'] = entity.ranking2;
  data['ranking3'] = entity.ranking3;
  data['ranking4'] = entity.ranking4;
  data['ranking5'] = entity.ranking5;
  data['ranking6'] = entity.ranking6;
  return data;
}

extension VrSportReplayDetailScoreRankingExtension on VrSportReplayDetailScoreRanking {
  VrSportReplayDetailScoreRanking copyWith({
    String? away,
    String? awayName,
    String? home,
    String? homeName,
    String? time,
    String? updateTime,
    String? ranking1,
    String? ranking2,
    String? ranking3,
    String? ranking4,
    String? ranking5,
    String? ranking6,
  }) {
    return VrSportReplayDetailScoreRanking()
      ..away = away ?? this.away
      ..awayName = awayName ?? this.awayName
      ..home = home ?? this.home
      ..homeName = homeName ?? this.homeName
      ..time = time ?? this.time
      ..updateTime = updateTime ?? this.updateTime
      ..ranking1 = ranking1 ?? this.ranking1
      ..ranking2 = ranking2 ?? this.ranking2
      ..ranking3 = ranking3 ?? this.ranking3
      ..ranking4 = ranking4 ?? this.ranking4
      ..ranking5 = ranking5 ?? this.ranking5
      ..ranking6 = ranking6 ?? this.ranking6;
  }
}