import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/match_disk_surface_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class MatchDiskSurfaceEntity {
	String? code;
	MatchDiskSurfaceData? data;
	String? msg;
	int? ts;

	MatchDiskSurfaceEntity();

	factory MatchDiskSurfaceEntity.fromJson(Map<String, dynamic> json) => $MatchDiskSurfaceEntityFromJson(json);

	Map<String, dynamic> toJson() => $MatchDiskSurfaceEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MatchDiskSurfaceData {
	MatchDiskSurfaceDataInParam? inParam;
	MatchDiskSurfaceDataMatchHistoryBattleDTOMap? matchHistoryBattleDTOMap;

	MatchDiskSurfaceData();

	factory MatchDiskSurfaceData.fromJson(Map<String, dynamic> json) => $MatchDiskSurfaceDataFromJson(json);

	Map<String, dynamic> toJson() => $MatchDiskSurfaceDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MatchDiskSurfaceDataInParam {
	dynamic historyAddition;
	dynamic histroyQueryMatchSize;
	dynamic homeNearAddition;
	dynamic homeNearMatchSize;
	String? lang;
	int? parentMenuId;
	int? sonMenuId;
	String? standardMatchId;

	MatchDiskSurfaceDataInParam();

	factory MatchDiskSurfaceDataInParam.fromJson(Map<String, dynamic> json) => $MatchDiskSurfaceDataInParamFromJson(json);

	Map<String, dynamic> toJson() => $MatchDiskSurfaceDataInParamToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MatchDiskSurfaceDataMatchHistoryBattleDTOMap {
	@JSONField(name: "1")
	MatchDiskSurfaceDataMatchHistoryBattleDTOMap1? x1;
	@JSONField(name: "2")
	MatchDiskSurfaceDataMatchHistoryBattleDTOMap2? x2;

	MatchDiskSurfaceDataMatchHistoryBattleDTOMap();

	factory MatchDiskSurfaceDataMatchHistoryBattleDTOMap.fromJson(Map<String, dynamic> json) => $MatchDiskSurfaceDataMatchHistoryBattleDTOMapFromJson(json);

	Map<String, dynamic> toJson() => $MatchDiskSurfaceDataMatchHistoryBattleDTOMapToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MatchDiskSurfaceDataMatchHistoryBattleDTOMap1 {
	List<int>? handicapResultList;
	List<MatchDiskSurfaceDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOList>? matchHistoryBattleDetailDTOList;
	List<int>? overunderResultList;

	MatchDiskSurfaceDataMatchHistoryBattleDTOMap1();

	factory MatchDiskSurfaceDataMatchHistoryBattleDTOMap1.fromJson(Map<String, dynamic> json) => $MatchDiskSurfaceDataMatchHistoryBattleDTOMap1FromJson(json);

	Map<String, dynamic> toJson() => $MatchDiskSurfaceDataMatchHistoryBattleDTOMap1ToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MatchDiskSurfaceDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOList {
	int? handicapResultEqual;
	int? handicapResultLose;
	int? handicapResultWin;
	double? handicapResultWinRate;
	int? overunderResultEqual;
	int? overunderResultLose;
	double? overunderResultLoseRate;
	int? overunderResultWin;
	double? overunderResultWinRate;
	int? postionFlag;

	MatchDiskSurfaceDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOList();

	factory MatchDiskSurfaceDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOList.fromJson(Map<String, dynamic> json) => $MatchDiskSurfaceDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOListFromJson(json);

	Map<String, dynamic> toJson() => $MatchDiskSurfaceDataMatchHistoryBattleDTOMap1MatchHistoryBattleDetailDTOListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MatchDiskSurfaceDataMatchHistoryBattleDTOMap2 {
	List<int>? handicapResultList;
	List<MatchDiskSurfaceDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOList>? matchHistoryBattleDetailDTOList;
	List<int>? overunderResultList;

	MatchDiskSurfaceDataMatchHistoryBattleDTOMap2();

	factory MatchDiskSurfaceDataMatchHistoryBattleDTOMap2.fromJson(Map<String, dynamic> json) => $MatchDiskSurfaceDataMatchHistoryBattleDTOMap2FromJson(json);

	Map<String, dynamic> toJson() => $MatchDiskSurfaceDataMatchHistoryBattleDTOMap2ToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MatchDiskSurfaceDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOList {
	int? handicapResultEqual;
	int? handicapResultLose;
	int? handicapResultWin;
	double? handicapResultWinRate;
	int? overunderResultEqual;
	int? overunderResultLose;
	double? overunderResultLoseRate;
	int? overunderResultWin;
	double? overunderResultWinRate;
	int? postionFlag;

	MatchDiskSurfaceDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOList();

	factory MatchDiskSurfaceDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOList.fromJson(Map<String, dynamic> json) => $MatchDiskSurfaceDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOListFromJson(json);

	Map<String, dynamic> toJson() => $MatchDiskSurfaceDataMatchHistoryBattleDTOMap2MatchHistoryBattleDetailDTOListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}