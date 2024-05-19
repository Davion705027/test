import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/match_disk_surface_entity.dart';

MatchDiskSurfaceEntity $MatchDiskSurfaceEntityFromJson(
    Map<String, dynamic> json) {
  final MatchDiskSurfaceEntity matchDiskSurfaceEntity = MatchDiskSurfaceEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    matchDiskSurfaceEntity.code = code;
  }
  final MatchDiskSurfaceData? data = jsonConvert.convert<MatchDiskSurfaceData>(
      json['data']);
  if (data != null) {
    matchDiskSurfaceEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    matchDiskSurfaceEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    matchDiskSurfaceEntity.ts = ts;
  }
  return matchDiskSurfaceEntity;
}

Map<String, dynamic> $MatchDiskSurfaceEntityToJson(
    MatchDiskSurfaceEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data?.toJson();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension MatchDiskSurfaceEntityExtension on MatchDiskSurfaceEntity {
  MatchDiskSurfaceEntity copyWith({
    String? code,
    MatchDiskSurfaceData? data,
    String? msg,
    int? ts,
  }) {
    return MatchDiskSurfaceEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

MatchDiskSurfaceData $MatchDiskSurfaceDataFromJson(Map<String, dynamic> json) {
  final MatchDiskSurfaceData matchDiskSurfaceData = MatchDiskSurfaceData();
  final MatchDiskSurfaceDataInParam? inParam = jsonConvert.convert<
      MatchDiskSurfaceDataInParam>(json['inParam']);
  if (inParam != null) {
    matchDiskSurfaceData.inParam = inParam;
  }
  final MatchDiskSurfaceDataMatchHistoryBattleDTOMap? matchHistoryBattleDTOMap = jsonConvert
      .convert<MatchDiskSurfaceDataMatchHistoryBattleDTOMap>(
      json['matchHistoryBattleDTOMap']);
  if (matchHistoryBattleDTOMap != null) {
    matchDiskSurfaceData.matchHistoryBattleDTOMap = matchHistoryBattleDTOMap;
  }
  return matchDiskSurfaceData;
}

Map<String, dynamic> $MatchDiskSurfaceDataToJson(MatchDiskSurfaceData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['inParam'] = entity.inParam?.toJson();
  data['matchHistoryBattleDTOMap'] = entity.matchHistoryBattleDTOMap?.toJson();
  return data;
}

extension MatchDiskSurfaceDataExtension on MatchDiskSurfaceData {
  MatchDiskSurfaceData copyWith({
    MatchDiskSurfaceDataInParam? inParam,
    MatchDiskSurfaceDataMatchHistoryBattleDTOMap? matchHistoryBattleDTOMap,
  }) {
    return MatchDiskSurfaceData()
      ..inParam = inParam ?? this.inParam
      ..matchHistoryBattleDTOMap = matchHistoryBattleDTOMap ??
          this.matchHistoryBattleDTOMap;
  }
}

MatchDiskSurfaceDataInParam $MatchDiskSurfaceDataInParamFromJson(
    Map<String, dynamic> json) {
  final MatchDiskSurfaceDataInParam matchDiskSurfaceDataInParam = MatchDiskSurfaceDataInParam();
  final dynamic historyAddition = json['historyAddition'];
  if (historyAddition != null) {
    matchDiskSurfaceDataInParam.historyAddition = historyAddition;
  }
  final dynamic histroyQueryMatchSize = json['histroyQueryMatchSize'];
  if (histroyQueryMatchSize != null) {
    matchDiskSurfaceDataInParam.histroyQueryMatchSize = histroyQueryMatchSize;
  }
  final dynamic homeNearAddition = json['homeNearAddition'];
  if (homeNearAddition != null) {
    matchDiskSurfaceDataInParam.homeNearAddition = homeNearAddition;
  }
  final dynamic homeNearMatchSize = json['homeNearMatchSize'];
  if (homeNearMatchSize != null) {
    matchDiskSurfaceDataInParam.homeNearMatchSize = homeNearMatchSize;
  }
  final String? lang = jsonConvert.convert<String>(json['lang']);
  if (lang != null) {
    matchDiskSurfaceDataInParam.lang = lang;
  }
  final int? parentMenuId = jsonConvert.convert<int>(json['parentMenuId']);
  if (parentMenuId != null) {
    matchDiskSurfaceDataInParam.parentMenuId = parentMenuId;
  }
  final int? sonMenuId = jsonConvert.convert<int>(json['sonMenuId']);
  if (sonMenuId != null) {
    matchDiskSurfaceDataInParam.sonMenuId = sonMenuId;
  }
  final String? standardMatchId = jsonConvert.convert<String>(
      json['standardMatchId']);
  if (standardMatchId != null) {
    matchDiskSurfaceDataInParam.standardMatchId = standardMatchId;
  }
  return matchDiskSurfaceDataInParam;
}

Map<String, dynamic> $MatchDiskSurfaceDataInParamToJson(
    MatchDiskSurfaceDataInParam entity) {
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

extension MatchDiskSurfaceDataInParamExtension on MatchDiskSurfaceDataInParam {
  MatchDiskSurfaceDataInParam copyWith({
    dynamic historyAddition,
    dynamic histroyQueryMatchSize,
    dynamic homeNearAddition,
    dynamic homeNearMatchSize,
    String? lang,
    int? parentMenuId,
    int? sonMenuId,
    String? standardMatchId,
  }) {
    return MatchDiskSurfaceDataInParam()
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

MatchDiskSurfaceDataMatchHistoryBattleDTOMap $MatchDiskSurfaceDataMatchHistoryBattleDTOMapFromJson(
    Map<String, dynamic> json) {
  final MatchDiskSurfaceDataMatchHistoryBattleDTOMap matchDiskSurfaceDataMatchHistoryBattleDTOMap = MatchDiskSurfaceDataMatchHistoryBattleDTOMap();
  final MatchDiskSurfaceDataMatchHistoryBattleDTOMap1? x1 = jsonConvert.convert<
      MatchDiskSurfaceDataMatchHistoryBattleDTOMap1>(json['1']);
  if (x1 != null) {
    matchDiskSurfaceDataMatchHistoryBattleDTOMap.x1 = x1;
  }
  final MatchDiskSurfaceDataMatchHistoryBattleDTOMap2? x2 = jsonConvert.convert<
      MatchDiskSurfaceDataMatchHistoryBattleDTOMap2>(json['2']);
  if (x2 != null) {
    matchDiskSurfaceDataMatchHistoryBattleDTOMap.x2 = x2;
  }
  return matchDiskSurfaceDataMatchHistoryBattleDTOMap;
}

Map<String, dynamic> $MatchDiskSurfaceDataMatchHistoryBattleDTOMapToJson(
    MatchDiskSurfaceDataMatchHistoryBattleDTOMap entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['1'] = entity.x1?.toJson();
  data['2'] = entity.x2?.toJson();
  return data;
}

extension MatchDiskSurfaceDataMatchHistoryBattleDTOMapExtension on MatchDiskSurfaceDataMatchHistoryBattleDTOMap {
  MatchDiskSurfaceDataMatchHistoryBattleDTOMap copyWith({
    MatchDiskSurfaceDataMatchHistoryBattleDTOMap1? x1,
    MatchDiskSurfaceDataMatchHistoryBattleDTOMap2? x2,
  }) {
    return MatchDiskSurfaceDataMatchHistoryBattleDTOMap()
      ..x1 = x1 ?? this.x1
      ..x2 = x2 ?? this.x2;
  }
}

MatchDiskSurfaceDataMatchHistoryBattleDTOMap1 $MatchDiskSurfaceDataMatchHistoryBattleDTOMap1FromJson(
    Map<String, dynamic> json) {
  final MatchDiskSurfaceDataMatchHistoryBattleDTOMap1 matchDiskSurfaceDataMatchHistoryBattleDTOMap1 = MatchDiskSurfaceDataMatchHistoryBattleDTOMap1();
  final List<int>? handicapResultList = (json['handicapResultList'] as List<
      dynamic>?)?.map(
          (e) => jsonConvert.convert<int>(e) as int).toList();
  if (handicapResultList != null) {
    matchDiskSurfaceDataMatchHistoryBattleDTOMap1.handicapResultList =
        handicapResultList;
  }
  final List<
      MatchDiskSurfaceDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOList>? matchHistoryBattleDetailDTOList = (json['matchHistoryBattleDetailDTOList'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<
          MatchDiskSurfaceDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOList>(
          e) as MatchDiskSurfaceDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOList)
      .toList();
  if (matchHistoryBattleDetailDTOList != null) {
    matchDiskSurfaceDataMatchHistoryBattleDTOMap1
        .matchHistoryBattleDetailDTOList = matchHistoryBattleDetailDTOList;
  }
  final List<int>? overunderResultList = (json['overunderResultList'] as List<
      dynamic>?)?.map(
          (e) => jsonConvert.convert<int>(e) as int).toList();
  if (overunderResultList != null) {
    matchDiskSurfaceDataMatchHistoryBattleDTOMap1.overunderResultList =
        overunderResultList;
  }
  return matchDiskSurfaceDataMatchHistoryBattleDTOMap1;
}

Map<String, dynamic> $MatchDiskSurfaceDataMatchHistoryBattleDTOMap1ToJson(
    MatchDiskSurfaceDataMatchHistoryBattleDTOMap1 entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['handicapResultList'] = entity.handicapResultList;
  data['matchHistoryBattleDetailDTOList'] =
      entity.matchHistoryBattleDetailDTOList?.map((v) => v.toJson()).toList();
  data['overunderResultList'] = entity.overunderResultList;
  return data;
}

extension MatchDiskSurfaceDataMatchHistoryBattleDTOMap1Extension on MatchDiskSurfaceDataMatchHistoryBattleDTOMap1 {
  MatchDiskSurfaceDataMatchHistoryBattleDTOMap1 copyWith({
    List<int>? handicapResultList,
    List<
        MatchDiskSurfaceDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOList>? matchHistoryBattleDetailDTOList,
    List<int>? overunderResultList,
  }) {
    return MatchDiskSurfaceDataMatchHistoryBattleDTOMap1()
      ..handicapResultList = handicapResultList ?? this.handicapResultList
      ..matchHistoryBattleDetailDTOList = matchHistoryBattleDetailDTOList ??
          this.matchHistoryBattleDetailDTOList
      ..overunderResultList = overunderResultList ?? this.overunderResultList;
  }
}

MatchDiskSurfaceDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOList $MatchDiskSurfaceDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOListFromJson(
    Map<String, dynamic> json) {
  final MatchDiskSurfaceDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOList matchDiskSurfaceDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOList = MatchDiskSurfaceDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOList();
  final int? handicapResultEqual = jsonConvert.convert<int>(
      json['handicapResultEqual']);
  if (handicapResultEqual != null) {
    matchDiskSurfaceDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOList
        .handicapResultEqual = handicapResultEqual;
  }
  final int? handicapResultLose = jsonConvert.convert<int>(
      json['handicapResultLose']);
  if (handicapResultLose != null) {
    matchDiskSurfaceDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOList
        .handicapResultLose = handicapResultLose;
  }
  final int? handicapResultWin = jsonConvert.convert<int>(
      json['handicapResultWin']);
  if (handicapResultWin != null) {
    matchDiskSurfaceDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOList
        .handicapResultWin = handicapResultWin;
  }
  final double? handicapResultWinRate = jsonConvert.convert<double>(
      json['handicapResultWinRate']);
  if (handicapResultWinRate != null) {
    matchDiskSurfaceDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOList
        .handicapResultWinRate = handicapResultWinRate;
  }
  final int? overunderResultEqual = jsonConvert.convert<int>(
      json['overunderResultEqual']);
  if (overunderResultEqual != null) {
    matchDiskSurfaceDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOList
        .overunderResultEqual = overunderResultEqual;
  }
  final int? overunderResultLose = jsonConvert.convert<int>(
      json['overunderResultLose']);
  if (overunderResultLose != null) {
    matchDiskSurfaceDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOList
        .overunderResultLose = overunderResultLose;
  }
  final double? overunderResultLoseRate = jsonConvert.convert<double>(
      json['overunderResultLoseRate']);
  if (overunderResultLoseRate != null) {
    matchDiskSurfaceDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOList
        .overunderResultLoseRate = overunderResultLoseRate;
  }
  final int? overunderResultWin = jsonConvert.convert<int>(
      json['overunderResultWin']);
  if (overunderResultWin != null) {
    matchDiskSurfaceDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOList
        .overunderResultWin = overunderResultWin;
  }
  final double? overunderResultWinRate = jsonConvert.convert<double>(
      json['overunderResultWinRate']);
  if (overunderResultWinRate != null) {
    matchDiskSurfaceDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOList
        .overunderResultWinRate = overunderResultWinRate;
  }
  final int? postionFlag = jsonConvert.convert<int>(json['postionFlag']);
  if (postionFlag != null) {
    matchDiskSurfaceDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOList
        .postionFlag = postionFlag;
  }
  return matchDiskSurfaceDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOList;
}

Map<String,
    dynamic> $MatchDiskSurfaceDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOListToJson(
    MatchDiskSurfaceDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOList entity) {
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

extension MatchDiskSurfaceDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOListExtension on MatchDiskSurfaceDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOList {
  MatchDiskSurfaceDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOList copyWith(
      {
        int? handicapResultEqual,
        int? handicapResultLose,
        int? handicapResultWin,
        double? handicapResultWinRate,
        int? overunderResultEqual,
        int? overunderResultLose,
        double? overunderResultLoseRate,
        int? overunderResultWin,
        double? overunderResultWinRate,
        int? postionFlag,
      }) {
    return MatchDiskSurfaceDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOList()
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

MatchDiskSurfaceDataMatchHistoryBattleDTOMap2 $MatchDiskSurfaceDataMatchHistoryBattleDTOMap2FromJson(
    Map<String, dynamic> json) {
  final MatchDiskSurfaceDataMatchHistoryBattleDTOMap2 matchDiskSurfaceDataMatchHistoryBattleDTOMap2 = MatchDiskSurfaceDataMatchHistoryBattleDTOMap2();
  final List<int>? handicapResultList = (json['handicapResultList'] as List<
      dynamic>?)?.map(
          (e) => jsonConvert.convert<int>(e) as int).toList();
  if (handicapResultList != null) {
    matchDiskSurfaceDataMatchHistoryBattleDTOMap2.handicapResultList =
        handicapResultList;
  }
  final List<
      MatchDiskSurfaceDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOList>? matchHistoryBattleDetailDTOList = (json['matchHistoryBattleDetailDTOList'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<
          MatchDiskSurfaceDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOList>(
          e) as MatchDiskSurfaceDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOList)
      .toList();
  if (matchHistoryBattleDetailDTOList != null) {
    matchDiskSurfaceDataMatchHistoryBattleDTOMap2
        .matchHistoryBattleDetailDTOList = matchHistoryBattleDetailDTOList;
  }
  final List<int>? overunderResultList = (json['overunderResultList'] as List<
      dynamic>?)?.map(
          (e) => jsonConvert.convert<int>(e) as int).toList();
  if (overunderResultList != null) {
    matchDiskSurfaceDataMatchHistoryBattleDTOMap2.overunderResultList =
        overunderResultList;
  }
  return matchDiskSurfaceDataMatchHistoryBattleDTOMap2;
}

Map<String, dynamic> $MatchDiskSurfaceDataMatchHistoryBattleDTOMap2ToJson(
    MatchDiskSurfaceDataMatchHistoryBattleDTOMap2 entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['handicapResultList'] = entity.handicapResultList;
  data['matchHistoryBattleDetailDTOList'] =
      entity.matchHistoryBattleDetailDTOList?.map((v) => v.toJson()).toList();
  data['overunderResultList'] = entity.overunderResultList;
  return data;
}

extension MatchDiskSurfaceDataMatchHistoryBattleDTOMap2Extension on MatchDiskSurfaceDataMatchHistoryBattleDTOMap2 {
  MatchDiskSurfaceDataMatchHistoryBattleDTOMap2 copyWith({
    List<int>? handicapResultList,
    List<
        MatchDiskSurfaceDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOList>? matchHistoryBattleDetailDTOList,
    List<int>? overunderResultList,
  }) {
    return MatchDiskSurfaceDataMatchHistoryBattleDTOMap2()
      ..handicapResultList = handicapResultList ?? this.handicapResultList
      ..matchHistoryBattleDetailDTOList = matchHistoryBattleDetailDTOList ??
          this.matchHistoryBattleDetailDTOList
      ..overunderResultList = overunderResultList ?? this.overunderResultList;
  }
}

MatchDiskSurfaceDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOList $MatchDiskSurfaceDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOListFromJson(
    Map<String, dynamic> json) {
  final MatchDiskSurfaceDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOList matchDiskSurfaceDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOList = MatchDiskSurfaceDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOList();
  final int? handicapResultEqual = jsonConvert.convert<int>(
      json['handicapResultEqual']);
  if (handicapResultEqual != null) {
    matchDiskSurfaceDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOList
        .handicapResultEqual = handicapResultEqual;
  }
  final int? handicapResultLose = jsonConvert.convert<int>(
      json['handicapResultLose']);
  if (handicapResultLose != null) {
    matchDiskSurfaceDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOList
        .handicapResultLose = handicapResultLose;
  }
  final int? handicapResultWin = jsonConvert.convert<int>(
      json['handicapResultWin']);
  if (handicapResultWin != null) {
    matchDiskSurfaceDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOList
        .handicapResultWin = handicapResultWin;
  }
  final double? handicapResultWinRate = jsonConvert.convert<double>(
      json['handicapResultWinRate']);
  if (handicapResultWinRate != null) {
    matchDiskSurfaceDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOList
        .handicapResultWinRate = handicapResultWinRate;
  }
  final int? overunderResultEqual = jsonConvert.convert<int>(
      json['overunderResultEqual']);
  if (overunderResultEqual != null) {
    matchDiskSurfaceDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOList
        .overunderResultEqual = overunderResultEqual;
  }
  final int? overunderResultLose = jsonConvert.convert<int>(
      json['overunderResultLose']);
  if (overunderResultLose != null) {
    matchDiskSurfaceDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOList
        .overunderResultLose = overunderResultLose;
  }
  final double? overunderResultLoseRate = jsonConvert.convert<double>(
      json['overunderResultLoseRate']);
  if (overunderResultLoseRate != null) {
    matchDiskSurfaceDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOList
        .overunderResultLoseRate = overunderResultLoseRate;
  }
  final int? overunderResultWin = jsonConvert.convert<int>(
      json['overunderResultWin']);
  if (overunderResultWin != null) {
    matchDiskSurfaceDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOList
        .overunderResultWin = overunderResultWin;
  }
  final double? overunderResultWinRate = jsonConvert.convert<double>(
      json['overunderResultWinRate']);
  if (overunderResultWinRate != null) {
    matchDiskSurfaceDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOList
        .overunderResultWinRate = overunderResultWinRate;
  }
  final int? postionFlag = jsonConvert.convert<int>(json['postionFlag']);
  if (postionFlag != null) {
    matchDiskSurfaceDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOList
        .postionFlag = postionFlag;
  }
  return matchDiskSurfaceDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOList;
}

Map<String,
    dynamic> $MatchDiskSurfaceDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOListToJson(
    MatchDiskSurfaceDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOList entity) {
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

extension MatchDiskSurfaceDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOListExtension on MatchDiskSurfaceDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOList {
  MatchDiskSurfaceDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOList copyWith(
      {
        int? handicapResultEqual,
        int? handicapResultLose,
        int? handicapResultWin,
        double? handicapResultWinRate,
        int? overunderResultEqual,
        int? overunderResultLose,
        double? overunderResultLoseRate,
        int? overunderResultWin,
        double? overunderResultWinRate,
        int? postionFlag,
      }) {
    return MatchDiskSurfaceDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOList()
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