import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_get_match_analysise_data_entity.dart';

AnalyzeGetMatchAnalysiseDataEntity $AnalyzeGetMatchAnalysiseDataEntityFromJson(
    Map<String, dynamic> json) {
  final AnalyzeGetMatchAnalysiseDataEntity analyzeGetMatchAnalysiseDataEntity = AnalyzeGetMatchAnalysiseDataEntity();
  final AnalyzeGetMatchAnalysiseDataInParam? inParam = jsonConvert.convert<
      AnalyzeGetMatchAnalysiseDataInParam>(json['inParam']);
  if (inParam != null) {
    analyzeGetMatchAnalysiseDataEntity.inParam = inParam;
  }
  final AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap? matchHistoryBattleDTOMap = jsonConvert
      .convert<AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap>(
      json['matchHistoryBattleDTOMap']);
  if (matchHistoryBattleDTOMap != null) {
    analyzeGetMatchAnalysiseDataEntity.matchHistoryBattleDTOMap =
        matchHistoryBattleDTOMap;
  }
  return analyzeGetMatchAnalysiseDataEntity;
}

Map<String, dynamic> $AnalyzeGetMatchAnalysiseDataEntityToJson(
    AnalyzeGetMatchAnalysiseDataEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['inParam'] = entity.inParam?.toJson();
  data['matchHistoryBattleDTOMap'] = entity.matchHistoryBattleDTOMap?.toJson();
  return data;
}

extension AnalyzeGetMatchAnalysiseDataEntityExtension on AnalyzeGetMatchAnalysiseDataEntity {
  AnalyzeGetMatchAnalysiseDataEntity copyWith({
    AnalyzeGetMatchAnalysiseDataInParam? inParam,
    AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap? matchHistoryBattleDTOMap,
  }) {
    return AnalyzeGetMatchAnalysiseDataEntity()
      ..inParam = inParam ?? this.inParam
      ..matchHistoryBattleDTOMap = matchHistoryBattleDTOMap ??
          this.matchHistoryBattleDTOMap;
  }
}

AnalyzeGetMatchAnalysiseDataInParam $AnalyzeGetMatchAnalysiseDataInParamFromJson(
    Map<String, dynamic> json) {
  final AnalyzeGetMatchAnalysiseDataInParam analyzeGetMatchAnalysiseDataInParam = AnalyzeGetMatchAnalysiseDataInParam();
  final dynamic historyAddition = json['historyAddition'];
  if (historyAddition != null) {
    analyzeGetMatchAnalysiseDataInParam.historyAddition = historyAddition;
  }
  final dynamic histroyQueryMatchSize = json['histroyQueryMatchSize'];
  if (histroyQueryMatchSize != null) {
    analyzeGetMatchAnalysiseDataInParam.histroyQueryMatchSize =
        histroyQueryMatchSize;
  }
  final dynamic homeNearAddition = json['homeNearAddition'];
  if (homeNearAddition != null) {
    analyzeGetMatchAnalysiseDataInParam.homeNearAddition = homeNearAddition;
  }
  final dynamic homeNearMatchSize = json['homeNearMatchSize'];
  if (homeNearMatchSize != null) {
    analyzeGetMatchAnalysiseDataInParam.homeNearMatchSize = homeNearMatchSize;
  }
  final String? lang = jsonConvert.convert<String>(json['lang']);
  if (lang != null) {
    analyzeGetMatchAnalysiseDataInParam.lang = lang;
  }
  final num? parentMenuId = jsonConvert.convert<num>(json['parentMenuId']);
  if (parentMenuId != null) {
    analyzeGetMatchAnalysiseDataInParam.parentMenuId = parentMenuId;
  }
  final num? sonMenuId = jsonConvert.convert<num>(json['sonMenuId']);
  if (sonMenuId != null) {
    analyzeGetMatchAnalysiseDataInParam.sonMenuId = sonMenuId;
  }
  final String? standardMatchId = jsonConvert.convert<String>(
      json['standardMatchId']);
  if (standardMatchId != null) {
    analyzeGetMatchAnalysiseDataInParam.standardMatchId = standardMatchId;
  }
  return analyzeGetMatchAnalysiseDataInParam;
}

