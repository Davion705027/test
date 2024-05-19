import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/playback_video_url_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/playback_video_url_entity.g.dart';

@JsonSerializable()
class PlaybackVideoUrlEntity {
	late String code;
	late PlaybackVideoUrlData data;
	late String msg;
	late int ts;

	PlaybackVideoUrlEntity();

	factory PlaybackVideoUrlEntity.fromJson(Map<String, dynamic> json) => $PlaybackVideoUrlEntityFromJson(json);

	Map<String, dynamic> toJson() => $PlaybackVideoUrlEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class PlaybackVideoUrlData {
	late List<PlaybackVideoUrlDataEventList> eventList;
	late String playBackPicUrl;
	late String playBackUrl;
	late String referUrl;
	late String serverTime;

	PlaybackVideoUrlData();

	factory PlaybackVideoUrlData.fromJson(Map<String, dynamic> json) => $PlaybackVideoUrlDataFromJson(json);

	Map<String, dynamic> toJson() => $PlaybackVideoUrlDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class PlaybackVideoUrlDataEventList {
	dynamic createTime;
	late String eventCode;
	late String eventId;
	late String eventTime;
	late String extraInfo;
	late int firstNum;
	late String fragmentCode;
	late String fragmentId;
	late String fragmentPic;
	late String fragmentVideo;
	late String homeAway;
	late String isHomeOrAway;
	late String matchPeriodId;
	late String mid;
	late int secondsFromStart;
	late int t1;
	late int t2;

	PlaybackVideoUrlDataEventList();

	factory PlaybackVideoUrlDataEventList.fromJson(Map<String, dynamic> json) => $PlaybackVideoUrlDataEventListFromJson(json);

	Map<String, dynamic> toJson() => $PlaybackVideoUrlDataEventListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}