import 'package:flutter_ty_app/generated/json/base/json_field.dart';
import 'package:flutter_ty_app/generated/json/analyze_back_video_info_entity_entity_entity_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class AnalyzeBackVideoInfoEntityEntityEntityEntity {

	List<AnalyzeBackVideoInfoEntityEntityEntityEventList>? eventList;
	String? playBackPicUrl;
	String? playBackUrl;
	String? referUrl;
	String? serverTime;
  
  AnalyzeBackVideoInfoEntityEntityEntityEntity();

  factory AnalyzeBackVideoInfoEntityEntityEntityEntity.fromJson(Map<String, dynamic> json) => $AnalyzeBackVideoInfoEntityEntityEntityEntityFromJson(json);

  Map<String, dynamic> toJson() => $AnalyzeBackVideoInfoEntityEntityEntityEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class AnalyzeBackVideoInfoEntityEntityEntityEventList {

	dynamic createTime;
	String? eventCode;
	String? eventId;
	String? eventTime;
	String? extraInfo;
	int? firstNum;
	String? fragmentCode;
	String? fragmentId;
	String? fragmentPic;
	String? fragmentVideo;
	String? homeAway;
	String? isHomeOrAway;
	String? matchPeriodId;
	String? mid;
	int? secondsFromStart;
	int? t1;
	int? t2;
  
  AnalyzeBackVideoInfoEntityEntityEntityEventList();

  factory AnalyzeBackVideoInfoEntityEntityEntityEventList.fromJson(Map<String, dynamic> json) => $AnalyzeBackVideoInfoEntityEntityEntityEventListFromJson(json);

  Map<String, dynamic> toJson() => $AnalyzeBackVideoInfoEntityEntityEntityEventListToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}