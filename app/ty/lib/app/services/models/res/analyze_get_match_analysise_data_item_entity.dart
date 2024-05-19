import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/analyze_get_match_analysise_data_item_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class AnalyzeGetMatchAnalysiseDataItemEntity {

	AnalyzeGetMatchAnalysiseDataItemInParam? inParam;
	AnalyzeGetMatchAnalysiseDataItemBasicInfoMap? basicInfoMap;
  
  AnalyzeGetMatchAnalysiseDataItemEntity();

  factory AnalyzeGetMatchAnalysiseDataItemEntity.fromJson(Map<String, dynamic> json) => $AnalyzeGetMatchAnalysiseDataItemEntityFromJson(json);

  Map<String, dynamic> toJson() => $AnalyzeGetMatchAnalysiseDataItemEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class AnalyzeGetMatchAnalysiseDataItemInParam {

	dynamic historyAddition;
	dynamic histroyQueryMatchSize;
	dynamic homeNearAddition;
	dynamic homeNearMatchSize;
	String? lang;
	int? parentMenuId;
	int? sonMenuId;
	String? standardMatchId;
  
  AnalyzeGetMatchAnalysiseDataItemInParam();

  factory AnalyzeGetMatchAnalysiseDataItemInParam.fromJson(Map<String, dynamic> json) => $AnalyzeGetMatchAnalysiseDataItemInParamFromJson(json);

  Map<String, dynamic> toJson() => $AnalyzeGetMatchAnalysiseDataItemInParamToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class AnalyzeGetMatchAnalysiseDataItemBasicInfoMap {

	AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchSidelinedDTOMap? sThirdMatchSidelinedDTOMap;
	AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap? sThirdMatchFutureStatisticsDTOMap;
  
  AnalyzeGetMatchAnalysiseDataItemBasicInfoMap();

  factory AnalyzeGetMatchAnalysiseDataItemBasicInfoMap.fromJson(Map<String, dynamic> json) => $AnalyzeGetMatchAnalysiseDataItemBasicInfoMapFromJson(json);

  Map<String, dynamic> toJson() => $AnalyzeGetMatchAnalysiseDataItemBasicInfoMapToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchSidelinedDTOMap {


  
  AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchSidelinedDTOMap();

  factory AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchSidelinedDTOMap.fromJson(Map<String, dynamic> json) => $AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchSidelinedDTOMapFromJson(json);

  Map<String, dynamic> toJson() => $AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchSidelinedDTOMapToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap {

	@JSONField(name: "1")
	List<AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap1>? x1;
	@JSONField(name: "2")
	List<AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap2>? x2;
  
  AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap();

  factory AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap.fromJson(Map<String, dynamic> json) => $AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMapFromJson(json);

  Map<String, dynamic> toJson() => $AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMapToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap1 {

	String? awayTeamName;
	String? beginTime;
	String? homeTeamName;
	int? intervalDay;
	String? tournamentName;
  
  AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap1();

  factory AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap1.fromJson(Map<String, dynamic> json) => $AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap1FromJson(json);

  Map<String, dynamic> toJson() => $AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap1ToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap2 {

	String? awayTeamName;
	String? beginTime;
	String? homeTeamName;
	int? intervalDay;
	String? tournamentName;
  
  AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap2();

  factory AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap2.fromJson(Map<String, dynamic> json) => $AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap2FromJson(json);

  Map<String, dynamic> toJson() => $AnalyzeGetMatchAnalysiseDataItemBasicInfoMapSThirdMatchFutureStatisticsDTOMap2ToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}