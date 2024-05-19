import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/playback_video_url_entity.dart';

PlaybackVideoUrlEntity $PlaybackVideoUrlEntityFromJson(
    Map<String, dynamic> json) {
  final PlaybackVideoUrlEntity playbackVideoUrlEntity = PlaybackVideoUrlEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    playbackVideoUrlEntity.code = code;
  }
  final PlaybackVideoUrlData? data = jsonConvert.convert<PlaybackVideoUrlData>(
      json['data']);
  if (data != null) {
    playbackVideoUrlEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    playbackVideoUrlEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    playbackVideoUrlEntity.ts = ts;
  }
  return playbackVideoUrlEntity;
}

Map<String, dynamic> $PlaybackVideoUrlEntityToJson(
    PlaybackVideoUrlEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.toJson();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension PlaybackVideoUrlEntityExtension on PlaybackVideoUrlEntity {
  PlaybackVideoUrlEntity copyWith({
    String? code,
    PlaybackVideoUrlData? data,
    String? msg,
    int? ts,
  }) {
    return PlaybackVideoUrlEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

PlaybackVideoUrlData $PlaybackVideoUrlDataFromJson(Map<String, dynamic> json) {
  final PlaybackVideoUrlData playbackVideoUrlData = PlaybackVideoUrlData();
  final List<
      PlaybackVideoUrlDataEventList>? eventList = (json['eventList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<PlaybackVideoUrlDataEventList>(
          e) as PlaybackVideoUrlDataEventList).toList();
  if (eventList != null) {
    playbackVideoUrlData.eventList = eventList;
  }
  final String? playBackPicUrl = jsonConvert.convert<String>(
      json['playBackPicUrl']);
  if (playBackPicUrl != null) {
    playbackVideoUrlData.playBackPicUrl = playBackPicUrl;
  }
  final String? playBackUrl = jsonConvert.convert<String>(json['playBackUrl']);
  if (playBackUrl != null) {
    playbackVideoUrlData.playBackUrl = playBackUrl;
  }
  final String? referUrl = jsonConvert.convert<String>(json['referUrl']);
  if (referUrl != null) {
    playbackVideoUrlData.referUrl = referUrl;
  }
  final String? serverTime = jsonConvert.convert<String>(json['serverTime']);
  if (serverTime != null) {
    playbackVideoUrlData.serverTime = serverTime;
  }
  return playbackVideoUrlData;
}

Map<String, dynamic> $PlaybackVideoUrlDataToJson(PlaybackVideoUrlData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['eventList'] = entity.eventList.map((v) => v.toJson()).toList();
  data['playBackPicUrl'] = entity.playBackPicUrl;
  data['playBackUrl'] = entity.playBackUrl;
  data['referUrl'] = entity.referUrl;
  data['serverTime'] = entity.serverTime;
  return data;
}

extension PlaybackVideoUrlDataExtension on PlaybackVideoUrlData {
  PlaybackVideoUrlData copyWith({
    List<PlaybackVideoUrlDataEventList>? eventList,
    String? playBackPicUrl,
    String? playBackUrl,
    String? referUrl,
    String? serverTime,
  }) {
    return PlaybackVideoUrlData()
      ..eventList = eventList ?? this.eventList
      ..playBackPicUrl = playBackPicUrl ?? this.playBackPicUrl
      ..playBackUrl = playBackUrl ?? this.playBackUrl
      ..referUrl = referUrl ?? this.referUrl
      ..serverTime = serverTime ?? this.serverTime;
  }
}

PlaybackVideoUrlDataEventList $PlaybackVideoUrlDataEventListFromJson(
    Map<String, dynamic> json) {
  final PlaybackVideoUrlDataEventList playbackVideoUrlDataEventList = PlaybackVideoUrlDataEventList();
  final dynamic createTime = json['createTime'];
  if (createTime != null) {
    playbackVideoUrlDataEventList.createTime = createTime;
  }
  final String? eventCode = jsonConvert.convert<String>(json['eventCode']);
  if (eventCode != null) {
    playbackVideoUrlDataEventList.eventCode = eventCode;
  }
  final String? eventId = jsonConvert.convert<String>(json['eventId']);
  if (eventId != null) {
    playbackVideoUrlDataEventList.eventId = eventId;
  }
  final String? eventTime = jsonConvert.convert<String>(json['eventTime']);
  if (eventTime != null) {
    playbackVideoUrlDataEventList.eventTime = eventTime;
  }
  final String? extraInfo = jsonConvert.convert<String>(json['extraInfo']);
  if (extraInfo != null) {
    playbackVideoUrlDataEventList.extraInfo = extraInfo;
  }
  final int? firstNum = jsonConvert.convert<int>(json['firstNum']);
  if (firstNum != null) {
    playbackVideoUrlDataEventList.firstNum = firstNum;
  }
  final String? fragmentCode = jsonConvert.convert<String>(
      json['fragmentCode']);
  if (fragmentCode != null) {
    playbackVideoUrlDataEventList.fragmentCode = fragmentCode;
  }
  final String? fragmentId = jsonConvert.convert<String>(json['fragmentId']);
  if (fragmentId != null) {
    playbackVideoUrlDataEventList.fragmentId = fragmentId;
  }
  final String? fragmentPic = jsonConvert.convert<String>(json['fragmentPic']);
  if (fragmentPic != null) {
    playbackVideoUrlDataEventList.fragmentPic = fragmentPic;
  }
  final String? fragmentVideo = jsonConvert.convert<String>(
      json['fragmentVideo']);
  if (fragmentVideo != null) {
    playbackVideoUrlDataEventList.fragmentVideo = fragmentVideo;
  }
  final String? homeAway = jsonConvert.convert<String>(json['homeAway']);
  if (homeAway != null) {
    playbackVideoUrlDataEventList.homeAway = homeAway;
  }
  final String? isHomeOrAway = jsonConvert.convert<String>(
      json['isHomeOrAway']);
  if (isHomeOrAway != null) {
    playbackVideoUrlDataEventList.isHomeOrAway = isHomeOrAway;
  }
  final String? matchPeriodId = jsonConvert.convert<String>(
      json['matchPeriodId']);
  if (matchPeriodId != null) {
    playbackVideoUrlDataEventList.matchPeriodId = matchPeriodId;
  }
  final String? mid = jsonConvert.convert<String>(json['mid']);
  if (mid != null) {
    playbackVideoUrlDataEventList.mid = mid;
  }
  final int? secondsFromStart = jsonConvert.convert<int>(
      json['secondsFromStart']);
  if (secondsFromStart != null) {
    playbackVideoUrlDataEventList.secondsFromStart = secondsFromStart;
  }
  final int? t1 = jsonConvert.convert<int>(json['t1']);
  if (t1 != null) {
    playbackVideoUrlDataEventList.t1 = t1;
  }
  final int? t2 = jsonConvert.convert<int>(json['t2']);
  if (t2 != null) {
    playbackVideoUrlDataEventList.t2 = t2;
  }
  return playbackVideoUrlDataEventList;
}

Map<String, dynamic> $PlaybackVideoUrlDataEventListToJson(
    PlaybackVideoUrlDataEventList entity) {
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

extension PlaybackVideoUrlDataEventListExtension on PlaybackVideoUrlDataEventList {
  PlaybackVideoUrlDataEventList copyWith({
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
    return PlaybackVideoUrlDataEventList()
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