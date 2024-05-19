import 'package:dio/dio.dart';
import 'package:flutter_ty_app/app/services/models/res/api_res.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:retrofit/retrofit.dart';

import '../../db/app_cache.dart';
import '../models/res/get_filter_match_list_new_entity.dart';
import '../models/res/get_h5_order_list_entity.dart';
import '../models/res/mchampion_match_result_entity.dart';
import '../models/res/playback_video_url_entity.dart';
import '../network/app_dio.dart';
import '../network/retry_interceptor.dart';

part 'result_api.g.dart';

@RestApi()
abstract class ResultApi {
  factory ResultApi(Dio dio, {String baseUrl}) = _ResultApi;

  factory ResultApi.instance() => ResultApi(AppDio.getInstance().dio,
      baseUrl: StringKV.baseUrl.get() ?? '');

  // 获取联赛数据
  @GET("/yewu11/v1/m/getFilterMatchListNew")
  Future<GetFilterMatchListNewEntity> getFilterMatchListNew(
    @Query('type') int type,
    @Query('euid') String euid,
    @Query('inputText') String inputText,
    @Query('cuid') int cuid,
    @Query('device') String device,
    @Query('showem') String showem,
    @Query('md') String md,
  );

  // 获取联赛数据
  @POST("/yewu11/v1/m/matcheResultPB")
  Future<ApiRes<List<MatchEntity>>> matcheResult(
    @Field('category') int category,
    @Field('cuid') String cuid,
    @Field('device') String device,
    @Field('euid') String euid,
    @Field('hpsFlag') String hpsFlag,
    @Field('md') String md,
    @Field('showem') int showem,
    @Field('sort') int sort,
    @Field('tid') String tid,
    @Field('type') int type,
  );

  // 赛果详情获取所有联赛数据
  @Extra({kRetryable: true, KRetryCode: '0401038'})
  @GET("/yewu11/v1/m/matchDetail/getMatchResult")
  Future<ApiRes<List<dynamic>>> getMatchResult(
    @Query('mcid') int mcid,
    @Query('mid') String mid,
    @Query('cuid') String cuid,
    @Query('isESport') String? isESport,
  );

  // 赛果详情获取所有联赛数据
  @GET("/yewu11/v1/m/matchDetail/getResultMatchDetail")
  Future<ApiRes<MatchEntity>> getResultMatchDetail(
    @Query('mid') String mid,
    @Query('type') int type,
    @Query('cuid') String cuid,
    @Query('isESport') String isESport,
  );

  // 精选赛果
  @POST("/yewu11/v1/m/matcheHandpick")
  Future<ApiRes<List<MatchEntity>>> matcheHandpick(
    @Field('cuid') String cuid,
    @Field('sportId') String sportId,
  );

  // 精选赛果
  @POST("/yewu11/v1/w/playbackVideoUrl")
  Future<PlaybackVideoUrlEntity> playbackVideoUrl(
    @Field('device') String device,
    @Field('eventCode') String eventCode,
    @Field('mid') String mid,
  );

  // 冠军赛果
  @POST("/yewu11/v1/m/championMatchResult")
  Future<MchampionMatchResultEntity> championMatchResult(
    @Field('category') int category,
    @Field('cuid') String cuid,
    @Field('device') String device,
    @Field('endTime') String endTime,
    @Field('euid') int euid,
    @Field('isVirtualSport') int isVirtualSport,
    @Field('md') String md,
    @Field('orderBy') int orderBy,
    @Field('sort') int sort,
    @Field('sportType') int sportType,
    @Field('startTime') String startTime,
    @Field('type') int type,
  );

  ///我的注单
  @POST("/yewu12/order/betRecord/getH5OrderList")
  Future<GetH5OrderListEntity> resultGetH5OrderList(
      @Field('matchId') String matchId,
      @Field('orderBy') int orderBy,
      @Field('orderStatus') String orderStatus,
      @Field('timeType') int timeType,
      );
}
