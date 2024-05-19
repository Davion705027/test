import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_get_match_analysise_data_item_entity.dart';

AnalyzeGetMatchAnalysiseDataItemEntity $AnalyzeGetMatchAnalysiseDataItemEntityFromJson(
    Map<String, dynamic> json) {
  final AnalyzeGetMatchAnalysiseDataItemEntity analyzeGetMatchAnalysiseDataItemEntity = AnalyzeGetMatchAnalysiseDataItemEntity();
  final AnalyzeGetMatchAnalysiseDataItemInParam? inParam = jsonConvert.convert<
      AnalyzeGetMatchAnalysiseDataItemInParam>(json['inParam']);
  if (inParam != null) {
    analyzeGetMatchAnalysiseDataItemEntity.inParam = inParam;
  }
  final AnalyzeGetMatchAnalysiseDataItemBasicInfoMap? basicInfoMap = jsonConvert
      .convert<AnalyzeGetMatchAnalysiseDataItemBasicInfoMap>(
      json['basicInfoMap']);
  if (basicInfoMap != null) {
    analyzeGetMatchAnalysiseDataItemEntity.basicInfoMap = basicInfoMap;
  }
  return analyzeGetMatchAnalysiseDataItemEntity;
}

Map<String, dynamic> $AnalyzeGetMatchAnalysiseDataItemEntityToJson(
    AnalyzeGetMatchAnalysiseDataItemEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['inParam'] = entity.inParam?.toJson();
  data['basicInfoMap'] = entity.basicInfoMap?.toJson();
  return data;
}

extension AnalyzeGetMatchAnalysiseDataItemEntityExtension on AnalyzeGetMatchAnalysiseDataItemEntity {
  AnalyzeGetMatchAnalysiseDataItemEntity copyWith({
    AnalyzeGetMatchAnalysiseDataItemInParam? inParam,
    AnalyzeGetMatchAnalysiseDataItemBasicInfoMap? basicInfoMap,
  }) {
    return AnalyzeGetMatchAnalysiseDataItemEntity()
      ..inParam = inParam ?? this.inParam
      ..basicInfoMap = basicInfoMap ?? this.basicInfoMap;
  }
}

AnalyzeGetMatchAnalysiseDataItemInParam $AnalyzeGetMatchAnalysiseDataItemInParamFromJson(
    Map<String, dynamic> json) {
  final AnalyzeGetMatchAnalysiseDataItemInParam analyzeGetMatchAnalysiseDataItemInParam = AnalyzeGetMatchAnalysiseDataItemInParam();
  final dynamic historyAddition = json['historyAddition'];
  if (historyAddition != null) {
    analyzeGetMatchAnalysiseDataItemInParam.historyAddition = historyAddition;
  }
  final dynamic histroyQueryMatchSize = json['histroyQueryMatchSize'];
  if (histroyQueryMatchSize != null) {
    analyzeGetMatchAnalysiseDataItemInParam.histroyQueryMatchSize =
        histroyQueryMatchSize;
  }
  final dynamic homeNearAddition = json['homeNearAddition'];
  if (homeNearAddition != null) {
    analyzeGetMatchAnalysiseDataItemInParam.homeNearAddition = homeNearAddition;
  }
  final dynamic homeNearMatchSize = json['homeNearMatchSize'];
  if (homeNearMatchSize != null) {
    analyzeGetMatchAnalysiseDataItemInParam.homeNearMatchSize =
        homeNearMatchSize;
  }
  final String? lang = jsonConvert.convert<String>(json['lang']);
  if (lang != null) {
    analyzeGetMatchAnalysiseDataItemInParam.lang = lang;
  }
  final int? parentMenuId = jsonConvert.convert<int>(json['parentMenuId']);
  if (parentMenuId != null) {
    analyzeGetMatchAnalysiseDataItemInParam.parentMenuId = parentMenuId;
  }
  final int? sonMenuId = jsonConvert.convert<int>(json['sonMenuId']);
  if (sonMenuId != null) {
    analyzeGetMatchAnalysiseDataItemInParam.sonMenuId = sonMenuId;
  }
  final String? standardMatchId = jsonConvert.convert<String>(
      json['standardMatchId']);
  if (standardMatchId != null) {
    analyzeGetMatchAnalysiseDataItemInParam.standardMatchId = standardMatchId;
  }
  return analyzeGetMatchAnalysiseDataItemInParam;
}

