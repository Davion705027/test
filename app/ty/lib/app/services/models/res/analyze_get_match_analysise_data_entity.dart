import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/analyze_get_match_analysise_data_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class AnalyzeGetMatchAnalysiseDataEntity {

	AnalyzeGetMatchAnalysiseDataInParam? inParam;
	AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap? matchHistoryBattleDTOMap;
  
  AnalyzeGetMatchAnalysiseDataEntity();

  factory AnalyzeGetMatchAnalysiseDataEntity.fromJson(Map<String, dynamic> json) => $AnalyzeGetMatchAnalysiseDataEntityFromJson(json);

  Map<String, dynamic> toJson() => $AnalyzeGetMatchAnalysiseDataEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class AnalyzeGetMatchAnalysiseDataInParam {

	dynamic historyAddition;
	dynamic histroyQueryMatchSize;
	dynamic homeNearAddition;
	dynamic homeNearMatchSize;
	String? lang;
	num? parentMenuId;
	num? sonMenuId;
	String? standardMatchId;
  
  AnalyzeGetMatchAnalysiseDataInParam();

  factory AnalyzeGetMatchAnalysiseDataInParam.fromJson(Map<String, dynamic> json) => $AnalyzeGetMatchAnalysiseDataInParamFromJson(json);

  Map<String, dynamic> toJson() => $AnalyzeGetMatchAnalysiseDataInParamToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap {

	@JSONField(name: "1")
	AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1? x1;
	@JSONField(name: "2")
	AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2? x2;
  
  AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap();

  factory AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap.fromJson(Map<String, dynamic> json) => $AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMapFromJson(json);

  Map<String, dynamic> toJson() => $AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMapToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1 {

	List<num>? handicapResultList;
	List<AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOList>? matchHistoryBattleDetailDTOList;
	List<num>? overunderResultList;
  
  AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1();

  factory AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1.fromJson(Map<String, dynamic> json) => $AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1FromJson(json);

  Map<String, dynamic> toJson() => $AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1ToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOList {

	num? handicapResultEqual;
	num? handicapResultLose;
	num? handicapResultWin;
	num? handicapResultWinRate;
	num? overunderResultEqual;
	num? overunderResultLose;
	num? overunderResultLoseRate;
	num? overunderResultWin;
	num? overunderResultWinRate;
	num? postionFlag;
  
  AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOList();

  factory AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOList.fromJson(Map<String, dynamic> json) => $AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOListFromJson(json);

  Map<String, dynamic> toJson() => $AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOListToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2 {

	List<num>? handicapResultList;
	List<AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOList>? matchHistoryBattleDetailDTOList;
	List<num>? overunderResultList;
  
  AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2();

  factory AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2.fromJson(Map<String, dynamic> json) => $AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2FromJson(json);

  Map<String, dynamic> toJson() => $AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2ToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOList {

	num? handicapResultEqual;
	num? handicapResultLose;
	num? handicapResultWin;
	num? handicapResultWinRate;
	num? overunderResultEqual;
	num? overunderResultLose;
	num? overunderResultLoseRate;
	num? overunderResultWin;
	num? overunderResultWinRate;
	num? postionFlag;
  
  AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOList();

  factory AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOList.fromJson(Map<String, dynamic> json) => $AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOListFromJson(json);

  Map<String, dynamic> toJson() => $AnalyzeGetMatchAnalysiseDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOListToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}