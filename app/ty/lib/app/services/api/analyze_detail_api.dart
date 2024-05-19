import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_ty_app/app/services/api/analyze_v_s_info_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_back_video_info_entity_entity_entity_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_get_match_analysise_data_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_get_match_analysise_data_item_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_team_vs_history_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_team_vs_other_team_item_entity_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/api_res.dart';
import 'package:retrofit/retrofit.dart';

import '../../db/app_cache.dart';
import '../models/res/analyze_array_person_entity.dart';
import '../models/res/analyze_favorite_article_entity.dart';
import '../models/res/analyze_news_entity.dart';
import '../models/res/category_list_entity.dart';
import '../models/res/match_detail_entity.dart';
import '../models/res/match_details_history_entity.dart';
import '../models/res/match_details_league_points_entity.dart';
import '../models/res/match_details_news_entity.dart';
import '../models/res/match_details_recent_entity.dart';
import '../models/res/match_disk_surface_entity.dart';
import '../models/res/match_entity.dart';
import '../models/res/match_intelligence_entity.dart';
import '../models/res/match_lineup_entity.dart';
import '../models/res/match_technology_entity.dart';
import '../network/app_dio.dart';
import '../network/retry_interceptor.dart';

part 'analyze_detail_api.g.dart';

@RestApi()
abstract class AnalyzeDetailApi {
  factory AnalyzeDetailApi(Dio dio, {String baseUrl}) = _AnalyzeDetailApi;

  factory AnalyzeDetailApi.instance() =>
      AnalyzeDetailApi(AppDio.getInstance().dio,
          baseUrl: StringKV.baseUrl.get() ?? '');

  // 精彩回放
  @POST("/yewu11/v1/w/playbackVideoUrl")
  Future<ApiRes<AnalyzeBackVideoInfoEntityEntityEntityEntity>> playbackVideoUrl(
    @Field('mid') String? mid,
    @Field('device') String? device,
    @Field('eventCode') String? eventCode,
  );


  // 近期战绩
  @Extra({kRetryable: true})
  @GET("/yewu11/v2/statistics/vsInfo")
  Future<ApiRes<List<AnalyzeVSInfoEntity>>> vsInfo(
      @Query('mid') String? mid,
      @Query('flag') String? flag,
      @Query('') String? t,
      );

  // 近期战绩
  @Extra({kRetryable: true})
  @GET("/yewu11/v2/statistics/teamVSHistory")
  Future<ApiRes<List<AnalyzeTeamVsHistoryEntity>>> teamVSHistory(
      @Query('mid') String? mid,
      @Query('flag') String? flag,
      @Query('cps') String? cps,
      );

  // 近期战绩
  @Extra({kRetryable: true})
  @GET("/yewu11/v2/statistics/teamVsOtherTeam")
  Future<ApiRes<List<AnalyzeTeamVsOtherTeamItemEntityEntity>>> teamVsOtherTeam(
      @Query('mid') String? mid,
      @Query('flag') String? flag,
      @Query('cps') String? cps,
      );

  // 精彩回放
  @Extra({kRetryable: true})
  @POST("/yewu11/v1/w/matchAnalysise/getMatchAnalysiseData")
  Future<ApiRes<Map<String, dynamic>>> getMatchAnalysiseData(
      @Field('parentMenuId') String? parentMenuId,
      @Field('sonMenuId') String? sonMenuId,
      @Field('standardMatchId') String? standardMatchId,
      );


  // 添加阅读数
  @Extra({kRetryable: true})
  @POST("/yewu11/v1/art/addArticleCount")
  Future<ApiRes<String>> addArticleCount(
      @Field('id') String? id,
      );
  // 获取文章
  @Extra({kRetryable: true})
  @GET("/yewu11/v1/art/getArticle")
  Future<ApiRes<AnalyzeNewsEntity>> getArticle(
      @Query('matchId') String? matchId,
      @Query('type') String? type,
      @Query('t') String? t,
      );




  // 获取文章
  @Extra({kRetryable: true})
  @GET("/yewu11/v2/matchLineup/getMatchLineupList")
  Future<ApiRes<AnalyzeArrayPersonEntity>> getMatchLineupList(
      @Query('matchInfoId') String? matchInfoId,
      @Query('homeAway') String? homeAway,
      );

  // 获取我的喜欢
  @GET("/yewu11/v1/art/getFavoriteArticle")
  Future<ApiRes<List<AnalyzeNewsEntity>>> getFavoriteArticle(
      @Query('id') String? id,
      @Query('matchId') String? matchId,
      );

}
