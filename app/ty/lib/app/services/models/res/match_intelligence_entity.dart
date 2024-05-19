import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/match_intelligence_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class MatchIntelligenceEntity {
	String? code;
	MatchIntelligenceData? data;
	String? msg;
	int? ts;

	MatchIntelligenceEntity();

	factory MatchIntelligenceEntity.fromJson(Map<String, dynamic> json) => $MatchIntelligenceEntityFromJson(json);

	Map<String, dynamic> toJson() => $MatchIntelligenceEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MatchIntelligenceData {
	MatchIntelligenceDataInParam? inParam;
	List<MatchIntelligenceDataSThirdMatchInformationDTOList>? sThirdMatchInformationDTOList;

	MatchIntelligenceData();

	factory MatchIntelligenceData.fromJson(Map<String, dynamic> json) => $MatchIntelligenceDataFromJson(json);

	Map<String, dynamic> toJson() => $MatchIntelligenceDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MatchIntelligenceDataInParam {
	dynamic historyAddition;
	dynamic histroyQueryMatchSize;
	dynamic homeNearAddition;
	dynamic homeNearMatchSize;
	String? lang;
	int? parentMenuId;
	int? sonMenuId;
	String? standardMatchId;

	MatchIntelligenceDataInParam();

	factory MatchIntelligenceDataInParam.fromJson(Map<String, dynamic> json) => $MatchIntelligenceDataInParamFromJson(json);

	Map<String, dynamic> toJson() => $MatchIntelligenceDataInParamToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MatchIntelligenceDataSThirdMatchInformationDTOList {
	int? benefit;
	String? content;
	String? typeId;
	String? typeName;

	MatchIntelligenceDataSThirdMatchInformationDTOList();

	factory MatchIntelligenceDataSThirdMatchInformationDTOList.fromJson(Map<String, dynamic> json) => $MatchIntelligenceDataSThirdMatchInformationDTOListFromJson(json);

	Map<String, dynamic> toJson() => $MatchIntelligenceDataSThirdMatchInformationDTOListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}