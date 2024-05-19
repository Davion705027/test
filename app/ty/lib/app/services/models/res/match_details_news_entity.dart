import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/match_details_news_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class MatchDetailsNewsEntity {
	String? code;
	List<MatchDetailsNewsData>? data;
	String? msg;
	int? ts;

	MatchDetailsNewsEntity();

	factory MatchDetailsNewsEntity.fromJson(Map<String, dynamic> json) => $MatchDetailsNewsEntityFromJson(json);

	Map<String, dynamic> toJson() => $MatchDetailsNewsEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MatchDetailsNewsData {
	String? articleContent;
	dynamic articleId;
	String? articleTittle;
	String? authorName;
	String? categoryName;
	int? count;
	dynamic excludeIds;
	String? id;
	String? matchDetail;
	dynamic matchId;
	String? readCounts;
	String? showTime;
	String? sportId;
	String? summary;
	String? tagColor;
	String? tagName;
	String? thumbnails;
	String? updateTime;

	MatchDetailsNewsData();

	factory MatchDetailsNewsData.fromJson(Map<String, dynamic> json) => $MatchDetailsNewsDataFromJson(json);

	Map<String, dynamic> toJson() => $MatchDetailsNewsDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}