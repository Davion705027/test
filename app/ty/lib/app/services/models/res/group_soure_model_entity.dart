
import 'dart:convert';

import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/group_soure_model_entity.g.dart';

@JsonSerializable()
class GroupSoureModelEntity {
	late String status;
	late GroupSoureModelData data;

	GroupSoureModelEntity();

	factory GroupSoureModelEntity.fromJson(Map<String, dynamic> json) => $GroupSoureModelEntityFromJson(json);

	Map<String, dynamic> toJson() => $GroupSoureModelEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GroupSoureModelData {
	@JSONField(name: "group_data")
	late List<GroupSoureModelDataGroupData> groupData;
	@JSONField(name: "is_disuse")
	late int isDisuse;

	GroupSoureModelData();

	factory GroupSoureModelData.fromJson(Map<String, dynamic> json) => $GroupSoureModelDataFromJson(json);

	Map<String, dynamic> toJson() => $GroupSoureModelDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GroupSoureModelDataGroupData {
	late String groupId;
	late List<GroupSoureModelDataGroupDataSVirtualSportXZTeamRankingDetailPOList> sVirtualSportXZTeamRankingDetailPOList;

	GroupSoureModelDataGroupData();

	factory GroupSoureModelDataGroupData.fromJson(Map<String, dynamic> json) => $GroupSoureModelDataGroupDataFromJson(json);

	Map<String, dynamic> toJson() => $GroupSoureModelDataGroupDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GroupSoureModelDataGroupDataSVirtualSportXZTeamRankingDetailPOList {
	late int draw;
	late int goalsConceded;
	late int goalsScored;
	late int goalsWinning;
	late int lost;
	late int points;
	late int ranking;
	late String tid;
	late int totalCount;
	late String virtualTeamId;
	late String virtualTeamName;
	late int win;
	late String winDrawLostDescription;

	GroupSoureModelDataGroupDataSVirtualSportXZTeamRankingDetailPOList();

	factory GroupSoureModelDataGroupDataSVirtualSportXZTeamRankingDetailPOList.fromJson(Map<String, dynamic> json) => $GroupSoureModelDataGroupDataSVirtualSportXZTeamRankingDetailPOListFromJson(json);

	Map<String, dynamic> toJson() => $GroupSoureModelDataGroupDataSVirtualSportXZTeamRankingDetailPOListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}