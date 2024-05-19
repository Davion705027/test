import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_back_video_info_entity_entity_entity_entity.dart';

AnalyzeBackVideoInfoEntityEntityEntityEntity $AnalyzeBackVideoInfoEntityEntityEntityEntityFromJson(
    Map<String, dynamic> json) {
  final AnalyzeBackVideoInfoEntityEntityEntityEntity analyzeBackVideoInfoEntityEntityEntityEntity = AnalyzeBackVideoInfoEntityEntityEntityEntity();
  final List<
      AnalyzeBackVideoInfoEntityEntityEntityEventList>? eventList = (json['eventList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<
          AnalyzeBackVideoInfoEntityEntityEntityEventList>(
          e) as AnalyzeBackVideoInfoEntityEntityEntityEventList).toList();
  if (eventList != null) {
    analyzeBackVideoInfoEntityEntityEntityEntity.eventList = eventList;
  }
  final String? playBackPicUrl = jsonConvert.convert<String>(
      json['playBackPicUrl']);
  if (playBackPicUrl != null) {
    analyzeBackVideoInfoEntityEntityEntityEntity.playBackPicUrl =
        playBackPicUrl;
  }
  final String? playBackUrl = jsonConvert.convert<String>(json['playBackUrl']);
  if (playBackUrl != null) {
    analyzeBackVideoInfoEntityEntityEntityEntity.playBackUrl = playBackUrl;
  }
  final String? referUrl = jsonConvert.convert<String>(json['referUrl']);
  if (referUrl != null) {
    analyzeBackVideoInfoEntityEntityEntityEntity.referUrl = referUrl;
  }
  final String? serverTime = jsonConvert.convert<String>(json['serverTime']);
  if (serverTime != null) {
    analyzeBackVideoInfoEntityEntityEntityEntity.serverTime = serverTime;
  }
  return analyzeBackVideoInfoEntityEntityEntityEntity;
}

Map<String, dynamic> $AnalyzeBackVideoInfoEntityEntityEntityEntityToJson(
    AnalyzeBackVideoInfoEntityEntityEntityEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['eventList'] = entity.eventList?.map((v) => v.toJson()).toList();
  data['playBackPicUrl'] = entity.playBackPicUrl;
  data['playBackUrl'] = entity.playBackUrl;
  data['referUrl'] = entity.referUrl;
  data['serverTime'] = entity.serverTime;
  return data;
}

extension AnalyzeBackVideoInfoEntityEntityEntityEntityExtension on AnalyzeBackVideoInfoEntityEntityEntityEntity {
  AnalyzeBackVideoInfoEntityEntityEntityEntity copyWith({
    List<AnalyzeBackVideoInfoEntityEntityEntityEventList>? eventList,
    String? playBackPicUrl,
    String? playBackUrl,
    String? referUrl,
    String? serverTime,
  }) {
    return AnalyzeBackVideoInfoEntityEntityEntityEntity()
      ..eventList = eventList ?? this.eventList
      ..playBackPicUrl = playBackPicUrl ?? this.playBackPicUrl
      ..playBackUrl = playBackUrl ?? this.playBackUrl
      ..referUrl = referUrl ?? this.referUrl
      ..serverTime = serverTime ?? this.serverTime;
  }
}

AnalyzeBackVideoInfoEntityEntityEntityEventList $AnalyzeBackVideoInfoEntityEntityEntityEventListFromJson(
    Map<String, dynamic> json) {
  final AnalyzeBackVideoInfoEntityEntityEntityEventList analyzeBackVideoInfoEntityEntityEntityEventList = AnalyzeBackVideoInfoEntityEntityEntityEventList();
  final dynamic createTime = json['createTime'];
  if (createTime != null) {
    analyzeBackVideoInfoEntityEntityEntityEventList.createTime = createTime;
  }
  final String? eventCode = jsonConvert.convert<String>(json['eventCode']);
  if (eventCode != null) {
    analyzeBackVideoInfoEntityEntityEntityEventList.eventCode = eventCode;
  }
  final String? eventId = jsonConvert.convert<String>(json['eventId']);
  if (eventId != null) {
    analyzeBackVideoInfoEntityEntityEntityEventList.eventId = eventId;
  }
  final String? eventTime = jsonConvert.convert<String>(json['eventTime']);
  if (eventTime != null) {
    analyzeBackVideoInfoEntityEntityEntityEventList.eventTime = eventTime;
  }
  final String? extraInfo = jsonConvert.convert<String>(json['extraInfo']);
  if (extraInfo != null) {
    analyzeBackVideoInfoEntityEntityEntityEventList.extraInfo = extraInfo;
  }
  final int? firstNum = jsonConvert.convert<int>(json['firstNum']);
  if (firstNum != null) {
    analyzeBackVideoInfoEntityEntityEntityEventList.firstNum = firstNum;
  }
  final String? fragmentCode = jsonConvert.convert<String>(
      json['fragmentCode']);
  if (fragmentCode != null) {
    analyzeBackVideoInfoEntityEntityEntityEventList.fragmentCode = fragmentCode;
  }
  final String? fragmentId = jsonConvert.convert<String>(json['fragmentId']);
  if (fragmentId != null) {
    analyzeBackVideoInfoEntityEntityEntityEventList.fragmentId = fragmentId;
  }
  final String? fragmentPic = jsonConvert.convert<String>(json['fragmentPic']);
  if (fragmentPic != null) {
    analyzeBackVideoInfoEntityEntityEntityEventList.fragmentPic = fragmentPic;
  }
  final String? fragmentVideo = jsonConvert.convert<String>(
      json['fragmentVideo']);
  if (fragmentVideo != null) {
    analyzeBackVideoInfoEntityEntityEntityEventList.fragmentVideo =
        fragmentVideo;
  }
  final String? homeAway = jsonConvert.convert<String>(json['homeAway']);
  if (homeAway != null) {
    analyzeBackVideoInfoEntityEntityEntityEventList.homeAway = homeAway;
  }
  final String? isHomeOrAway = jsonConvert.convert<String>(
      json['isHomeOrAway']);
  if (isHomeOrAway != null) {
    analyzeBackVideoInfoEntityEntityEntityEventList.isHomeOrAway = isHomeOrAway;
  }
  final String? matchPeriodId = jsonConvert.convert<String>(
      json['matchPeriodId']);
  if (matchPeriodId != null) {
    analyzeBackVideoInfoEntityEntityEntityEventList.matchPeriodId =
        matchPeriodId;
  }
  final String? mid = jsonConvert.convert<String>(json['mid']);
  if (mid != null) {
    analyzeBackVideoInfoEntityEntityEntityEventList.mid = mid;
  }
  final int? secondsFromStart = jsonConvert.convert<int>(
      json['secondsFromStart']);
  if (secondsFromStart != null) {
    analyzeBackVideoInfoEntityEntityEntityEventList.secondsFromStart =
        secondsFromStart;
  }
  final int? t1 = jsonConvert.convert<int>(json['t1']);
  if (t1 != null) {
    analyzeBackVideoInfoEntityEntityEntityEventList.t1 = t1;
  }
  final int? t2 = jsonConvert.convert<int>(json['t2']);
  if (t2 != null) {
    analyzeBackVideoInfoEntityEntityEntityEventList.t2 = t2;
  }
  return analyzeBackVideoInfoEntityEntityEntityEventList;
}

Map<String, dynamic> $AnalyzeBackVideoInfoEntityEntityEntityEventListToJson(
    AnalyzeBackVideoInfoEntityEntityEntityEventList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['createTime'] = entity.createTime;
  data['eventCode'] = entity.eventCode;
  data['eventId'] = entity.eventId;
  data['eventTime'] = entity.eventTime;
  data['extraInfo'] = entity.extraInfo;
  data['firstNum'] = entity.firstNum;
  data['fragmentCode'] = entity.fragmentCode;
  data['fragmentId'] = entity.fragmentId;
  data['fragmentPic'] = entity.fragmentPic;
  data['fragmentVideo'] = entity.fragmentVideo;
  data['homeAway'] = entity.homeAway;
  data['isHomeOrAway'] = entity.isHomeOrAway;
  data['matchPeriodId'] = entity.matchPeriodId;
  data['mid'] = entity.mid;
  data['secondsFromStart'] = entity.secondsFromStart;
  data['t1'] = entity.t1;
  data['t2'] = entity.t2;
  return data;
}

extension AnalyzeBackVideoInfoEntityEntityEntityEventListExtension on AnalyzeBackVideoInfoEntityEntityEntityEventList {
  AnalyzeBackVideoInfoEntityEntityEntityEventList copyWith({
    dynamic createTime,
    String? eventCode,
    String? eventId,
    String? eventTime,
    String? extraInfo,
    int? firstNum,
    String? fragmentCode,
    String? fragmentId,
    String? fragmentPic,
    String? fragmentVideo,
    String? homeAway,
    String? isHomeOrAway,
    String? matchPeriodId,
    String? mid,
    int? secondsFromStart,
    int? t1,
    int? t2,
  }) {
    return AnalyzeBackVideoInfoEntityEntityEntityEventList()
      ..createTime = createTime ?? this.createTime
      ..eventCode = eventCode ?? this.eventCode
      ..eventId = eventId ?? this.eventId
      ..eventTime = eventTime ?? this.eventTime
      ..extraInfo = extraInfo ?? this.extraInfo
      ..firstNum = firstNum ?? this.firstNum
      ..fragmentCode = fragmentCode ?? this.fragmentCode
      ..fragmentId = fragmentId ?? this.fragmentId
      ..fragmentPic = fragmentPic ?? this.fragmentPic
      ..fragmentVideo = fragmentVideo ?? this.fragmentVideo
      ..homeAway = homeAway ?? this.homeAway
      ..isHomeOrAway = isHomeOrAway ?? this.isHomeOrAway
      ..matchPeriodId = matchPeriodId ?? this.matchPeriodId
      ..mid = mid ?? this.mid
      ..secondsFromStart = secondsFromStart ?? this.secondsFromStart
      ..t1 = t1 ?? this.t1
      ..t2 = t2 ?? this.t2;
  }
}