import 'package:dio/dio.dart';
import 'package:flutter_ty_app/app/services/models/res/api_res.dart';
import 'package:retrofit/retrofit.dart';

import '../../db/app_cache.dart';
import '../models/res/category_list_entity.dart';
import '../models/res/detail_video_entity.dart';
import '../models/res/live_video_url_entity.dart';
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
import '../models/res/video_animation_url_entity.dart';
import '../network/app_dio.dart';
import '../network/retry_interceptor.dart';

part 'match_detail_api.g.dart';

@RestApi()
abstract class MatchDetailApi {
  factory MatchDetailApi(Dio dio, {String baseUrl}) = _MatchDetailApi;

  factory MatchDetailApi.instance() => MatchDetailApi(AppDio.getInstance().dio,
      baseUrl: StringKV.baseUrl.get() ?? '');

  // 赛事详情
  @Extra({kRetryable: true})
  @GET('/yewu11/v1/m/matchDetail/getMatchDetailPB')
  Future<ApiRes<Map<String, dynamic>>> getMatchDetail(
    @Query('mid') String mid,
    @Query('cuid') String cuid,
    @Query('init') String init,
  );

  @Extra({kRetryable: true})
  @GET('/yewu11/v1/m/matchDetail/getESMatchDetail')
  Future<ApiRes<Map<String, dynamic>>> getESMatchDetail(
    @Query('mid') String mid,
    @Query('cuid') String cuid,
    @Query('init') String init,
  );

  // 玩法类型
  @Extra({kRetryable: true, kThrottleAbleKey: true, kThrottleDurtionKey: 1500})
  @GET("/yewu11/v1/m/category/getCategoryList")
  Future<ApiRes<List<CategoryListData>>> getCategoryList(
    @Query('sportId') String sportId,
    @Query('mid') String mid,
  );

  // 联赛列表
  @Extra({kRetryable: true})
  @GET("/yewu11/v1/m/matchDetail/getMatchDetailByTournamentIdPB")
  Future<ApiRes<List<MatchEntity>>> getMatchDetailByTournamentId(
    @Query('tId') String tId,
    @Query('type') num? type,
    @Query('dateTime') String? dateTime,
    @Query('isESport') String? isESport,
  );

  // 投注列表
  @Extra({kRetryable: true, kThrottleAbleKey: true, kThrottleDurtionKey: 1500})
  @GET("/yewu11/v1/m/matchDetail/getMatchOddsInfo1PB")
  Future<ApiRes<List<dynamic>>> getMatchOddsInfo1(
    @Query('mcid') String mcid,
    @Query('mid') String mid,
    @Query('cuid') String cuid,
    @Query('showType') int? showType,
  );

  // 电竞投注列表
  @Extra({kRetryable: true, kThrottleAbleKey: true, kThrottleDurtionKey: 1500})
  @GET("/yewu11/v1/m/matchDetail/getESMatchOddsInfoPB")
  Future<ApiRes<List<dynamic>>> getESMatchOddsInfo(
    @Query('mcid') String mcid,
    @Query('mid') String mid,
    @Query('cuid') String cuid,
    @Query('showType') int? showType,
  );

  // vr投注列表
  @Extra({kRetryable: true, kThrottleAbleKey: true, kThrottleDurtionKey: 1500})
  @GET("/yewu11/v1/m/matchDetail/getVirtualMatchOddsInfo")
  Future<ApiRes<List<dynamic>>> getVirtualMatchOddsInfo(
    @Query('mcid') String mcid,
    @Query('mid') String mid,
    @Query('cuid') String cuid,
    @Query('showType') int? showType,
  );

  // vr赛果
  @Extra({kRetryable: true, kThrottleAbleKey: true, kThrottleDurtionKey: 1500})
  @GET("/yewu11/v1/m/matchDetail/getVirtualMatchResult")
  Future<ApiRes<List<dynamic>>> getVirtualMatchResult(
    @Query('mcid') String mcid,
    @Query('mid') String mid,
  );

  // 详情页赛事结束自动切换赛事接口(业务:yk)
  @GET("/yewu11/v1/w/getDetailVideo")
  Future<ApiRes<DetailVideoEntity>> getDetailVideo(
    @Query('sm') String sm,
    @Query('euid') String euid,
    @Query('csid') String csid,
    @Query('tid') String tid,
    @Query('sort') String sort,
    @Query('keyword') String keyword,
    @Query('cuid') String cuid,
    @Query('mid') String mid,
  );

  // 聊天室
  @POST("/yewu11/v1/w/liveVideoUrl")
  Future<LiveVideoUrlEntity> liveVideoUrl(
    @Field('device') String device,
    @Field('mid') String mid,
  );

