import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/live_video_url_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/live_video_url_entity.g.dart';

@JsonSerializable()
class LiveVideoUrlEntity {
	late String chatRoomId;
	dynamic crs;
	late String h5hdUrl;
	late String h5sdUrl;
	late String hdUrl;
	dynamic liveState;
	late String programPath;
	late String referUrl;
	late String sdUrl;
	late String serverTime;

	LiveVideoUrlEntity();

	factory LiveVideoUrlEntity.fromJson(Map<String, dynamic> json) => $LiveVideoUrlEntityFromJson(json);

	Map<String, dynamic> toJson() => $LiveVideoUrlEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}