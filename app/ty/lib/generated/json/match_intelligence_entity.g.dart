import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/match_intelligence_entity.dart';

MatchIntelligenceEntity $MatchIntelligenceEntityFromJson(
    Map<String, dynamic> json) {
  final MatchIntelligenceEntity matchIntelligenceEntity = MatchIntelligenceEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    matchIntelligenceEntity.code = code;
  }
  final MatchIntelligenceData? data = jsonConvert.convert<
      MatchIntelligenceData>(json['data']);
  if (data != null) {
    matchIntelligenceEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    matchIntelligenceEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    matchIntelligenceEntity.ts = ts;
  }
  return matchIntelligenceEntity;
}

Map<String, dynamic> $MatchIntelligenceEntityToJson(
    MatchIntelligenceEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data?.toJson();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension MatchIntelligenceEntityExtension on MatchIntelligenceEntity {
  MatchIntelligenceEntity copyWith({
    String? code,
    MatchIntelligenceData? data,
    String? msg,
    int? ts,
  }) {
    return MatchIntelligenceEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

MatchIntelligenceData $MatchIntelligenceDataFromJson(
    Map<String, dynamic> json) {
  final MatchIntelligenceData matchIntelligenceData = MatchIntelligenceData();
  final MatchIntelligenceDataInParam? inParam = jsonConvert.convert<
      MatchIntelligenceDataInParam>(json['inParam']);
  if (inParam != null) {
    matchIntelligenceData.inParam = inParam;
  }
  final List<
      MatchIntelligenceDataSThirdMatchInformationDTOList>? sThirdMatchInformationDTOList = (json['sThirdMatchInformationDTOList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<
          MatchIntelligenceDataSThirdMatchInformationDTOList>(
          e) as MatchIntelligenceDataSThirdMatchInformationDTOList).toList();
  if (sThirdMatchInformationDTOList != null) {
    matchIntelligenceData.sThirdMatchInformationDTOList =
        sThirdMatchInformationDTOList;
  }
  return matchIntelligenceData;
}

Map<String, dynamic> $MatchIntelligenceDataToJson(
    MatchIntelligenceData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['inParam'] = entity.inParam?.toJson();
  data['sThirdMatchInformationDTOList'] =
      entity.sThirdMatchInformationDTOList?.map((v) => v.toJson()).toList();
  return data;
}

extension MatchIntelligenceDataExtension on MatchIntelligenceData {
  MatchIntelligenceData copyWith({
    MatchIntelligenceDataInParam? inParam,
    List<
        MatchIntelligenceDataSThirdMatchInformationDTOList>? sThirdMatchInformationDTOList,
  }) {
    return MatchIntelligenceData()
      ..inParam = inParam ?? this.inParam
      ..sThirdMatchInformationDTOList = sThirdMatchInformationDTOList ??
          this.sThirdMatchInformationDTOList;
  }
}

MatchIntelligenceDataInParam $MatchIntelligenceDataInParamFromJson(
    Map<String, dynamic> json) {
  final MatchIntelligenceDataInParam matchIntelligenceDataInParam = MatchIntelligenceDataInParam();
  final dynamic historyAddition = json['historyAddition'];
  if (historyAddition != null) {
    matchIntelligenceDataInParam.historyAddition = historyAddition;
  }
  final dynamic histroyQueryMatchSize = json['histroyQueryMatchSize'];
  if (histroyQueryMatchSize != null) {
    matchIntelligenceDataInParam.histroyQueryMatchSize = histroyQueryMatchSize;
  }
  final dynamic homeNearAddition = json['homeNearAddition'];
  if (homeNearAddition != null) {
    matchIntelligenceDataInParam.homeNearAddition = homeNearAddition;
  }
  final dynamic homeNearMatchSize = json['homeNearMatchSize'];
  if (homeNearMatchSize != null) {
    matchIntelligenceDataInParam.homeNearMatchSize = homeNearMatchSize;
  }
  final String? lang = jsonConvert.convert<String>(json['lang']);
  if (lang != null) {
    matchIntelligenceDataInParam.lang = lang;
  }
  final int? parentMenuId = jsonConvert.convert<int>(json['parentMenuId']);
  if (parentMenuId != null) {
    matchIntelligenceDataInParam.parentMenuId = parentMenuId;
  }
  final int? sonMenuId = jsonConvert.convert<int>(json['sonMenuId']);
  if (sonMenuId != null) {
    matchIntelligenceDataInParam.sonMenuId = sonMenuId;
  }
  final String? standardMatchId = jsonConvert.convert<String>(
      json['standardMatchId']);
  if (standardMatchId != null) {
    matchIntelligenceDataInParam.standardMatchId = standardMatchId;
  }
  return matchIntelligenceDataInParam;
}

Map<String, dynamic> $MatchIntelligenceDataInParamToJson(
    MatchIntelligenceDataInParam entity) {
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

extension MatchIntelligenceDataInParamExtension on MatchIntelligenceDataInParam {
  MatchIntelligenceDataInParam copyWith({
    dynamic historyAddition,
    dynamic histroyQueryMatchSize,
    dynamic homeNearAddition,
    dynamic homeNearMatchSize,
    String? lang,
    int? parentMenuId,
    int? sonMenuId,
    String? standardMatchId,
  }) {
    return MatchIntelligenceDataInParam()
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

MatchIntelligenceDataSThirdMatchInformationDTOList $MatchIntelligenceDataSThirdMatchInformationDTOListFromJson(
    Map<String, dynamic> json) {
  final MatchIntelligenceDataSThirdMatchInformationDTOList matchIntelligenceDataSThirdMatchInformationDTOList = MatchIntelligenceDataSThirdMatchInformationDTOList();
  final int? benefit = jsonConvert.convert<int>(json['benefit']);
  if (benefit != null) {
    matchIntelligenceDataSThirdMatchInformationDTOList.benefit = benefit;
  }
  final String? content = jsonConvert.convert<String>(json['content']);
  if (content != null) {
    matchIntelligenceDataSThirdMatchInformationDTOList.content = content;
  }
  final String? typeId = jsonConvert.convert<String>(json['typeId']);
  if (typeId != null) {
    matchIntelligenceDataSThirdMatchInformationDTOList.typeId = typeId;
  }
  final String? typeName = jsonConvert.convert<String>(json['typeName']);
  if (typeName != null) {
    matchIntelligenceDataSThirdMatchInformationDTOList.typeName = typeName;
  }
  return matchIntelligenceDataSThirdMatchInformationDTOList;
}

Map<String, dynamic> $MatchIntelligenceDataSThirdMatchInformationDTOListToJson(
    MatchIntelligenceDataSThirdMatchInformationDTOList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['benefit'] = entity.benefit;
  data['content'] = entity.content;
  data['typeId'] = entity.typeId;
  data['typeName'] = entity.typeName;
  return data;
}

extension MatchIntelligenceDataSThirdMatchInformationDTOListExtension on MatchIntelligenceDataSThirdMatchInformationDTOList {
  MatchIntelligenceDataSThirdMatchInformationDTOList copyWith({
    int? benefit,
    String? content,
    String? typeId,
    String? typeName,
  }) {
    return MatchIntelligenceDataSThirdMatchInformationDTOList()
      ..benefit = benefit ?? this.benefit
      ..content = content ?? this.content
      ..typeId = typeId ?? this.typeId
      ..typeName = typeName ?? this.typeName;
  }
}