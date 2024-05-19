import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/match_details_news_entity.dart';

MatchDetailsNewsEntity $MatchDetailsNewsEntityFromJson(
    Map<String, dynamic> json) {
  final MatchDetailsNewsEntity matchDetailsNewsEntity = MatchDetailsNewsEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    matchDetailsNewsEntity.code = code;
  }
  final List<MatchDetailsNewsData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<MatchDetailsNewsData>(e) as MatchDetailsNewsData)
      .toList();
  if (data != null) {
    matchDetailsNewsEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    matchDetailsNewsEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    matchDetailsNewsEntity.ts = ts;
  }
  return matchDetailsNewsEntity;
}

Map<String, dynamic> $MatchDetailsNewsEntityToJson(
    MatchDetailsNewsEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension MatchDetailsNewsEntityExtension on MatchDetailsNewsEntity {
  MatchDetailsNewsEntity copyWith({
    String? code,
    List<MatchDetailsNewsData>? data,
    String? msg,
    int? ts,
  }) {
    return MatchDetailsNewsEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

MatchDetailsNewsData $MatchDetailsNewsDataFromJson(Map<String, dynamic> json) {
  final MatchDetailsNewsData matchDetailsNewsData = MatchDetailsNewsData();
  final String? articleContent = jsonConvert.convert<String>(
      json['articleContent']);
  if (articleContent != null) {
    matchDetailsNewsData.articleContent = articleContent;
  }
  final dynamic articleId = json['articleId'];
  if (articleId != null) {
    matchDetailsNewsData.articleId = articleId;
  }
  final String? articleTittle = jsonConvert.convert<String>(
      json['articleTittle']);
  if (articleTittle != null) {
    matchDetailsNewsData.articleTittle = articleTittle;
  }
  final String? authorName = jsonConvert.convert<String>(json['authorName']);
  if (authorName != null) {
    matchDetailsNewsData.authorName = authorName;
  }
  final String? categoryName = jsonConvert.convert<String>(
      json['categoryName']);
  if (categoryName != null) {
    matchDetailsNewsData.categoryName = categoryName;
  }
  final int? count = jsonConvert.convert<int>(json['count']);
  if (count != null) {
    matchDetailsNewsData.count = count;
  }
  final dynamic excludeIds = json['excludeIds'];
  if (excludeIds != null) {
    matchDetailsNewsData.excludeIds = excludeIds;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    matchDetailsNewsData.id = id;
  }
  final String? matchDetail = jsonConvert.convert<String>(json['matchDetail']);
  if (matchDetail != null) {
    matchDetailsNewsData.matchDetail = matchDetail;
  }
  final dynamic matchId = json['matchId'];
  if (matchId != null) {
    matchDetailsNewsData.matchId = matchId;
  }
  final String? readCounts = jsonConvert.convert<String>(json['readCounts']);
  if (readCounts != null) {
    matchDetailsNewsData.readCounts = readCounts;
  }
  final String? showTime = jsonConvert.convert<String>(json['showTime']);
  if (showTime != null) {
    matchDetailsNewsData.showTime = showTime;
  }
  final String? sportId = jsonConvert.convert<String>(json['sportId']);
  if (sportId != null) {
    matchDetailsNewsData.sportId = sportId;
  }
  final String? summary = jsonConvert.convert<String>(json['summary']);
  if (summary != null) {
    matchDetailsNewsData.summary = summary;
  }
  final String? tagColor = jsonConvert.convert<String>(json['tagColor']);
  if (tagColor != null) {
    matchDetailsNewsData.tagColor = tagColor;
  }
  final String? tagName = jsonConvert.convert<String>(json['tagName']);
  if (tagName != null) {
    matchDetailsNewsData.tagName = tagName;
  }
  final String? thumbnails = jsonConvert.convert<String>(json['thumbnails']);
  if (thumbnails != null) {
    matchDetailsNewsData.thumbnails = thumbnails;
  }
  final String? updateTime = jsonConvert.convert<String>(json['updateTime']);
  if (updateTime != null) {
    matchDetailsNewsData.updateTime = updateTime;
  }
  return matchDetailsNewsData;
}

Map<String, dynamic> $MatchDetailsNewsDataToJson(MatchDetailsNewsData entity) {
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

extension MatchDetailsNewsDataExtension on MatchDetailsNewsData {
  MatchDetailsNewsData copyWith({
    String? articleContent,
    dynamic articleId,
    String? articleTittle,
    String? authorName,
    String? categoryName,
    int? count,
    dynamic excludeIds,
    String? id,
    String? matchDetail,
    dynamic matchId,
    String? readCounts,
    String? showTime,
    String? sportId,
    String? summary,
    String? tagColor,
    String? tagName,
    String? thumbnails,
    String? updateTime,
  }) {
    return MatchDetailsNewsData()
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