Map<String, dynamic> $AnalyzeGetMatchAnalysiseDataInParamToJson(
    AnalyzeGetMatchAnalysiseDataInParam entity) {
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

extension AnalyzeGetMatchAnalysiseDataInParamExtension on AnalyzeGetMatchAnalysiseDataInParam {
  AnalyzeGetMatchAnalysiseDataInParam copyWith({
    dynamic historyAddition,
    dynamic histroyQueryMatchSize,
    dynamic homeNearAddition,
    dynamic homeNearMatchSize,
    String? lang,
    num? parentMenuId,
    num? sonMenuId,
    String? standardMatchId,
  }) {
    return AnalyzeGetMatchAnalysiseDataInParam()
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

AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap $AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMapFromJson(
    Map<String, dynamic> json) {
  final AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap analyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap = AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap();
  final AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1? x1 = jsonConvert
      .convert<AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1>(
      json['1']);
  if (x1 != null) {
    analyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap.x1 = x1;
  }
  final AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2? x2 = jsonConvert
      .convert<AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2>(
      json['2']);
  if (x2 != null) {
    analyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap.x2 = x2;
  }
  return analyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap;
}

Map<String,
    dynamic> $AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMapToJson(
    AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['1'] = entity.x1?.toJson();
  data['2'] = entity.x2?.toJson();
  return data;
}

extension AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMapExtension on AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap {
  AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap copyWith({
    AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1? x1,
    AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2? x2,
  }) {
    return AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap()
      ..x1 = x1 ?? this.x1
      ..x2 = x2 ?? this.x2;
  }
}

AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1 $AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1FromJson(
    Map<String, dynamic> json) {
  final AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1 analyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1 = AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1();
  final List<num>? handicapResultList = (json['handicapResultList'] as List<
      dynamic>?)?.map(
          (e) => jsonConvert.convert<num>(e) as num).toList();
  if (handicapResultList != null) {
    analyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1.handicapResultList =
        handicapResultList;
  }
  final List<
      AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOList>? matchHistoryBattleDetailDTOList = (json['matchHistoryBattleDetailDTOList'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<
          AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOList>(
          e) as AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOList)
      .toList();
  if (matchHistoryBattleDetailDTOList != null) {
    analyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1
        .matchHistoryBattleDetailDTOList = matchHistoryBattleDetailDTOList;
  }
  final List<num>? overunderResultList = (json['overunderResultList'] as List<
      dynamic>?)?.map(
          (e) => jsonConvert.convert<num>(e) as num).toList();
  if (overunderResultList != null) {
    analyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1.overunderResultList =
        overunderResultList;
  }
  return analyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1;
}

Map<String,
    dynamic> $AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1ToJson(
    AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1 entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['handicapResultList'] = entity.handicapResultList;
  data['matchHistoryBattleDetailDTOList'] =
      entity.matchHistoryBattleDetailDTOList?.map((v) => v.toJson()).toList();
  data['overunderResultList'] = entity.overunderResultList;
  return data;
}

extension AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1Extension on AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1 {
  AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1 copyWith({
    List<num>? handicapResultList,
    List<
        AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOList>? matchHistoryBattleDetailDTOList,
    List<num>? overunderResultList,
  }) {
    return AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1()
      ..handicapResultList = handicapResultList ?? this.handicapResultList
      ..matchHistoryBattleDetailDTOList = matchHistoryBattleDetailDTOList ??
          this.matchHistoryBattleDetailDTOList
      ..overunderResultList = overunderResultList ?? this.overunderResultList;
  }
}

AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOList $AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOListFromJson(
    Map<String, dynamic> json) {
  final AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOList analyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOList = AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOList();
  final num? handicapResultEqual = jsonConvert.convert<num>(
      json['handicapResultEqual']);
  if (handicapResultEqual != null) {
    analyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOList
        .handicapResultEqual = handicapResultEqual;
  }
  final num? handicapResultLose = jsonConvert.convert<num>(
      json['handicapResultLose']);
  if (handicapResultLose != null) {
    analyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOList
        .handicapResultLose = handicapResultLose;
  }
  final num? handicapResultWin = jsonConvert.convert<num>(
      json['handicapResultWin']);
  if (handicapResultWin != null) {
    analyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOList
        .handicapResultWin = handicapResultWin;
  }
  final num? handicapResultWinRate = jsonConvert.convert<num>(
      json['handicapResultWinRate']);
  if (handicapResultWinRate != null) {
    analyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOList
        .handicapResultWinRate = handicapResultWinRate;
  }
  final num? overunderResultEqual = jsonConvert.convert<num>(
      json['overunderResultEqual']);
  if (overunderResultEqual != null) {
    analyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOList
        .overunderResultEqual = overunderResultEqual;
  }
  final num? overunderResultLose = jsonConvert.convert<num>(
      json['overunderResultLose']);
  if (overunderResultLose != null) {
    analyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOList
        .overunderResultLose = overunderResultLose;
  }
  final num? overunderResultLoseRate = jsonConvert.convert<num>(
      json['overunderResultLoseRate']);
  if (overunderResultLoseRate != null) {
    analyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOList
        .overunderResultLoseRate = overunderResultLoseRate;
  }
  final num? overunderResultWin = jsonConvert.convert<num>(
      json['overunderResultWin']);
  if (overunderResultWin != null) {
    analyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOList
        .overunderResultWin = overunderResultWin;
  }
  final num? overunderResultWinRate = jsonConvert.convert<num>(
      json['overunderResultWinRate']);
  if (overunderResultWinRate != null) {
    analyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOList
        .overunderResultWinRate = overunderResultWinRate;
  }
  final num? postionFlag = jsonConvert.convert<num>(json['postionFlag']);
  if (postionFlag != null) {
    analyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOList
        .postionFlag = postionFlag;
  }
  return analyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOList;
}

Map<String,
    dynamic> $AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOListToJson(
    AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['handicapResultEqual'] = entity.handicapResultEqual;
  data['handicapResultLose'] = entity.handicapResultLose;
  data['handicapResultWin'] = entity.handicapResultWin;
  data['handicapResultWinRate'] = entity.handicapResultWinRate;
  data['overunderResultEqual'] = entity.overunderResultEqual;
  data['overunderResultLose'] = entity.overunderResultLose;
  data['overunderResultLoseRate'] = entity.overunderResultLoseRate;
  data['overunderResultWin'] = entity.overunderResultWin;
  data['overunderResultWinRate'] = entity.overunderResultWinRate;
  data['postionFlag'] = entity.postionFlag;
  return data;
}

extension AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOListExtension on AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOList {
  AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOList copyWith(
      {
        num? handicapResultEqual,
        num? handicapResultLose,
        num? handicapResultWin,
        num? handicapResultWinRate,
        num? overunderResultEqual,
        num? overunderResultLose,
        num? overunderResultLoseRate,
        num? overunderResultWin,
        num? overunderResultWinRate,
        num? postionFlag,
      }) {
    return AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOList()
      ..handicapResultEqual = handicapResultEqual ?? this.handicapResultEqual
      ..handicapResultLose = handicapResultLose ?? this.handicapResultLose
      ..handicapResultWin = handicapResultWin ?? this.handicapResultWin
      ..handicapResultWinRate = handicapResultWinRate ??
          this.handicapResultWinRate
      ..overunderResultEqual = overunderResultEqual ?? this.overunderResultEqual
      ..overunderResultLose = overunderResultLose ?? this.overunderResultLose
      ..overunderResultLoseRate = overunderResultLoseRate ??
          this.overunderResultLoseRate
      ..overunderResultWin = overunderResultWin ?? this.overunderResultWin
      ..overunderResultWinRate = overunderResultWinRate ??
          this.overunderResultWinRate
      ..postionFlag = postionFlag ?? this.postionFlag;
  }
}

AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2 $AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2FromJson(
    Map<String, dynamic> json) {
  final AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2 analyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2 = AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2();
  final List<num>? handicapResultList = (json['handicapResultList'] as List<
      dynamic>?)?.map(
          (e) => jsonConvert.convert<num>(e) as num).toList();
  if (handicapResultList != null) {
    analyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2.handicapResultList =
        handicapResultList;
  }
  final List<
      AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOList>? matchHistoryBattleDetailDTOList = (json['matchHistoryBattleDetailDTOList'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<
          AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOList>(
          e) as AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOList)
      .toList();
  if (matchHistoryBattleDetailDTOList != null) {
    analyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2
        .matchHistoryBattleDetailDTOList = matchHistoryBattleDetailDTOList;
  }
  final List<num>? overunderResultList = (json['overunderResultList'] as List<
      dynamic>?)?.map(
          (e) => jsonConvert.convert<num>(e) as num).toList();
  if (overunderResultList != null) {
    analyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2.overunderResultList =
        overunderResultList;
  }
  return analyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2;
}

Map<String,
    dynamic> $AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2ToJson(
    AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2 entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['handicapResultList'] = entity.handicapResultList;
  data['matchHistoryBattleDetailDTOList'] =
      entity.matchHistoryBattleDetailDTOList?.map((v) => v.toJson()).toList();
  data['overunderResultList'] = entity.overunderResultList;
  return data;
}

extension AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2Extension on AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2 {
  AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2 copyWith({
    List<num>? handicapResultList,
    List<
        AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOList>? matchHistoryBattleDetailDTOList,
    List<num>? overunderResultList,
  }) {
    return AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2()
      ..handicapResultList = handicapResultList ?? this.handicapResultList
      ..matchHistoryBattleDetailDTOList = matchHistoryBattleDetailDTOList ??
          this.matchHistoryBattleDetailDTOList
      ..overunderResultList = overunderResultList ?? this.overunderResultList;
  }
}

AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOList $AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOListFromJson(
    Map<String, dynamic> json) {
  final AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOList analyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOList = AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOList();
  final num? handicapResultEqual = jsonConvert.convert<num>(
      json['handicapResultEqual']);
  if (handicapResultEqual != null) {
    analyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOList
        .handicapResultEqual = handicapResultEqual;
  }
  final num? handicapResultLose = jsonConvert.convert<num>(
      json['handicapResultLose']);
  if (handicapResultLose != null) {
    analyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOList
        .handicapResultLose = handicapResultLose;
  }
  final num? handicapResultWin = jsonConvert.convert<num>(
      json['handicapResultWin']);
  if (handicapResultWin != null) {
    analyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOList
        .handicapResultWin = handicapResultWin;
  }
  final num? handicapResultWinRate = jsonConvert.convert<num>(
      json['handicapResultWinRate']);
  if (handicapResultWinRate != null) {
    analyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOList
        .handicapResultWinRate = handicapResultWinRate;
  }
  final num? overunderResultEqual = jsonConvert.convert<num>(
      json['overunderResultEqual']);
  if (overunderResultEqual != null) {
    analyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOList
        .overunderResultEqual = overunderResultEqual;
  }
  final num? overunderResultLose = jsonConvert.convert<num>(
      json['overunderResultLose']);
  if (overunderResultLose != null) {
    analyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOList
        .overunderResultLose = overunderResultLose;
  }
  final num? overunderResultLoseRate = jsonConvert.convert<num>(
      json['overunderResultLoseRate']);
  if (overunderResultLoseRate != null) {
    analyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOList
        .overunderResultLoseRate = overunderResultLoseRate;
  }
  final num? overunderResultWin = jsonConvert.convert<num>(
      json['overunderResultWin']);
  if (overunderResultWin != null) {
    analyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOList
        .overunderResultWin = overunderResultWin;
  }
  final num? overunderResultWinRate = jsonConvert.convert<num>(
      json['overunderResultWinRate']);
  if (overunderResultWinRate != null) {
    analyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOList
        .overunderResultWinRate = overunderResultWinRate;
  }
  final num? postionFlag = jsonConvert.convert<num>(json['postionFlag']);
  if (postionFlag != null) {
    analyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOList
        .postionFlag = postionFlag;
  }
  return analyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOList;
}

Map<String,
    dynamic> $AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOListToJson(
    AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['handicapResultEqual'] = entity.handicapResultEqual;
  data['handicapResultLose'] = entity.handicapResultLose;
  data['handicapResultWin'] = entity.handicapResultWin;
  data['handicapResultWinRate'] = entity.handicapResultWinRate;
  data['overunderResultEqual'] = entity.overunderResultEqual;
  data['overunderResultLose'] = entity.overunderResultLose;
  data['overunderResultLoseRate'] = entity.overunderResultLoseRate;
  data['overunderResultWin'] = entity.overunderResultWin;
  data['overunderResultWinRate'] = entity.overunderResultWinRate;
  data['postionFlag'] = entity.postionFlag;
  return data;
}

extension AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOListExtension on AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOList {
  AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOList copyWith(
      {
        num? handicapResultEqual,
        num? handicapResultLose,
        num? handicapResultWin,
        num? handicapResultWinRate,
        num? overunderResultEqual,
        num? overunderResultLose,
        num? overunderResultLoseRate,
        num? overunderResultWin,
        num? overunderResultWinRate,
        num? postionFlag,
      }) {
    return AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOList()
      ..handicapResultEqual = handicapResultEqual ?? this.handicapResultEqual
      ..handicapResultLose = handicapResultLose ?? this.handicapResultLose
      ..handicapResultWin = handicapResultWin ?? this.handicapResultWin
      ..handicapResultWinRate = handicapResultWinRate ??
          this.handicapResultWinRate
      ..overunderResultEqual = overunderResultEqual ?? this.overunderResultEqual
      ..overunderResultLose = overunderResultLose ?? this.overunderResultLose
      ..overunderResultLoseRate = overunderResultLoseRate ??
          this.overunderResultLoseRate
      ..overunderResultWin = overunderResultWin ?? this.overunderResultWin
      ..overunderResultWinRate = overunderResultWinRate ??
          this.overunderResultWinRate
      ..postionFlag = postionFlag ?? this.postionFlag;
  }
}