import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/macth_details_news_new_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class MacthDetailsNewsNewEntity {
	String? code;
	MacthDetailsNewsNewData? data;
	String? msg;
	int? ts;

	MacthDetailsNewsNewEntity();

	factory MacthDetailsNewsNewEntity.fromJson(Map<String, dynamic> json) => $MacthDetailsNewsNewEntityFromJson(json);

	Map<String, dynamic> toJson() => $MacthDetailsNewsNewEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MacthDetailsNewsNewData {
	String? articleContent;
	dynamic articleId;
	String? articleTittle;
	String? authorName;
	String? categoryName;
	int? count;
	dynamic excludeIds;
	String? id;
	String? matchDetail;
	String? matchId;
	String? readCounts;
	String? showTime;
	String? sportId;
	String? summary;
	String? tagColor;
	String? tagName;
	String? thumbnails;
	String? updateTime;

	MacthDetailsNewsNewData();

	factory MacthDetailsNewsNewData.fromJson(Map<String, dynamic> json) => $MacthDetailsNewsNewDataFromJson(json);

	Map<String, dynamic> toJson() => $MacthDetailsNewsNewDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}