import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/origin_data_entity.dart';
import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';

import 'analyze_array_person_entity.dart';
import 'analyze_favorite_article_entity.dart';
import 'analyze_news_entity.dart';
import 'balance_entity.dart';
import 'category_list_entity.dart';
import 'collection_info.dart';
import 'sport_config_info.dart';

/// @Author swifter
/// @Date 2024/2/4 17:40

class ApiRes<T> {
  T? data;
  String? code;
  String? msg;
  num? ts;

  ApiRes({this.data, this.code, this.msg, this.ts});

  bool get success => code == '0000000';

  factory ApiRes.fromJson(Map<String, dynamic> json) {
    return ApiRes(
      data: EntityFactory.generateOBJ<T>(json['data']),
      code: json['code'],
      msg: json['msg'],
      ts: json['ts'],
    );
  }
}

class EntityFactory {
  static T? generateOBJ<T>(json) {
    if (ObjectUtil.isEmpty(json)) return null;

    switch (T) {
      case BalanceEntity:
        return BalanceEntity.fromJson(json) as T;

      case OriginDataEntity:
        return OriginDataEntity.fromJson(json) as T;
      case AnalyzeNewsEntity:
        return AnalyzeNewsEntity.fromJson(json) as T;

      case const (List<AnalyzeNewsEntity>):
        return (json as List)
            .map((e) => AnalyzeNewsEntity.fromJson(e))
            .toList() as T;

      case const (List<AnalyzeFavoriteArticleEntity>):
        return (json as List)
            .map((e) => AnalyzeFavoriteArticleEntity.fromJson(e))
            .toList() as T;
      case MatchEntity:
        return MatchEntity.fromJson(json) as T;

      case const (Map<String, CollectionInfo>):
        return (json as Map<String, dynamic>).map((k, v) {
          return MapEntry(k, CollectionInfo.fromJson(v));
        }) as T;

      case AnalyzeArrayPersonEntity:
        return AnalyzeArrayPersonEntity.fromJson(json) as T;

      case const (List<CategoryListData>):
        return (json as List).map((e) => CategoryListData.fromJson(e)).toList()
            as T;

      case const (List<SportConfigInfo>):
        return (json as List).map((e) => SportConfigInfo.fromJson(e)).toList()
            as T;

      case const (Map<String, CollectionInfo?>):
        return (json as Map<String, dynamic>).map((k, v) {
          return MapEntry(k, JsonConvert.fromJsonAsT<CollectionInfo>(v));
        }) as T;

      case const (List<MatchHps>):
        return (json as List).map((e) {
          MatchHps matchHps = MatchHps.fromJson(e);
          // TODO title 特殊处理 title 可能为空。也可能为[[obj]] 或者 [obj] 嵌套，目前现这样处理
          if (e['title'].toString().startsWith('[[')) {
            final List<List<MatchHpsTitle>?>? title =
                (e['title'] as List<dynamic>?)?.map((m) {
              return (m as List<dynamic>?)
                  ?.map((t) =>
                      jsonConvert.convert<MatchHpsTitle>(t) as MatchHpsTitle)
                  .toList();
            }).toList();
            if (title != null) {
              matchHps.title = title;
            }
          } else {
            final List<MatchHpsTitle>? title =
                JsonConvert.fromJsonAsT<List<MatchHpsTitle>>(e['title']);
            if (title != null) {
              matchHps.title = title;
            }
          }
          return matchHps;
        }).toList() as T;

      default:
        //return json as T?;
        // json_convert_content.dart里有自动生成转换代码
        return JsonConvert.fromJsonAsT<T>(json);
    }
  }
}
