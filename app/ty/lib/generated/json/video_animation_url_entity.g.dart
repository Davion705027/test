import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/video_animation_url_entity.dart';

VideoAnimationUrlEntity $VideoAnimationUrlEntityFromJson(
    Map<String, dynamic> json) {
  final VideoAnimationUrlEntity videoAnimationUrlEntity = VideoAnimationUrlEntity();
  final List<
      VideoAnimationUrlAnimation3Url>? animation3Url = (json['animation3Url'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<VideoAnimationUrlAnimation3Url>(
          e) as VideoAnimationUrlAnimation3Url).toList();
  if (animation3Url != null) {
    videoAnimationUrlEntity.animation3Url = animation3Url;
  }
  final String? animationUrl = jsonConvert.convert<String>(
      json['animationUrl']);
  if (animationUrl != null) {
    videoAnimationUrlEntity.animationUrl = animationUrl;
  }
  final String? referUrl = jsonConvert.convert<String>(json['referUrl']);
  if (referUrl != null) {
    videoAnimationUrlEntity.referUrl = referUrl;
  }
  final String? serverTime = jsonConvert.convert<String>(json['serverTime']);
  if (serverTime != null) {
    videoAnimationUrlEntity.serverTime = serverTime;
  }
  final List<dynamic>? videoUrlVOList = (json['videoUrlVOList'] as List<
      dynamic>?)?.map(
          (e) => e).toList();
  if (videoUrlVOList != null) {
    videoAnimationUrlEntity.videoUrlVOList = videoUrlVOList;
  }
  return videoAnimationUrlEntity;
}

Map<String, dynamic> $VideoAnimationUrlEntityToJson(
    VideoAnimationUrlEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['animation3Url'] = entity.animation3Url.map((v) => v.toJson()).toList();
  data['animationUrl'] = entity.animationUrl;
  data['referUrl'] = entity.referUrl;
  data['serverTime'] = entity.serverTime;
  data['videoUrlVOList'] = entity.videoUrlVOList;
  return data;
}

extension VideoAnimationUrlEntityExtension on VideoAnimationUrlEntity {
  VideoAnimationUrlEntity copyWith({
    List<VideoAnimationUrlAnimation3Url>? animation3Url,
    String? animationUrl,
    String? referUrl,
    String? serverTime,
    List<dynamic>? videoUrlVOList,
  }) {
    return VideoAnimationUrlEntity()
      ..animation3Url = animation3Url ?? this.animation3Url
      ..animationUrl = animationUrl ?? this.animationUrl
      ..referUrl = referUrl ?? this.referUrl
      ..serverTime = serverTime ?? this.serverTime
      ..videoUrlVOList = videoUrlVOList ?? this.videoUrlVOList;
  }
}

VideoAnimationUrlAnimation3Url $VideoAnimationUrlAnimation3UrlFromJson(
    Map<String, dynamic> json) {
  final VideoAnimationUrlAnimation3Url videoAnimationUrlAnimation3Url = VideoAnimationUrlAnimation3Url();
  final String? path = jsonConvert.convert<String>(json['path']);
  if (path != null) {
    videoAnimationUrlAnimation3Url.path = path;
  }
  final String? styleName = jsonConvert.convert<String>(json['styleName']);
  if (styleName != null) {
    videoAnimationUrlAnimation3Url.styleName = styleName;
  }
  return videoAnimationUrlAnimation3Url;
}

Map<String, dynamic> $VideoAnimationUrlAnimation3UrlToJson(
    VideoAnimationUrlAnimation3Url entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['path'] = entity.path;
  data['styleName'] = entity.styleName;
  return data;
}

extension VideoAnimationUrlAnimation3UrlExtension on VideoAnimationUrlAnimation3Url {
  VideoAnimationUrlAnimation3Url copyWith({
    String? path,
    String? styleName,
  }) {
    return VideoAnimationUrlAnimation3Url()
      ..path = path ?? this.path
      ..styleName = styleName ?? this.styleName;
  }
}