  // 动画链接
  @POST("/yewu11/v1/w/videoAnimationUrl")
  Future<ApiRes<VideoAnimationUrlEntity>> getVideoAnimationUrl(
    @Field('type') String type,
    @Field('mid') String mid,
  );

  // 置顶
  @GET("/yewu11/v1/m/category/playTop")
  Future<void> playTop(
    @Query('status') String status,
    @Query('playId') String playId,
    @Query('matchId') String matchId,
    @Query('cuid') String cuid,
    @Query('topKey') String topKey,
  );

  ///赛事分析-资讯https://api.jlsdfj012.com/yewu11/v1/art/getArticle
  @GET('/v1/art/getArticle')
  Future<ApiRes<MatchDetailsNewsEntity>> getMatchDetailNews(
    @Query('matchId') int mid,
    @Query('type') int type,
    @Query('t') int t,
  );

  ///赛事分析-赛况https://api.jlsdfj012.com/yewu11/v1/m/matchDetail/getEventResult?mid=3236376&t=1709365374207
  @GET('/v1/m/matchDetail/getEventResult')
  Future<ApiRes<MatchDetailEntity>> getMatchDetailBatter(
    @Query('mid') int mid,
    @Query('t') int t,
  );

  ///赛事分析-数据-基本面-联赛积分
  // https://api-c.sportxxx1zx.com/yewu11/v2/statistics/vsInfo?mid=3242205&flag=&t=1709394813950
  @GET('v2/statistics/vsInfo')
  Future<ApiRes<MatchDetailsLeaguePointsEntity>> getMatchDetailVSInfo(
    @Query('mid') int mid,
    @Query('flag') int flag,
    @Query('t') int t,
  );

  ///赛事分析-数据-基本面-历史战绩
  // https://api-c.sportxxx1zx.com/yewu11/v2/statistics/teamVSHistory?mid=3242205&flag=0&cps=5&t=1709394813951
  @GET('/yewu11/v2/statistics/teamVSHistory')
  Future<ApiRes<MatchDetailsHistoryEntity>> getMatchDetailTeamVSHistory(
    @Query('mid') int mid,
    @Query('flag') int flag,
    @Query('cps') int cps,
    @Query('t') int t,
  );

  ///赛事分析-数据-基本面-近期战绩
  //https://api-c.sportxxx1zx.com/yewu11/v2/statistics/teamVsOtherTeam?mid=3242205&flag=0&cps=5&t=1709394813951
  @GET('/yewu11/v2/statistics/teamVsOtherTeam')
  Future<ApiRes<MatchDetailsRecentEntity>> getMatchDetailTeamVsOtherTeam(
    @Query('mid') int mid,
    @Query('flag') int flag,
    @Query('cps') int cps,
    @Query('t') int t,
  );

  ///赛事分析-数据-盘面
  //hhttp://uat-api-1.sportxxxifbdxm2.com/yewu11/v1/w/matchAnalysise/getMatchAnalysiseData?t=1709484432719
  @GET('/yewu11/v2/statistics/teamVsOtherTeam')
  Future<ApiRes<MatchDiskSurfaceEntity>> getMatchDetailAnalysiseData(
    @Query('mid') int mid,
    @Query('flag') int flag,
    @Query('cps') int cps,
    @Query('t') int t,
  );

  ///赛事分析-数据-技术面
  //http://uat-api-1.sportxxxifbdxm2.com/yewu11/v1/w/matchAnalysise/getMatchAnalysiseData?t=1709484533430
  @GET('/yewu11/v2/statistics/teamVsOtherTeam')
  Future<ApiRes<MatchTechnologyEntity>> getMatchDetailtechnology(
    @Query('mid') int mid,
    @Query('flag') int flag,
    @Query('cps') int cps,
    @Query('t') int t,
  );

  ///赛事分析--阵容
  //http://uat-api-1.sportxxxifbdxm2.com/yewu11/v2/matchLineup/getMatchLineupList?matchInfoId=2952920&homeAway=1&t=1709484650841
  @GET('/yewu11/v2/statistics/teamVsOtherTeam')
  Future<ApiRes<MatchLineupEntity>> getMatchDetaiLineup(
    @Query('mid') int mid,
    @Query('flag') int flag,
    @Query('cps') int cps,
    @Query('t') int t,
  );

  ///赛事分析--情报
  //http://uat-api-1.sportxxxifbdxm2.com/yewu11/v1/w/matchAnalysise/getMatchAnalysiseData?t=170948491829
  @GET('/yewu11/v2/statistics/teamVsOtherTeam')
  Future<ApiRes<MatchIntelligenceEntity>> getMatchDetaiintelligence(
    @Query('mid') int mid,
    @Query('flag') int flag,
    @Query('cps') int cps,
    @Query('t') int t,
  );
}
