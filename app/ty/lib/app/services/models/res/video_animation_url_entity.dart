import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/video_animation_url_entity.g.dart';
import 'dart:convert';
export 'package:flutter_ty_app/generated/json/video_animation_url_entity.g.dart';

@JsonSerializable()
class VideoAnimationUrlEntity {
	late List<VideoAnimationUrlAnimation3Url> animation3Url;
	late String animationUrl;
	late String referUrl;
	late String serverTime;
	late List<dynamic> videoUrlVOList;

	VideoAnimationUrlEntity();

	factory VideoAnimationUrlEntity.fromJson(Map<String, dynamic> json) => $VideoAnimationUrlEntityFromJson(json);

	Map<String, dynamic> toJson() => $VideoAnimationUrlEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class VideoAnimationUrlAnimation3Url {
	late String path;
	late String styleName;

	VideoAnimationUrlAnimation3Url();

	factory VideoAnimationUrlAnimation3Url.fromJson(Map<String, dynamic> json) => $VideoAnimationUrlAnimation3UrlFromJson(json);

	Map<String, dynamic> toJson() => $VideoAnimationUrlAnimation3UrlToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}