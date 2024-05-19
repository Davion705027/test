import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/live_video_url_entity.dart';

LiveVideoUrlEntity $LiveVideoUrlEntityFromJson(Map<String, dynamic> json) {
  final LiveVideoUrlEntity liveVideoUrlEntity = LiveVideoUrlEntity();
  final String? chatRoomId = jsonConvert.convert<String>(json['chatRoomId']);
  if (chatRoomId != null) {
    liveVideoUrlEntity.chatRoomId = chatRoomId;
  }
  final dynamic crs = json['crs'];
  if (crs != null) {
    liveVideoUrlEntity.crs = crs;
  }
  final String? h5hdUrl = jsonConvert.convert<String>(json['h5hdUrl']);
  if (h5hdUrl != null) {
    liveVideoUrlEntity.h5hdUrl = h5hdUrl;
  }
  final String? h5sdUrl = jsonConvert.convert<String>(json['h5sdUrl']);
  if (h5sdUrl != null) {
    liveVideoUrlEntity.h5sdUrl = h5sdUrl;
  }
  final String? hdUrl = jsonConvert.convert<String>(json['hdUrl']);
  if (hdUrl != null) {
    liveVideoUrlEntity.hdUrl = hdUrl;
  }
  final dynamic liveState = json['liveState'];
  if (liveState != null) {
    liveVideoUrlEntity.liveState = liveState;
  }
  final String? programPath = jsonConvert.convert<String>(json['programPath']);
  if (programPath != null) {
    liveVideoUrlEntity.programPath = programPath;
  }
  final String? referUrl = jsonConvert.convert<String>(json['referUrl']);
  if (referUrl != null) {
    liveVideoUrlEntity.referUrl = referUrl;
  }
  final String? sdUrl = jsonConvert.convert<String>(json['sdUrl']);
  if (sdUrl != null) {
    liveVideoUrlEntity.sdUrl = sdUrl;
  }
  final String? serverTime = jsonConvert.convert<String>(json['serverTime']);
  if (serverTime != null) {
    liveVideoUrlEntity.serverTime = serverTime;
  }
  return liveVideoUrlEntity;
}

Map<String, dynamic> $LiveVideoUrlEntityToJson(LiveVideoUrlEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['chatRoomId'] = entity.chatRoomId;
  data['crs'] = entity.crs;
  data['h5hdUrl'] = entity.h5hdUrl;
  data['h5sdUrl'] = entity.h5sdUrl;
  data['hdUrl'] = entity.hdUrl;
  data['liveState'] = entity.liveState;
  data['programPath'] = entity.programPath;
  data['referUrl'] = entity.referUrl;
  data['sdUrl'] = entity.sdUrl;
  data['serverTime'] = entity.serverTime;
  return data;
}

extension LiveVideoUrlEntityExtension on LiveVideoUrlEntity {
  LiveVideoUrlEntity copyWith({
    String? chatRoomId,
    dynamic crs,
    String? h5hdUrl,
    String? h5sdUrl,
    String? hdUrl,
    dynamic liveState,
    String? programPath,
    String? referUrl,
    String? sdUrl,
    String? serverTime,
  }) {
    return LiveVideoUrlEntity()
      ..chatRoomId = chatRoomId ?? this.chatRoomId
      ..crs = crs ?? this.crs
      ..h5hdUrl = h5hdUrl ?? this.h5hdUrl
      ..h5sdUrl = h5sdUrl ?? this.h5sdUrl
      ..hdUrl = hdUrl ?? this.hdUrl
      ..liveState = liveState ?? this.liveState
      ..programPath = programPath ?? this.programPath
      ..referUrl = referUrl ?? this.referUrl
      ..sdUrl = sdUrl ?? this.sdUrl
      ..serverTime = serverTime ?? this.serverTime;
  }
}