Map<String, dynamic> $AnalyzeGetMatchAnalysiseDataItemInParamToJson(
    AnalyzeGetMatchAnalysiseDataItemInParam entity) {
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

extension AnalyzeGetMatchAnalysiseDataItemInParamExtension on AnalyzeGetMatchAnalysiseDataItemInParam {
  AnalyzeGetMatchAnalysiseDataItemInParam copyWith({
    dynamic historyAddition,
    dynamic histroyQueryMatchSize,
    dynamic homeNearAddition,
    dynamic homeNearMatchSize,
    String? lang,
    int? parentMenuId,
    int? sonMenuId,
    String? standardMatchId,
  }) {
    return AnalyzeGetMatchAnalysiseDataItemInParam()
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

AnalyzeGetMatchAnalysiseDataItemBasicInfoMap $AnalyzeGetMatchAnalysiseDataItemBasicInfoMapFromJson(
    Map<String, dynamic> json) {
  final AnalyzeGetMatchAnalysiseDataItemBasicInfoMap analyzeGetMatchAnalysiseDataItemBasicInfoMap = AnalyzeGetMatchAnalysiseDataItemBasicInfoMap();
  final AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchSidelinedDTOMap? sThirdMatchSidelinedDTOMap = jsonConvert
      .convert<
      AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchSidelinedDTOMap>(
      json['sThirdMatchSidelinedDTOMap']);
  if (sThirdMatchSidelinedDTOMap != null) {
    analyzeGetMatchAnalysiseDataItemBasicInfoMap.sThirdMatchSidelinedDTOMap =
        sThirdMatchSidelinedDTOMap;
  }
  final AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap? sThirdMatchFutureStatisticsDTOMap = jsonConvert
      .convert<
      AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap>(
      json['sThirdMatchFutureStatisticsDTOMap']);
  if (sThirdMatchFutureStatisticsDTOMap != null) {
    analyzeGetMatchAnalysiseDataItemBasicInfoMap
        .sThirdMatchFutureStatisticsDTOMap = sThirdMatchFutureStatisticsDTOMap;
  }
  return analyzeGetMatchAnalysiseDataItemBasicInfoMap;
}

Map<String, dynamic> $AnalyzeGetMatchAnalysiseDataItemBasicInfoMapToJson(
    AnalyzeGetMatchAnalysiseDataItemBasicInfoMap entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['sThirdMatchSidelinedDTOMap'] =
      entity.sThirdMatchSidelinedDTOMap?.toJson();
  data['sThirdMatchFutureStatisticsDTOMap'] =
      entity.sThirdMatchFutureStatisticsDTOMap?.toJson();
  return data;
}

extension AnalyzeGetMatchAnalysiseDataItemBasicInfoMapExtension on AnalyzeGetMatchAnalysiseDataItemBasicInfoMap {
  AnalyzeGetMatchAnalysiseDataItemBasicInfoMap copyWith({
    AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchSidelinedDTOMap? sThirdMatchSidelinedDTOMap,
    AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap? sThirdMatchFutureStatisticsDTOMap,
  }) {
    return AnalyzeGetMatchAnalysiseDataItemBasicInfoMap()
      ..sThirdMatchSidelinedDTOMap = sThirdMatchSidelinedDTOMap ??
          this.sThirdMatchSidelinedDTOMap
      ..sThirdMatchFutureStatisticsDTOMap = sThirdMatchFutureStatisticsDTOMap ??
          this.sThirdMatchFutureStatisticsDTOMap;
  }
}

AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchSidelinedDTOMap $AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchSidelinedDTOMapFromJson(
    Map<String, dynamic> json) {
  final AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchSidelinedDTOMap analyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchSidelinedDTOMap = AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchSidelinedDTOMap();
  return analyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchSidelinedDTOMap;
}

Map<String,
    dynamic> $AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchSidelinedDTOMapToJson(
    AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchSidelinedDTOMap entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  return data;
}

extension AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchSidelinedDTOMapExtension on AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchSidelinedDTOMap {
}

AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap $AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMapFromJson(
    Map<String, dynamic> json) {
  final AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap analyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap = AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap();
  final List<
      AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap1>? x1 = (json['1'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<
          AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap1>(
          e) as AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap1)
      .toList();
  if (x1 != null) {
    analyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap
        .x1 = x1;
  }
  final List<
      AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap2>? x2 = (json['2'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<
          AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap2>(
          e) as AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap2)
      .toList();
  if (x2 != null) {
    analyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap
        .x2 = x2;
  }
  return analyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap;
}

Map<String,
    dynamic> $AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMapToJson(
    AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['1'] = entity.x1?.map((v) => v.toJson()).toList();
  data['2'] = entity.x2?.map((v) => v.toJson()).toList();
  return data;
}

extension AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMapExtension on AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap {
  AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap copyWith(
      {
        List<
            AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap1>? x1,
        List<
            AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap2>? x2,
      }) {
    return AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap()
      ..x1 = x1 ?? this.x1
      ..x2 = x2 ?? this.x2;
  }
}

AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap1 $AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap1FromJson(
    Map<String, dynamic> json) {
  final AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap1 analyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap1 = AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap1();
  final String? awayTeamName = jsonConvert.convert<String>(
      json['awayTeamName']);
  if (awayTeamName != null) {
    analyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap1
        .awayTeamName = awayTeamName;
  }
  final String? beginTime = jsonConvert.convert<String>(json['beginTime']);
  if (beginTime != null) {
    analyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap1
        .beginTime = beginTime;
  }
  final String? homeTeamName = jsonConvert.convert<String>(
      json['homeTeamName']);
  if (homeTeamName != null) {
    analyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap1
        .homeTeamName = homeTeamName;
  }
  final int? intervalDay = jsonConvert.convert<int>(json['intervalDay']);
  if (intervalDay != null) {
    analyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap1
        .intervalDay = intervalDay;
  }
  final String? tournamentName = jsonConvert.convert<String>(
      json['tournamentName']);
  if (tournamentName != null) {
    analyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap1
        .tournamentName = tournamentName;
  }
  return analyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap1;
}

Map<String,
    dynamic> $AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap1ToJson(
    AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap1 entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['awayTeamName'] = entity.awayTeamName;
  data['beginTime'] = entity.beginTime;
  data['homeTeamName'] = entity.homeTeamName;
  data['intervalDay'] = entity.intervalDay;
  data['tournamentName'] = entity.tournamentName;
  return data;
}

extension AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap1Extension on AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap1 {
  AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap1 copyWith(
      {
        String? awayTeamName,
        String? beginTime,
        String? homeTeamName,
        int? intervalDay,
        String? tournamentName,
      }) {
    return AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap1()
      ..awayTeamName = awayTeamName ?? this.awayTeamName
      ..beginTime = beginTime ?? this.beginTime
      ..homeTeamName = homeTeamName ?? this.homeTeamName
      ..intervalDay = intervalDay ?? this.intervalDay
      ..tournamentName = tournamentName ?? this.tournamentName;
  }
}

AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap2 $AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap2FromJson(
    Map<String, dynamic> json) {
  final AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap2 analyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap2 = AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap2();
  final String? awayTeamName = jsonConvert.convert<String>(
      json['awayTeamName']);
  if (awayTeamName != null) {
    analyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap2
        .awayTeamName = awayTeamName;
  }
  final String? beginTime = jsonConvert.convert<String>(json['beginTime']);
  if (beginTime != null) {
    analyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap2
        .beginTime = beginTime;
  }
  final String? homeTeamName = jsonConvert.convert<String>(
      json['homeTeamName']);
  if (homeTeamName != null) {
    analyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap2
        .homeTeamName = homeTeamName;
  }
  final int? intervalDay = jsonConvert.convert<int>(json['intervalDay']);
  if (intervalDay != null) {
    analyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap2
        .intervalDay = intervalDay;
  }
  final String? tournamentName = jsonConvert.convert<String>(
      json['tournamentName']);
  if (tournamentName != null) {
    analyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap2
        .tournamentName = tournamentName;
  }
  return analyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap2;
}

Map<String,
    dynamic> $AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap2ToJson(
    AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap2 entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['awayTeamName'] = entity.awayTeamName;
  data['beginTime'] = entity.beginTime;
  data['homeTeamName'] = entity.homeTeamName;
  data['intervalDay'] = entity.intervalDay;
  data['tournamentName'] = entity.tournamentName;
  return data;
}

extension AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap2Extension on AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap2 {
  AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap2 copyWith(
      {
        String? awayTeamName,
        String? beginTime,
        String? homeTeamName,
        int? intervalDay,
        String? tournamentName,
      }) {
    return AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap2()
      ..awayTeamName = awayTeamName ?? this.awayTeamName
      ..beginTime = beginTime ?? this.beginTime
      ..homeTeamName = homeTeamName ?? this.homeTeamName
      ..intervalDay = intervalDay ?? this.intervalDay
      ..tournamentName = tournamentName ?? this.tournamentName;
  }
}