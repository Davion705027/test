import 'package:dio/dio.dart';
import 'package:flutter_ty_app/app/services/models/req/match_list_req.dart';
import 'package:flutter_ty_app/app/services/models/res/collection_info.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:retrofit/retrofit.dart';

import '../../db/app_cache.dart';
import '../models/res/api_res.dart';
import '../models/res/champion_match_result_entity.dart';
import '../models/res/collection_count_info.dart';
import '../models/res/event_info_entity.dart';
import '../models/res/event_info_entity.dart';
import '../network/app_dio.dart';
import '../network/retry_interceptor.dart';

part 'match_api.g.dart';

@RestApi()
abstract class MatchApi {
  factory MatchApi(Dio dio, {String baseUrl}) = _MatchApi;

  factory MatchApi.instance() =>
      MatchApi(AppDio.getInstance().dio, baseUrl: StringKV.baseUrl.get() ?? '');

  @POST("/championMatchResult")
  Future<ChampionMatchResultEntity> championMatchResults(
    @Query("euid") String euid,
    @Query("type") int type,
    @Query("orderBy") int orderBy,
    @Query("category") int category,
    // @Query("md") String md ,
    @Query("startTime") String startTime,
    @Query("endTime") String endTime,
  );


  @GET("/yewu11/v1/w/eventInfo")
  Future<EventInfo2Entity> getEventInfo();

  /// 收藏
  @Extra({kRetryable: true})
  @POST("/yewu11/v1/m/matchesCollectNewH5")
  Future<ApiRes<List<MatchEntity>>> matchesCollectNewH5(
    @Body() MatchListReq req,
  );

  /// 获取收藏id
  @Extra({kRetryable: true})
  @POST('/yewu11/v1/w/collectMatches')
  Future<ApiRes<Map<String, CollectionInfo?>>> collectMatches(
    @Field('matchType') int matchType, // 0全部 1常规 2冠军 3电竞
    @Field('cuid') String cuid,
  );

  /// 获取比赛基本信息
  @Extra({kRetryable: true, kThrottleAbleKey: true, kThrottleDurtionKey: 1000})
  @POST('/yewu11/v1/m/getMatchBaseInfoByMidsPB')
  Future<ApiRes<List<MatchEntity>>> getMatchBaseInfo(
      @Field('mids') String mids,
      //赛事id
      @Field('cuid') String? cuid, //用户id
      @Field('sort') int sort,
      @Field('euid') String? euid,
      @Field('device') String device,
      @Field('pids') String? pids,
      @Field('is_user') String? isUser,
      @Field('playId') int? playId,
 /*     @Field('orpt') String? orpt,
      @Field('selectionHour') String? selectionHour,
      @Field('cos') int? cos,*/
      @Field('tabs') List tabs,

      ); //

  /// 列表信息
  @Extra({kRetryable: true})
  @POST('/yewu11/v1/m/matchesPB')
  Future<ApiRes<List<MatchEntity>>> matches(
    @Body() MatchListReq req,
  );

  /// 更新收藏列表菜单赛事数
  @Extra({kRetryable: true})
  @POST('/yewu11/v1/w/menu/countCollect')
  Future<ApiRes<List<CollectionCountInfo>>> updateCollectMatches(
    @Field('cuid') String cuid,
    @Field('euid') String euid,
    @Field('sort') int sort,
    @Field('type') int type,
  );

  @Extra({kRetryable: true})
  @POST('/yewu13/v1/userCollection/addOrCancelMatch')
  Future<ApiRes<int>> addOrCancelMatch(
    @Field('cuid') String cuid,
    @Field('mid') String mid,
    @Field('cf') int cf,
  );

  @Extra({kRetryable: true})
  @POST('/yewu13/v1/userCollection/addOrCancelTournament')
  Future<ApiRes<int>> addOrCancelTournament(
    @Field('cuid') String cuid,
    @Field('tid') String tid,
    @Field('cf') int cf,
  );

  @Extra({kRetryable: true})
  @POST('/yewu13/v1/userCollection/addOrCancelTournament')
  Future<ApiRes<int>> addOrCancelTournamentGuanjun(
    @Field('cuid') String cuid,
    @Field('mid') String mid, //冠军传这个
    @Field('cf') int cf,
  );
}
