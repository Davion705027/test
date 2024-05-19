import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/macth_details_news_new_entity.dart';

MacthDetailsNewsNewEntity $MacthDetailsNewsNewEntityFromJson(
    Map<String, dynamic> json) {
  final MacthDetailsNewsNewEntity macthDetailsNewsNewEntity = MacthDetailsNewsNewEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    macthDetailsNewsNewEntity.code = code;
  }
  final MacthDetailsNewsNewData? data = jsonConvert.convert<
      MacthDetailsNewsNewData>(json['data']);
  if (data != null) {
    macthDetailsNewsNewEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    macthDetailsNewsNewEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    macthDetailsNewsNewEntity.ts = ts;
  }
  return macthDetailsNewsNewEntity;
}

Map<String, dynamic> $MacthDetailsNewsNewEntityToJson(
    MacthDetailsNewsNewEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data?.toJson();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension MacthDetailsNewsNewEntityExtension on MacthDetailsNewsNewEntity {
  MacthDetailsNewsNewEntity copyWith({
    String? code,
    MacthDetailsNewsNewData? data,
    String? msg,
    int? ts,
  }) {
    return MacthDetailsNewsNewEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

MacthDetailsNewsNewData $MacthDetailsNewsNewDataFromJson(
    Map<String, dynamic> json) {
  final MacthDetailsNewsNewData macthDetailsNewsNewData = MacthDetailsNewsNewData();
  final String? articleContent = jsonConvert.convert<String>(
      json['articleContent']);
  if (articleContent != null) {
    macthDetailsNewsNewData.articleContent = articleContent;
  }
  final dynamic articleId = json['articleId'];
  if (articleId != null) {
    macthDetailsNewsNewData.articleId = articleId;
  }
  final String? articleTittle = jsonConvert.convert<String>(
      json['articleTittle']);
  if (articleTittle != null) {
    macthDetailsNewsNewData.articleTittle = articleTittle;
  }
  final String? authorName = jsonConvert.convert<String>(json['authorName']);
  if (authorName != null) {
    macthDetailsNewsNewData.authorName = authorName;
  }
  final String? categoryName = jsonConvert.convert<String>(
      json['categoryName']);
  if (categoryName != null) {
    macthDetailsNewsNewData.categoryName = categoryName;
  }
  final int? count = jsonConvert.convert<int>(json['count']);
  if (count != null) {
    macthDetailsNewsNewData.count = count;
  }
  final dynamic excludeIds = json['excludeIds'];
  if (excludeIds != null) {
    macthDetailsNewsNewData.excludeIds = excludeIds;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    macthDetailsNewsNewData.id = id;
  }
  final String? matchDetail = jsonConvert.convert<String>(json['matchDetail']);
  if (matchDetail != null) {
    macthDetailsNewsNewData.matchDetail = matchDetail;
  }
  final String? matchId = jsonConvert.convert<String>(json['matchId']);
  if (matchId != null) {
    macthDetailsNewsNewData.matchId = matchId;
  }
  final String? readCounts = jsonConvert.convert<String>(json['readCounts']);
  if (readCounts != null) {
    macthDetailsNewsNewData.readCounts = readCounts;
  }
  final String? showTime = jsonConvert.convert<String>(json['showTime']);
  if (showTime != null) {
    macthDetailsNewsNewData.showTime = showTime;
  }
  final String? sportId = jsonConvert.convert<String>(json['sportId']);
  if (sportId != null) {
    macthDetailsNewsNewData.sportId = sportId;
  }
  final String? summary = jsonConvert.convert<String>(json['summary']);
  if (summary != null) {
    macthDetailsNewsNewData.summary = summary;
  }
  final String? tagColor = jsonConvert.convert<String>(json['tagColor']);
  if (tagColor != null) {
    macthDetailsNewsNewData.tagColor = tagColor;
  }
  final String? tagName = jsonConvert.convert<String>(json['tagName']);
  if (tagName != null) {
    macthDetailsNewsNewData.tagName = tagName;
  }
  final String? thumbnails = jsonConvert.convert<String>(json['thumbnails']);
  if (thumbnails != null) {
    macthDetailsNewsNewData.thumbnails = thumbnails;
  }
  final String? updateTime = jsonConvert.convert<String>(json['updateTime']);
  if (updateTime != null) {
    macthDetailsNewsNewData.updateTime = updateTime;
  }
  return macthDetailsNewsNewData;
}

Map<String, dynamic> $MacthDetailsNewsNewDataToJson(
    MacthDetailsNewsNewData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['articleContent'] = entity.articleContent;
  data['articleId'] = entity.articleId;
  data['articleTittle'] = entity.articleTittle;
  data['authorName'] = entity.authorName;
  data['categoryName'] = entity.categoryName;
  data['count'] = entity.count;
  data['excludeIds'] = entity.excludeIds;
  data['id'] = entity.id;
  data['matchDetail'] = entity.matchDetail;
  data['matchId'] = entity.matchId;
  data['readCounts'] = entity.readCounts;
  data['showTime'] = entity.showTime;
  data['sportId'] = entity.sportId;
  data['summary'] = entity.summary;
  data['tagColor'] = entity.tagColor;
  data['tagName'] = entity.tagName;
  data['thumbnails'] = entity.thumbnails;
  data['updateTime'] = entity.updateTime;
  return data;
}

extension MacthDetailsNewsNewDataExtension on MacthDetailsNewsNewData {
  MacthDetailsNewsNewData copyWith({
    String? articleContent,
    dynamic articleId,
    String? articleTittle,
    String? authorName,
    String? categoryName,
    int? count,
    dynamic excludeIds,
    String? id,
    String? matchDetail,
    String? matchId,
    String? readCounts,
    String? showTime,
    String? sportId,
    String? summary,
    String? tagColor,
    String? tagName,
    String? thumbnails,
    String? updateTime,
  }) {
    return MacthDetailsNewsNewData()
      ..articleContent = articleContent ?? this.articleContent
      ..articleId = articleId ?? this.articleId
      ..articleTittle = articleTittle ?? this.articleTittle
      ..authorName = authorName ?? this.authorName
      ..categoryName = categoryName ?? this.categoryName
      ..count = count ?? this.count
      ..excludeIds = excludeIds ?? this.excludeIds
      ..id = id ?? this.id
      ..matchDetail = matchDetail ?? this.matchDetail
      ..matchId = matchId ?? this.matchId
      ..readCounts = readCounts ?? this.readCounts
      ..showTime = showTime ?? this.showTime
      ..sportId = sportId ?? this.sportId
      ..summary = summary ?? this.summary
      ..tagColor = tagColor ?? this.tagColor
      ..tagName = tagName ?? this.tagName
      ..thumbnails = thumbnails ?? this.thumbnails
      ..updateTime = updateTime ?? this.updateTime;
  }
}