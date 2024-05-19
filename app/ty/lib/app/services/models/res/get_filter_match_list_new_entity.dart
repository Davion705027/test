import 'package:flutter_ty_app/app/modules/setting_menu/league_filter/league_filter_controller.dart';
import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/get_filter_match_list_new_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/get_filter_match_list_new_entity.g.dart';

@JsonSerializable()
class GetFilterMatchListNewEntity {
	late String code;
	late List<GetFilterMatchListNewData> data;
	late String msg;
	late int ts;

	GetFilterMatchListNewEntity();

	factory GetFilterMatchListNewEntity.fromJson(Map<String, dynamic> json) => $GetFilterMatchListNewEntityFromJson(json);

	Map<String, dynamic> toJson() => $GetFilterMatchListNewEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GetFilterMatchListNewData {
	late int hotStatus;
	late String id;
	dynamic nameCode;
	late String nameText;
	late int num;
	late String picUrlthumb;
	late String regionId;
	late String spell;
	late String sportId;
	late String tournamentId;
	late int tournamentLevel;
	late String tournamentName;
  bool isSelect = false;
	/// TODO
	@JSONField(serialize: false, deserialize: false)
  late RenderGroupModel parent;

	GetFilterMatchListNewData();

	factory GetFilterMatchListNewData.fromJson(Map<String, dynamic> json) => $GetFilterMatchListNewDataFromJson(json);

	Map<String, dynamic> toJson() => $GetFilterMatchListNewDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}