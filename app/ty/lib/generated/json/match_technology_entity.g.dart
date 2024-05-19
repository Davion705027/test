import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/match_technology_entity.dart';

MatchTechnologyEntity $MatchTechnologyEntityFromJson(
    Map<String, dynamic> json) {
  final MatchTechnologyEntity matchTechnologyEntity = MatchTechnologyEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    matchTechnologyEntity.code = code;
  }
  final MatchTechnologyData? data = jsonConvert.convert<MatchTechnologyData>(
      json['data']);
  if (data != null) {
    matchTechnologyEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    matchTechnologyEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    matchTechnologyEntity.ts = ts;
  }
  return matchTechnologyEntity;
}

Map<String, dynamic> $MatchTechnologyEntityToJson(
    MatchTechnologyEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data?.toJson();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension MatchTechnologyEntityExtension on MatchTechnologyEntity {
  MatchTechnologyEntity copyWith({
    String? code,
    MatchTechnologyData? data,
    String? msg,
    int? ts,
  }) {
    return MatchTechnologyEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

MatchTechnologyData $MatchTechnologyDataFromJson(Map<String, dynamic> json) {
  final MatchTechnologyData matchTechnologyData = MatchTechnologyData();
  final MatchTechnologyDataInParam? inParam = jsonConvert.convert<
      MatchTechnologyDataInParam>(json['inParam']);
  if (inParam != null) {
    matchTechnologyData.inParam = inParam;
  }
  final MatchTechnologyDataHomeAwayGoalAndCoachMap? homeAwayGoalAndCoachMap = jsonConvert
      .convert<MatchTechnologyDataHomeAwayGoalAndCoachMap>(
      json['homeAwayGoalAndCoachMap']);
  if (homeAwayGoalAndCoachMap != null) {
    matchTechnologyData.homeAwayGoalAndCoachMap = homeAwayGoalAndCoachMap;
  }
  return matchTechnologyData;
}

Map<String, dynamic> $MatchTechnologyDataToJson(MatchTechnologyData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['inParam'] = entity.inParam?.toJson();
  data['homeAwayGoalAndCoachMap'] = entity.homeAwayGoalAndCoachMap?.toJson();
  return data;
}

extension MatchTechnologyDataExtension on MatchTechnologyData {
  MatchTechnologyData copyWith({
    MatchTechnologyDataInParam? inParam,
    MatchTechnologyDataHomeAwayGoalAndCoachMap? homeAwayGoalAndCoachMap,
  }) {
    return MatchTechnologyData()
      ..inParam = inParam ?? this.inParam
      ..homeAwayGoalAndCoachMap = homeAwayGoalAndCoachMap ??
          this.homeAwayGoalAndCoachMap;
  }
}

MatchTechnologyDataInParam $MatchTechnologyDataInParamFromJson(
    Map<String, dynamic> json) {
  final MatchTechnologyDataInParam matchTechnologyDataInParam = MatchTechnologyDataInParam();
  final dynamic historyAddition = json['historyAddition'];
  if (historyAddition != null) {
    matchTechnologyDataInParam.historyAddition = historyAddition;
  }
  final dynamic histroyQueryMatchSize = json['histroyQueryMatchSize'];
  if (histroyQueryMatchSize != null) {
    matchTechnologyDataInParam.histroyQueryMatchSize = histroyQueryMatchSize;
  }
  final dynamic homeNearAddition = json['homeNearAddition'];
  if (homeNearAddition != null) {
    matchTechnologyDataInParam.homeNearAddition = homeNearAddition;
  }
  final dynamic homeNearMatchSize = json['homeNearMatchSize'];
  if (homeNearMatchSize != null) {
    matchTechnologyDataInParam.homeNearMatchSize = homeNearMatchSize;
  }
  final String? lang = jsonConvert.convert<String>(json['lang']);
  if (lang != null) {
    matchTechnologyDataInParam.lang = lang;
  }
  final int? parentMenuId = jsonConvert.convert<int>(json['parentMenuId']);
  if (parentMenuId != null) {
    matchTechnologyDataInParam.parentMenuId = parentMenuId;
  }
  final int? sonMenuId = jsonConvert.convert<int>(json['sonMenuId']);
  if (sonMenuId != null) {
    matchTechnologyDataInParam.sonMenuId = sonMenuId;
  }
  final String? standardMatchId = jsonConvert.convert<String>(
      json['standardMatchId']);
  if (standardMatchId != null) {
    matchTechnologyDataInParam.standardMatchId = standardMatchId;
  }
  return matchTechnologyDataInParam;
}

Map<String, dynamic> $MatchTechnologyDataInParamToJson(
    MatchTechnologyDataInParam entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['historyAddition'] = entity.historyAddition;
  data['histroyQueryMatchSize'] = entity.histroyQueryMatchSize;
  data['homeNearAddition'] = entity.homeNearAddition;
  data['homeNearMatchSize'] = entity.homeNearMatchSize;
  data['lang'] = entity.lang;
  data['parentMenuId'] = entity.parentMenuId;
  data['sonMenuId'] = entity.sonMenuId;
  data['standardMatchId'] = entity.standardMatchId;
  return data;
}

extension MatchTechnologyDataInParamExtension on MatchTechnologyDataInParam {
  MatchTechnologyDataInParam copyWith({
    dynamic historyAddition,
    dynamic histroyQueryMatchSize,
    dynamic homeNearAddition,
    dynamic homeNearMatchSize,
    String? lang,
    int? parentMenuId,
    int? sonMenuId,
    String? standardMatchId,
  }) {
    return MatchTechnologyDataInParam()
      ..historyAddition = historyAddition ?? this.historyAddition
      ..histroyQueryMatchSize = histroyQueryMatchSize ??
          this.histroyQueryMatchSize
      ..homeNearAddition = homeNearAddition ?? this.homeNearAddition
      ..homeNearMatchSize = homeNearMatchSize ?? this.homeNearMatchSize
      ..lang = lang ?? this.lang
      ..parentMenuId = parentMenuId ?? this.parentMenuId
      ..sonMenuId = sonMenuId ?? this.sonMenuId
      ..standardMatchId = standardMatchId ?? this.standardMatchId;
  }
}

MatchTechnologyDataHomeAwayGoalAndCoachMap $MatchTechnologyDataHomeAwayGoalAndCoachMapFromJson(
    Map<String, dynamic> json) {
  final MatchTechnologyDataHomeAwayGoalAndCoachMap matchTechnologyDataHomeAwayGoalAndCoachMap = MatchTechnologyDataHomeAwayGoalAndCoachMap();
  final MatchTechnologyDataHomeAwayGoalAndCoachMapHomeGoalMap? homeGoalMap = jsonConvert
      .convert<MatchTechnologyDataHomeAwayGoalAndCoachMapHomeGoalMap>(
      json['homeGoalMap']);
  if (homeGoalMap != null) {
    matchTechnologyDataHomeAwayGoalAndCoachMap.homeGoalMap = homeGoalMap;
  }
  final MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap? sThirdMatchCoachDTOMap = jsonConvert
      .convert<
      MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap>(
      json['sThirdMatchCoachDTOMap']);
  if (sThirdMatchCoachDTOMap != null) {
    matchTechnologyDataHomeAwayGoalAndCoachMap.sThirdMatchCoachDTOMap =
        sThirdMatchCoachDTOMap;
  }
  final MatchTechnologyDataHomeAwayGoalAndCoachMapAwayGoalMap? awayGoalMap = jsonConvert
      .convert<MatchTechnologyDataHomeAwayGoalAndCoachMapAwayGoalMap>(
      json['awayGoalMap']);
  if (awayGoalMap != null) {
    matchTechnologyDataHomeAwayGoalAndCoachMap.awayGoalMap = awayGoalMap;
  }
  return matchTechnologyDataHomeAwayGoalAndCoachMap;
}

Map<String, dynamic> $MatchTechnologyDataHomeAwayGoalAndCoachMapToJson(
    MatchTechnologyDataHomeAwayGoalAndCoachMap entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['homeGoalMap'] = entity.homeGoalMap?.toJson();
  data['sThirdMatchCoachDTOMap'] = entity.sThirdMatchCoachDTOMap?.toJson();
  data['awayGoalMap'] = entity.awayGoalMap?.toJson();
  return data;
}

extension MatchTechnologyDataHomeAwayGoalAndCoachMapExtension on MatchTechnologyDataHomeAwayGoalAndCoachMap {
  MatchTechnologyDataHomeAwayGoalAndCoachMap copyWith({
    MatchTechnologyDataHomeAwayGoalAndCoachMapHomeGoalMap? homeGoalMap,
    MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap? sThirdMatchCoachDTOMap,
    MatchTechnologyDataHomeAwayGoalAndCoachMapAwayGoalMap? awayGoalMap,
  }) {
    return MatchTechnologyDataHomeAwayGoalAndCoachMap()
      ..homeGoalMap = homeGoalMap ?? this.homeGoalMap
      ..sThirdMatchCoachDTOMap = sThirdMatchCoachDTOMap ??
          this.sThirdMatchCoachDTOMap
      ..awayGoalMap = awayGoalMap ?? this.awayGoalMap;
  }
}

MatchTechnologyDataHomeAwayGoalAndCoachMapHomeGoalMap $MatchTechnologyDataHomeAwayGoalAndCoachMapHomeGoalMapFromJson(
    Map<String, dynamic> json) {
  final MatchTechnologyDataHomeAwayGoalAndCoachMapHomeGoalMap matchTechnologyDataHomeAwayGoalAndCoachMapHomeGoalMap = MatchTechnologyDataHomeAwayGoalAndCoachMapHomeGoalMap();
  return matchTechnologyDataHomeAwayGoalAndCoachMapHomeGoalMap;
}

Map<String,
    dynamic> $MatchTechnologyDataHomeAwayGoalAndCoachMapHomeGoalMapToJson(
    MatchTechnologyDataHomeAwayGoalAndCoachMapHomeGoalMap entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  return data;
}

extension MatchTechnologyDataHomeAwayGoalAndCoachMapHomeGoalMapExtension on MatchTechnologyDataHomeAwayGoalAndCoachMapHomeGoalMap {
}

MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap $MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMapFromJson(
    Map<String, dynamic> json) {
  final MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap matchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap = MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap();
  final List<
      MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap1>? x1 = (json['1'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<
          MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap1>(
          e) as MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap1)
      .toList();
  if (x1 != null) {
    matchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap.x1 = x1;
  }
  final List<
      MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap2>? x2 = (json['2'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<
          MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap2>(
          e) as MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap2)
      .toList();
  if (x2 != null) {
    matchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap.x2 = x2;
  }
  return matchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap;
}

Map<String,
    dynamic> $MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMapToJson(
    MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['1'] = entity.x1?.map((v) => v.toJson()).toList();
  data['2'] = entity.x2?.map((v) => v.toJson()).toList();
  return data;
}

extension MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMapExtension on MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap {
  MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap copyWith({
    List<MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap1>? x1,
    List<MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap2>? x2,
  }) {
    return MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap()
      ..x1 = x1 ?? this.x1
      ..x2 = x2 ?? this.x2;
  }
}

MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap1 $MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap1FromJson(
    Map<String, dynamic> json) {
  final MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap1 matchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap1 = MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap1();
  final String? coachBirthdate = jsonConvert.convert<String>(
      json['coachBirthdate']);
  if (coachBirthdate != null) {
    matchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap1
        .coachBirthdate = coachBirthdate;
  }
  final dynamic coachGameCount = json['coachGameCount'];
  if (coachGameCount != null) {
    matchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap1
        .coachGameCount = coachGameCount;
  }
  final String? coachName = jsonConvert.convert<String>(json['coachName']);
  if (coachName != null) {
    matchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap1
        .coachName = coachName;
  }
  final String? coachStyle = jsonConvert.convert<String>(json['coachStyle']);
  if (coachStyle != null) {
    matchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap1
        .coachStyle = coachStyle;
  }
  final int? drawCount = jsonConvert.convert<int>(json['drawCount']);
  if (drawCount != null) {
    matchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap1
        .drawCount = drawCount;
  }
  final int? homeAway = jsonConvert.convert<int>(json['homeAway']);
  if (homeAway != null) {
    matchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap1.homeAway =
        homeAway;
  }
  final int? loseCount = jsonConvert.convert<int>(json['loseCount']);
  if (loseCount != null) {
    matchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap1
        .loseCount = loseCount;
  }
  final String? score = jsonConvert.convert<String>(json['score']);
  if (score != null) {
    matchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap1.score =
        score;
  }
  final int? winCount = jsonConvert.convert<int>(json['winCount']);
  if (winCount != null) {
    matchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap1.winCount =
        winCount;
  }
  return matchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap1;
}

Map<String,
    dynamic> $MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap1ToJson(
    MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap1 entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['coachBirthdate'] = entity.coachBirthdate;
  data['coachGameCount'] = entity.coachGameCount;
  data['coachName'] = entity.coachName;
  data['coachStyle'] = entity.coachStyle;
  data['drawCount'] = entity.drawCount;
  data['homeAway'] = entity.homeAway;
  data['loseCount'] = entity.loseCount;
  data['score'] = entity.score;
  data['winCount'] = entity.winCount;
  return data;
}

extension MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap1Extension on MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap1 {
  MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap1 copyWith({
    String? coachBirthdate,
    dynamic coachGameCount,
    String? coachName,
    String? coachStyle,
    int? drawCount,
    int? homeAway,
    int? loseCount,
    String? score,
    int? winCount,
  }) {
    return MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap1()
      ..coachBirthdate = coachBirthdate ?? this.coachBirthdate
      ..coachGameCount = coachGameCount ?? this.coachGameCount
      ..coachName = coachName ?? this.coachName
      ..coachStyle = coachStyle ?? this.coachStyle
      ..drawCount = drawCount ?? this.drawCount
      ..homeAway = homeAway ?? this.homeAway
      ..loseCount = loseCount ?? this.loseCount
      ..score = score ?? this.score
      ..winCount = winCount ?? this.winCount;
  }
}

MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap2 $MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap2FromJson(
    Map<String, dynamic> json) {
  final MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap2 matchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap2 = MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap2();
  final String? coachBirthdate = jsonConvert.convert<String>(
      json['coachBirthdate']);
  if (coachBirthdate != null) {
    matchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap2
        .coachBirthdate = coachBirthdate;
  }
  final dynamic coachGameCount = json['coachGameCount'];
  if (coachGameCount != null) {
    matchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap2
        .coachGameCount = coachGameCount;
  }
  final String? coachName = jsonConvert.convert<String>(json['coachName']);
  if (coachName != null) {
    matchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap2
        .coachName = coachName;
  }
  final String? coachStyle = jsonConvert.convert<String>(json['coachStyle']);
  if (coachStyle != null) {
    matchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap2
        .coachStyle = coachStyle;
  }
  final int? drawCount = jsonConvert.convert<int>(json['drawCount']);
  if (drawCount != null) {
    matchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap2
        .drawCount = drawCount;
  }
  final int? homeAway = jsonConvert.convert<int>(json['homeAway']);
  if (homeAway != null) {
    matchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap2.homeAway =
        homeAway;
  }
  final int? loseCount = jsonConvert.convert<int>(json['loseCount']);
  if (loseCount != null) {
    matchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap2
        .loseCount = loseCount;
  }
  final String? score = jsonConvert.convert<String>(json['score']);
  if (score != null) {
    matchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap2.score =
        score;
  }
  final int? winCount = jsonConvert.convert<int>(json['winCount']);
  if (winCount != null) {
    matchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap2.winCount =
        winCount;
  }
  return matchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap2;
}

Map<String,
    dynamic> $MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap2ToJson(
    MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap2 entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['coachBirthdate'] = entity.coachBirthdate;
  data['coachGameCount'] = entity.coachGameCount;
  data['coachName'] = entity.coachName;
  data['coachStyle'] = entity.coachStyle;
  data['drawCount'] = entity.drawCount;
  data['homeAway'] = entity.homeAway;
  data['loseCount'] = entity.loseCount;
  data['score'] = entity.score;
  data['winCount'] = entity.winCount;
  return data;
}

extension MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap2Extension on MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap2 {
  MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap2 copyWith({
    String? coachBirthdate,
    dynamic coachGameCount,
    String? coachName,
    String? coachStyle,
    int? drawCount,
    int? homeAway,
    int? loseCount,
    String? score,
    int? winCount,
  }) {
    return MatchTechnologyDataHomeAwayGoalAndCoachMapSThirdMatchCoachDTOMap2()
      ..coachBirthdate = coachBirthdate ?? this.coachBirthdate
      ..coachGameCount = coachGameCount ?? this.coachGameCount
      ..coachName = coachName ?? this.coachName
      ..coachStyle = coachStyle ?? this.coachStyle
      ..drawCount = drawCount ?? this.drawCount
      ..homeAway = homeAway ?? this.homeAway
      ..loseCount = loseCount ?? this.loseCount
      ..score = score ?? this.score
      ..winCount = winCount ?? this.winCount;
  }
}

MatchTechnologyDataHomeAwayGoalAndCoachMapAwayGoalMap $MatchTechnologyDataHomeAwayGoalAndCoachMapAwayGoalMapFromJson(
    Map<String, dynamic> json) {
  final MatchTechnologyDataHomeAwayGoalAndCoachMapAwayGoalMap matchTechnologyDataHomeAwayGoalAndCoachMapAwayGoalMap = MatchTechnologyDataHomeAwayGoalAndCoachMapAwayGoalMap();
  return matchTechnologyDataHomeAwayGoalAndCoachMapAwayGoalMap;
}

Map<String,
    dynamic> $MatchTechnologyDataHomeAwayGoalAndCoachMapAwayGoalMapToJson(
    MatchTechnologyDataHomeAwayGoalAndCoachMapAwayGoalMap entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  return data;
}

extension MatchTechnologyDataHomeAwayGoalAndCoachMapAwayGoalMapExtension on MatchTechnologyDataHomeAwayGoalAndCoachMapAwayGoalMap {
}